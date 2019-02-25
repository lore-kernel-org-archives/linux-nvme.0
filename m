From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 25 Feb 2019 08:10:16 -0800
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <20190225153827.GA17442@linux-x5ow.site>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
 <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
 <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
 <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>
 <20190225153827.GA17442@linux-x5ow.site>
Message-ID: <1551111016.31902.149.camel@acm.org>

On Mon, 2019-02-25@16:38 +0100, Johannes Thumshirn wrote:
> On Mon, Feb 25, 2019@06:49:04AM -0800, Bart Van Assche wrote:
> > On 2/25/19 1:37 AM, Johannes Thumshirn wrote:
> > > On 24/02/2019 11:54, Max Gurtovoy wrote:
> > > > What is the status of iSCSI/SRP targets in this case ?
> > > 
> > > iSCSI/SRP passes in the following:
> > > 
> > >   /*
> > >    * Use O_DSYNC by default instead of O_SYNC to forgo syncing
> > >    * of pure timestamp updates.
> > >    */
> > >   flags = O_RDWR | O_CREAT | O_LARGEFILE | O_DSYNC;
> > 
> > That code fragment comes from the LIO file backend. There is no requirement
> > for a SCSI target core file backend to use O_DSYNC. SCST allows users to
> > choose whether or not O_DSYNC should be used:
> 
> Yes, LIO file backend is the in-tree equivalent to NVMe's file backend. That's
> why I copied it here.
> 
> 
> > 
> > 	if (virt_dev->wt_flag && !virt_dev->nv_cache)
> > 		open_flags |= O_DSYNC;
> > 
> 
> OK. Do your open_flags include O_DIRECT per default as well?

I don't think it has ever been supported to pass O_DIRECT to filp_open().
As one can see in build_open_flags() O_DIRECT is ignored. The only way I
know of to submit direct I/O from kernel context is by setting the
IOCB_DIRECT flag.

Bart.
