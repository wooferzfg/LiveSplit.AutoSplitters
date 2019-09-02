state("LiveSplit")
{
}

update
{
    if (timer.CurrentPhase == TimerPhase.Running) {
        if (timer.CurrentTime.RealTime > TimeSpan.Zero) {
            timer.SetGameTime(TimeSpan.Zero);
            timer.IsGameTimePaused = true;
            return;
        }
    }
    timer.SetGameTime(timer.CurrentTime.RealTime.Value.Negate());
}