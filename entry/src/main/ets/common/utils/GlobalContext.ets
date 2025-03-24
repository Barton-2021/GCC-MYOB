/**
 *
 * @author: 坚果
 * @date: 2024/5/5
 * @phone：17752170152
 * @organization：坚果派
 */


import data_preferences from '@ohos.data.preferences';

export class GlobalContext {
  private constructor() {
  }

  private static instance: GlobalContext;
  private _objects = new Map<string, Promise<data_preferences.Preferences>>();

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Promise<data_preferences.Preferences> | undefined {
    return this._objects.get(value);
  }

  setObject(key: string, objectClass: Promise<data_preferences.Preferences>): void {
    this._objects.set(key, objectClass);
  }
}