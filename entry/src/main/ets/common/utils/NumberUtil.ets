/**
 *
 * @author: 坚果
 * @date: 2024/5/5
 * @phone：17752170152
 * @organization：坚果派
 */


class NumberUtil {
  _parseInt(str: string, radix: number): number {
    let res = 0;

    str = String(str).trim().split('.')[0]
    let length = str.length;

    for (let i = 0; i < length; i++) {
      let arr = str.split('').reverse().join('');
      res += Math.floor(Number(arr[i])) * Math.pow(radix, i)
    }

    return res;
  }
}

let numberUtil = new NumberUtil();

export default numberUtil as NumberUtil;