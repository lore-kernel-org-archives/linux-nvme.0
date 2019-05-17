From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 17 May 2019 16:32:02 +0000
Subject: [PATCH] nvme: target: use struct_size() in kmalloc()
References: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
Message-ID: <SN6PR04MB4527D340D48215FE19335A99860B0@SN6PR04MB4527.namprd04.prod.outlook.com>

If maintainers are okay with this then,

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/17/19 12:07 AM, xiaolinkui wrote:
> Use struct_size() to keep code sample.
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>
> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> Signed-off-by: xiaolinkui <xiaolinkui at kylinos.cn>
> ---
>  drivers/nvme/target/admin-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 9f72d51..6f9f830 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -248,8 +248,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>  	u16 status;
>  
>  	status = NVME_SC_INTERNAL;
> -	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
> -			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
> +	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
> +			GFP_KERNEL);
>  	if (!desc)
>  		goto out;
>  
