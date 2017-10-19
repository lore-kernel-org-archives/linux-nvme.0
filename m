From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 15:55:22 +0200
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <9cb7f448-f4a3-e3e6-e906-749a56daa943@grimberg.me>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
 <20171019084926.GA14227@lst.de>
 <9604c4ac-0a0f-a029-1894-051e6de50072@grimberg.me>
 <20171019102022.GC17326@lst.de>
 <9cb7f448-f4a3-e3e6-e906-749a56daa943@grimberg.me>
Message-ID: <20171019135522.GF21452@lst.de>

On Thu, Oct 19, 2017@01:28:42PM +0300, Sagi Grimberg wrote:
>>> We could, but that would mean that the nvme_ctrl tagset pointer will
>>> need to be updated later (or from the routine itself).
>>
>> That why I want to pass the address of the tagset pointers, so that
>> it can be updated.
>
> But I'm targeting this code to nvme-core which at this point, only has
> a pointer to the tagsets (which are embedded in the transport ctrl
> structs).

But with a a double indirection you _can_ update the pointers.
