From: mb@lightnvm.io (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Thu, 23 Jul 2015 12:48:00 +0200
Subject: [PATCH v5 4/5] null_blk: LightNVM support
In-Reply-To: <20150723095351.GB26420@infradead.org>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
 <1437587464-7964-5-git-send-email-mb@lightnvm.io>
 <20150723095351.GB26420@infradead.org>
Message-ID: <55B0C660.8010509@lightnvm.io>

On 07/23/2015 11:53 AM, Christoph Hellwig wrote:
> Any reason you're adding this to null_blk instead of having a separate
> null_nvm driver?
> 

Only reason was to not duplicate the I/O submission/completion flow.
With the simple code at the moment, it is little to add. However, if
someone decides to put backing store, simulation, etc. into it, then it
should properly go into another module.

Do you want me to move it into a new driver for this patchset?
