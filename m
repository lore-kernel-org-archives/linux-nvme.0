From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 3 Jun 2019 16:26:42 +0000
Subject: [PATCH 2/5] nvme: update description for "nvme list" command
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
 <1559209406-713-2-git-send-email-maxg@mellanox.com>
Message-ID: <BYAPR04MB5749039CF8D73B22484A389486140@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/30/19 2:44 AM, Max Gurtovoy wrote:
> The "nvme list" command doesn't get any device handle as an input
> argument. This operation prints out a basic information for all NVMe
> namespaces in the system.
>
> Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nvme.c b/nvme.c
> index 9d763f5..3310abd 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -1801,7 +1801,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
>  	struct list_item *list_items;
>  	unsigned int list_cnt = 0;
>  	int fmt, ret, fd, i, n;
> -	const char *desc = "Retrieve basic information for the given device";
> +	const char *desc = "Retrieve basic information for all NVMe namespaces";
>  	struct config {
>  		char *output_format;
>  	};
