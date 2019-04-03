From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Apr 2019 16:53:16 +0200
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <20190401031036.GB11565@localhost.localdomain>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
 <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
 <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>
 <20190401031036.GB11565@localhost.localdomain>
Message-ID: <20190403145316.GA25258@lst.de>

On Sun, Mar 31, 2019@09:10:37PM -0600, Keith Busch wrote:
> Wouldn't this indicate MDTS should be driven from hardware constraints
> rather than user tunable knobs? I don't think we should have user
> parameters if their only purpose is to test how host drivers react
> to them. It's okay if they've a functional purpose, but there are so
> many adjustable nvme parameters, this is a bit of a slippery slope if we
> want to turn the nvme target driver into a host driver test vehicle.

Agreed.  In that past we've not merged patches that just include
tunables for testing purposes, and I'm inclined to keep that stance.
