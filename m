From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 3 Jun 2019 16:32:40 +0000
Subject: [PATCH 4/5] nvme-print: fix json object memory leak
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
 <1559209406-713-4-git-send-email-maxg@mellanox.com>
Message-ID: <BYAPR04MB5749791616213945550D579F86140@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/30/19 2:44 AM, Max Gurtovoy wrote:
> Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  nvme-print.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/nvme-print.c b/nvme-print.c
> index 2c4822e..6f85e73 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -2918,6 +2918,7 @@ void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n)
>  		json_object_add_value_array(root, "Subsystems", subsystems);
>  	json_print_object(root, NULL);
>  	printf("\n");
> +	json_free_object(root);
>  }
>  
>  static void show_registers_cap(struct nvme_bar_cap *cap)
