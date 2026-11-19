using Microsoft.AspNetCore.Mvc;
using Model1.Models;

namespace Model1.Controllers
{
    [ApiController]
    public class RestaurantController(MapDbContext db) : ControllerBase
    {
        [HttpGet("sy    stem/api/restaurant/list")]
        public ApiResult List(int pageNum = 1, int pageSize = 10,
        string? restaurantName = null, string? restaurantType = null)
        {
            var q = db.Restaurants.AsQueryable();
            if (!string.IsNullOrEmpty(restaurantName))
                q = q.Where(x => x.RestaurantName!.Contains(restaurantName));
            if (!string.IsNullOrEmpty(restaurantType))
                q = q.Where(x => x.RestaurantType == restaurantType);
            int total = q.Count();
            var rows = q.OrderBy(x => x.RestaurantId)
            .Skip((pageNum - 1) * pageSize)
            .Take(pageSize)
            .ToList()
            .Select(x => new {
                x.RestaurantId,
                x.RestaurantName,
                x.Address,
                x.Phone,
                rating = x.Rating.ToString(),
                x.PriceRange,
                x.RestaurantType,
                x.ImageUrl,
                x.Description,
                distance = x.Distance.ToString(),
                businessType = "restaurant"
            });
            return ApiResult.Ok(new { total, rows });
        }
    }
}