using System;
using System.Collections.Generic;

namespace Model1.Models;

public partial class Congestion
{
    public int CongestionId { get; set; }

    public string? RoadName { get; set; }

    public decimal? StartLatitude { get; set; }

    public decimal? StartLongitude { get; set; }

    public string? StartAddress { get; set; }

    public decimal? EndLatitude { get; set; }

    public decimal? EndLongitude { get; set; }

    public string? EndAddress { get; set; }

    public string? CongestionLevel { get; set; }

    public int? CongestionLength { get; set; }

    public string? DelayTime { get; set; }
}
