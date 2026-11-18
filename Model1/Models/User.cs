using System;
using System.Collections.Generic;

namespace Model1.Models;

public partial class User
{
    public int UserId { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? NickName { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public string? Avatar { get; set; }

    public DateTime CreateTime { get; set; }

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}
