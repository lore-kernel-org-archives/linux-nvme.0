From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Jun 2016 11:18:11 -0400
Subject: nvme-cli plugins
In-Reply-To: <20160608130754.GA31553@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
 <20160607184248.GE28414@localhost.localdomain>
 <20160607223908.GC30120@localhost.localdomain>
 <20160608130754.GA31553@lst.de>
Message-ID: <20160608151811.GD1430@localhost.localdomain>

On Wed, Jun 08, 2016@03:07:54PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 07, 2016@06:39:09PM -0400, Keith Busch wrote:
> > It also adds support for dynamically loaded plug-ins. This is so a
> > 3rd party or vendor can extend the program without having their stuff
> > in-tree. It accomplishes this using the dynamic linking loader (dlopen,
> > dlsym, and friends) to open and register symbols.
> 
> I'm really worried about dlopen()able symbols.  They mean you now
> expose an ABI, and once in distros will probably cause all kinds of
> vendors to ask for ABI stability.

I'm happy to drop it for now, but would like something like this since
the demand exists. If we get the right ABI, maitaining it shouldn't much
trouble; 'fio' does dynamic loading for ioengines, and nvme-cli is a
small project in comparison.

I would like to get it right the first time, so no particular rush yet.
