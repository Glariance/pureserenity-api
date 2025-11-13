<div class="card-body">
    <table class="table table-bordered">
        <tr>
            <th class="w-25">Name</th>
            <td class="w-75">{{ $product->name }}</td>
        </tr>
        <tr>
            <th class="w-25">Slug</th>
            <td class="w-75">{{ $product->slug }}</td>
        </tr>
        <tr>
            <th>Brand</th>
            <td>{{ $product->brand->name ?? '-' }}</td>
        </tr>
        <tr>
            <th>Category</th>
            <td>{{ $product->category->name ?? '-' }}</td>
        </tr>
        @if ($product->has_variations)
            <tr>
                <th>Variations</th>
                <td>
                    @foreach ($product->variations as $variation)
                        <div><strong>Price:</strong> ${{ $variation->price ?? 'N/A' }}</div>
                        <div><strong>Stock:</strong> {{ $variation->stock ?? 'N/A' }}</div>
                        <div><strong>Variation(s):</strong>
                            {{-- @dd($variation->options) --}}
                            @foreach ($variation->options as $option)
                                {!! defaultBadge($option['name'] . ': ' . $option['value'], 25) !!}
                            @endforeach
                            @if (!$loop->last)
                                <hr>
                            @endif
                        </div>
                    @endforeach
                </td>
            </tr>
        @endif
        <tr>
            <th>Status</th>
            <td>{!! defaultBadge(ucfirst(config('constants.product.status.' . $product->status)), 25) !!}</td>
        </tr>
        <tr>
            <th>Featured</th>
            <td>{!! defaultBadge(ucfirst(config('constants.product.featured.' . $product->featured)), 25) !!}</td>
        </tr>
        <tr>
            <th>Created-At</th>
            <td>{{ $product->created_at->format('d M Y, h:i A') }}</td>
        </tr>
        <tr>
            <th>Desciption</th>
            <td>{!! $product->description !!}</td>
        </tr>
        @if ($product->media)
            <tr>
                <th>Image</th>
                <td>
                    @foreach ($product->media as $media)
                        <img src="{{ asset('storage/' . $media->path) }}" alt="{{ $product->name }}" width="100px">
                    @endforeach
                </td>
            </tr>
        @endif
    </table>
</div>
