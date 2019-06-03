From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 3 Jun 2019 16:33:01 +0000
Subject: [PATCH 5/5] nvme: fix coding style issue
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
 <1559209406-713-5-git-send-email-maxg@mellanox.com>
Message-ID: <BYAPR04MB5749196B1B64839154AA405486140@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
On 5/30/19 2:44 AM, Max Gurtovoy wrote:
> It's more common to use the following coding style:
> if (condition) {
>    do_that;
>    do_this;
> } else if (condition2) {
>    do_this;
> } else {
>    do_that;
> }
>
> Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/nvme.c b/nvme.c
> index 3310abd..2fd4362 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -988,11 +988,11 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
>  		for (i = 0; i < 1024; i++)
>  			if (ns_list[i])
>  				printf("[%4u]:%#x\n", i, le32_to_cpu(ns_list[i]));
> -	}
> -	else if (err > 0)
> +	} else if (err > 0) {
>  		show_nvme_status(err);
> -	else
> +	} else {
>  		perror("id namespace list");
> +	}
>  
>  close_fd:
>  	close(fd);
