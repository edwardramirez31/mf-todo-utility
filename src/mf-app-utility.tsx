// Anything exported from this file is importable by other in-browser modules.
import { Subject } from 'rxjs';

import type DjangoTask from './types';

export const UTILITY_CONST = 'CONSTANT';

export const taskSubscription = new Subject<DjangoTask>();

export function utilityFunc(item: DjangoTask): void {
  // eslint-disable-next-line no-console
  console.log('HEREEE AT UTILITY ====================');
  // eslint-disable-next-line no-console
  console.log(item);
}
export { default as RootComponent } from './root.component';

export { default as DjangoTask } from './types';
