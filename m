From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 May 2018 11:07:17 +0300
Subject: [PATCH 01/17] IB/isert: fix T10-pi check mask setting
In-Reply-To: <20180529221943.GR18442@mellanox.com>
References: <1527436222-15494-2-git-send-email-maxg@mellanox.com>
 <20180528072130.GB5618@lst.de>
 <452bfcde-ee3c-a4e5-e2d0-43114099590a@mellanox.com>
 <20180528120359.GA13368@lst.de>
 <99191c8c-b03e-f40d-ffd9-a73e01d0ae2a@mellanox.com>
 <20180528163324.GF17491@mellanox.com> <yq1o9gz2mi1.fsf@oracle.com>
 <6c7335c1-1d59-f764-be46-9aab46eb8458@mellanox.com>
 <20180529192329.GJ18442@mellanox.com> <yq1a7si15a1.fsf@oracle.com>
 <20180529221943.GR18442@mellanox.com>
Message-ID: <6e9b09a2-6b17-c128-fad1-198db6059a62@mellanox.com>



On 5/30/2018 1:19 AM, Jason Gunthorpe wrote:
> On Tue, May 29, 2018@06:11:18PM -0400, Martin K. Petersen wrote:
>>
>> Jason,
>>
>>>> we must wait until Martin PR for sure...
>>>
>>> Hmm, maybe we should have sent this patch through rdma in that
>>> case.. The merge window is soon anyhow so it doesn't really matter
>>> this time - but you need to think about what tree patches need to go
>>> to when building your patch plan, don't just send a large unstructured
>>> series like this and expect the maintainers to figure out all the
>>> dependencies!
>>
>> I am also happy to just drop the patch from scsi-fixes and you can
>> funnel everything through RDMA. Doesn't matter to me.
> 
> Sure, if you can still do that.. Max can you send me all four patches
> tomorrow and I'll route them through rdma.

Yes sure. I'm sorry for the ping-pong, I've tried to cover this in the 
cover letter but I guess I should've mentioned specifically what patches 
goes through which tree.

> 
> Thanks,
> Jason
> 
