From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Wed, 14 Oct 2015 22:55:02 +0200
Subject: [RFC PATCH] lightnvm: nvm_find_target_type() can be static
In-Reply-To: <20151014205217.GA96356@lkp-sb04>
References: <201510150404.YgKu7QhT%fengguang.wu@intel.com>
 <1444850524-16827-2-git-send-email-m@bjorling.me>
 <20151014205217.GA96356@lkp-sb04>
Message-ID: <CAOu_J6=00c+aF650UwP57hj7_PecD9yor2rXN1Y4Fd1VDJoMHw@mail.gmail.com>

On Wed, Oct 14, 2015@10:52 PM, kbuild test robot <lkp@intel.com> wrote:
>
> Signed-off-by: Fengguang Wu <fengguang.wu at intel.com>
> ---
>  core.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 9b06d75..7205e57 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -34,7 +34,7 @@ static LIST_HEAD(nvm_mgrs);
>  static LIST_HEAD(nvm_devices);
>  static DECLARE_RWSEM(nvm_lock);
>
> -struct nvm_tgt_type *nvm_find_target_type(const char *name)
> +static struct nvm_tgt_type *nvm_find_target_type(const char *name)
>  {
>         struct nvm_tgt_type *tt;
>
> @@ -123,7 +123,7 @@ void nvm_unregister_mgr(struct nvmm_type *mt)
>  }
>  EXPORT_SYMBOL(nvm_unregister_mgr);
>
> -struct nvm_dev *nvm_find_nvm_dev(const char *name)
> +static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>  {
>         struct nvm_dev *dev;
>
> @@ -209,7 +209,7 @@ static void nvm_free(struct nvm_dev *dev)
>         nvm_core_free(dev);
>  }
>
> -int nvm_validate_features(struct nvm_dev *dev)
> +static int nvm_validate_features(struct nvm_dev *dev)
>  {
>         struct nvm_get_features gf;
>         int ret;
> @@ -223,7 +223,7 @@ int nvm_validate_features(struct nvm_dev *dev)
>         return 0;
>  }
>
> -int nvm_validate_responsibility(struct nvm_dev *dev)
> +static int nvm_validate_responsibility(struct nvm_dev *dev)
>  {
>         if (!dev->ops->set_responsibility)
>                 return 0;
> @@ -231,7 +231,7 @@ int nvm_validate_responsibility(struct nvm_dev *dev)
>         return dev->ops->set_responsibility(dev->q, 0);
>  }
>
> -int nvm_init(struct nvm_dev *dev)
> +static int nvm_init(struct nvm_dev *dev)
>  {
>         struct nvmm_type *mt;
>         int ret = 0;
> @@ -304,7 +304,7 @@ err:
>         return ret;
>  }
>
> -void nvm_exit(struct nvm_dev *dev)
> +static void nvm_exit(struct nvm_dev *dev)
>  {
>         if (dev->ppalist_pool)
>                 dev->ops->destroy_dma_pool(dev->ppalist_pool);

Thanks! I'll apply it.
