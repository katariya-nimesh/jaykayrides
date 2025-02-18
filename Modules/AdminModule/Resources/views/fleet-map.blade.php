@section('title', translate('fleet_map'))

@extends('adminmodule::layouts.master')

@push('css_or_js')
    @php($map_key = businessConfig(GOOGLE_MAP_API)?->value['map_api_key'] ?? null)
    <script src="https://maps.googleapis.com/maps/api/js?key={{$map_key}}&libraries=places"></script>
    <script src="{{asset('public/assets/admin-module/js/maps/markerclusterer.js')}}"></script>
@endpush

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <div class="w-100 max-w-299px">
                        <h4>{{translate('User Live View')}}</h4>
                        <p>{{translate("Monitor your drivers from here")}}</p>
                    </div>
                </div>
                <div class="card-body tab-filter-container">
                    <div class="border-bottom d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                        {{-- Tab Menu --}}
                        <ul class="nav d-inline-flex nav--tabs-2 rounded bg-white align-items-center mt-2"
                            id="zone-tab-menu">
                            <li class="nav-item">
                                <a href="{{route('admin.fleet-map',['type' => ALL_DRIVER, 'zone_id' => request('zone_id')])}}"
                                   class="nav-link text-capitalize {{request('type') == ALL_DRIVER ? 'active' : ''}}"
                                   data-tab-target="all-driver">{{translate("All Drivers")}}</a>
                            </li>
                            <li class="nav-item">
                                <a href="{{route('admin.fleet-map',['type' => DRIVER_ON_TRIP, 'zone_id' => request('zone_id')])}}"
                                   class="nav-link text-capitalize {{request('type') == DRIVER_ON_TRIP ? 'active' : ''}}"
                                   data-tab-target="trip-driver">{{translate("On-trip")}}</a>
                            </li>
                            <li class="nav-item">
                                <a href="{{route('admin.fleet-map',['type' => DRIVER_IDLE, 'zone_id' => request('zone_id')])}}"
                                   class="nav-link text-capitalize {{request('type') == DRIVER_IDLE ? 'active' : ''}}"
                                   data-tab-target="idle-driver">{{translate("Idle")}}</a>
                            </li>
                            {{--                            <li class="nav-item">--}}
                            {{--                                <a class="nav-link text-capitalize">|</a>--}}
                            {{--                            </li>--}}
                            {{--                            <li class="nav-item">--}}
                            {{--                                <a href="{{route('admin.fleet-map','all-customer')}}"--}}
                            {{--                                   class="nav-link text-capitalize {{request('type') == 'all-customer' ? 'active' : ''}}"--}}
                            {{--                                   data-tab-target="customer">{{translate("Customers")}}</a>--}}
                            {{--                            </li>--}}
                        </ul>
                        <form action="{{request()->fullUrl()}}" id="zoneSubmitForm" class="pb-1">
                            <div class="">
                                <select class="js-select h-35" name="zone_id" id="selectZone">
                                    @if(count($zones)>0)
                                        @foreach($zones as $key =>$zone)
                                            <option
                                                value="{{$zone->id}}" {{request('zone_id') == $zone->id ? "selected" :""}}>{{$zone->name}}</option>
                                        @endforeach
                                    @else
                                        <option
                                            value="" selected disabled>{{translate("zone_not_found")}}</option>
                                    @endif
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="zone-lists d-flex flex-wrap gap-3">
                        <div class="zone-lists__left">
                            <div id="zone-tab-content">

                                <div>
                                    @if(request('type') == ALL_DRIVER)
                                        <div data-tab-type="all-driver">
                                            <h4 class="mb-2">{{translate("Driver List")}}</h4>
                                            <form action="javascript:;"
                                                  class="search-form search-form_style-two" method="GET">
                                                <div class="input-group search-form__input_group">
                                                <span class="search-form__icon">
                                                    <i class="bi bi-search"></i>
                                                </span>
                                                    <input type="search" class="theme-input-style search-form__input"
                                                           value="{{ request('search') }}" name="search" id="search"
                                                           placeholder="{{ translate('search_driver') }}">
                                                </div>
                                                <button type="submit" class="btn btn-primary search-submit"
                                                        data-url="{{ url()->full() }}">{{ translate('search') }}</button>
                                            </form>
                                            <ul class="zone-list">
                                                @include('adminmodule::partials.fleet-map._fleet-map-driver-list')
                                            </ul>
                                        </div>
                                    @endif
                                    @if(request('type') == DRIVER_ON_TRIP)
                                        <div data-tab-type="trip-driver">
                                            <h4 class="mb-2">{{translate("On Trip Driver")}}</h4>
                                            <form action="javascript:;"
                                                  class="search-form search-form_style-two" method="GET">
                                                <div class="input-group search-form__input_group">
                                                <span class="search-form__icon">
                                                    <i class="bi bi-search"></i>
                                                </span>
                                                    <input type="search" class="theme-input-style search-form__input"
                                                           value="{{ request('search') }}" name="search" id="search"
                                                           placeholder="{{ translate('search_driver') }}">
                                                </div>
                                                <button type="submit" class="btn btn-primary search-submit"
                                                        data-url="{{ url()->full() }}">{{ translate('search') }}</button>
                                            </form>
                                            <ul class="zone-list">
                                                @include('adminmodule::partials.fleet-map._fleet-map-driver-list')
                                            </ul>
                                        </div>

                                    @endif
                                    @if(request('type') == DRIVER_IDLE)
                                        <div data-tab-type="idle-driver">
                                            <h4 class="mb-2">{{translate("Idle Driver")}}</h4>
                                            <form action="javascript:;"
                                                  class="search-form search-form_style-two" method="GET">
                                                <div class="input-group search-form__input_group">
                                                <span class="search-form__icon">
                                                    <i class="bi bi-search"></i>
                                                </span>
                                                    <input type="search" class="theme-input-style search-form__input"
                                                           value="{{ request('search') }}" name="search" id="search"
                                                           placeholder="{{ translate('search_driver') }}">
                                                </div>
                                                <button type="submit" class="btn btn-primary search-submit"
                                                        data-url="{{ url()->full() }}">{{ translate('search') }}</button>
                                            </form>
                                            <ul class="zone-list">
                                                @include('adminmodule::partials.fleet-map._fleet-map-driver-list')
                                            </ul>
                                        </div>

                                    @endif

                                </div>
                            </div>

                            {{-- Driver Details --}}
                            <div id="driverDetails">
                            </div>
                        </div>
                        <div class="zone-lists__map" id="partialFleetMap">
                            @include('adminmodule::partials.fleet-map._fleet-map-view')
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {{-- Overlay --}}
        <div class="js-select-overlay">
            <div class="inner-div">
                <select class="js-select">
                    <option value="">{{count($zones)?$zones[0]?->name:translate("zone_not_found")}}</option>
                </select>
                <div class="mt-2">
                    {{translate('From here select your zone and see the filtered data')}}
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" id="driverId">
@endsection

