// Anything exported from this file is importable by other in-browser modules.

import type DjangoTask from './types';

export const UTILITY_CONST = 'YOUR_CONSTANT';

export const newTasks: DjangoTask[] = [];
export function utilityFunc(item: DjangoTask): void {
  // eslint-disable-next-line no-console
  console.log('HEREEE AT UTILITY ====================');
  newTasks.push(item);
}
export { default as RootComponent } from './root.component';
export { default as DjangoTask } from './types';
