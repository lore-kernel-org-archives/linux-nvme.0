From: james.smart@broadcom.com (James Smart)
Date: Tue, 11 Sep 2018 22:01:06 -0700
Subject: [PATCH] nvme-cli: make default error log entries to 128
In-Reply-To: <20180911004126.32509-1-chaitanya.kulkarni@wdc.com>
References: <20180911004126.32509-1-chaitanya.kulkarni@wdc.com>
Message-ID: <657c3d30-3d49-689a-383f-8492b0becc9e@broadcom.com>

On 9/10/2018 5:41 PM, Chaitanya Kulkarni wrote:
> NVMeOF target defines default error log entries to be 128, use the
> same number as a default value in the nvme-cli when retrieving
> error-log.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nvme.c b/nvme.c
> index 970fc0b..ad88aa6 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -557,7 +557,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
>   	};
>   
>   	struct config cfg = {
> -		.log_entries  = 64,
> +		.log_entries  = 128,
>   		.output_format = "normal",
>   	};
>   

I disagree with this change based on the current implementation. Today's 
implementation tries to do the entire log read in an single read 
operation. Thus you are doubling the size of the io payload to something 
over 128k. It can be beyond the capacity of the host port or the 
device.? I think it's already high at 64k.

Now, if you wanted to change the nvme read log code to read the log in 
multiple transactions up to this count, that would be good.

-- james
