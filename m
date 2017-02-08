From: parav@mellanox.com (Parav Pandit)
Date: Wed, 8 Feb 2017 20:06:10 +0000
Subject: [PATCH] nvmet: Do not check for sg_cnt being zero for	read/write
 commands.
References: <1486510557-26831-1-git-send-email-parav@mellanox.com>
 <20170208082426.GA7629@lst.de> 
Message-ID: <VI1PR0502MB3008EA12098DAF45C42CF937D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>



> -----Original Message-----
> From: Parav Pandit
> Sent: Wednesday, February 8, 2017 9:11 AM
> To: 'Christoph Hellwig' <hch at lst.de>
> Cc: sagi at grimberg.me; linux-nvme at lists.infradead.org
> Subject: RE: [PATCH] nvmet: Do not check for sg_cnt being zero for
> read/write commands.
> 
> 
> > -----Original Message-----
> > From: Christoph Hellwig [mailto:hch at lst.de]
> > Sent: Wednesday, February 8, 2017 2:24 AM
> > To: Parav Pandit <parav at mellanox.com>
> > Cc: hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org
> > Subject: Re: [PATCH] nvmet: Do not check for sg_cnt being zero for
> > read/write commands.
> >
> > On Tue, Feb 07, 2017@05:35:57PM -0600, Parav Pandit wrote:
> > > sg_cnt cannot be zero for inline or sge mode from the fabric drivers
> > > because nvme read/write commands have minimum of one block to be
> > read
> > > or written. (nlb dw12 is 0 based value).
> > > So sg_cnt check for 0 is not useful.
> >
> > Except that we currently don't verify the data transfer in the SGL
> > matches that in the command.  It's been on my todo list for a while,
> > so maybe you can take it off my plate first before we'll aply this patch.
> 
> Yes. I hit an error when there was a mismatch between nlba and sge length.
> That check is needed to fail the nvme requests. I will post that patch soon.

However check for sg_cnt being not zero doesn't catch that error either, so both the checks are unrelated.
I think this patch still holds fine?
