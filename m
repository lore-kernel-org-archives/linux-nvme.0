From: Damien.LeMoal@wdc.com (Damien Le Moal)
Date: Fri, 19 Jul 2019 00:53:38 +0000
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
 <BYAPR04MB581667EE6FB45D86881529E2E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <50c35ab3db7745875476c0966bf191ab42de4dd1.camel@kernel.crashing.org>
Message-ID: <BYAPR04MB58163BC85D7A5351BC053D43E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>

On 2019/07/19 9:44, Benjamin Herrenschmidt wrote:
> On Fri, 2019-07-19@00:39 +0000, Damien Le Moal wrote:
>> On 2019/07/18 16:40, Benjamin Herrenschmidt wrote:
>>> On Thu, 2019-07-18@07:13 +0000, Damien Le Moal wrote:
>>>>> I can trigger the problem easily now running smartctl -c /dev/nvme0n1
>>>>> and doing a bit of IOs. It seems to happen when the IO and Admin queue
>>>>> use the same tag.
>>>>
>>>> So isn't it that you are getting a completion cqe for an admin queue command in
>>>> an IO completion queue ? Or the reverse ? Given how weird this NVMe device seems
>>>> to be, it may be a possibility. In addition to the command ID (tag), if you
>>>> print the cqe queue ID (le16_to_cpu(cqe->sq_id)), what do you see ?
>>>
>>> Ah I can add code to validate that it's coming into the right queue,
>>> good idea.
>>
>> If the completion really shows up into the wrong queue, a fix may be simply to
>> hack this code in nvme_handle_cqe():
>>
>> 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
>> 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>> 	nvme_end_request(req, cqe->status, cqe->result);
>>
>> to use a different nvmeq pointer, that is the one that corresponds to cqe->sq_id
>> queue used for submission, which would lead to the correct tagset to be
>> referenced and suppress the false "duplicate" tag issue. Locking of queues/hctx
>> may need careful checking with such a change though.
> 
> But if the completion arrived in the wrong queue, wouldn't we be
> missing the completions for admin requests and thus having all sort of
> issues ?
If the admin req completion comes in the wrong queue, then the admin queue
completion queue should not be changing and not need any head/doorbell tweaks.
It simply stays as is. Since I think that nvme_handle_cqe is used for all
commands regardless of submission type (normal, polled, sync, etc), this should
work in all cases. Not sure at all for all this. Some side effects are
definitely possible. But worth a try I think.

> 
> Things are now solid with those two changes I've done locally, I'll
> send a tentative patche:
> 
>  - Offset all tags in the IO queue with 32 so they don't overlap (I do
> it at the point of writing into the submission queue, and undo it when
> processing the CQs).
> 
>  - Reduce the IO queue depth by 32
> 
> Without the latter, I occasionally (but more rarely) still got the
> error, but always with tags > 127. I suspect that not only Apple
> implementation actually *uses* the tags we specify for their own
> internal tracking, but they also only support values 0...127.
> 
> With those two changes it's been solid. Thankfully the resulting quirk
> is reasonably simple and self contained to pci.c. I'll clean things up
> and post.
> 
> Cheers,
> Ben.
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
