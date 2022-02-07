enum ErgMachineType {
  staticD,
  staticC,
  staticA,
  staticB,
  staticE,
  staticSimulator,
  staticDynamic,
  slidesA,
  slidesB,
  slidesC,
  slidesD,
  slidesE,
  slidesDynamic,
  staticDyno,
  staticSki,
  staticSkiSimulator,
  bike,
  bikeArms,
  bikeNoArms,
  bikeSimulator,
  multiErgRow,
  multiErgSki,
  multiErgBike,
  num
}

enum WorkoutType {
  justRowNoSplits,
  justRowSplits,
  fixedDistanceNoSplits,
  fixedDistanceSplits,
  fixedTimeNoSplits,
  fixedTimeSplits,
  fixedTimeInterval,
  fixedDistanceInterval,
  variableInterval,
  variableUndefinedRestInterval,
  fixedCalorie,
  fixedWattMinutes,
  fixedCaloriesInterval,
  num
}

enum IntervalType {
  time,
  distance,
  rest,
  timeRestUndefined,
  distanceRestUndefined,
  calorie,
  calorieRestUndefined,
  wattMinute,
  wattMinuteRestUndefined,
  none
}

enum WorkoutState {
  waitToBegin,
  workoutRow,
  countdownPause,
  intervalRest,
  intervalWorkTime,
  intervalWorkDistance,
  intervalRestEndToWorkTime,
  intervalRestToWorkDistance,
  intervalWorkTimeToRest,
  intervalWorkDistanceToRest,
  workoutEnd,
  terminate,
  workoutLogged,
  rearm
}

enum RowingState {
  inactive,
  active
}

enum StrokeState {
  waitingForWheelToReachMinSpeed,
  waitingForWheelToAccelerate,
  driving,
  dwellingAfterDrive,
  recovery
}

enum WorkoutDuration {
  timeDuration,
  caloriesDuration,
  distanceDuration,
  wattsDuration
}

enum GameID {
  none,
  fish,
  dart,
  targetBasic,
  targetAdvanced,
  crossTraining
}