From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Sat, 27 Jul 2019 21:53:24 +0200
Subject: [PATCH V2 3/3] lnvm: introduce alias geometry for id-ns for lnvm
In-Reply-To: <20190727193249.22655-4-minwoo.im.dev@gmail.com>
References: <20190727193249.22655-1-minwoo.im.dev@gmail.com>
 <20190727193249.22655-4-minwoo.im.dev@gmail.com>
Message-ID: <a6fd74d8-5ebc-2c16-82c1-3af5d6782264@lightnvm.io>

On 7/27/19 9:32 PM, Minwoo Im wrote:
> Now we have 2.0 OCSSD spec which introudces Geometry command instead of
> Identity or something else.  This patch just adds an alias for this
> command for the given NVMe namespace with backward compatibility.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Cc: Javier Gonz?lez <javier at javigon.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   plugins/lnvm/lnvm-nvme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/lnvm/lnvm-nvme.h b/plugins/lnvm/lnvm-nvme.h
> index e25f756..45b3cf0 100644
> --- a/plugins/lnvm/lnvm-nvme.h
> +++ b/plugins/lnvm/lnvm-nvme.h
> @@ -11,7 +11,7 @@ PLUGIN(NAME("lnvm", "LightNVM specific extensions"),
>   	COMMAND_LIST(
>   		ENTRY("list", "List available LightNVM devices", lnvm_list)
>   		ENTRY("info", "List general information and available target engines", lnvm_info)
> -		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns)
> +		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns, "geometry")
>   		ENTRY("chunk-log", "Chunk Information Log Page", lnvm_chunk_log)
>   		ENTRY("init", "Initialize media manager on LightNVM device", lnvm_init)
>   		ENTRY("create", "Create target on top of a LightNVM device", lnvm_create_tgt)
> 

Thanks. Works for me.

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
