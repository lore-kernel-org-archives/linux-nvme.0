From: emilgoode@gmail.com (Emil Goode)
Date: Fri, 17 May 2013 17:22:20 +0200
Subject: [PATCH] NVMe: Fix incompatible pointer type warnings
In-Reply-To: <20130517144526.GV6057@linux.intel.com>
References: <1368799780-2871-1-git-send-email-emilgoode@gmail.com>
 <20130517144526.GV6057@linux.intel.com>
Message-ID: <20130517152220.GA2807@debian>

I see, I will resend and include Andrew Morton.

Thanks,

Emil

On Fri, May 17, 2013@10:45:26AM -0400, Matthew Wilcox wrote:
> On Fri, May 17, 2013@04:09:40PM +0200, Emil Goode wrote:
> > Commit 6a4d55146334 ("block: prep work for batch completion")
> > added a struct batch_complete * as a third argument to bi_end_io.
> > This patch adds the missing third argument to the nvme_bio_pair_endio
> > function.
> 
> That patch isn't in Linus' tree yet, so we can't apply this patch.  It needs
> to go to linux-next.
