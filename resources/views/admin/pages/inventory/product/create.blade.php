@extends('admin.layouts.app')
@section('title', env('APP_NAME') . ' | Product Management')
@section('content')
    <div class="page-wrapper">
        <div class="page-content">

            <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
                <div class="breadcrumb-title pe-3">Product Management</div>
                <div class="ps-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 p-0">
                            <li class="breadcrumb-item"><a href="javascript:;"><i class="bx bx-home-alt"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Create Product</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <form method="POST" id="product-form" action="{{ route('admin.inventory.product.store') }}"
                enctype="multipart/form-data">
                @csrf
                <div class="card">
                    <div class="card-body row g-3">

                        <!-- Name -->
                        <div class="col-md-6">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control" value="{{ old('name') }}" required
                                onkeyup="makeSlug(this.value,'#slug')">
                        </div>

                        <!-- Slug -->
                        <div class="col-md-6">
                            <label class="form-label">Slug</label>
                            <input type="text" id="slug" name="slug" class="form-control"
                                value="{{ old('slug') }}" readonly required>
                        </div>

                        <!-- Brand -->
                        <div class="col-md-3">
                            <label class="form-label">Brand</label>
                            <select name="brand_id" class="single-select" required>
                                <option value="">Select Brand</option>
                                @foreach ($brands as $brand)
                                    <option value="{{ $brand->id }}" @selected(old('brand_id') == $brand->id)>{{ $brand->name }}
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
                                    <option value="{{ $category->id }}" @selected(old('category_id') == $category->id)>{{ $category->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Price (if not variation) -->
                        <div class="col-md-3 no-variation-field">
                            <label class="form-label">Base Price</label>
                            <input type="number" name="base_price" class="form-control" step="0.01"
                                value="{{ old('base_price', 0) }}">
                        </div>

                        <!-- Stock (if not variation) -->
                        <div class="col-md-3 no-variation-field">
                            <label class="form-label">Stock</label>
                            <input type="number" name="stock" class="form-control" value="{{ old('stock', 0) }}">
                        </div>
                    </div>
                    <div class="card-body row g-3">
                        <!-- Status -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="status" id="status"
                                    {{ old('status', true) ? 'checked' : '' }}>
                                <label class="form-check-label" for="status">Active</label>
                            </div>
                        </div>

                        <!-- Featured -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="featured"
                                    id="featured" {{ old('featured', true) ? 'checked' : '' }}>
                                <label class="form-check-label" for="featured">Featured</label>
                            </div>
                        </div>

                        <!-- Top -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="top" id="top"
                                    {{ old('top', true) ? 'checked' : '' }}>
                                <label class="form-check-label" for="top">Top</label>
                            </div>
                        </div>

                        <!-- New -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="new" id="new"
                                    {{ old('new', true) ? 'checked' : '' }}>
                                <label class="form-check-label" for="new">New</label>
                            </div>
                        </div>

                        <!-- Has Discount -->
                        <div class="col-sm-2">
                            <div class="form-check form-switch">
                                <input class="form-check-input" value="1" type="checkbox" name="has_discount"
                                    id="has_discount" {{ old('has_discount', false) ? 'checked' : '' }}>
                                <label class="form-check-label" for="has_discount">Has Discount</label>
                            </div>
                        </div>

                        <!-- Discount Type -->
                        <div class="col-md-3">
                            <label class="form-label" for="discount_type">Discount Type</label>
                            <select name="discount_type" id="discount_type" class="single-select">
                                <option value="">Select Type</option>
                                <option value="percentage" {{ old('discount_type') == 'percentage' ? 'selected' : '' }}>
                                    Percentage</option>
                                <option value="fixed" {{ old('discount_type') == 'fixed' ? 'selected' : '' }}>
                                    Fixed</option>
                            </select>
                        </div>
                        <!-- Discount Value -->
                        <div class="col-md-3">
                            <label class="form-label">Discount Value</label>
                            <input type="number" name="discount_value" class="form-control"
                                value="{{ old('discount_value', '0') }}">
                        </div>
                        <!-- Description -->
                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea name="description" rows="4" class="form-control myEditor">{{ old('description') }}</textarea>
                        </div>

                        <!-- Media Upload -->
                        <div class="col-md-12">
                            <label class="form-label">
                                Upload Product Images <span class="text-light">(Please upload images first, and then select
                                    one image to set as the featured image)</span>
                            </label>
                            <div id="dropzone-area" class="dropzone"></div>
                            <input type="hidden" name="featured_image" id="featured_image">
                        </div>

                        <!-- Has Variations -->
                        <div class="col-md-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" onclick="toggleVariationSection(this)" value="1"
                                    type="checkbox" name="has_variations" id="has_variations"
                                    {{ old('has_variations', false) ? 'checked' : '' }}>
                                <label class="form-check-label" for="has_variations">Has Variations?</label>
                            </div>
                        </div>
                        <div class="border border-light card-body variation-section" style="display: none;">
                            <!-- Variation Section -->
                            <div class="col-md-12">
                                <label class="form-label">Select Attributes</label>
                                <div class="row">
                                    @foreach ($attributes as $attribute)
                                        <div class="col-sm-4">
                                            <label>{{ $attribute->name }}</label>
                                            <select class="multiple-select" name="attributes[{{ $attribute->id }}][]"
                                                data-placeholder="Choose anything" multiple="multiple">
                                                @foreach ($attribute->options as $option)
                                                    <option value="{{ $option->id }}">{{ $option->value }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    @endforeach
                                </div>
                            </div>

                            <!-- Variation Input Table (JS based rows) -->
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
                                        {{-- JavaScript will populate this based on selected options --}}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Submit Button -->
                        <div class="col-md-12 mt-4">
                            <button type="submit" id="product-btn"
                                class="btn btn-light px-5">{{ isset($product) ? 'Update' : 'Save' }}</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    @push('scripts')
        <script>
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
            // Cartesian product helper
            function cartesianProduct(arrays) {
                return arrays.reduce((acc, curr) => {
                    const result = [];
                    acc.forEach(a => {
                        curr.forEach(b => {
                            result.push([...a, b]);
                        });
                    });
                    return result;
                }, [
                    []
                ]);
            }

            // Generate variation combinations
            function generateVariations() {
                const attributeSections = document.querySelectorAll('.variation-section select[multiple]');
                const variationTable = document.querySelector('#variation-table tbody');
                variationTable.innerHTML = '';
                const selectedData = [];
                attributeSections.forEach(select => {
                    const attributeName = select.closest('div').querySelector('label').textContent.trim();
                    const selectedOptions = Array.from(select.selectedOptions).map(opt => ({
                        id: opt.value,
                        value: opt.textContent.trim()
                    }));
                    if (selectedOptions.length) {
                        selectedData.push({
                            name: attributeName,
                            options: selectedOptions
                        });
                    }
                });

                if (!selectedData.length) return;

                const optionSets = selectedData.map(attr =>
                    attr.options.map(option => ({
                        attribute: attr.name,
                        value: option.value,
                        option_id: option.id
                    }))
                );

                const combinations = cartesianProduct(optionSets);

                combinations.forEach((combo, index) => {
                    const key = combo.map(c => `${c.attribute}: <strong>${c.value}</strong>`).join(', ');

                    let hiddenInputs = '';
                    combo.forEach(c => {
                        hiddenInputs +=
                            `<input type="hidden" name="variations[${index}][attributes][${c.attribute}]" value="${c.option_id}">`;
                    });

                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>
                            ${key}
                            ${hiddenInputs}
                        </td>
                        <td>
                            <input type="number" name="variations[${index}][price]" class="form-control" step="0.01" required>
                        </td>
                        <td>
                            <input type="number" name="variations[${index}][stock]" class="form-control" required>
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

            // DOM Ready
            document.addEventListener('DOMContentLoaded', function() {
                const select = document.getElementById('has_variations');
                toggleVariationSection(select);
                $('.variation-section select[multiple]').select2();
                $('.variation-section select[multiple]').on('change', function() {
                    generateVariations();
                });
                $('#variation-table tbody').on('click', '.remove-variation', function() {
                    $(this).closest('tr').remove();
                });

                // Discount related fields
                const hasDiscountCheckbox = document.getElementById('has_discount');
                const discountTypeField = document.getElementById('discount_type').closest('.col-md-3');
                const discountValueField = document.querySelector('input[name="discount_value"]').closest('.col-md-3');

                function toggleDiscountFields() {
                    if (hasDiscountCheckbox.checked) {
                        discountTypeField.style.display = 'block';
                        discountValueField.style.display = 'block';
                    } else {
                        discountTypeField.style.display = 'none';
                        discountValueField.style.display = 'none';
                    }
                }
                // Initial check on page load
                toggleDiscountFields();
                hasDiscountCheckbox.addEventListener('change', toggleDiscountFields);
            });

            $(function() {
                $('.single-select').each(function() {
                    $(this).select2({
                        theme: 'bootstrap4',
                        width: $(this).data('width') ? $(this).data('width') : $(this).hasClass(
                            'w-100') ? '100%' : 'style',
                        placeholder: $(this).data('placeholder'),
                        allowClear: Boolean($(this).data('allow-clear')),
                    });
                });
                $('.multiple-select').each(function() {
                    $(this).select2({
                        theme: 'bootstrap4',
                        width: $(this).data('width') ? $(this).data('width') : $(this).hasClass(
                            'w-100') ? '100%' : 'style',
                        placeholder: $(this).data('placeholder'),
                        allowClear: Boolean($(this).data('allow-clear')),
                    })
                });

                $('.myEditor').each(function(index) {
                    var elementId = $(this).attr('id') || 'editor-' + index;
                    $(this).attr('id', elementId);
                    CKEDITOR.replace(elementId, {
                        width: '100%'
                    });
                });
                ajaxPost('#product-form', '#product-btn', function(response) {
                    successMessage(response.success);
                    window.location = "{{ route('admin.inventory.product.index') }}"

                });
            })

            function makeSlug(val, slugSelector) {
                let slug = val.toLowerCase()
                    .replace(/[^\w ]+/g, '') // remove non-word chars
                    .replace(/ +/g, '-'); // replace spaces with hyphens
                document.querySelector(slugSelector).value = slug;
            }
            Dropzone.autoDiscover = false;
            let selectedFiles = [];
            let featuredImage = null;
            let myDropzone = new Dropzone("#dropzone-area", {
                url: "#", // Prevent auto upload
                maxFiles: 10,
                acceptedFiles: "image/*, video/*",
                addRemoveLinks: true,
                autoProcessQueue: false,
                uploadMultiple: true,
                parallelUploads: 10,
                init: function() {
                    this.on("addedfile", function(file) {
                        selectedFiles.push(file);

                        // Create a checkbox for the "Feature Image"
                        let featureCheckbox = document.createElement("input");
                        featureCheckbox.type = "checkbox";
                        featureCheckbox.classList.add("feature-checkbox");
                        featureCheckbox.style.margin = "5px";
                        featureCheckbox.onclick = function() {
                            if (featureCheckbox.checked) {
                                // Uncheck all other checkboxes
                                let checkboxes = document.querySelectorAll(".feature-checkbox");
                                checkboxes.forEach(function(checkbox) {
                                    if (checkbox !== featureCheckbox) {
                                        checkbox.checked = false;
                                    }
                                });

                                // Mark this file as the featured image
                                featuredImage = file;
                                $('#featured_image').val(file.name)
                                // alert(file.name + " is now the featured image!");
                            } else {
                                // If unchecked, clear featured image if this was the one
                                if (featuredImage && featuredImage.name === file.name) {
                                    featuredImage = null;
                                }
                            }
                        };

                        // Append the checkbox to the file preview element
                        let previewElement = file.previewElement;
                        let checkboxLabel = document.createElement("label");
                        checkboxLabel.innerText = "Set as Featured Image";
                        checkboxLabel.style.marginLeft = "10px";
                        checkboxLabel.style.color = "black";
                        previewElement.appendChild(checkboxLabel);
                        previewElement.appendChild(featureCheckbox);
                    });

                    this.on("removedfile", function(file) {
                        selectedFiles = selectedFiles.filter(f => f.name !== file.name);
                        if (featuredImage && featuredImage.name === file.name) {
                            featuredImage = null; // Clear featured image if it was removed
                        }
                    });
                }
            });
            window.getSelectedFile = function() {
                return selectedFiles;
            };
        </script>
    @endpush
@endsection
