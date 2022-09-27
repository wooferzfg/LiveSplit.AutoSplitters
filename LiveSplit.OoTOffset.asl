state("LiveSplit")
{
}

update
{
    timer.SetGameTime(timer.CurrentTime.RealTime.Value + TimeSpan.FromSeconds(170));
}