@push('script')

    <script>

        "use strict";
        $(document).ready(function () {
            let bounds = new google.maps.LatLngBounds();
            let map = "";
            let polygons = [];
            let markerCluster = null;
            let activeInfoWindow = null;
            let markers = [];
            let activeData = null

            function initMap(
                mapSelector,
                lat,
                lng,
                title,
                markersData,
                input,
                data = []
            ) {

                let zoomValue = 13;
                if (lat == 0 && lng == 0) {
                    zoomValue = 2;
                }
                let polygons = [];
                if (zoomValue == 2) {
                    map = new google.maps.Map(document.getElementById(mapSelector), {
                        zoom: 2, // Low zoom level to display the world
                        center: {lat: 0, lng: 0},
                    });
                } else {
                    map = new google.maps.Map(document.getElementById(mapSelector), {
                        zoom: zoomValue,
                        center: {lat: lat, lng: lng},
                        fullscreenControl: true,
                        mapTypeControlOptions: {
                            position: google.maps.ControlPosition.BOTTOM_LEFT,
                        },
                    });
                }

                if (zoomValue == 13) {
                    for (let i = 0; i < data.length; i++) {
                        polygons.push(
                            new google.maps.Polygon({
                                paths: data[i],
                                strokeColor: "#000000",
                                strokeOpacity: 0.2,
                                strokeWeight: 2,
                                fillColor: "#000000",
                                fillOpacity: 0.05,
                            })
                        );
                        polygons[i].setMap(map);
                        polygons[i].getPaths().forEach(function (path) {
                            path.forEach(function (latlng) {
                                bounds.extend(latlng);
                            });
                        });
                    }
                    map.fitBounds(bounds);
                }

                const infoWindow = new google.maps.InfoWindow();


                const searchBox = new google.maps.places.SearchBox(input);

                map.addListener("bounds_changed", function () {
                    searchBox.setBounds(map.getBounds());
                });

                let searchMarkers = [];

                searchBox.addListener("places_changed", function () {
                    const places = searchBox.getPlaces();

                    if (places.length === 0) {
                        return;
                    }

                    searchMarkers.forEach(function (marker) {
                        marker.setMap(null);
                    });
                    searchMarkers = [];

                    const bounds = new google.maps.LatLngBounds();

                    places.forEach(function (place) {
                        if (!place.geometry || !place.geometry.location) {
                            console.log("Returned place contains no geometry");
                            return;
                        }

                        const marker = new google.maps.Marker({
                            map: map,
                            icon: {
                                url: place.icon,
                                size: new google.maps.Size(71, 71),
                                origin: new google.maps.Point(0, 0),
                                anchor: new google.maps.Point(17, 34),
                                scaledSize: new google.maps.Size(25, 25),
                            },
                            title: place.name,
                            position: place.geometry.location,
                        });

                        searchMarkers.push(marker);

                        if (place.geometry.viewport) {
                            bounds.union(place.geometry.viewport);
                        } else {
                            bounds.extend(place.geometry.location);
                        }
                    });

                    map.fitBounds(bounds);
                });

                updateMarkers(markersData);

            }


            function updateMarkers(markerData, openMarkers) {
                if (markers.length > 0) {
                    for (let i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                    }

                    markers = [];
                }

                if (markerCluster) {
                    markerCluster.clearMarkers();
                }

                if (markerData) {
                    const mapMarkers = markerData.map(function (data) {
                        const marker = new google.maps.Marker({
                            position: data.position,
                            title: data.title,
                            icon: data.icon,
                        });
                        const infoWindow = new google.maps.InfoWindow({
                            content: `<div class="map-clusters-custom-window">
                                <h6><a href="${data.driver}" target="_blank">${data.title}</a></h6>
                                <p><a href="${data.trip}" target="_blank">${data.subtitle || ""}</a></p>
                            </div>`,
                        });

                        if (data.position.lat === activeData?.position?.lat && data.position.lng === activeData?.position?.lng) {
                            infoWindow.open(map, marker)
                        }

                        if (openMarkers) {
                            infoWindow.open(map, marker)
                        }

                        marker.addListener("click", function () {
                            if (activeInfoWindow == infoWindow) {
                                activeInfoWindow.close();
                                activeInfoWindow = null;
                                activeData = null;
                            } else {
                                if (activeInfoWindow) activeInfoWindow.close();
                                singleViewZoom(data.position)
                                infoWindow.open(map, marker);
                                activeInfoWindow = infoWindow;
                                activeData = data
                            }
                        });

                        marker.setMap(map);
                        markers.push(marker);

                        return marker;
                    });

                    markerCluster = new markerClusterer.MarkerClusterer({
                        map: map,
                        markers: mapMarkers,
                    });
                }


            }

            function fetchModelUpdate() {
                console.log("double")
                $.get({
                    url: "{{ route('admin.fleet-map-view-using-ajax') }}",
                    dataType: "json",
                    data: {
                        zone_id: "{{ request('zone_id') }}",
                        type: "{{ $type }}",
                        search: "{{ request('search') }}",
                    },
                    success: function (response) {
                        if (response) {
                            updateMarkers(JSON.parse(response.markers));
                        }
                    },
                    error: function (xhr, status, error) {
                        toastr.error('{{translate('failed_to_load_data')}}');
                    },
                });
            }

            let isSingleView = false;
            const singleViewZoom = (center) => {
                if (map.getZoom() <= 19) {
                    map.setCenter({
                        lat: center.lat,
                        lng: center.lng
                    });
                    map.setZoom(19);
                }
            }

            function fetchSingleModelUpdate() {
                var id = $("#driverId").val();
                var url = "{{ route('admin.fleet-map-view-single-driver',':id') }}";
                $.get({
                    url: url.replace(':id', id),
                    dataType: "json",
                    data: {
                        zone_id: "{{ request('zone_id') }}",
                    },
                    success: function (response) {
                        if (response) {
                            updateMarkers(JSON.parse(response.markers), true);
                            if (!isSingleView) {
                                singleViewZoom(JSON.parse(response.markers)[0].position)
                            }
                            isSingleView = true;
                        }
                    },
                    error: function (xhr, status, error) {
                        toastr.error('{{translate('failed_to_load_data')}}');
                    },
                });
            }

            var singleInterval;
            var doubleInterval;

            if ($("#driverId").val()) {
                singleInterval = setInterval(fetchSingleModelUpdate, 10000);
            } else {
                doubleInterval = setInterval(fetchModelUpdate, 10000);
            }


            $(".map-container").each(function () {
                const map = $(this).find(".map");
                const input = $(this).find(".map-search-input")[0];
                const lat = map.data("lat");
                const lng = map.data("lng");
                const title = map.data("title");
                const markers = map.data("markers");
                const polygonData = map.data("polygon");
                initMap(map.attr("id"), lat, lng, title, markers, input, polygonData);
            });

            $('#selectZone').on('change', function () {
                $('#zoneSubmitForm').submit();
            });

            resetView();

            function resetView() {
                $('#zone-tab-content').show();
                $('#driverDetails').hide();

            }

            $('.zone-list').find('.driver-details').on('click', 'label', function (e) {
                let url = "{{ route('admin.fleet-map-driver-details', ':id') }}";
                url = url.replace(':id', $(this).attr('data-id'));
                $.get({
                    url: url,
                    dataType: 'json',
                    success: function (response) {
                        e.preventDefault();
                        $('#zone-tab-content').hide();
                        $('#driverDetails').show();
                        $('#driverDetails').empty().html(response);
                        $('.customer-back-btn').on('click', function (e) {
                            e.preventDefault();
                            $("#driverId").val("");
                            clearInterval(singleInterval)
                            fetchModelUpdate();
                            doubleInterval = setInterval(fetchModelUpdate, 10000);
                            resetView();
                            map.fitBounds(bounds);
                        });
                    },
                    error: function (xhr, status, error) {
                        toastr.error('{{translate('failed_to_load_data')}}')
                    },
                });
                $("#driverId").val($(this).attr('data-id'));
                fetchSingleModelUpdate();
                singleInterval = setInterval(fetchSingleModelUpdate, 10000);
                isSingleView = false;
                clearInterval(doubleInterval)
            });

            if (localStorage.getItem('firstTimeUser') === null) {
                $('.js-select-overlay').show();
                localStorage.setItem('firstTimeUser', 'true');
            }
            $('.js-select-overlay').on('click', function () {
                $(this).hide()
            })
        });

    </script>
@endpush
