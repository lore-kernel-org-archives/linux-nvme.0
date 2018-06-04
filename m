From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 11:48:14 +0200
Subject: [PATCH 8/9] nvmet: support configuring additional ANA groups
In-Reply-To: <20180604065339.GA21183@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-9-hch@lst.de>
 <20180604084250.302284cf@pentland.suse.de>
 <20180604065339.GA21183@lst.de>
Message-ID: <20180604114814.5213858b@pentland.suse.de>

On Mon, 4 Jun 2018 08:53:39 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Jun 04, 2018@08:42:50AM +0200, Hannes Reinecke wrote:
> > I'm not particularly keen of having the default ANA group _not_
> > being present in configfs, but that can be fixed with a later
> > patch.  
> 
> Yes, I came to the conclusion that having it visible and even being
> able to change state might be useful.  We just need to careful to
> not allow removing it, but I think the SCSI target code has some
> precedence for that.

No worries, I have a patch for that.
I'm currently rebasing my patchset (including ANATT support) and will
be posting it once testing has completed.

Cheers,

Hannes
