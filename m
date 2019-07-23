From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 23 Jul 2019 07:44:24 +0200
Subject: [PATCH 3/4] lnvm: cast identity structure to (void *) directly
In-Reply-To: <20190721153219.5730-4-minwoo.im.dev@gmail.com>
References: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
 <20190721153219.5730-4-minwoo.im.dev@gmail.com>
Message-ID: <D149564E-916F-477B-AE28-8421EE52EC2C@javigon.com>

> On 21 Jul 2019,@17.32, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> 
> If we use "tmp" or something like this, we can expect that it just
> stores the previous pointer and do something else with the previous
> pointer.  But, in this function, it just to cast it out.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
> nvme-lightnvm.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
> index 0b99786..62bdc40 100644
> --- a/nvme-lightnvm.c
> +++ b/nvme-lightnvm.c
> @@ -422,13 +422,12 @@ static void show_lnvm_id20_ns(struct nvme_nvm_id20 *id, unsigned int flags)
> 
> static void show_lnvm_id_ns(struct nvme_nvm_id *id, unsigned int flags)
> {
> -	void *tmp = id;
> 	switch (id->ver_id) {
> 		case 1:
> -			show_lnvm_id12_ns(tmp, flags);
> +			show_lnvm_id12_ns((void *) id, flags);
> 		break;
> 		case 2:
> -			show_lnvm_id20_ns(tmp, flags);
> +			show_lnvm_id20_ns((void *) id, flags);
> 		break;
> 		default:
> 			fprintf(stderr, "Version %d not supported.\n",
> --
> 2.17.1

LGTM


Reviewed-by: Javier Gonz?lez <javier at javigon.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190723/136ecac1/attachment.sig>
