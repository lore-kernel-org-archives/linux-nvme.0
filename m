From: Damien.LeMoal@wdc.com (Damien Le Moal)
Date: Fri, 19 Jul 2019 00:39:42 +0000
Subject: Duplicate tag error with 5.2
References: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>
 <dbb6572c3d0b8ad1f20fd5f89ee112995676375b.camel@kernel.crashing.org>
 <6e4b08daaa0482bd863b63cc5a85fa58ed871045.camel@kernel.crashing.org>
 <CAOSXXT6Z=zEpWqac2k1ydk2LynAEtFr-4jXJVCtTa5yn8H7f3Q@mail.gmail.com>
 <ee8eb3c8855942eb22391dd6137f3b969abce303.camel@kernel.crashing.org>
 <f5de042adc383df7cb040859f13ce92412977467.camel@kernel.crashing.org>
 <8936e370b7ae272c8810780ee26ae3cebc8525b9.camel@kernel.crashing.org>
 <BYAPR04MB58169C5A4EF8DFB10C5C2148E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c7235187d44618bc6636da0968c8037aebf50742.camel@kernel.crashing.org>
Message-ID: <BYAPR04MB581667EE6FB45D86881529E2E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>

On 2019/07/18 16:40, Benjamin Herrenschmidt wrote:
> On Thu, 2019-07-18@07:13 +0000, Damien Le Moal wrote:
>>> I can trigger the problem easily now running smartctl -c /dev/nvme0n1
>>> and doing a bit of IOs. It seems to happen when the IO and Admin queue
>>> use the same tag.
>>
>> So isn't it that you are getting a completion cqe for an admin queue command in
>> an IO completion queue ? Or the reverse ? Given how weird this NVMe device seems
>> to be, it may be a possibility. In addition to the command ID (tag), if you
>> print the cqe queue ID (le16_to_cpu(cqe->sq_id)), what do you see ?
> 
> Ah I can add code to validate that it's coming into the right queue,
> good idea.

If the completion really shows up into the wrong queue, a fix may be simply to
hack this code in nvme_handle_cqe():

	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
	nvme_end_request(req, cqe->status, cqe->result);

to use a different nvmeq pointer, that is the one that corresponds to cqe->sq_id
queue used for submission, which would lead to the correct tagset to be
referenced and suppress the false "duplicate" tag issue. Locking of queues/hctx
may need careful checking with such a change though.

> 
>>> I verified after the crash, going to MacOS and getting the log from the
>>> T2 chip, that the tag it complains about *is* the one that we happened
>>> to have used accross both queues at the point where it dies.
>>>
>>> Now, I am not that familiar with the tag management/allocation code,
>>> how hard would it be to split the tags accross the queues ? I suppose I
>>> could easily add a quirk to do +32 to the tags used on the IO queue...
>>
>> The admin queue has its own tagset (nvme_dev->admin_tagset), separate from IO
>> queues (nvme_dev->tagset). So I do not see how this would solve the problem.
> 
> I can easily do that by offsetting command_id locally to pci.c but
> doing just that didn't completely fix it. It just made it much harder
> to hit. I suspect they might also not like tags > 128, so I've added a
> hack to clamp the IO queue depth to 64 as well, it's still running,
> I'll let it run overnight (smartctl in a loop + dd's)
> 
> Cheers,
> Ben.
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
