From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 16 May 2019 03:22:21 +0000
Subject: [PATCH] nvmet: get rid of extra line in the tcp code
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
 <20190516032109.13048-3-chaitanya.kulkarni@wdc.com>
Message-ID: <SN6PR04MB4527A95E95B73029A2D5D89B860A0@SN6PR04MB4527.namprd04.prod.outlook.com>

Please ignore this patch, sorry for the noise.

On 5/15/19 8:21 PM, Chaitanya Kulkarni wrote:
> This is a code cleanup patch, it doesn't change any functionality,
> It removes the extra line at the end of the function.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/target/tcp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 69b83fa0c76c..f019af264081 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -557,7 +557,6 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
>   	}
>   
>   	return 1;
> -
>   }
>   
>   static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
> 
