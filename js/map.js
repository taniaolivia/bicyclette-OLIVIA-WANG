let myMap;

let goldIcon = new L.Icon({
    iconUrl: 'img/marker-icon-2x-gold.png',
    shadowUrl: 'img/marker-shadow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
});


let redIcon = new L.Icon({
    iconUrl: 'img/marker-icon-2x-red.png',
    shadowUrl: 'img/marker-shadow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
});

let violetIcon = new L.Icon({
    iconUrl: 'img/marker-icon-2x-violet.png',
    shadowUrl: 'img/marker-shadow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
});

let blueIcon = new L.Icon({
    iconUrl: 'img/marker-icon-2x-blue.png',
    shadowUrl: 'img/marker-shadow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41]
});


function initMap()
{
    // Creation de l'objet "myMap" et insertion dans l'element HTML qui a l'ID "map"
    myMap = L.map('map').setView([48.687, 6.22], 5);
    // Recuperation des cartes sur openstreetmap.fr
    L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
        {
            minZoom: 13,
            maxZoom: 20
        }).addTo(myMap);
}

let getXMLFileClient = function(path) {
    let xhr = new XMLHttpRequest();
    xhr.open("GET", path, false);
    xhr.send();
    let lat = xhr.responseXML.getElementsByTagName('lat');
    let long = xhr.responseXML.getElementsByTagName('lon');
    L.marker([lat[0].innerHTML, long[0].innerHTML],{icon:goldIcon}).bindPopup('<b>Vous êtes ici!</b>').addTo(myMap);
}

let getXMLFileVelo = function(path) {
    let xhr = new XMLHttpRequest();
    xhr.open("GET", path, false);
    xhr.send();
    let markers = xhr.responseXML.querySelectorAll('marker');
    markers.forEach(marker => {
        L.marker([marker.getAttribute('lat'), marker.getAttribute('lng'),],{icon:redIcon})
            .bindPopup("<b><u>" + marker.getAttribute('name') + "</u></b>"
                     + "<br><br><b>Vélos disponibles : </b>" + marker.getElementsByTagName('available')[0].innerHTML
                        + "<br><b>Places libres : </b>" + marker.getElementsByTagName('free')[0].innerHTML
                        + "<br><b>Total : </b>" + marker.getElementsByTagName('total')[0].innerHTML).addTo(myMap);
    });
}

let getXMLFilePositions = function(path) {
    let xhr = new XMLHttpRequest();
    xhr.open("GET", path, false);
    xhr.send();
    let address = xhr.responseXML.querySelectorAll('address');
    address.forEach(addresse => {
        let url = "https://nominatim.openstreetmap.org/search?format=json&limit=3&q=" + addresse.innerHTML;
        xhr.onreadystatechange = function()
        {
            if (this.readyState === 4 && this.status === 200)
            {
                let data = JSON.parse(this.responseText);
                L.marker([data[0].lat, data[0].lon],{icon:violetIcon}).bindPopup('<b>'+ addresse.getAttribute('name')+'</b>').addTo(myMap);
            }
        };
        xhr.open("GET", url, false);
        xhr.send();
    });


}


initMap();
getXMLFileClient("./data/position/position_client.xml");
getXMLFileVelo("./data/parkings/parkings2.xml");
getXMLFilePositions("./data/position/positions.xml");
