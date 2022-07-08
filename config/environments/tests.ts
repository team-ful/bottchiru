import {URL} from 'url';
import {Config} from '../config';

const config: Config = {
  environment: 'test',

  host: new URL('http://localhost:3000'),

  cateiruSSOEndpoint: new URL('https://sso.cateiru.com'),
  cateiruSSOTokenEndpoint: new URL(
    'https://api.sso.cateiru.com/v1/oauth/token'
  ),
  cateiruSSOPublicKeyEndpoint: new URL(
    'https://api.sso.cateiru.com/v1/oauth/jwt/key'
  ),
  cateiruSSOClientSecret: 'cateiru-sso-client-id',
  cateiruSSOClientId: 'cateiru-sso-client-secret',

  sessionTokenLen: 64,
  sessionCookieName: 'noratomo-session',
  sessionPeriodDay: 7,
  sessionCookieOptions: () => {
    const date = new Date(Date.now());
    date.setDate(date.getDate() + config.sessionPeriodDay);

    return {
      domain: 'localhost',
      expires: date,
      maxAge: config.sessionPeriodDay * 86400,
      sameSite: 'strict',
      secure: false, // テスト用であるためfalse
      httpOnly: true,
      path: '/',
    };
  },

  refreshTokenLen: 128,
  refreshCookieName: 'noratomo-refresh',
  refreshPeriodDay: 30,
  refreshCookieOptions: () => {
    const date = new Date(Date.now());
    date.setDate(date.getDate() + config.refreshPeriodDay);

    return {
      domain: 'localhost',
      expires: date,
      maxAge: config.refreshPeriodDay * 86400,
      sameSite: 'strict',
      secure: true,
      httpOnly: true,
      path: '/',
    };
  },

  otherCookieName: 'noratomo-options',
  otherCookieOptions: () => {
    const date = new Date(Date.now());
    date.setDate(date.getDate() + config.refreshPeriodDay);

    return {
      domain: 'localhost',
      expires: date,
      maxAge: config.refreshPeriodDay * 86400,
      sameSite: 'strict',
      secure: false,
      httpOnly: false,
      path: '/',
    };
  },

  db: {
    host: '127.0.0.1',
    user: 'docker',
    password: 'docker',
    database: 'test',
  },

  // Cloud Storage
  storageHost: 'http://gcs:4443',
  publicStorageHost: new URL('http://localhost:4443'),
  bucketName: 'noratomotest',
};

export default config;
