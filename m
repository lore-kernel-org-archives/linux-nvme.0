From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 7 Oct 2018 02:01:51 +0300
Subject: [PATCH rfc 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181002001422.9111-3-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-3-sagi@grimberg.me>
Message-ID: <69faa49f-6ba6-41ee-7b88-4b0b14f3a26e@mellanox.com>



On 10/2/2018 3:14 AM, Sagi Grimberg wrote:
> Only override the allowed parts of it.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/configfs.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b37a8e3e3f80..53b88858ee97 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -148,7 +148,7 @@ CONFIGFS_ATTR(nvmet_, addr_traddr);
>   static ssize_t nvmet_addr_treq_show(struct config_item *item,
>   		char *page)
>   {
> -	switch (to_nvmet_port(item)->disc_addr.treq) {
> +	switch (to_nvmet_port(item)->disc_addr.treq & 0x3) {

can you use some MACRO for 0x3 ? this will make the code more readable.

>   	case NVMF_TREQ_NOT_SPECIFIED:
>   		return sprintf(page, "not specified\n");
>   	case NVMF_TREQ_REQUIRED:
> @@ -164,6 +164,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = port->disc_addr.treq & 0xfc;

also for 0xfc.

>   
>   	if (port->enabled) {
>   		pr_err("Cannot modify address while enabled\n");
> @@ -172,15 +173,16 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	}
>   
>   	if (sysfs_streq(page, "not specified")) {
> -		port->disc_addr.treq = NVMF_TREQ_NOT_SPECIFIED;
> +		treq |= NVMF_TREQ_NOT_SPECIFIED;
>   	} else if (sysfs_streq(page, "required")) {
> -		port->disc_addr.treq = NVMF_TREQ_REQUIRED;
> +		treq |= NVMF_TREQ_REQUIRED;
>   	} else if (sysfs_streq(page, "not required")) {
> -		port->disc_addr.treq = NVMF_TREQ_NOT_REQUIRED;
> +		treq |= NVMF_TREQ_NOT_REQUIRED;
>   	} else {
>   		pr_err("Invalid value '%s' for treq\n", page);
>   		return -EINVAL;
>   	}
> +	port->disc_addr.treq = treq;
>   
>   	return count;
>   }
> 
