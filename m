From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 May 2019 11:49:02 +0300
Subject: [PATCH] nvmet: get rid of extra line in the tcp code
In-Reply-To: <20190515161044.25772-1-chaitanya.kulkarni@wdc.com>
References: <20190515161044.25772-1-chaitanya.kulkarni@wdc.com>
Message-ID: <47ad211c-526f-a33f-13ff-94f02c17baf4@mellanox.com>


On 5/15/2019 7:10 PM, Chaitanya Kulkarni wrote:
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


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
