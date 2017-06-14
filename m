From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 14 Jun 2017 09:27:27 -0700
Subject: [PATCH nvme-4.13] nvme/pci: Use saved CSTS value
In-Reply-To: <1497456838-11593-1-git-send-email-keith.busch@intel.com>
References: <1497456838-11593-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170614162727.GA14468@infradead.org>

On Wed, Jun 14, 2017@12:13:58PM -0400, Keith Busch wrote:
> Don't re-read controller status when checking controller health on an
> IO timeout.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> Note for Christoph: I planned to fold this into a v2 of the watchdog
> timer removal, but I see that was added in commit afd83d84461808, but
> under the wrong author. :)

Meh, damn git rebase messing up the author on conlicts one again.
I'll fold the patch and will fix the author when doing the next
rebase.

I still need a review for my 64-bit division fix before doing that
rebase, though.
