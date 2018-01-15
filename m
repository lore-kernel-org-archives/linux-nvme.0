From: pmenzel+linux-nvme@molgen.mpg.de (Paul Menzel)
Date: Mon, 15 Jan 2018 14:11:46 +0100
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
In-Reply-To: <20180115130723.31469-1-keith.busch@intel.com>
References: <20180115130723.31469-1-keith.busch@intel.com>
Message-ID: <82829391-9853-2f06-4403-6777772f3a5a@molgen.mpg.de>

Dear Keith,


On 01/15/18 14:07, Keith Busch wrote:
> The driver needs to verify there is a payload with a command before
> seeing if it should use SGLs to map it.
> 
> Fixes: 955b1b5a00ba ("nvme-pci: move use_sgl initialization to nvme_init_iod()")
> 
> Reported-by: Paul Menzel <pmenzel+linux-nvme at molgen.mpg.de>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/pci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d53550e612bc..a7e94cc3c70e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -451,10 +451,13 @@ static void **nvme_pci_iod_list(struct request *req)
>   static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	int nseg = blk_rq_nr_phys_segments(req);
>   	unsigned int avg_seg_size;
>   
> -	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
> -			blk_rq_nr_phys_segments(req));
> +	if (nseg == 0)
> +		return false;
> +
> +	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
>   
>   	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
>   		return false;
> 

Thank you for the quick reaction.

Reviewed-by: Paul Menzel <pmenzel+linux-nvme at molgen.mpg.de>


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180115/51c8b8d8/attachment.p7s>
