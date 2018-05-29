From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 29 May 2018 13:33:47 -0500
Subject: Question on inline support
In-Reply-To: <72e73b2e-4e3d-a39e-8514-a0a506a5b409@opengridcomputing.com>
References: <5276f947-0ccf-5d0e-53bc-724f65c1c837@opengridcomputing.com>
 <20180529174442.GA1637@lst.de>
 <72e73b2e-4e3d-a39e-8514-a0a506a5b409@opengridcomputing.com>
Message-ID: <39f14994-bebe-121c-3485-a5d1143542a4@opengridcomputing.com>



On 5/29/2018 12:48 PM, Steve Wise wrote:
>
> On 5/29/2018 12:44 PM, hch@lst.de wrote:
>> On Tue, May 29, 2018@12:33:56PM -0500, Steve Wise wrote:
>>> Hey guys,
>>>
>>> While testing the nvme rdma target with inline_data_size=0 for my patch
>>> series [1], I found that the nvme host side rejected the queue
>>> connections with this error:
>>>
>>> "nvme nvme0: Mandatory keyed sgls are not support"
>>>
>>> Due to this code in nvme/host/rdma.c:
>>>
>>> ?????? /* sanity check keyed sgls */
>>> ?????? if (!(ctrl->ctrl.sgls & (1 << 20))) {
>>> ?????????????? dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not
>>> support\n");
>>> ?????????????? ret = -EINVAL;
>>> ?????????????? goto out_remove_admin_queue;
>>> ?????? }
>> Keyed SGLs are bit 2, so the above should check for bit 2 as well.
> Ah.? I'll fix that.
>
>> We should still check for bit 20 if inline data is supported, though.
>>
> Why, exactly?? Use of inline data is determined by the target's
> advertised ioccsz, and handled in nvme/host/rdma.c:
>
> static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue
> *queue)
> {
> ??????? return queue->cmnd_capsule_len - sizeof(struct nvme_command);
> }
>
> Are you saying that the host should support a target that doesn't set
> bit 20, yet advertises an ioccsz that could support inline??
>
> Thanks,
>
> Steve.


I added this:? only use inline if the target advertised it via bit 20
-and- there is space available based on ioccsz.

I'm resending a new version of my series soon.

Thanks,

Steve.
