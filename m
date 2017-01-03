From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 3 Jan 2017 15:09:43 -0700
Subject: [PATCH v4 0/6] SED OPAL Library
In-Reply-To: <20161231054735.GA28356@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <20161230082826.GA30378@infradead.org>
 <20161230225252.GA3716@sbauer-Z170X-UD5>
 <20161231035108.GA18886@infradead.org>
 <5c2ba56a-dfc4-d83a-0df0-b66b2f59cb54@eng.utah.edu>
 <20161231054735.GA28356@infradead.org>
Message-ID: <20170103220941.GA2182@sbauer-Z170X-UD5>

On Fri, Dec 30, 2016@09:47:35PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 30, 2016@10:41:46PM -0700, Scott Bauer wrote:
> > I don't have an issue with that. It may take a week or two we'll have to have
> > lawyers and crap OK the new program, not sure how long that takes.
> 
> If it makes your life easier I can just take your existing code and
> move it to a new tools once we're ready to merge the kernel code.

I think that will be the best for us. I've ripped it out of nvme-cli
and attempted to make a stand alone utility. I blatantly stole some
functions and files from nvme-cli to get it to work but it isn't dependent
on nvme-cli anymore.

I've temporarily pushed it here:
https://github.com/ScottyBauer/sed-opal-temp

I don't know anything about licensing but it's dependent on some GPL2 code
in argconfig.c so I assume it will have to be under that one as well.

I'd prefer to maintain it off my Personal Github account so if we want to host it
on infradead that would be good or if we want to create another repo on github
that's fine too (like what nvme-cli is hosted on).
