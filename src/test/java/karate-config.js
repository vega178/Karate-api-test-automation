function fn() {    
  var env = karate.env; // get system property 'karate.env'
  var System = Java.type("java.lang.System");
  var envSystem = System.getProperty("ENVIRONMENT");

  if (env === null || !env ) {
    env = 'dev';
  }

  if (env != 'dev') {
    env = envSystem.toLocaleLowerCase();
  }

  var config = {
    baseUrl: 'https://conduit.productionready.io/api'
  }

  switch(env) {
    case 'dev':
      config.userEmail = 'estebanvegapatio@gmail.com';
      config.userPassword = 'Ab1234567!';
      break;
    case 'qa':
      config.userEmail = 'estebanvegapatio_qa@gmail.com';
      config.userPassword = 'Ab1234567!';
      break;
    default :
      karate.log('User doesnt exists', env);
  }

  var loginServiceResponse = karate.callSingle('classpath:helpers/login.feature', config).sessionToken;
  karate.configure('headers', {Authorization: 'Token ' + loginServiceResponse});

  return config;
}