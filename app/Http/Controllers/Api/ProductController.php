<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class ProductController extends Controller
{
    /**
     * Retrieve products with optional filtering.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $products = $this->buildQuery($request)->get();

        return ProductResource::collection($products);
    }

    /**
     * Retrieve featured products only.
     */
    public function featured(Request $request): AnonymousResourceCollection
    {
        $request->merge(['featured' => true]);

        $products = $this->buildQuery($request)->get();

        return ProductResource::collection($products);
    }

    /**
     * Base query shared across product endpoints.
     */
    protected function buildQuery(Request $request): Builder
    {
        $query = Product::query()
            ->with(['category', 'mediaFeatured'])
            ->when(! $request->boolean('include_inactive'), function (Builder $builder) {
                $builder->where('status', 1);
            })
            ->when($request->boolean('featured'), function (Builder $builder) {
                $builder->where('featured', 1);
            })
            ->when($request->boolean('new'), function (Builder $builder) {
                $builder->where('new', 1);
            })
            ->when($request->boolean('top'), function (Builder $builder) {
                $builder->where('top', 1);
            })
            ->when($request->filled('category'), function (Builder $builder) use ($request) {
                $category = $request->input('category');

                if (is_numeric($category)) {
                    $builder->where('category_id', $category);
                } else {
                    $builder->whereHas('category', function (Builder $inner) use ($category) {
                        $inner->where('slug', $category);
                    });
                }
            })
            ->when($request->filled('search'), function (Builder $builder) use ($request) {
                $search = $request->input('search');

                $builder->where(function (Builder $inner) use ($search) {
                    $inner->where('name', 'like', "%{$search}%")
                        ->orWhere('slug', 'like', "%{$search}%")
                        ->orWhere('description', 'like', "%{$search}%");
                });
            })
            ->orderByDesc('featured')
            ->orderBy('name');

        return $query;
    }
}
