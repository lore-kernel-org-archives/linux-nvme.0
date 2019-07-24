From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Wed, 24 Jul 2019 09:14:36 +0200
Subject: [PATCH 1/5] lnvm: make data_len to sizeof() instead of magic
 number
In-Reply-To: <20190723183601.29370-2-minwoo.im.dev@gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-2-minwoo.im.dev@gmail.com>
Message-ID: <0C3D57E7-D810-41E7-ACA3-298A47077A6A@javigon.com>

> On 23 Jul 2019,@20.35, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> 
> We can have it as a sizeof() instead of the hard-coded value for the
> data structure.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
> nvme-lightnvm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
> index 0b99786..e8cdccd 100644
> --- a/nvme-lightnvm.c
> +++ b/nvme-lightnvm.c
> @@ -442,7 +442,7 @@ static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
> 		.opcode		= nvme_nvm_admin_identity,
> 		.nsid		= nsid,
> 		.addr		= (__u64)(uintptr_t)nvm_id,
> -		.data_len	= 0x1000,
> +		.data_len	= sizeof(struct nvme_nvm_id),
> 	};
> 
> 	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
> --
> 2.17.1

Looks good.

Reviewed-by: Javier Gonz?lez <javier at javigon.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190724/1fd30f1f/attachment-0001.sig>
