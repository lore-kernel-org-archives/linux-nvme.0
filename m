From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 14:01:06 +0300
Subject: [PATCH 10/18] nvme: move nvme_setup_flush and nvme_setup_rw to
 common code
In-Reply-To: <1444975128-8768-11-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-11-git-send-email-hch@lst.de>
Message-ID: <56261EF2.3080507@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> And mark them inline so that we don't slow down the I/O submission path by
> having to turn it into a forced out of line call.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/nvme.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/pci.c  | 49 ----------------------------------------------
>   2 files changed, 51 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a4f2f2c..6c77db7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -80,6 +80,57 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
>   	return (sector >> (ns->lba_shift - 9));
>   }
>
> +static inline void nvme_setup_flush(struct nvme_ns *ns,
> +		struct nvme_command *cmnd)
> +{
> +	memset(cmnd, 0, sizeof(*cmnd));
> +	cmnd->common.opcode = nvme_cmd_flush;
> +	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
> +}
> +
> +static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
> +		struct nvme_command *cmnd)
> +{
> +	u16 control = 0;
> +	u32 dsmgmt = 0;
> +
> +	if (req->cmd_flags & REQ_FUA)
> +		control |= NVME_RW_FUA;
> +	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
> +		control |= NVME_RW_LR;
> +
> +	if (req->cmd_flags & REQ_RAHEAD)
> +		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
> +
> +	memset(cmnd, 0, sizeof(*cmnd));
> +	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
> +	cmnd->rw.command_id = req->tag;
> +	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
> +	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
> +	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> +
> +	if (ns->ms) {
> +		switch (ns->pi_type) {
> +		case NVME_NS_DPS_PI_TYPE3:
> +			control |= NVME_RW_PRINFO_PRCHK_GUARD;
> +			break;
> +		case NVME_NS_DPS_PI_TYPE1:
> +		case NVME_NS_DPS_PI_TYPE2:
> +			control |= NVME_RW_PRINFO_PRCHK_GUARD |
> +					NVME_RW_PRINFO_PRCHK_REF;
> +			cmnd->rw.reftag = cpu_to_le32(
> +					nvme_block_nr(ns, blk_rq_pos(req)));
> +			break;
> +		}
> +		if (!blk_integrity_rq(req))
> +			control |= NVME_RW_PRINFO_PRACT;
> +	}
> +
> +	cmnd->rw.control = cpu_to_le16(control);
> +	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> +}
> +
> +

Hi Christoph,

I do agree that making these static inline can speed things up here,
but the coding style documentation asks to avoid inline'ing functions
longer than a few lines of code (See Documentation/CodingStyle Chapter
15: "The inline disease").

Do you think this case qualifies as an exception?
