class Report {
  var _subject;
  var _image;
  var _lat;
  var _lan;
  var _sendTime;

  Report(this._subject, this._image, this._lat, this._lan, this._sendTime);

  get sendTime => _sendTime;

  get subject => _subject;

  get lan => _lan;

  get lat => _lat;

  get image => _image;

  set sendTime(value) {
    _sendTime = value;
  }

  set lan(value) {
    _lan = value;
  }

  set lat(value) {
    _lat = value;
  }

  set image(value) {
    _image = value;
  }

  set subject(value) {
    _subject = value;
  }
}
