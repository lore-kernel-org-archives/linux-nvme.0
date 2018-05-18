From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 15:31:47 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <20180518212849.GB31490@localhost.localdomain>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
 <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>
 <20180518212849.GB31490@localhost.localdomain>
Message-ID: <266ee916-b86a-c499-20ff-98cf716059b5@kernel.dk>

On 5/18/18 3:28 PM, Keith Busch wrote:
> On Fri, May 18, 2018@03:22:20PM -0600, Jens Axboe wrote:
>> Totally untested, does this work?
> 
> Looks like that did the trick. Previously it triggered within 1 or 2
> iterations. Haven't seen in about a dozen so far.

Alright, folded into that patch. This impacts the two patches after
this one too, updated versions all attached. Or find them here:

http://git.kernel.dk/cgit/linux-block/log/?h=nvme-4.18

-- 
Jens Axboe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-nvme-pci-drop-IRQ-disabling-on-submission-queue-lock.patch
Type: text/x-patch
Size: 1480 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180518/0404be47/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-nvme-pci-split-the-nvme-queue-lock-into-submission-a.patch
Type: text/x-patch
Size: 5380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180518/0404be47/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-nvme-pci-handle-completions-outside-of-the-queue-loc.patch
Type: text/x-patch
Size: 5976 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180518/0404be47/attachment-0002.bin>
