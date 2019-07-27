From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Sat, 27 Jul 2019 21:36:39 +0200
Subject: [PATCH 3/4] nvme: lightnvm: trace opcode name
In-Reply-To: <20190727184155.18014-4-minwoo.im.dev@gmail.com>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
 <20190727184155.18014-4-minwoo.im.dev@gmail.com>
Message-ID: <bf4212ea-8c08-61eb-39cd-c43a5186125c@lightnvm.io>

On 7/27/19 8:41 PM, Minwoo Im wrote:
> This patch moved opcode enum values to nvme.h to make it support for
> command trace with opcode name istead of raw opcode value.
> 
> Example of Vector Chunk Read:
> 	... cmd=(0xe2 cdw10=00 00 00 00 00 00 00 00 00 ...
> 
> It would be like:
> 	... cmd=(nvme_nvm_admin_identity cdw10=00 00 00 00 00 00 00 00 00 ...
> 
> Although OCSSD 1.2 has been deprecated, we have the codes for 1.2 so
> that this kind of traces might be deprecated later time.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Matias Bj?rling <mb at lightnvm.io>
> Cc: Javier Gonz?lez <javier at javigon.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/lightnvm.c |  6 ------
>   include/linux/nvme.h         | 10 +++++++++-
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index ba009d4c9dfa..d06d0919c139 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -15,12 +15,6 @@
>   #include <linux/sched/sysctl.h>
>   #include <uapi/linux/lightnvm.h>
>   
> -enum nvme_nvm_admin_opcode {
> -	nvme_nvm_admin_identity		= 0xe2,
> -	nvme_nvm_admin_get_bb_tbl	= 0xf2,
> -	nvme_nvm_admin_set_bb_tbl	= 0xf1,
> -};
> -
>   enum nvme_nvm_log_page {
>   	NVME_NVM_LOG_REPORT_CHUNK	= 0xca,
>   };
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 01aa6a6c241d..fddf4c776788 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -814,6 +814,11 @@ enum nvme_admin_opcode {
>   	nvme_admin_security_send	= 0x81,
>   	nvme_admin_security_recv	= 0x82,
>   	nvme_admin_sanitize_nvm		= 0x84,
> +
> +	/* OCSSD 1.2 */
> +	nvme_nvm_admin_identity		= 0xe2,
> +	nvme_nvm_admin_get_bb_tbl	= 0xf2,
> +	nvme_nvm_admin_set_bb_tbl	= 0xf1,
>   };
>   
>   #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> @@ -840,7 +845,10 @@ enum nvme_admin_opcode {
>   		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
>   		nvme_admin_opcode_name(nvme_admin_security_send),	\
>   		nvme_admin_opcode_name(nvme_admin_security_recv),	\
> -		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
> +		nvme_admin_opcode_name(nvme_admin_sanitize_nvm),	\
> +		nvme_admin_opcode_name(nvme_nvm_admin_identity),	\
> +		nvme_admin_opcode_name(nvme_nvm_admin_get_bb_tbl),	\
> +		nvme_admin_opcode_name(nvme_nvm_admin_set_bb_tbl))
>   
>   enum {
>   	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
> 

We should not pollute the standardilized NVMe code with vendor-specific 
opcodes. The above code assumes generally that an opcode is associated 
as an admin opcode - this is true for an OCSSD 1.2 drive, but not so for 
any other vendor's drive.

Besides that, I don't think we should add anymore code for 1.2 since it 
is deprecated.
