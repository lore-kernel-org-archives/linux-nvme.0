From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Wed, 25 Nov 2015 16:35:13 +0100
Subject: [PATCH 1/3] lightnvm: missing nvm_lock acquire
In-Reply-To: <1448455376-5020-2-git-send-email-ww.tao0320@gmail.com>
References: <1448455376-5020-1-git-send-email-ww.tao0320@gmail.com>
 <1448455376-5020-2-git-send-email-ww.tao0320@gmail.com>
Message-ID: <5655D531.3090809@bjorling.me>



On 11/25/2015 01:42 PM, Wenwei Tao wrote:
> To avoid race conditions, traverse dev, media manager,
> and targeet lists and also register, unregister entries
> to/from them, should be always under the nvm_lock control.
>
> Signed-off-by: Wenwei Tao <ww.tao0320 at gmail.com>
> ---
>   drivers/lightnvm/core.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index f659e60..39aec3a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -333,19 +333,19 @@ EXPORT_SYMBOL(nvm_register);
>
>   void nvm_unregister(char *disk_name)
>   {
> +	down_write(&nvm_lock);
>   	struct nvm_dev *dev = nvm_find_nvm_dev(disk_name);
>
>   	if (!dev) {
>   		pr_err("nvm: could not find device %s to unregister\n",
>   								disk_name);
> +		up_write(&nvm_lock);
>   		return;
>   	}
>
> -	nvm_exit(dev);
> -
> -	down_write(&nvm_lock);
>   	list_del(&dev->devices);
>   	up_write(&nvm_lock);
> +	nvm_exit(dev);
>   }
>   EXPORT_SYMBOL(nvm_unregister);
>
> @@ -365,12 +365,15 @@ static int nvm_create_target(struct nvm_dev *dev,
>   	void *targetdata;
>   	int ret = 0;
>
> +	down_write(&nvm_lock);
>   	if (!dev->mt) {
>   		/* register with device with a supported NVM manager */
>   		list_for_each_entry(mt, &nvm_mgrs, list) {
>   			ret = mt->register_mgr(dev);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				up_write(&nvm_lock);
>   				return ret; /* initialization failed */
> +			}
>   			if (ret > 0) {
>   				dev->mt = mt;
>   				break; /* successfully initialized */
> @@ -379,6 +382,7 @@ static int nvm_create_target(struct nvm_dev *dev,
>
>   		if (!ret) {
>   			pr_info("nvm: no compatible nvm manager found.\n");
> +			up_write(&nvm_lock);
>   			return -ENODEV;
>   		}
>   	}
> @@ -386,10 +390,10 @@ static int nvm_create_target(struct nvm_dev *dev,
>   	tt = nvm_find_target_type(create->tgttype);
>   	if (!tt) {
>   		pr_err("nvm: target type %s not found\n", create->tgttype);
> +		up_write(&nvm_lock);
>   		return -EINVAL;
>   	}
>
> -	down_write(&nvm_lock);
>   	list_for_each_entry(t, &dev->online_targets, list) {
>   		if (!strcmp(create->tgtname, t->disk->disk_name)) {
>   			pr_err("nvm: target name already exists.\n");
> @@ -472,8 +476,9 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
>   {
>   	struct nvm_dev *dev;
>   	struct nvm_ioctl_create_simple *s;
> -
> +	down_write(&nvm_lock);
>   	dev = nvm_find_nvm_dev(create->dev);
> +	up_write(&nvm_lock);
>   	if (!dev) {
>   		pr_err("nvm: device not found\n");
>   		return -EINVAL;
> @@ -532,7 +537,9 @@ static int nvm_configure_show(const char *val)
>   		return -EINVAL;
>   	}
>
> +	down_write(&nvm_lock);
>   	dev = nvm_find_nvm_dev(devname);
> +	up_write(&nvm_lock);
>   	if (!dev) {
>   		pr_err("nvm: device not found\n");
>   		return -EINVAL;
>
Thanks Tao, applied.
