From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Oct 2017 10:20:39 -0600
Subject: [PATCH 2/6] nvme: use 'nvmsXnZ' instead of 'nvm-subXnZ'
In-Reply-To: <20171002161621.GB11048@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-3-git-send-email-hare@suse.de>
 <20171002161621.GB11048@lst.de>
Message-ID: <20171002162038.GS8463@localhost.localdomain>

On Mon, Oct 02, 2017@06:16:21PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 02, 2017@03:55:55PM +0200, Hannes Reinecke wrote:
> > Align with overall nvme device naming scheme.
> 
> It is very close to the normal /dev/nvme* devices, so I feat it will
> create a lot of confusion.
> 
> But given that all device name suggestions so far suck I'd be happy
> to take a stawpoll of linux-nvme subscribers :)

Of the options availble, +1 to Hannes' nvmsXnY.
