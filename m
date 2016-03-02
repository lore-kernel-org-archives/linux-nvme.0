From: hch@lst.de (Christoph Hellwig)
Date: Wed, 2 Mar 2016 22:17:29 +0100
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin
 queue
In-Reply-To: <56D7247C.4000208@dev.mellanox.co.il>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il>
Message-ID: <20160302211729.GA3803@lst.de>

On Wed, Mar 02, 2016@07:35:56PM +0200, Sagi Grimberg wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 680f578..19be56a 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>>   		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>>   		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
>>   		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
>> +		dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>
> I still don't understand what's the point?

still? :)

But yes, we're not going to hit the merge case for the passthrough
command indeed.  Except for keeping the flags in sync, which sounds
like a good ?dea in general there is not reall need for this one.
