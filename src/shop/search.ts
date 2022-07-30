import {ApiError} from 'next/dist/server/api-utils';
import config from '../../config';
import Base from '../base/base';
import {
  GourmetRequest,
  GourmetResponseLite,
} from '../services/api/hotpepper/gourmet';
import {HotPepper} from '../services/api/hotpepper/hotpepper';

/**
 *
 * @param {Base} base - base
 */
export async function shopSearch(base: Base<GourmetResponseLite>) {
  let page = NaN;
  try {
    page = parseInt(base.getQuery('page') || '0');
  } catch (e) {
    if (e instanceof Error) {
      throw new ApiError(400, 'Illegal parse');
    }
  }

  const query: GourmetRequest = {
    key: config.hotpepperApiKey,
    type: 'lite',
    count: config.searchCount,
    start: config.searchCount * page,
  };

  // 検索キーワード
  const keyword = base.getQuery('keyword');

  if (typeof keyword === 'undefined') {
    // keywordが設定されていない場合はlat, lonを求める（必須）
    const lat = base.getQuery('lat', true);
    const lon = base.getQuery('lon', true);

    const range = base.getQuery('range') || '3';

    try {
      query.lat = parseInt(lat);
      query.lon = parseInt(lon);
      query.range = ((parseInt(range) % 5) + 2) as 1 | 2 | 3 | 4 | 5;
    } catch (e) {
      if (e instanceof Error) {
        throw new ApiError(400, 'Illegal parse');
      }
    }
  } else {
    query.keyword = keyword;
  }

  const hotpepper = new HotPepper();

  const data = await hotpepper.search(query);

  base.sendJson(data);
}
