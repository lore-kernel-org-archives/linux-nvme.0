From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 15:14:37 -0600
Subject: [PATCH V5] nvmet: add simple file backed ns support
In-Reply-To: <20180517124714.GA31470@lst.de>
References: <20180517054558.5648-1-chaitanya.kulkarni@wdc.com>
 <20180517124714.GA31470@lst.de>
Message-ID: <20180517211436.GH23555@localhost.localdomain>

On Thu, May 17, 2018@02:47:14PM +0200, Christoph Hellwig wrote:
> On Thu, May 17, 2018@01:45:58AM -0400, Chaitanya Kulkarni wrote:
> > The new file io-cmd-file.c is responsible for handling
> > the code for I/O commands when ns is file backed. Also,
> > we introduce mempools based slow path for file backed
> > ns.
> 
> Please use ~ 73 lines for the changelog to instead of line wrapping
> earlier.

Useful tip for vi users: http://vim.wikia.com/wiki/Chop_long_lines

The same method can combine shorter lines.
