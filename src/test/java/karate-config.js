function fn() {    
  var env = karate.env; // get system property 'karate.env'
  var System = Java.type("java.lang.System");
  var envSystem = System.getProperty("ENVIRONMENT");
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';
  }

  var config = {
    baseUrl: 'https://conduit.productionready.io/api'
  }

  //TODO: FALTA RESOLVER EL ISSUE CUANDO NO SE CAMBIA EL ENVIRONMENT DIFERENTE QUE DEV!!
  if (envSystem.toLocaleLowerCase() != 'dev') {
    env = envSystem.toLocaleLowerCase();
  }

  switch(env) {
    case 'dev':
      config.userEmail = 'estebanvegapatio@gmail.com';
      config.userPassword = 'Ab1234567!';
    case 'qa':
      config.userEmail = 'estebanvegapatio_qa@gmail.com';
      config.userPassword = 'Ab1234567!';
      break;
  }
  /*if (env == 'dev') {
    config.userEmail = 'estebanvegapatio@gmail.com';
    config.userPassword = 'Ab1234567!';
  } else if (env == 'qa') {
    config.userEmail = 'estebanvegapatio_qa@gmail.com';
    config.userPassword = 'Ab1234567!';
  }*/

  var loginServiceResponse = karate.callSingle('classpath:helpers/login.feature', config).sessionToken;
  karate.configure('headers', {Authorization: 'Token ' + loginServiceResponse});

  return config;
}