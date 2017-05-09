From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 9 May 2017 15:59:43 +0200
Subject: [PATCH] nvme: lightnvm: fix memory leak
In-Reply-To: <20170509135506.GA22624@dhcp-216.srv.tuxera.com>
References: <20170509135506.GA22624@dhcp-216.srv.tuxera.com>
Message-ID: <FFAA9DA2-8A84-4C03-AFED-82F4BE10985B@lightnvm.io>

> On 9 May 2017,@15.55, Rakesh Pandit <rakesh@tuxera.com> wrote:
> 
> Free up kmalloc allocated memory if failure happens while handling L2P
> table transfer in nvme_nvm_get_l2p_tbl.
> 
> Fixes: 8e79b5cb ("lightnvm: move block provisioning to targets")
> Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
> ---
> drivers/nvme/host/lightnvm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 206bfdb..f5df78e 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -367,7 +367,8 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
> 
> 		if (unlikely(elba > nvmdev->total_secs)) {
> 			pr_err("nvm: L2P data from device is out of bounds!\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;
> 		}
> 
> 		/* Transform physical address to target address space */
> --
> 2.5.5

Looks good. Thanks Rakesh.

Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170509/05c92c69/attachment.sig>
