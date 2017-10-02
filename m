From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 2 Oct 2017 13:48:38 +0530
Subject: [PATCH] nvme: make config_item_type __ro_after_init
In-Reply-To: <1506885278-9234-1-git-send-email-bhumirks@gmail.com>
References: <1506885278-9234-1-git-send-email-bhumirks@gmail.com>
Message-ID: <CAOH+1jFW5b2C05kP9FHHT_529kCy4cJ2z6QF9XyUHYhMixXPfQ@mail.gmail.com>

On Mon, Oct 2, 2017@12:44 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> Make these __ro_after_init as they are only stored as a reference in the
> ci_type field of a config_item structure during the init phase in the
> function config_group_init_type_name. None of the fields of these
> structures are modified after the init phase, so they can be
> __ro_after_init.
>
> Structures found using Coccinelle and changes done by hand.
>

Hello all,

This patch should be dropped as the structures can also be made const
instead of __ro_after_init. I will send a patch making them const.

Thanks,
Bhumika

> Signed-off-by: Bhumika Goyal <bhumirks at gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b6aeb1d..075d9b5 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -767,7 +767,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>         .make_group             = nvmet_subsys_make,
>  };
>
> -static struct config_item_type nvmet_subsystems_type = {
> +static struct config_item_type nvmet_subsystems_type __ro_after_init = {
>         .ct_group_ops           = &nvmet_subsystems_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -921,7 +921,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>         .make_group             = nvmet_ports_make,
>  };
>
> -static struct config_item_type nvmet_ports_type = {
> +static struct config_item_type nvmet_ports_type __ro_after_init = {
>         .ct_group_ops           = &nvmet_ports_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -963,7 +963,7 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
>         .make_group             = nvmet_hosts_make_group,
>  };
>
> -static struct config_item_type nvmet_hosts_type = {
> +static struct config_item_type nvmet_hosts_type __ro_after_init = {
>         .ct_group_ops           = &nvmet_hosts_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> --
> 1.9.1
>
