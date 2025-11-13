@extends('admin.layouts.app')
@section('title', env('APP_NAME') . ' | Edit Product')
@section('content')
    <div class="page-wrapper">
        <div class="page-content">
            <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                <div class="breadcrumb-title pe-3">Product Management</div>
                <div class="ps-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 p-0">
                            <li class="breadcrumb-item"><a href="javascript:;"><i class="bx bx-home-alt"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Edit Product</li>
                        </ol>
                    </nav>
                </div>
            </div>

            <form method="POST" id="product-form" action="{{ route('admin.inventory.product.update', $product->id) }}"
                enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="card">
                    <div class="card-body row g-3">
                        <!-- Name -->
                        <div class="col-md-6">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control"
                                value="{{ old('name', $product->name) }}" required onkeyup="makeSlug(this.value,'#slug')">
                        </div>

                        <!-- Slug -->
                        <div class="col-md-6">
                            <label class="form-label">Slug</label>
                            <input type="text" id="slug" name="slug" class="form-control"
                                value="{{ old('slug', $product->slug) }}" readonly required>
                        </div>

                        <!-- Brand -->
                        <div class="col-md-3">
                            <label class="form-label">Brand</label>
                            <select name="brand_id" class="single-select" required>
                                <option value="">Select Brand</option>
                                @foreach ($brands as $brand)
                                    <option value="{{ $brand->id }}" @selected(old('brand_id', $product->brand_id) == $brand->id)>
                                        {{ $brand->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Category -->
                        <div class="col-md-3">
                            <label class="form-label">Category</label>
                            <select name="category_id" class="single-select" required>
                                <option value="">Select Category</option>
                                @foreach ($categories as $category)
                                    <option value="{{ $category->id }}" @selected(old('category_id', $product->category_id) == $category->id)>
                                        {{ $category->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Price (if not variation) -->
                        <div class="col-md-3 no-variation-field"
                            style="{{ $product->has_variations ? 'display:none' : '' }}">
                            <label class="form-label">Base Price</label>
                            <input type="number" name="base_price" class="form-control" step="0.01"
                                value="{{ old('base_price', $product->base_price) }}">
                        </div>

                        <!-- Stock (if not variation) -->
                        <div class="col-md-3 no-variation-field"
                            style="{{ $product->has_variations ? 'display:none' : '' }}">
                            <label class="form-label">Stock</label>
                            <input type="number" name="stock" class="form-control"
                                value="{{ old('stock', $product->stock) }}">
                        </div>
                    </div>

                    <div class="card-body row g-3">
                        <!-- Status -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="status" id="status"
                                    {{ old('status', $product->status) ? 'checked' : '' }}>
                                <label class="form-check-label" for="status">Active</label>
                            </div>
                        </div>

                        <!-- Featured -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="featured"
                                    id="featured" {{ old('featured', $product->featured) ? 'checked' : '' }}>
                                <label class="form-check-label" for="featured">Featured</label>
                            </div>
                        </div>

                        <!-- Top -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="top" id="top"
                                    {{ old('top', $product->top) ? 'checked' : '' }}>
                                <label class="form-check-label" for="top">Top</label>
                            </div>
                        </div>

                        <!-- New -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="new" id="new"
                                    {{ old('new', $product->new) ? 'checked' : '' }}>
                                <label class="form-check-label" for="new">New</label>
                            </div>
                        </div>

                        <!-- Has Discount -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="has_discount"
                                    id="has_discount" {{ old('has_discount', $product->has_discount) ? 'checked' : '' }}>
                                <label class="form-check-label" for="has_discount">Has Discount</label>
                            </div>
                        </div>

                        <!-- Discount Type -->
                        <div class="col-md-3" style="{{ !$product->has_discount ? 'display:none' : '' }}"
                            id="discount_type_field">
                            <label class="form-label" for="discount_type">Discount Type</label>
                            <select name="discount_type" id="discount_type" class="single-select">
                                <option value="">Select Type</option>
                                <option value="percentage"
                                    {{ old('discount_type', $product->discount_type) == 'percentage' ? 'selected' : '' }}>
                                    Percentage
                                </option>
                                <option value="fixed"
                                    {{ old('discount_type', $product->discount_type) == 'fixed' ? 'selected' : '' }}>
                                    Fixed
                                </option>
                            </select>
                        </div>

                        <!-- Discount Value -->
                        <div class="col-md-3" style="{{ !$product->has_discount ? 'display:none' : '' }}"
                            id="discount_value_field">
                            <label class="form-label">Discount Value</label>
                            <input type="number" name="discount_value" class="form-control"
                                value="{{ old('discount_value', $product->discount_value) }}">
                        </div>

                        <!-- Description -->
                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea name="description" rows="4" class="form-control myEditor">{{ old('description', $product->description) }}</textarea>
                        </div>

                        <!-- Media Upload -->
                        <div class="col-md-12">
                            <label class="form-label">
                                Product Images <span class="text-light">(Upload new images or select featured image)</span>
                            </label>
                            <div id="dropzone-area" class="dropzone"></div>
                            <input type="hidden" name="featured_image" id="featured_image"
                                value="{{ $product->mediaFeatured ? basename($product->mediaFeatured->path) : '' }}">

                            <!-- Display existing images -->
                            <div class="existing-media mt-3">
                                <h6>Current Images:</h6>
                                <div class="row ">
                                    @foreach ($product->media as $media)
                                        <div class="mb-3 media-item" style="width: 120px;"
                                            data-media-id="{{ $media->id }}">
                                            <div class="position-relative setting-input-group">
                                                <label for="product-image{{ $media->id }}">
                                                    @if (str_starts_with($media->media_type, 'image'))
                                                        <img src="{{ asset('storage/' . $media->path) }}" height="100">
                                                    @endif
                                                    <div class="form-check position-absolute top-0 start-0 m-1">
                                                        <input class="form-check-input feature-checkbox" type="radio"
                                                            id="product-image{{ $media->id }}"
                                                            name="existing_featured" value="{{ basename($media->path) }}"
                                                            {{ $media->is_featured ? 'checked' : '' }}>
                                                    </div>
                                                </label>
                                                <button
                                                    class="btn btn-light btn-sm position-absolute top-0 end-0 m-1 remove-media delete-btn"
                                                    data-media-id="{{ $media->id }}" type="button"
                                                    {{-- onclick="deleteBlogMedia({{ $media->id }}, '{{ route('admin.blogs.destroyMedia', $media->id) }}')" --}} style="right: 0; background-color: #0000006e;">
                                                    <i class="bx bx-trash"></i>
                                                </button>
                                                {{-- <button type="button"
                                                    class="btn btn-danger btn-sm position-absolute top-0 end-0 m-1 remove-media"
                                                    data-media-id="{{ $media->id }}">
                                                    <i class="bx bx-trash"></i>
                                                </button> --}}
                                            </div>
                                        </div>
                                    @endforeach
                                </div>
                            </div>
                        </div>
                        <!-- Has Variations -->
                        <div class="col-md-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" onclick="toggleVariationSection(this)" value="1"
                                    type="checkbox" name="has_variations" id="has_variations"
                                    {{ old('has_variations', $product->has_variations) ? 'checked' : '' }}>
                                <label class="form-check-label" for="has_variations">Has Variations?</label>
                            </div>
                        </div>
                        <!-- Variation Section -->
                        <div class="border border-light card-body variation-section"
                            style="{{ $product->has_variations ? '' : 'display:none' }}">
                            <div class="col-md-12">
                                <label class="form-label">Select Attributes</label>
                                <div class="row">
                                    @foreach ($attributes as $attribute)
                                        <div class="col-sm-4">
                                            <label>{{ $attribute->name }}</label>
                                            <select class="multiple-select" name="attributes[{{ $attribute->id }}][]"
                                                data-placeholder="Choose anything" multiple="multiple">
                                                @foreach ($attribute->options as $option)
                                                    @php
                                                        $isSelected = false;
                                                        if ($product->has_variations) {
                                                            foreach ($product->variations as $variation) {
                                                                // Explicitly decode if needed
                                                                $optionIds = is_array($variation->option_ids)
                                                                    ? $variation->option_ids
                                                                    : json_decode($variation->option_ids, true);

                                                                if (in_array($option->id, $optionIds)) {
                                                                    $isSelected = true;
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    @endphp
                                                    <option value="{{ $option->id }}"
                                                        {{ $isSelected ? 'selected' : '' }}>
                                                        {{ $option->value }}
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>
                                    @endforeach
                                </div>
                            </div>

                            <!-- Variation Input Table -->
                            <div class="col-md-12 mt-4">
                                <label class="form-label">Variation Combinations</label>
                                <table class="table table-bordered" id="variation-table">
                                    <thead>
                                        <tr>
                                            <th>Options</th>
                                            <th>Price</th>
                                            <th>Stock</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @if ($product->has_variations)
                                            @foreach ($product->variations as $index => $variation)
                                                @php
                                                    // Safely get option_ids as array
                                                    $optionIds = is_array($variation->option_ids)
                                                        ? $variation->option_ids
                                                        : json_decode($variation->option_ids, true) ?? [];

                                                    // Get options with their attributes
                                                    $options = \App\Models\ProductAttributeOption::with('attribute')
                                                        ->whereIn('id', $optionIds)
                                                        ->get();
                                                @endphp

                                                @if (count($options) > 0)
                                                    <tr>
                                                        <td>
                                                            @foreach ($options as $option)
                                                                {{ $option->attribute->name }}:
                                                                <strong>{{ $option->value }}</strong>
                                                                @if (!$loop->last)
                                                                    ,
                                                                @endif
                                                                <input type="hidden"
                                                                    name="variations[{{ $index }}][attributes][{{ $option->attribute->id }}]"
                                                                    value="{{ $option->id }}">
                                                            @endforeach
                                                            <input type="hidden"
                                                                name="variations[{{ $index }}][id]"
                                                                value="{{ $variation->id }}">
                                                        </td>
                                                        <td>
                                                            <input type="number"
                                                                name="variations[{{ $index }}][price]"
                                                                class="form-control" step="0.01"
                                                                value="{{ old("variations.$index.price", $variation->price) }}"
                                                                required>
                                                        </td>
                                                        <td>
                                                            <input type="number"
                                                                name="variations[{{ $index }}][stock]"
                                                                class="form-control"
                                                                value="{{ old("variations.$index.stock", $variation->stock) }}"
                                                                required>
                                                        </td>
                                                        <td>
                                                            <button type="button"
                                                                class="btn btn-sm btn-light remove-variation">
                                                                <i class="bx bx-trash"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                @endif
                                            @endforeach
                                        @endif
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Submit Button -->
                        <div class="col-md-12 mt-4">
                            <button type="submit" id="product-btn" class="btn btn-light px-5">Update Product</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        // Initialize edit mode flag
        const isEditMode = true;
        let existingMedia = {!! $product->media->pluck('id') !!};

        function toggleVariationSection(el) {
            const isChecked = el.checked;
            if (isChecked) {
                document.querySelectorAll('.variation-section').forEach(e => e.style.display = 'block');
                document.querySelectorAll('.no-variation-field').forEach(e => e.style.display = 'none');
            } else {
                document.querySelectorAll('.variation-section').forEach(e => e.style.display = 'none');
                document.querySelectorAll('.no-variation-field').forEach(e => e.style.display = 'block');
            }
        }

        // Generate variation combinations
        function generateVariations() {
            const attributeSections = document.querySelectorAll('.variation-section select[multiple]');
            const variationTable = document.querySelector('#variation-table tbody');

            // Keep existing variations if they exist
            const existingRows = Array.from(variationTable.querySelectorAll('tr'))
                .filter(row => {
                    const idInput = row.querySelector('input[name*="[id]"]');
                    // Skip rows marked for deletion
                    return idInput && !idInput.name.includes('deleted_variations');
                });

            variationTable.innerHTML = '';
            existingRows.forEach(row => variationTable.appendChild(row));

            const selectedData = [];

            attributeSections.forEach(select => {
                const attributeId = select.name.match(/\[(\d+)\]/)[1]; // Get attribute ID from name
                const attributeName = select.closest('div').querySelector('label').textContent.trim();
                const selectedOptions = Array.from(select.selectedOptions).map(opt => ({
                    id: opt.value,
                    value: opt.textContent.trim(),
                    attributeId: attributeId // Store attribute ID for reference
                }));

                if (selectedOptions.length) {
                    selectedData.push({
                        id: attributeId,
                        name: attributeName,
                        options: selectedOptions
                    });
                }
            });

            if (!selectedData.length) return;

            const optionSets = selectedData.map(attr =>
                attr.options.map(option => ({
                    attributeId: attr.id,
                    attributeName: attr.name,
                    value: option.value,
                    option_id: option.id
                }))
            );

            const combinations = cartesianProduct(optionSets);

            combinations.forEach((combo, index) => {
                // Skip if this combination already exists
                const existingVariation = Array.from(variationTable.querySelectorAll(
                        'input[type="hidden"][name*="[attributes]"]'))
                    .find(input => combo.some(c => input.value === c.option_id &&
                        input.name.includes(`[${c.attributeId}]`)));

                if (existingVariation) return;

                const key = combo.map(c => `${c.attributeName}: <strong>${c.value}</strong>`).join(', ');

                let hiddenInputs = '';
                combo.forEach(c => {
                    hiddenInputs +=
                        `<input type="hidden" name="new_variations[${index}][attributes][${c.attributeId}]" value="${c.option_id}">`;
                });

                const row = document.createElement('tr');
                row.innerHTML = `
            <td>
                ${key}
                ${hiddenInputs}
            </td>
            <td>
                <input type="number" name="new_variations[${index}][price]" class="form-control" step="0.01" required>
            </td>
            <td>
                <input type="number" name="new_variations[${index}][stock]" class="form-control" required>
            </td>
            <td>
                <button type="button" class="btn btn-sm btn-light remove-variation">
                    <i class="bx bx-trash"></i>
                </button>
            </td>
        `;
                variationTable.appendChild(row);
            });
        }

        // Improved cartesian product function
        function cartesianProduct(arrays) {
            return arrays.reduce((a, b) =>
                a.flatMap(d => b.map(e => [d, e].flat())), [
                    []
                ]);
        }
        // DOM Ready
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize variation section
            const variationCheckbox = document.getElementById('has_variations');
            if (variationCheckbox) {
                toggleVariationSection(variationCheckbox);
            }

            // Initialize Select2
            $('.single-select').select2({
                theme: 'bootstrap4',
                width: '100%'
            });

            $('.multiple-select').select2({
                theme: 'bootstrap4',
                width: '100%'
            });

            // Variation generation on attribute change
            $('.variation-section select[multiple]').on('change', function() {
                generateVariations();
            });

            // Remove variation row with better handling
            $('#variation-table').on('click', '.remove-variation', function() {
                const row = $(this).closest('tr');
                const idInput = row.find('input[name*="[id]"]');

                if (idInput.length) {
                    // For existing variations, mark for deletion
                    idInput.attr('name', 'deleted_variations[]');
                    row.hide();

                    // Also remove any new variations that might reference the same options
                    const optionInputs = row.find('input[name*="[attributes]"]');
                    optionInputs.each(function() {
                        const attrId = $(this).attr('name').match(/\[(\d+)\]/)[1];
                        const optionId = $(this).val();

                        $(`input[name*="[attributes][${attrId}]"][value="${optionId}"]`)
                            .closest('tr')
                            .remove();
                    });
                } else {
                    row.remove();
                }
            });

            // Discount fields toggle
            $('#has_discount').change(function() {
                $('#discount_type_field, #discount_value_field').toggle(this.checked);
            }).trigger('change');

            // Featured image selection for existing media
            $('input[name="existing_featured"]').change(function() {
                $('#featured_image').val($(this).val());
            });

            // Remove existing media
            $('.remove-media').click(function() {
                const mediaId = $(this).data('media-id');
                $(`[data-media-id="${mediaId}"]`).remove();
                $('<input>').attr({
                    type: 'hidden',
                    name: 'deleted_media[]',
                    value: mediaId
                }).appendTo('form');
            });

            // Initialize Dropzone
            Dropzone.autoDiscover = false;
            let myDropzone = new Dropzone("#dropzone-area", {
                url: "#",
                maxFiles: 10,
                acceptedFiles: "image/*, video/*",
                addRemoveLinks: true,
                autoProcessQueue: false,
                uploadMultiple: true,
                parallelUploads: 10,
                init: function() {
                    this.on("addedfile", function(file) {
                        // Create featured image checkbox
                        const checkbox = $(`
                        <div class="form-check position-absolute top-0 start-0 m-1">
                            <input class="form-check-input feature-checkbox" type="radio" name="featured_new" value="${file.name}">
                        </div>
                    `);
                        $(file.previewElement).addClass('position-relative').append(checkbox);
                        // Handle featured image selection
                        $(file.previewElement).find('.feature-checkbox').change(function() {
                            if (this.checked) {
                                $('#featured_image').val(file.name);
                            }
                        });
                    });
                }
            });

            $('.myEditor').each(function(index) {
                var elementId = $(this).attr('id') || 'editor-' + index;
                $(this).attr('id', elementId);
                CKEDITOR.replace(elementId, {
                    width: '100%'
                });
            });
        });

        $(function() {
            ajaxPost('#product-form', '#product-btn', function(response) {
                successMessage(response.success);
                window.location = "{{ route('admin.inventory.product.index') }}"

            });
        })
        // Slug generation
        function makeSlug(val, slugSelector) {
            if (isEditMode && $(slugSelector).val().length > 0) return;
            let slug = val.toLowerCase()
                .replace(/[^\w ]+/g, '')
                .replace(/ +/g, '-');
            $(slugSelector).val(slug);
        }
    </script>
@endpush
