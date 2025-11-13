<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductAttribute;
use App\Models\ProductVariation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\DataTables;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        if (request()->ajax()) {
            $data = Product::orderBy('status', 'desc')->orderBy('id', 'desc');
            return DataTables::of($data)
                ->addIndexColumn()
                ->addColumn('action', function ($row) {
                    $showUrl = route('admin.inventory.product.show', $row->id);
                    $editUrl = route('admin.inventory.product.edit', $row->id);

                    $showBtn = '<a href="javascript:;" onclick="showAjaxModal(\'View Product Details\', \'view\', \'' . $showUrl . '\')" class="btn btn-light"><i class="lni lni-eye"></i></a>';
                    // $editBtn = '<a href="javascript:;" onclick="showAjaxModal(\'Edit Product Details\', \'Update\', \'' . $editUrl . '\')" class="btn btn-light"><i class="bx bx-edit-alt"></i></a>';
                    $editBtn = '<a href="' . $editUrl . '" class="btn btn-light"><i class="bx bx-edit-alt"></i></a>';
                    $deleteBtn = '<a href="javascript:;" onclick="deleteTag(' . $row->id . ', `' . route('admin.inventory.product.destroy', $row->id) . '`)" class="btn btn-light"><i class="bx bx-trash"></i></a>';
                    // $deleteBtn
                    return $showBtn . ' ' . $editBtn;
                })
                ->addColumn('image', function ($row) {
                    $imagePath = asset("storage/" . $row->mediaFeatured?->path);
                    return "<img src='" . $imagePath . "' alt='' width='150'/>";
                })
                ->editColumn('status', function ($row) {
                    return defaultBadge(config('constants.product.status.' . $row->status));
                })
                ->editColumn('featured', function ($row) {
                    return defaultBadge(config('constants.product.featured.' . $row->featured));
                })
                ->editColumn('created_at', function ($row) {
                    return $row->created_at->format('d M Y');
                })
                ->editColumn('brand_id', function ($row) {
                    return $row->brand->name ?? "N/A";
                })
                ->editColumn('category_id', function ($row) {
                    return $row->category->name ?? "N/A";
                })
                ->rawColumns(['action', 'status', 'featured', 'image']) // Allow HTML in these columns
                ->make(true);
        }
        return view('admin.pages.inventory.product.index');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $data['brands'] = Brand::where('status', 1)->get();
        $data['categories'] = Category::where('status', 1)->get();
        $data['attributes'] = ProductAttribute::where('status', 1)->get();
        return view('admin.pages.inventory.product.create', $data);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->merge([
            'created_by' => Auth::id(),
            'has_discount' => $request->has('has_discount') ? 1 : 0,
            'has_variations' => $request->has('has_variations') ? 1 : 0,
            'featured' => $request->has('featured') ? 1 : 0,
            'new' => $request->has('new') ? 1 : 0,
            'top' => $request->has('top') ? 1 : 0,
            'status' => $request->has('status') ? 1 : 0,
        ]);
        if ($request->has_variations) {
            $request['base_price'] = 0;
            $request['stock'] = 0;
        }
        if (!$request->has_discount) {
            $request['discount_type'] = 'none';
            $request['discount_value'] = 0;
        }
        if ($request->has_variations) {
            foreach ($request->variations as $index => $variation) {
                $optionIds = array_values($variation['attributes']); // extract only IDs
                $request->merge([
                    "variations.$index.option_ids" => $optionIds,
                ]);
            }
        }

        // dd($request->all());
        $request->validate([
            'name' => 'required|string|max:255',
            'slug' => 'required|string|max:255|unique:products,slug',
            'description' => 'nullable|string',
            'has_variations' => 'required|boolean',
            'base_price' => 'required_if:has_variations,0|numeric|min:0',
            'stock' => 'required_if:has_variations,0|integer|min:0',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'required|exists:brands,id',
            'has_discount' => 'boolean',
            'discount_type' => 'required_if:has_discount,1|in:percentage,fixed,none',
            'discount_value' => 'required_if:has_discount,1|numeric|min:0',
            'featured' => 'boolean',
            'new' => 'boolean',
            'top' => 'boolean',
            'status' => 'required|boolean',
            'images' => 'required|array',
            'images.*' => 'required|file|mimes:jpeg,png,jpg,gif,svg,webp|max:20480',
            'featured_image' => 'required',
            'featured_image' => 'required|file|mimes:jpeg,png,jpg,gif,svg,webp|max:20480',
            'created_by' => 'required|exists:users,id',

            // Optional media uploads
            'files.*' => 'nullable|file|mimes:jpeg,png,jpg,gif,svg,webp,mp4,mov,avi|max:20480',

            // Variations
            'variations' => 'nullable|array',

            'variations.*.option_ids' => 'required_if:has_variations,1|array',
            'variations.*.price' => 'required_if:has_variations,1|numeric',
            'variations.*.stock' => 'required_if:has_variations,1|numeric',
        ],[
            'images' => 'The images field is required.',
            'featured_image' => 'The featured image field is required.',
            'discount_type' => 'The discount type field is required.',
            'discount_value' => 'The discount value field is required.',
        ]);
        // dd($request->all());
        DB::beginTransaction();

        try {
            $slug = str($request->slug)->slug();
            $product = Product::create([
                'name' => $request->name,
                'slug' => $slug,
                'description' => $request->description,
                'base_price' => $request->base_price,
                'stock' => $request->stock,
                'has_variations' => $request->has_variations,
                'category_id' => $request->category_id,
                'brand_id' => $request->brand_id,
                'featured' => $request->featured,
                'new' => $request->new,
                'top' => $request->top,
                'status' => $request->status,
                'created_by' => $request->created_by,
            ]);

            // 2. Handle Variations
            if ($request->has_variations && is_array($request->variations)) {
                foreach ($request->variations as $variation) {
                    $optionIds = collect($variation['attributes'])->values()->toArray();

                    ProductVariation::create([
                        'product_id' => $product->id,
                        'price' => $variation['price'],
                        'stock' => $variation['stock'],
                        'option_ids' => json_encode($optionIds),
                    ]);
                }
            }
            // 3. Handle Media Uploads
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $file) {
                    $storedPath = $file->store('products', 'public');
                    $mime = $file->getMimeType();
                    $mediaType = str()->startsWith($mime, 'image') ? 'image' : (str()->startsWith($mime, 'video') ? 'video' : 'unknown');

                    $product->media()->create([
                        'path' => $storedPath,
                        'media_type' => $mediaType,
                        'is_featured' => 0,
                    ]);
                }
            }
            if ($request->hasFile('featured_image')) {
                $featuredImage = $request->file('featured_image');
                $storedPath = $featuredImage->store('products', 'public');
                $mime = $featuredImage->getMimeType();
                $mediaType = str()->startsWith($mime, 'image') ? 'image' : (str()->startsWith($mime, 'video') ? 'video' : 'unknown');

                $product->media()->create([
                    'path' => $storedPath,
                    'media_type' => $mediaType,
                    'is_featured' => 1,
                ]);
            }
            DB::commit();
            return response()->json([
                'success' => 'Product created successfully.',
                'product' => $product->load('variations', 'media'),
            ], 201);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'message' => 'Failed to create product.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::findOrFail($id);
        return view('admin.pages.inventory.product.show', compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $data['product'] = Product::findOrFail($id);
        $data['brands'] = Brand::where('status', 1)->get();
        $data['categories'] = Category::where('status', 1)->get();
        $data['attributes'] = ProductAttribute::where('status', 1)->get();
        // dd($data['product']);
        return view('admin.pages.inventory.product.edit', $data);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $product = Product::findOrFail($id);
        $request->merge([
            'has_discount' => $request->has('has_discount') ? 1 : 0,
            'has_variations' => $request->has('has_variations') ? 1 : 0,
            'featured' => $request->has('featured') ? 1 : 0,
            'new' => $request->has('new') ? 1 : 0,
            'top' => $request->has('top') ? 1 : 0,
            'status' => $request->has('status') ? 1 : 0,
            'created_by' => Auth::id(),
        ]);

        if ($request->has_variations) {
            $request['base_price'] = 0;
            $request['stock'] = 0;
        }

        if (!$request->has_discount) {
            $request['discount_type'] = null;
            $request['discount_value'] = 0;
        }

        // Process variations for validation
        if ($request->has_variations) {
            // Handle existing variations
            if ($request->has('variations')) {
                foreach ($request->variations as $index => $variation) {
                    $optionIds = array_values($variation['attributes']);
                    $request->merge([
                        "variations.$index.option_ids" => $optionIds,
                    ]);
                }
            }
            // Handle new variations
            if ($request->has('new_variations')) {
                foreach ($request->new_variations as $index => $variation) {
                    $optionIds = array_values($variation['attributes']);
                    $request->merge([
                        "new_variations.$index.option_ids" => $optionIds,
                    ]);
                }
            }
        }

        dd($request->all());
        $request->validate([
            'name' => 'required|string|max:255',
            'slug' => 'required|string|max:255|unique:products,slug,' . $product->id,
            'description' => 'nullable|string',
            'has_variations' => 'required|boolean',
            'base_price' => 'required_if:has_variations,0|numeric|min:0',
            'stock' => 'required_if:has_variations,0|integer|min:0',
            'category_id' => 'required|exists:categories,id',
            'brand_id' => 'required|exists:brands,id',
            'has_discount' => 'boolean',
            'discount_type' => 'required_if:has_discount,1|in:percentage,fixed',
            'discount_value' => 'required_if:has_discount,1|numeric|min:0',
            'featured' => 'boolean',
            'new' => 'boolean',
            'top' => 'boolean',
            'status' => 'required|boolean',

            // Media uploads
            'files.*' => 'nullable|file|mimes:jpeg,png,jpg,gif,svg,webp,mp4,mov,avi|max:20480',
            'deleted_media' => 'nullable|array',
            'deleted_media.*' => 'exists:media,id',
            'featured_image' => 'nullable|string',

            // Variations
            'variations' => 'nullable|array',
            'variations.*.id' => 'required|exists:product_variations,id',
            'variations.*.option_ids' => 'required_if:has_variations,1|array',
            'variations.*.price' => 'required_if:has_variations,1|numeric',
            'variations.*.stock' => 'required_if:has_variations,1|numeric',

            // New variations
            'new_variations' => 'nullable|array',
            'new_variations.*.option_ids' => 'required_if:has_variations,1|array',
            'new_variations.*.price' => 'required_if:has_variations,1|numeric',
            'new_variations.*.stock' => 'required_if:has_variations,1|numeric',

            // Deleted variations
            'deleted_variations' => 'nullable|array',
            'deleted_variations.*' => 'exists:product_variations,id',
        ]);

        DB::beginTransaction();

        try {
            // Update product basic info
            $product->update([
                'name' => $request->name,
                'slug' => $request->slug,
                'description' => $request->description,
                'base_price' => $request->base_price,
                'stock' => $request->stock,
                'has_variations' => $request->has_variations,
                'category_id' => $request->category_id,
                'brand_id' => $request->brand_id,
                'has_discount' => $request->has_discount,
                'discount_type' => $request->discount_type,
                'discount_value' => $request->discount_value,
                'featured' => $request->featured,
                'new' => $request->new,
                'top' => $request->top,
                'status' => $request->status,
            ]);

            // Handle media deletions
            if ($request->has('deleted_media')) {
                $product->media()->whereIn('id', $request->deleted_media)->delete();
            }

            // Handle new media uploads
            if ($request->hasFile('files')) {
                foreach ($request->file('files') as $file) {
                    $storedPath = $file->store('products', 'public');
                    $isFeatured = $file->getClientOriginalName() === $request->featured_image ? 1 : 0;
                    $mediaType = str()->startsWith($file->getMimeType(), 'image') ? 'image' : 'video';

                    $product->media()->create([
                        'path' => $storedPath,
                        'media_type' => $mediaType,
                        'is_featured' => $isFeatured,
                    ]);
                }
            }

            // Handle featured image from existing media
            if ($request->featured_image && !$request->hasFile('files')) {
                $product->media()->update(['is_featured' => 0]);
                $product->media()
                    ->where('path', 'like', '%' . $request->featured_image)
                    ->update(['is_featured' => 1]);
            }

            // Handle variations
            if ($request->has_variations) {
                // Update existing variations
                if ($request->has('variations')) {
                    foreach ($request->variations as $variationData) {
                        $variation = ProductVariation::find($variationData['id']);
                        if ($variation) {
                            $variation->update([
                                'price' => $variationData['price'],
                                'stock' => $variationData['stock'],
                                'option_ids' => $variationData['option_ids'],
                            ]);
                        }
                    }
                }

                // Add new variations
                if ($request->has('new_variations')) {
                    foreach ($request->new_variations as $newVariation) {
                        $product->variations()->create([
                            'price' => $newVariation['price'],
                            'stock' => $newVariation['stock'],
                            'option_ids' => $newVariation['option_ids'],
                        ]);
                    }
                }

                // Delete removed variations
                if ($request->has('deleted_variations')) {
                    $product->variations()->whereIn('id', $request->deleted_variations)->delete();
                }
            } else {
                // Remove all variations if product no longer has variations
                $product->variations()->delete();
            }

            DB::commit();

            return response()->json([
                'success' => 'Product updated successfully.',
                'product' => $product->load('variations', 'media'),
                'redirect' => route('admin.inventory.product.index')
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'message' => 'Failed to update product.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
