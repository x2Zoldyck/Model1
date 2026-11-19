namespace Model1
{
    public class ApiResult
    {
        public int Code { get; set; }
        public string Msg { get; set; } = "";
        public object? Data { get; set; }
        public static ApiResult Ok(object? d = null) =>
        new ApiResult
        {
            Code = 200,
            Msg = "success",
            Data = d
        };
        public static ApiResult Fail(int c, string m) =>
        new ApiResult { Code = c, Msg = m };
    }
}