From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:16:21 +0200
Subject: [PATCH 2/6] nvme: use 'nvmsXnZ' instead of 'nvm-subXnZ'
In-Reply-To: <1506952559-1588-3-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-3-git-send-email-hare@suse.de>
Message-ID: <20171002161621.GB11048@lst.de>

On Mon, Oct 02, 2017@03:55:55PM +0200, Hannes Reinecke wrote:
> Align with overall nvme device naming scheme.

It is very close to the normal /dev/nvme* devices, so I feat it will
create a lot of confusion.

But given that all device name suggestions so far suck I'd be happy
to take a stawpoll of linux-nvme subscribers :)
