From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 16:55:12 +0200
Subject: [PATCH] Fix controller reset return
In-Reply-To: <20180525145009.GR11037@localhost.localdomain>
References: <20180511162501.7258-1-keith.busch@intel.com>
 <20180525091056.GD11309@infradead.org>
 <20180525145009.GR11037@localhost.localdomain>
Message-ID: <20180525145512.GA27143@lst.de>

On Fri, May 25, 2018@08:50:09AM -0600, Keith Busch wrote:
> On Fri, May 25, 2018@02:10:56AM -0700, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to nvme-4.18-2
> 
> I'd included this one in an earlier 4.17 pull request. The regression
> caused some major problems in test automation, and the fix was trivial.

ok, I'll drop it again to avoid a duplicate commit.
