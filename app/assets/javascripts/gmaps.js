var map;
var jsonObj = [];

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 5,
    center: {lat: 21, lng: 105.8}
  });

  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer({
    draggable: false,
    map: map,
    panel: document.getElementById('right-panel')
  });

  directionsDisplay.addListener('directions_changed', function() {
    computeTotalDistance(directionsDisplay.getDirections());
  });
  var origin = document.getElementById('address1').value;
  var destination = document.getElementById('address2').value;

  displayRoute(origin, destination, directionsService,
      directionsDisplay);
  var geocoder_origin = new google.maps.Geocoder();
  var geocoder_destination = new google.maps.Geocoder();
  geocodeAddress(geocoder_origin, origin, destination, 0);
  geocodeAddress(geocoder_destination, destination, destination, 0);

  new AutocompleteDirectionsHandler(map);
}

function geocodeAddress(geocoder, address, plant_des, plant_id) {
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === 'OK') {
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
      });
      var infowindow = new google.maps.InfoWindow({
        content: plant_des
      });
      infowindow.open(map, marker);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function displayRoute(origin, destination, service, display) {
  service.route({
    origin: origin,
    destination: destination,
    waypoints: jsonObj,
    travelMode: 'DRIVING',
    avoidTolls: true
  }, function(response, status) {
    if (status === 'OK') {
      display.setDirections(response);
    } else {
      alert('Could not display directions due to: ' + status);
    }
  });
}

function computeTotalDistance(result) {
  var total = 0;
  var myroute = result.routes[0];
  for (var i = 0; i < myroute.legs.length; i++) {
    total += myroute.legs[i].distance.value;
  }
  total = total / 1000;
  document.getElementById('total').innerHTML = total + ' km';
}

function AutocompleteDirectionsHandler(map) {
  this.map = map;
  this.originPlaceId = null;
  var destinationInput = document.getElementById('place-input');

  var destinationAutocomplete = new google.maps.places.Autocomplete(
      destinationInput, {placeIdOnly: true});
  this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');
}

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
  var me = this;
  autocomplete.bindTo('bounds', this.map);
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.place_id) {
      window.alert('Please select an option from the dropdown list.');
      return;
    }
    me.destinationPlaceId = place.place_id;
    var service = new google.maps.places.PlacesService(map);
    service.getDetails({
        placeId: place.place_id
    }, function (result, status) {
        var marker = new google.maps.Marker({
            map: map,
            place: {
                placeId: place.place_id,
                location: result.geometry.location
            }
        });
    });
  });
};

