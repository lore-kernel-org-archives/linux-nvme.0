From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu, 12 Oct 2017 17:03:50 +0200
Subject: [PATCH] nvmet: make config_item_type const
In-Reply-To: <1507811901-11522-1-git-send-email-bhumirks@gmail.com>
References: <1507811901-11522-1-git-send-email-bhumirks@gmail.com>
Message-ID: <CAOH+1jFc0ZRrKks7f2R1NXWYmebmCfF8D2Bwv_ajEzi=10m0JA@mail.gmail.com>

On Thu, Oct 12, 2017@2:38 PM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> This is a followup patch for:
> https://patchwork.kernel.org/patch/9999649/ and
> https://lkml.org/lkml/2017/10/11/375
>
> Make config_item_type structures const as they are either passed to a
> function having the argument as const or used inside an if statement or
> stored in the const "ci_type" field of a config_item structure.
>
> Done using Coccinelle
>

Actually, this patch is dependent on the patches in the links
https://lkml.org/lkml/2017/10/11/375 and
https://patchwork.kernel.org/patch/9999649/. Therefore, this patch
won't be correct unless the patches in these links gets applied.

> Signed-off-by: Bhumika Goyal <bhumirks at gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b6aeb1d..e6b2d2a 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -20,8 +20,8 @@
>
>  #include "nvmet.h"
>
> -static struct config_item_type nvmet_host_type;
> -static struct config_item_type nvmet_subsys_type;
> +static const struct config_item_type nvmet_host_type;
> +static const struct config_item_type nvmet_subsys_type;
>
>  /*
>   * nvmet_port Generic ConfigFS definitions.
> @@ -425,7 +425,7 @@ static void nvmet_ns_release(struct config_item *item)
>         .release                = nvmet_ns_release,
>  };
>
> -static struct config_item_type nvmet_ns_type = {
> +static const struct config_item_type nvmet_ns_type = {
>         .ct_item_ops            = &nvmet_ns_item_ops,
>         .ct_attrs               = nvmet_ns_attrs,
>         .ct_owner               = THIS_MODULE,
> @@ -464,7 +464,7 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
>         .make_group             = nvmet_ns_make,
>  };
>
> -static struct config_item_type nvmet_namespaces_type = {
> +static const struct config_item_type nvmet_namespaces_type = {
>         .ct_group_ops           = &nvmet_namespaces_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -540,7 +540,7 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
>         .drop_link              = nvmet_port_subsys_drop_link,
>  };
>
> -static struct config_item_type nvmet_port_subsys_type = {
> +static const struct config_item_type nvmet_port_subsys_type = {
>         .ct_item_ops            = &nvmet_port_subsys_item_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -613,7 +613,7 @@ static void nvmet_allowed_hosts_drop_link(struct config_item *parent,
>         .drop_link              = nvmet_allowed_hosts_drop_link,
>  };
>
> -static struct config_item_type nvmet_allowed_hosts_type = {
> +static const struct config_item_type nvmet_allowed_hosts_type = {
>         .ct_item_ops            = &nvmet_allowed_hosts_item_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -729,7 +729,7 @@ static void nvmet_subsys_release(struct config_item *item)
>         .release                = nvmet_subsys_release,
>  };
>
> -static struct config_item_type nvmet_subsys_type = {
> +static const struct config_item_type nvmet_subsys_type = {
>         .ct_item_ops            = &nvmet_subsys_item_ops,
>         .ct_attrs               = nvmet_subsys_attrs,
>         .ct_owner               = THIS_MODULE,
> @@ -767,7 +767,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>         .make_group             = nvmet_subsys_make,
>  };
>
> -static struct config_item_type nvmet_subsystems_type = {
> +static const struct config_item_type nvmet_subsystems_type = {
>         .ct_group_ops           = &nvmet_subsystems_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -827,7 +827,7 @@ static void nvmet_referral_release(struct config_item *item)
>         .release        = nvmet_referral_release,
>  };
>
> -static struct config_item_type nvmet_referral_type = {
> +static const struct config_item_type nvmet_referral_type = {
>         .ct_owner       = THIS_MODULE,
>         .ct_attrs       = nvmet_referral_attrs,
>         .ct_item_ops    = &nvmet_referral_item_ops,
> @@ -852,7 +852,7 @@ static struct config_group *nvmet_referral_make(
>         .make_group             = nvmet_referral_make,
>  };
>
> -static struct config_item_type nvmet_referrals_type = {
> +static const struct config_item_type nvmet_referrals_type = {
>         .ct_owner       = THIS_MODULE,
>         .ct_group_ops   = &nvmet_referral_group_ops,
>  };
> @@ -880,7 +880,7 @@ static void nvmet_port_release(struct config_item *item)
>         .release                = nvmet_port_release,
>  };
>
> -static struct config_item_type nvmet_port_type = {
> +static const struct config_item_type nvmet_port_type = {
>         .ct_attrs               = nvmet_port_attrs,
>         .ct_item_ops            = &nvmet_port_item_ops,
>         .ct_owner               = THIS_MODULE,
> @@ -921,7 +921,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>         .make_group             = nvmet_ports_make,
>  };
>
> -static struct config_item_type nvmet_ports_type = {
> +static const struct config_item_type nvmet_ports_type = {
>         .ct_group_ops           = &nvmet_ports_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -940,7 +940,7 @@ static void nvmet_host_release(struct config_item *item)
>         .release                = nvmet_host_release,
>  };
>
> -static struct config_item_type nvmet_host_type = {
> +static const struct config_item_type nvmet_host_type = {
>         .ct_item_ops            = &nvmet_host_item_ops,
>         .ct_owner               = THIS_MODULE,
>  };
> @@ -963,14 +963,14 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
>         .make_group             = nvmet_hosts_make_group,
>  };
>
> -static struct config_item_type nvmet_hosts_type = {
> +static const struct config_item_type nvmet_hosts_type = {
>         .ct_group_ops           = &nvmet_hosts_group_ops,
>         .ct_owner               = THIS_MODULE,
>  };
>
>  static struct config_group nvmet_hosts_group;
>
> -static struct config_item_type nvmet_root_type = {
> +static const struct config_item_type nvmet_root_type = {
>         .ct_owner               = THIS_MODULE,
>  };
>
> --
> 1.9.1
>
