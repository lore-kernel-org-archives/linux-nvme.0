From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 27 Jun 2019 17:11:47 +0000
Subject: [PATCH v4 2/3] nvmet: Export NVMe namespace attributes
References: <20190627143215.27443-1-bvanassche@acm.org>
 <20190627143215.27443-3-bvanassche@acm.org>
Message-ID: <BYAPR04MB5749F47AB1FC3409E513F3AE86FD0@BYAPR04MB5749.namprd04.prod.outlook.com>

Thanks for keeping the comment in the file-backend, very useful.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


On 6/27/19 7:32 AM, Bart Van Assche wrote:
> Make the NVMe NAWUN, NAWUPF, NACWU, NPWG, NPWA, NPDG and NOWS attributes
> available to initator systems for the block backend.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Martin K. Petersen <martin.petersen at oracle.com>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>   drivers/nvme/target/admin-cmd.c   |  5 ++++
>   drivers/nvme/target/io-cmd-bdev.c | 45 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/io-cmd-file.c | 12 +++++++++
>   drivers/nvme/target/nvmet.h       |  2 ++
>   4 files changed, 64 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 9f72d515fc4b..2558ed333d29 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -442,6 +442,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>   		break;
>           }
>   
> +	if (ns->file)
> +		nvmet_file_set_limits(ns->file, id);
> +	else if (ns->bdev)
> +		nvmet_bdev_set_limits(ns->bdev, id);
> +
>   	/*
>   	 * We just provide a single LBA format that matches what the
>   	 * underlying device reports.
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 7a1cf6437a6a..6e57d0d4f4e9 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -8,6 +8,51 @@
>   #include <linux/module.h>
>   #include "nvmet.h"
>   
> +/* Convert a 32-bit number to a 16-bit 0's based number */
> +static __le16 to0based(u32 a)
> +{
> +	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> +}
> +
> +void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
> +{
> +	const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
> +	/* Number of physical blocks per logical block. */
> +	const u32 ppl = ql->physical_block_size / ql->logical_block_size;
> +	/* Physical blocks per logical block, 0's based. */
> +	const __le16 ppl0b = to0based(ppl);
> +
> +	/*
> +	 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
> +	 * NAWUPF, and NACWU are defined for this namespace and should be
> +	 * used by the host for this namespace instead of the AWUN, AWUPF,
> +	 * and ACWU fields in the Identify Controller data structure. If
> +	 * any of these fields are zero that means that the corresponding
> +	 * field from the identify controller data structure should be used.
> +	 */
> +	id->nsfeat |= 1 << 1;
> +	id->nawun = ppl0b;
> +	id->nawupf = ppl0b;
> +	id->nacwu = ppl0b;
> +
> +	/*
> +	 * For NVMe 1.4 and later, bit 4 indicates that the fields NPWG,
> +	 * NPWA, NPDG, NPDA, and NOWS are defined for this namespace and
> +	 * should be used by the host for I/O optimization.
> +	 */
> +	id->nsfeat |= 1 << 4;
> +	/* NPWG = Namespace Preferred Write Granularity. 0's based */
> +	id->npwg = ppl0b;
> +	/* NPWA = Namespace Preferred Write Alignment. 0's based */
> +	id->npwa = id->npwg;
> +	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
> +	id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
> +	/* NPDG = Namespace Preferred Deallocate Alignment */
> +	id->npda = id->npdg;
> +	/* NOWS = Namespace Optimal Write Size */
> +	id->nows = to0based(ql->io_opt / ql->logical_block_size);
> +}
> +
>   int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   {
>   	int ret;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 05453f5d1448..8e59c107ec38 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -13,6 +13,18 @@
>   #define NVMET_MAX_MPOOL_BVEC		16
>   #define NVMET_MIN_MPOOL_OBJ		16
>   
> +void nvmet_file_set_limits(struct file *file, struct nvme_id_ns *id)
> +{
> +	/*
> +	 * Since the file backend uses buffered I/O and since the NVMe spec
> +	 * does not allow to report that atomic commands are not supported by
> +	 * a namespace, do not set any of the namespace specific atomic
> +	 * properties. This will cause the initiator to rely on the atomic
> +	 * properties reported by the controller. To do: discuss whether or
> +	 * not the file backend should use direct I/O instead of buffered I/O.
> +	 */
> +}
> +
>   void nvmet_file_ns_disable(struct nvmet_ns *ns)
>   {
>   	if (ns->file) {
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dc270944bb25..552af334fe1d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -365,6 +365,8 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
>   void nvmet_execute_async_event(struct nvmet_req *req);
>   
>   u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
> +void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id);
> +void nvmet_file_set_limits(struct file *file, struct nvme_id_ns *id);
>   u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
>   u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
>   u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
> 
