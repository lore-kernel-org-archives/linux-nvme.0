From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Fri, 9 May 2014 23:14:46 +0200
Subject: [PATCH] Remove redundant writes to uncached sqe memory
In-Reply-To: <536D3E3F.9050902@micron.com>
References: <536D3E3F.9050902@micron.com>
Message-ID: <CAOu_J6ntbk=CxHLk-mea5Jkza=NFgomyZoGmFe+_Zg96tQN5_g@mail.gmail.com>

On Fri, May 9, 2014@10:44 PM, Sam Bradshaw <sbradshaw@micron.com> wrote:
> The memset to clear the SQE in nvme_submit_iod() is made partially
> redundant by subsequent writes.  This patch explicitly clears each
> SQE structure member in ascending order, eliminating the need for
> the memset.  With this change, our perf runs show ~1.5% less time
> spent in the IO submission path and minor reduced q lock contention.
>
> Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> ---
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index cd8a8bc..a9bdcbd 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -655,11 +655,12 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
>                 dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>
>         cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
> -       memset(cmnd, 0, sizeof(*cmnd));
>
>         cmnd->rw.opcode = bio_data_dir(bio) ? nvme_cmd_write : nvme_cmd_read;
> +       cmnd->rw.flags = 0;
>         cmnd->rw.command_id = cmdid;
>         cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
> +       cmnd->rw.rsvd2 = 0;
>         cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
>         cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
>         cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
> @@ -667,6 +668,9 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
>                 cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
>         cmnd->rw.control = cpu_to_le16(control);
>         cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> +       cmnd->rw.reftag = 0;
> +       cmnd->rw.apptag = 0;
> +       cmnd->rw.appmask = 0;
>
>         if (++nvmeq->sq_tail == nvmeq->q_depth)
>                 nvmeq->sq_tail = 0;
>

I think a description above the declaration of struct nvme_rw_command
would be helpful. E.g. "If you modify this structure, please change
nvme_submit_iod accordingly to take care of initialization."
