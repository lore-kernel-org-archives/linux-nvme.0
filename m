From: Damien.LeMoal@wdc.com (Damien Le Moal)
Date: Fri, 19 Jul 2019 05:01:01 +0000
Subject: [PATCH v2] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
References: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
 <BYAPR04MB58168C42A68712287F734242E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <bc856389e6b09f7c545144be0f370f7ad3b05784.camel@kernel.crashing.org>
Message-ID: <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>

On 2019/07/19 13:49, Benjamin Herrenschmidt wrote:
> On Fri, 2019-07-19@04:43 +0000, Damien Le Moal wrote:
>> On 2019/07/19 13:37, Benjamin Herrenschmidt wrote:
>>> Another issue with the Apple T2 based 2018 controllers seem to be
>>> that they blow up (and shut the machine down) if there's a tag
>>> collision between the IO queue and the Admin queue.
>>>
>>> My suspicion is that they use our tags for their internal tracking
>>> and don't mix them with the queue id. They also seem to not like
>>> when tags go beyond the IO queue depth, ie 128 tags.
>>>
>>> This adds a quirk that offsets all the tags in the IO queue by 32
>>> to avoid those collisions. It also limits the number of IO queues
>>> to 1 since the code wouldn't otherwise make sense (the device
>>> supports only one queue anyway but better safe than sorry) and
>>> reduces the size of the IO queue
>>
>> What about keeping the IO queue QD at 128, but marking the first 32 tags as
>> "allocated" when the device is initialized ? This way, these tags numbers are
>> never used for regular IOs and you can avoid the entire tag +/- offset dance at
>> runtime. The admin queue uses tags 0-31 and the IO queue uses tags 32-127. No ?
> 
> I suppose that would work and be simpler. I honestly don't know much
> about the block layer and tag allocation so I stayed away from it :-)
> 
> I'll dig, but a hint would be welcome :)

Uuuh.. Never played with the tag management code directly myself either. A quick
look seem to indicate that blk_mq_get/put_tag() is what you should be using. But
further looking, struct blk_mq_tags has the field nr_reserved_tags which is used
as an offset start point for searching free tags, which is exactly what you
would need.


-- 
Damien Le Moal
Western Digital Research
