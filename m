From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 07:25:08 -0700
Subject: [PATCH-4.7 1/3] NVMe: Return ENODEV error on invalid namespace
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D578C4F@fmsmsx104.amr.corp.intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-2-git-send-email-keith.busch@intel.com>
 <20160503075821.GA31768@infradead.org>
 <B58D82457FDA0744A320A2FC5AC253B93D578C4F@fmsmsx104.amr.corp.intel.com>
Message-ID: <20160503142508.GA28219@infradead.org>

On Tue, May 03, 2016@02:19:28PM +0000, Busch, Keith wrote:
> This was added at the joint request from one OSV and IHV. I've no idea
> what they're software is doing with this, but they say it doesn't do the
> right thing with 'EIO'. ENODEV for invalid namespaces sounded like a
> reasonable error.

Well, I'll have to say "no" to this until said OSV and IHV can explain
why they need this in detail on linux-nvme.  And even then we'll
probably need a different solution for them.
