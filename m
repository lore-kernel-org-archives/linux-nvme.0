From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Tue, 13 Feb 2018 14:53:01 +0100
Subject: [PATCH 1/1] nvme: implement log page low/high offset and dwords
In-Reply-To: <1518529671.3592.9.camel@suse.de>
References: <20180213124916.28653-1-mb@lightnvm.io>
 <20180213124916.28653-2-mb@lightnvm.io> <1518529671.3592.9.camel@suse.de>
Message-ID: <a3b14909-0f9a-b0b3-876e-eb9722b528d1@lightnvm.io>

On 02/13/2018 02:47 PM, Johannes Thumshirn wrote:
> On Tue, 2018-02-13@13:49 +0100, Matias Bj?rling wrote:
>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +			????u8 log_page, void *log,
>> +			????size_t size, size_t offset)
>> +{
>> +	struct nvme_command c = { };
>> +	unsigned long dwlen = (size / 4) - 1;
> 
> Consulting my long gone maths knowledge suggests the parantheses aren't
> really needed here.
> 

Heh, you're right. However, it does make it a bit more readable? The 
untrained eye would properly mess it up was my thinking for keeping them.
