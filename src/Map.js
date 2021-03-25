/* eslint-disable import/no-webpack-loader-syntax */
import React from "react";

import mapboxgl from "mapbox-gl/dist/mapbox-gl-csp";
import MapboxWorker from "worker-loader!mapbox-gl/dist/mapbox-gl-csp-worker";

mapboxgl.workerClass = MapboxWorker;
mapboxgl.accessToken = process.env.REACT_APP_MAPBOX_SECRET;

const useMap = ({ lng, lat, zoom }) => {
  const mapContainer = React.useRef();

  React.useEffect(() => {
    const map = new mapboxgl.Map({
      container: mapContainer.current,
      style: "mapbox://styles/mapbox/outdoors-v11",
      center: [lng, lat],
      zoom,
    });

    new mapboxgl.Marker().setLngLat([lng, lat]).addTo(map);

    map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true,
        },
        trackUserLocation: true,
      })
    );

    map.addControl(new mapboxgl.NavigationControl(), "top-left");

    return () => map.remove();
  }, [lng, lat, zoom]);

  return mapContainer;
};

const Map = ({ lng, lat, zoom, width, height }) => {
  const mapContainer = useMap({ lng, lat, zoom });
  return React.useMemo(
    () => <div style={{ width, height }} ref={mapContainer} />,
    [height, mapContainer, width]
  );
};

export default Map;
