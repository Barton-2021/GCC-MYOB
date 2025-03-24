/**
 *
 * @author: 坚果
 * @date: 2024/5/5
 * @phone：17752170152
 * @organization：坚果派
 */


import geoLocationManager from '@ohos.geoLocationManager';

class LocationUtil {
  geolocationOn(locationChange: (location: geoLocationManager.Location) => void): void {
    let requestInfo: geoLocationManager.LocationRequest = {
      'priority': 0x203,
      'scenario': 0x300,
      'timeInterval': 0,
      'distanceInterval': 0,
      'maxAccuracy': 0
    }
    try {
      geoLocationManager.on('locationChange', requestInfo, locationChange);
    } catch (err) {
      console.error("locationChange error:" + JSON.stringify(err));
    }
  }

  geolocationOff(): void {
    geoLocationManager.off('locationChange');
  }
}

let locationUtil = new LocationUtil();

export default locationUtil as LocationUtil;