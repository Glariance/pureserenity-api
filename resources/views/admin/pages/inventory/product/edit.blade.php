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
                enctype="multipart/form-data" data-dropzone-single-field="image">
                @csrf
                @method('PUT')

                <div class="card">
                    <div class="card-body row g-3">

                        <div class="col-md-12">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control"
                                value="{{ old('name', $product->name) }}" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Amazon Link</label>
                            <input type="url" name="amazon_link" class="form-control"
                                value="{{ old('amazon_link', $product->amazon_link) }}"
                                placeholder="https://www.amazon.com/...">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea name="description" rows="6" class="form-control myEditor">{{ old('description', $product->description) }}</textarea>
                        </div>

                        @if ($product->mediaFeatured)
                            <div class="col-md-12">
                                <label class="form-label d-block">Current Image</label>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="{{ asset('storage/' . $product->mediaFeatured->path) }}" alt="Current image"
                                        class="rounded border" width="200">
                                    <small class="text-muted">Uploading a new image will replace this one.</small>
                                </div>
                            </div>
                        @endif

                        <div class="col-md-12">
                            <label class="form-label">Upload New Image</label>
                            <div id="dropzone-area" class="dropzone border rounded bg-light"></div>
                            <small class="text-muted d-block mt-2">Optional — upload one image (max 20MB) to replace the current
                                photo.</small>
                        </div>

                        <div class="col-12 text-end">
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
        $(function() {
            $('.myEditor').each(function(index) {
                let elementId = $(this).attr('id') || 'editor-' + index;
                $(this).attr('id', elementId);
                CKEDITOR.replace(elementId, { width: '100%' });
            });

            ajaxPost('#product-form', '#product-btn', function(response) {
                successMessage(response.success);
                window.location = "{{ route('admin.inventory.product.index') }}"
            });
        });

        (function() {
            Dropzone.autoDiscover = false;
            let selectedFile = null;

            const myDropzone = new Dropzone("#dropzone-area", {
                url: "#",
                maxFiles: 1,
                acceptedFiles: "image/*",
                addRemoveLinks: true,
                autoProcessQueue: false,
                dictDefaultMessage: "Drop new product image here or click to upload",
                init: function() {
                    this.on("addedfile", function(file) {
                        if (selectedFile && selectedFile !== file) {
                            this.removeFile(selectedFile);
                        }
                        selectedFile = file;
                    });
                    this.on("removedfile", function(file) {
                        if (selectedFile === file) {
                            selectedFile = null;
                        }
                    });
                }
            });

            window.getSelectedFile = function() {
                return selectedFile;
            };
        })();
    </script>
@endpush
