From: helen.koike@collabora.co.uk (Helen Koike)
Date: Mon, 27 Mar 2017 13:04:44 -0300
Subject: [PATCH v5 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <20170327094947.GA26830@infradead.org>
References: <20170317222843.GD13709@localhost.localdomain>
 <1490329423-17152-1-git-send-email-helen.koike@collabora.com>
 <20170327094947.GA26830@infradead.org>
Message-ID: <619476f4-9680-e00b-3692-175adfbf4838@collabora.co.uk>

Hi Keith,

Thanks for your review. Please, see my comments below

On 2017-03-27 06:49 AM, Christoph Hellwig wrote:
>> +#define SQ_IDX(qid, stride)	((qid) * 2 * (stride))
>> +#define CQ_IDX(qid, stride)	(((qid) * 2 + 1) * (stride))
>
> Please use inline functions for these.
>
>> +	struct {
>> +		u32 *dbs;
>> +		u32 *eis;
>> +		dma_addr_t dbs_dma_addr;
>> +		dma_addr_t eis_dma_addr;
>> +	} dbbuf;
>
> No need for a struct here, also please keep the field and its dma_addr_t
> together.
>
>> +	struct {
>> +		u32 *sq_db;
>> +		u32 *cq_db;
>> +		u32 *sq_ei;
>> +		u32 *cq_ei;
>> +	} dbbuf;
>
> No need for the struct here either.
>
>> +
>> +static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>> +{
>> +	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
>> +
>> +	dev->dbbuf.dbs = dma_alloc_coherent(dev->dev, mem_size,
>> +					    &dev->dbbuf.dbs_dma_addr,
>> +					    GFP_KERNEL);
>> +	if (!dev->dbbuf.dbs)
>> +		return -ENOMEM;
>> +	dev->dbbuf.eis = dma_alloc_coherent(dev->dev, mem_size,
>> +					    &dev->dbbuf.eis_dma_addr,
>> +					    GFP_KERNEL);
>> +	if (!dev->dbbuf.eis) {
>> +		dma_free_coherent(dev->dev, mem_size,
>> +				  dev->dbbuf.dbs, dev->dbbuf.dbs_dma_addr);
>> +		dev->dbbuf.dbs = NULL;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>
> Please use normal kernel-style goto unwinding.

I don't think it is necessary as there is only a single item to unwind. 
 From my experience in other parts of the kernel code we usually use 
goto when there are several other steps to unwind. But I don't mind 
changing it if you still prefer a goto here.

>
>> +static void nvme_dbbuf_set(struct nvme_dev *dev)
>> +{
>> +	struct nvme_command c;
>> +
>> +	if (!dev->dbbuf.dbs)
>> +		return;
>> +
>> +	memset(&c, 0, sizeof(c));
>> +	c.dbbuf.opcode = nvme_admin_dbbuf;
>> +	c.dbbuf.prp1 = cpu_to_le64(dev->dbbuf.dbs_dma_addr);
>> +	c.dbbuf.prp2 = cpu_to_le64(dev->dbbuf.eis_dma_addr);
>> +
>> +	if (nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0))
>> +		/* Free memory and continue on */
>> +		nvme_dbbuf_dma_free(dev);
>
> At least log a warning.
>
>> +static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
>> +{
>> +	/* Borrowed from vring_need_event */
>
> I don't think this comment matters.
>
>> +static void nvme_write_doorbell(u16 value,
>> +				u32 __iomem *db,
>> +				u32 *dbbuf_db,
>> +				volatile u32 *dbbuf_ei)
>> +{
>
> Very odd formatting.  Why not:
>
> static void nvme_write_doorbell(u16 value, u32 __iomem *db, u32 *dbbuf_db,
> 		volatile u32 *dbbuf_ei)
>
> ?
>
>> +	u16 old_value;
>> +
>> +	if (!dbbuf_db) {
>> +		writel(value, db);
>> +		return;
>> +	}
>
> I'd prefer to keep this in the ultimate callers to make the flow
> easier to read.
>
>> +static inline void nvme_write_doorbell_cq(struct nvme_queue *nvmeq, u16 value)
>> +{
>> +	nvme_write_doorbell(value, nvmeq->q_db + nvmeq->dev->db_stride,
>> +			    nvmeq->dbbuf.cq_db, nvmeq->dbbuf.cq_ei);
>> +}
>> +
>> +static inline void nvme_write_doorbell_sq(struct nvme_queue *nvmeq, u16 value)
>> +{
>> +	nvme_write_doorbell(value, nvmeq->q_db,
>> +			    nvmeq->dbbuf.sq_db, nvmeq->dbbuf.sq_ei);
>>  }
>
> I'd skip these wrappers entirely.

I added them to avoid future mistakes as mixing nvmeq->dbbuf.sq_db with 
nvmeq->dbbuf.sq_ei. But I don't mind to remove them either.

>
>> +	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
>> +		result = nvme_dbbuf_dma_alloc(dev);
>> +		if (result)
>> +			goto out;
>> +	}
>
> Should we really fail the init here or just print a warning?
>
