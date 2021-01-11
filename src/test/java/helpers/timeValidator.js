function fn(s) {
  var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
  var dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'");
  try {
    dateFormat.parse(s).time;
    return true;
  } catch(e) {
    karate.log('*** invalid date string:', s);
    return false;
  }
}