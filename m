From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 15:23:32 +0000
Subject: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
References: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <CGME20190512155540epcas4p14c15eb86b08dcd281e9a93a4fc190800@epcms2p1>
 <20190513074601epcms2p12c0a32730a16be3b69b68e3c9d4d0b92@epcms2p1>
Message-ID: <SN6PR04MB4527DFC75838C3236F5D05B2860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 05/13/2019 12:46 AM, Minwoo Im wrote:
>> +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
>> +					 size_t bytes, loff_t offset)
>> +{
>> +	loff_t pos = 0;
>> +	u32 chunk_size;
>> +
>> +	if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))
>> +		chunk_size = UINT_MAX;
>> +
>> +	while (pos < bytes) {
>> +		size_t size = min_t(size_t, bytes - pos, chunk_size);
>> +		int ret;
>> +
>> +		ret = nvme_get_log(ctrl, NVME_NSID_ALL,
>> NVME_LOG_TELEMETRY_CTRL,
>> +				   0, buf + pos, size, offset + pos);
>> +		if (ret)
>> +			return ret;
>> +
>> +		pos += size;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int nvme_get_telemetry_log(struct nvme_ctrl *ctrl,
>> +				  struct sg_table *table, size_t bytes)
>> +{
>> +	int n = sg_nents(table->sgl);
>> +	struct scatterlist *sg;
>> +	size_t offset = 0;
>> +	int i;
>> +
A little comment would be nice if you are using sg operations.
>> +	for_each_sg(table->sgl, sg, n, i) {
>> +		struct page *page = sg_page(sg);
>> +		size_t size = min_t(int, bytes - offset, sg->length);
>> +		int ret;
>> +
>> +		ret = nvme_get_telemetry_log_blocks(ctrl,
>> page_address(page),
>> +						    size, offset);
>> +		if (ret)
>> +			return ret;
>> +
>> +		offset += size;
>> +	}
>> +
>> +	return 0;
>> +}
>
> Can we have those two in nvme-core module instead of being in pci module?

Since they are based on the controller they should be moved next to 
nvme_get_log() in the ${KERN_DIR}/drivers/nvme/host/core.c.

>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
