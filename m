From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 08:37:53 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180604082455.6369788d@pentland.suse.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de> <20180530143020.50a299b8@pentland.suse.de>
 <20180530125452.GA2763@lst.de>
 <35d5d780-b1c2-d176-639b-b41106e3e980@grimberg.me>
 <20180604082455.6369788d@pentland.suse.de>
Message-ID: <20180604063753.GA20811@lst.de>

On Mon, Jun 04, 2018@08:24:55AM +0200, Hannes Reinecke wrote:
> On Thu, 31 May 2018 02:10:35 +0300
> Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> > > And I guess this where the real issue starts.  We should not do
> > > block I/O under nvmf_dev_mutex.
> > > 
> > > James has some work on asynchronous connects pending for FC, so I
> > > guess we could look into generalizing that and always exectute the
> > > real connect work in a different thread.  
> > 
> > I still need to ramp up on the ANA patches, but I'd prefer moving
> > create_ctrl outside of nvmf_dev_mutex instead of having it async.
> 
> We'd need the async patches still, as they provide a way on how we can
> call nvme-cli directly from within udev rules.
> Without those patches nvme-cli might get stuck (as this issue neatly
> proves) and would block udev from processing events.

So just run nvme-cli in the background from udev.  Or if udev really
is too stupid for that have an option to fork and run in the background
in nvme-cli itself..
