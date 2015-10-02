From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 14:26:22 +0000 (UTC)
Subject: [PATCH 1/2] NVMe: Reference count open namespaces
In-Reply-To: <20151002125932.GA11175@infradead.org>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
 <1443741251-13274-2-git-send-email-keith.busch@intel.com>
 <20151002125932.GA11175@infradead.org>
Message-ID: <alpine.LNX.2.00.1510021417360.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> Shouldn't each namesapce have a reference on the nvme_dev while we're at
> it?

We just need to make a small change to the device removal. An orderly
removal won't drop the final namespace ref until after the last device ref
is closed first. This relationship isn't necessary and can be simplified
even more if we remove it.

Should I fix and resend this patch, or patch on top of this one?

> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
