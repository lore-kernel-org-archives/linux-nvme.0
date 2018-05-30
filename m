From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 30 May 2018 10:11:53 -0500
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
Message-ID: <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>



On 5/30/2018 9:39 AM, Steve Wise wrote:
>
> On 5/29/2018 3:23 PM, Ruhl, Michael J wrote:
>>> -----Original Message-----
>>> From: linux-rdma-owner at vger.kernel.org [mailto:linux-rdma-
>>> owner at vger.kernel.org] On Behalf Of Steve Wise
>>> Sent: Tuesday, May 29, 2018 2:26 PM
>>> To: axboe at kernel.dk; hch at lst.de; Busch, Keith <keith.busch at intel.com>;
>>> sagi at grimberg.me; linux-nvme at lists.infradead.org
>>> Cc: parav at mellanox.com; maxg at mellanox.com; linux-rdma at vger.kernel.org
>>> Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
>>> support
>>>
>>> The code was checking bit 20 instead of bit 2.  Also fixed
>>> the log entry.
>>>
>>> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>>> ---
>>> drivers/nvme/host/rdma.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index 1eb4438..f11faa8 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -1949,8 +1949,8 @@ static struct nvme_ctrl
>>> *nvme_rdma_create_ctrl(struct device *dev,
>>> 	}
>>>
>>> 	/* sanity check keyed sgls */
>>> -	if (!(ctrl->ctrl.sgls & (1 << 20))) {
>>> -		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not
>>> support\n");
>>> +	if (!(ctrl->ctrl.sgls & (1 << 2))) {
>>> +		dev_err(ctrl->ctrl.device, "Mandatory keyed sgls are not
>>> supported!\n");
>> I can see that the 2 and 20 are defined for specific things.  Since they are
>> used in several places (in the next 2 patches), is there any chance these
>> could be defined bits?
>>
>> Mike
>>
> That seems reasonable.? I would think these defines could also be shared
> across the host and target.? Perhaps include/linux/nvme.h?? I see both
> nvme/host/nvme.h and nvme/target/nvmet.h include linux/nvme.h.? So they
> could go there.?
>
> Christoph, what do you think?? It seems like these are either nvme
> protocol bits or nvme/f protocol bits...
>
> Steve.
>
>

It looks like these bits are part of the Identify Controller Data
Structure, figure 90 in the 1.2.1 spec.? The SGL Support (SGLS) field
within that struct.?? So I guess it belongs in include/linux/nvme.h??
But I don't see any of this big structure in that header.?



Steve.
