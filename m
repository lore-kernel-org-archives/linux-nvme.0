From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 3 Jun 2019 16:31:34 +0000
Subject: [PATCH 3/5] fabrics: Fix memory leak of subsys list
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
 <1559209406-713-3-git-send-email-maxg@mellanox.com>
Message-ID: <BYAPR04MB574904A07AA236EC9D47A29A86140@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
On 5/30/19 2:44 AM, Max Gurtovoy wrote:
> Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  fabrics.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fabrics.c b/fabrics.c
> index 573a6ef..9ed4a56 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -1205,5 +1205,6 @@ int disconnect_all(const char *desc, int argc, char **argv)
>  		}
>  	}
>  out:
> +	free_subsys_list(slist, subcnt);
>  	return ret;
>  }
