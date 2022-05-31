export interface SessionModel {
  session_token: string;
  date: Date;
  period_date: Date;
  user_id: number;
}

export class Session implements SessionModel {
  readonly session_token: string;
  readonly date: Date;
  readonly period_date: Date;
  readonly user_id: number;

  constructor(row: SessionModel) {
    this.session_token = row.session_token;
    this.date = new Date(row.date);
    this.period_date = new Date(row.period_date);
    this.user_id = row.user_id;
  }

  /**
   * Sessionが有効期限かどうかを判定する
   *
   * @returns {boolean} - 有効期限切れの場合はtrue
   */
  public isPeriod(): boolean {
    const now = new Date(Date.now());

    return now > this.period_date;
  }
}