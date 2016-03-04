From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Mar 2016 18:13:06 +0000
Subject: [PATCH] NVMe: Create discard zero quirk white list
In-Reply-To: <20160304180443.GA3972@infradead.org>
References: <1457113522-14099-1-git-send-email-keith.busch@intel.com>
 <20160304180443.GA3972@infradead.org>
Message-ID: <20160304181305.GA24457@localhost.localdomain>

On Fri, Mar 04, 2016@10:04:43AM -0800, Christoph Hellwig wrote:
> Not happy about this, but I guess we'll need something like this in the
> long run..

Cool, thanks for the feedback. I mainly wanted to confirm there wasn't
a better way to do this.

I will need to resend as I merged this from an older branch, and flag
value is already claimed for a different quirk.
