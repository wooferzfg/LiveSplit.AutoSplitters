state("LiveSplit")
{
}

update
{
    if (timer.CurrentPhase == TimerPhase.Running && timer.CurrentTime.RealTime > TimeSpan.Zero) {
        timer.SetGameTime(TimeSpan.Zero);
        timer.IsGameTimePaused = true;
    }
}