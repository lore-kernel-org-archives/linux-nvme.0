From: kbusch@kernel.org (Keith Busch)
Date: Tue, 2 Apr 2019 17:31:35 -0600
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <91c8f4a1-8bb6-adac-4206-e65d778cc2b1@mellanox.com>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
 <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>
 <9abfa47a-3374-a1a0-8370-1096d02743d0@suse.com>
 <20190401031036.GB11565@localhost.localdomain>
 <c42e4c4e-51bb-b255-b242-e68594bc160a@suse.de>
 <91c8f4a1-8bb6-adac-4206-e65d778cc2b1@mellanox.com>
Message-ID: <20190402233135.GF16792@localhost.localdomain>

On Tue, Apr 02, 2019@03:06:02PM +0300, Max Gurtovoy wrote:
> On 4/1/2019 2:48 PM, Hannes Reinecke wrote:
> > On 4/1/19 5:10 AM, Keith Busch wrote:
> > > 
> > > Wouldn't this indicate MDTS should be driven from hardware constraints
> > > rather than user tunable knobs? I don't think we should have user
> > > parameters if their only purpose is to test how host drivers react
> > > to them. It's okay if they've a functional purpose, but there are so
> > > many adjustable nvme parameters, this is a bit of a slippery slope if we
> > > want to turn the nvme target driver into a host driver test vehicle.
> > > 
> > I would love to indicate hardware constraints to nvme target; there's a
> > similar problem I'm facing in that the hardware is using only a limited
> > set of queues, but I cannot express this with nvme target.
> > However, in the absense of such an interface having a manual
> > configuration allows us to at least _map_ onto the hardware
> > capabilities.
> 
> my suggestion exactly check the HW constraint.
> 
> My suggestion also makes sure that a greedy user will get a clamp and an
> economical user can save resources at the target.
> 
> Let's say I have a very "weak" target server with super HCA (ConnectX-5), so
> in that case I would like to set mdts=4 (or so) and let the initiator block
> layer to deal with 1MB IO splits.
> 
> Keith,
> 
> although NVMe has many params, I guess we can make some of the most vital
> ones to be tunable.
> 
> I agree regarding code adaptation for test-cases (we shouldn't change driver
> in order to write tests), but in this case it's a real world scenario.

Fair enough, I am all for config options that serve to help the nvme
target work better.
