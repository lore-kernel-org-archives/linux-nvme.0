From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 20 Oct 2015 10:38:38 -0700
Subject: [PATCH] Update target repo for nvme patch contributions
In-Reply-To: <20151018182337.GB21211@lst.de>
References: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20151016234700.GA13234@localhost.localdomain>
 <20151018182337.GB21211@lst.de>
Message-ID: <1445362718.2819.40.camel@linux.intel.com>

On Sun, 2015-10-18@20:23 +0200, Christoph Hellwig wrote:
> On Fri, Oct 16, 2015@11:47:01PM +0000, Busch, Keith wrote:
> > This is not in drivers/block anymore, so question to Jens: do you 
> > want
> > to take on maintenance for driver/nvme? We've been doing it this 
> > way
> > de-facto for the past year, so if you're okay with listing your 
> > tree
> > for nvme, that's definitely okay with me too.
> > 
> > I'll just throw out for the next merge window that I'm happy to 
> > herd all
> > the nvme patches out there into a pull request in a public tree if 
> > that
> > would help.
> > 
> > I've started this one, so far just with Christoph's latest, plus a 
> > fix
> > from me from the fallout:
> > 
> >   http://git.infradead.org/users/kbusch/linux-nvme.git
> > 
> > I'll be happy to add patches from other developers that appear to 
> > have
> > been left behind as well.
> 
> A nvme tree sounds useful to me, and I'd love to see you handle it.
> 
> But for now I think it might be a good idea if it gets pulled by Jens
> into the block layer tree given that nvme is driving a lot of the 
> block
> layer work and having both merged early is going to make everyones 
> life
> a lot easier.

Let me know if there is a different target or other info you'd like me
to add to this patch and I'll change it.
