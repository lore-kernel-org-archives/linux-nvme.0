From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Sat, 27 Jul 2019 21:47:42 +0200
Subject: [PATCH 4/4] nvme: lightnvm: trace opcode name of I/O commands for
 2.0
In-Reply-To: <20190727184155.18014-5-minwoo.im.dev@gmail.com>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
 <20190727184155.18014-5-minwoo.im.dev@gmail.com>
Message-ID: <97cbcbd3-5887-ec8e-dd43-ef08d612372c@lightnvm.io>

On 7/27/19 8:41 PM, Minwoo Im wrote:
> This patch adds opcode values which are defined in OCSSD 2.0 spec.  This
> will make it printed a name of opcode rather than the raw value.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Matias Bj?rling <mb at lightnvm.io>
> Cc: Javier Gonz?lez <javier at javigon.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   include/linux/nvme.h | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index fddf4c776788..d1db459dbfc1 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -566,6 +566,12 @@ enum nvme_opcode {
>   	nvme_cmd_resv_report	= 0x0e,
>   	nvme_cmd_resv_acquire	= 0x11,
>   	nvme_cmd_resv_release	= 0x15,
> +
> +	/* OCSSD 2.0 */
> +	nvme_nvm_cmd_vec_chunk_reset	= 0x90,
> +	nvme_nvm_cmd_vec_chunk_write	= 0x91,
> +	nvme_nvm_cmd_vec_chunk_read	= 0x92,
> +	nvme_nvm_cmd_vec_chunk_copy	= 0x93,
>   };
>   
>   #define nvme_opcode_name(opcode)	{ opcode, #opcode }
> @@ -581,7 +587,11 @@ enum nvme_opcode {
>   		nvme_opcode_name(nvme_cmd_resv_register),	\
>   		nvme_opcode_name(nvme_cmd_resv_report),		\
>   		nvme_opcode_name(nvme_cmd_resv_acquire),	\
> -		nvme_opcode_name(nvme_cmd_resv_release))
> +		nvme_opcode_name(nvme_cmd_resv_release),	\
> +		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_reset),	\
> +		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_write),	\
> +		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_read),	\
> +		nvme_opcode_name(nvme_nvm_cmd_vec_chunk_copy))
>   
>   
>   /*
> 

It can not be assumed that it is an nvme opcode for any other device 
than an OCSSD 2.0 device (the command opcodes are allocated from the 
vendor-specific range of the NVMe specification). The trace code should 
be updated to take that into account before using the lookup value.

As a side note, I appreciate the work being put into supporting OCSSD, 
but for broad adoption, the OCSSD interface is superseded by the Zoned 
Namespaces (ZNS) technical proposal that is under standardization in the 
NVMe workgroup. We do expect a lot of adoption in this area, and have 
the kernel code ready when work is ratified (only at that point is the 
TBD values allocated). I hope that the energy that is now being put into 
OCSSD, can be put onto ZNS, as that is where we will see broad adoption 
and long-term support in the kernel.
