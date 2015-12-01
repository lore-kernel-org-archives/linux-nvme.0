From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Tue, 1 Dec 2015 21:05:14 +0100
Subject: [PATCH v2] nvme: temporary fix for Apple controller reset
In-Reply-To: <565DFB7F.6000807@kernel.dk>
References: <781f695dc3cedc678faf29070a6f6bf5@localhost>
 <9cc23b98072a89f0f469f528f6e8f74e@localhost>
 <565DFB7F.6000807@kernel.dk>
Message-ID: <2b5655ec98dda469696608bf34344e5a@localhost>

On 2015/December/01 12:56, Jens Axboe wrote:
> On 12/01/2015 12:46 PM, Stephan G?nther wrote:
> >The patch below has been reviewed by Christoph and reported to work.
> >However, there is still no sign that it will be applied to linux-4.4.
> >
> >Please either undo commit c74dc7801d515d01847fd5cf2b472489fa5717b1,
> >which added the PCI ID of the Apple controller, or merge the patch below
> >asap.
> >
> >
> >Currently, the driver will make that controller destroy data!
> 
> Honestly, I'd rather revert the pci id addition, unless there's conclusive
> evidence that limiting the (per queue) depth to 2 really does fix the issue.

Wes Cilldhaire tested the patch (his answer is in that thread) - as I
did the past 3 weeks ago as I'm running solely Linux on that broken 
MacBook.

> Is this what the OSX driver does? What testing was done to ascertain that 2
> is the magic number? Does it just make it harder to hit, or does it really
> fix it?

I do not know what the OSX driver does. Apple is of absolutely no help
whatsoever.

But without that patch `mkfs btrfs` immediately fails. Even `partprobe
/dev/nvme0n1` will reset the controller (the latter one without data
loss).

As I am running a btrfs on a luks container for 3 weeks with that patch,
it *does* work. Performance is, obviously, not the best one I have seen.
But given the circumstances I cannot complain at all.


So again: please either revert the previous patch and leave it to the
more interested individuals to try it (probably slowing down Linux
support for that MacBook as not detecting the hard-soldered disk is
quite a blocker), or merge that hotfix until we find a better solution.

With 4.5 that may even become a quirk.


Best,
Stephan
