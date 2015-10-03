From: hch@lst.de (Christoph Hellwig)
Date: Sat, 3 Oct 2015 12:02:23 +0200
Subject: [PATCH 4/7] nvme: merge nvme_dev_start, nvme_dev_resume and
 nvme_async_probe
In-Reply-To: <alpine.LNX.2.00.1510022119550.23840@localhost.lm.intel.com>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-5-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510022119550.23840@localhost.lm.intel.com>
Message-ID: <20151003100223.GB851@lst.de>

On Fri, Oct 02, 2015@09:27:28PM +0000, Keith Busch wrote:
> On Fri, 2 Oct 2015, Christoph Hellwig wrote:
>> And give the resulting function a sensible name.  This keeps all the
>> error handling in a single place and will allow for further improvements
>> to it.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>
> This, and the next patch by extension, are in conflict with the
> linux-block/for-linus. We had to move where the irq affinity hint
> is set due to the scanning occuring in yet-another-work-queue.
>
> The simplication is great though, feel free to add my review if you
> spin another.

Thanks - I'll rebase everything on top of Jens' tree.
