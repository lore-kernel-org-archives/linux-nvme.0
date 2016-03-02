From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 3 Mar 2016 07:55:15 +0800
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin
 queue
In-Reply-To: <20160302211729.GA3803@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il>
 <20160302211729.GA3803@lst.de>
Message-ID: <CACVXFVM=-BSTGbrO1MqciCs4zPAt1Lfk1=9DZr+NNur-R96j_g@mail.gmail.com>

On Thu, Mar 3, 2016@5:17 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Mar 02, 2016@07:35:56PM +0200, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 680f578..19be56a 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>>>              dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>>>              dev->admin_tagset.numa_node = dev_to_node(dev->dev);
>>>              dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
>>> +            dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>>
>> I still don't understand what's the point?
>
> still? :)
>
> But yes, we're not going to hit the merge case for the passthrough
> command indeed.  Except for keeping the flags in sync, which sounds
> like a good ?dea in general there is not reall need for this one.

NO_SG_MERGE has been bypassed after bio splitting is introduced,
and looks it should have been removed.


-- 
Ming Lei
