From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Jun 2017 11:42:14 -0400
Subject: [RFC PATCH] nvme: Submit uevents for log page notification
In-Reply-To: <20170614150546.GA32323@infradead.org>
References: <1490388582-10237-1-git-send-email-keith.busch@intel.com>
 <20170330083609.GD11540@lst.de>
 <20170614150546.GA32323@infradead.org>
Message-ID: <20170614154213.GE26073@localhost.localdomain>

On Wed, Jun 14, 2017@08:05:46AM -0700, Christoph Hellwig wrote:
> Given that we have the uevent discussion again can you resubmit this
> with the comments address, most notably only enabling it for the
> uevents we want userspace to handle.  Maybe including whatever
> code you have on the userspace side (even if it's an ugly prototype)

Thanks for reminding me. I'll rebase, address the comments, and resend
shortly.
