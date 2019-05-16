From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 16 May 2019 23:02:24 +0000
Subject: [PATCH 2/2] nvme-cli: remove unnecessary initialize of local var
References: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
 <20190516172350.11864-3-minwoo.im.dev@gmail.com>
Message-ID: <DM6PR04MB4521100AAE335BF495B4B46F860A0@DM6PR04MB4521.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
On 5/16/19 10:24 AM, Minwoo Im wrote:
> This patch does not have any functional changes here.  Just clean-up the
> unnecessary initialize.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  fabrics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fabrics.c b/fabrics.c
> index 733a24b..573a6ef 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -1180,7 +1180,7 @@ int disconnect(const char *desc, int argc, char **argv)
>  int disconnect_all(const char *desc, int argc, char **argv)
>  {
>  	struct subsys_list_item *slist;
> -	int i, j, ret = 0, subcnt = 0;
> +	int i, j, ret, subcnt = 0;
>  	const struct argconfig_commandline_options command_line_options[] = {
>  		{NULL},
>  	};
