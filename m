From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Apr 2017 10:58:44 -0700
Subject: [PATCH] lpfc: Fix memory corruption of the lpfc_ncmd->list
 pointers
In-Reply-To: <20170422004908.24261-1-jsmart2021@gmail.com>
References: <20170422004908.24261-1-jsmart2021@gmail.com>
Message-ID: <20170425175844.GC3575@infradead.org>

On Fri, Apr 21, 2017@05:49:08PM -0700, jsmart2021@gmail.com wrote:
> This is a nvme-specific bug. The patch was cut against the
> linux-block tree, for-4.12/block tree. It should be pulled in through
> that tree.

It conflicts with your nvme changes that are in the nvme-4.12.
Can you respin it?
