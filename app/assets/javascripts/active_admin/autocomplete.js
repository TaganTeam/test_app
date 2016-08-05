$(document).ready(function() {

 if ($('#edit_user').length > 0 || $('#new_user').length > 0) {

   $('#new_user').keydown(function (event) {
     if (event.keyCode == 13) {
       event.preventDefault();
       return false;
     }
   });

   $('#edit_user').keydown(function (event) {
     if (event.keyCode == 13) {
       event.preventDefault();
       return false;
     }
   });

   var autocomplete, userPlaceOfBirth;

   autocomplete = new google.maps.places.Autocomplete(
       (document.getElementById('user_location')),
       {types: ['geocode']});

   userPlaceOfBirth = new google.maps.places.Autocomplete(
       (document.getElementById('user_place_of_birth')),
       {types: ['geocode']});

   autocomplete.addListener('place_changed', fillInAddress);
   userPlaceOfBirth.addListener('place_changed', fillInAddressU);


   function fillInAddress() {

     var place = autocomplete.getPlace();
     $('#user_location_id').val(place.place_id)
   }

     function fillInAddressU() {

       var place = userPlaceOfBirth.getPlace();
       $('#user_place_id').val(place.place_id)
     }
   }
 });