From: parav@mellanox.com (Parav Pandit)
Date: Sat, 14 Jan 2017 16:12:37 +0000
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <45c8815c-d9a1-4a74-8a70-0a0ea11d8201@grimberg.me>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
 <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>
 <CAG53R5XGW-up2JtB_X29nPwbEGW14mvRBjnao8yOHczYUvvPgg@mail.gmail.com>
 <45c8815c-d9a1-4a74-8a70-0a0ea11d8201@grimberg.me>
Message-ID: <VI1PR0502MB3008E00F1FC094A35496C6DBD17B0@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Hi Sagi, Christoph,

> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Friday, January 13, 2017 2:01 PM
> To: Parav Pandit <pandit.parav at gmail.com>
> Cc: Parav Pandit <parav at mellanox.com>; Christoph Hellwig <hch at lst.de>;
> linux-nvme at lists.infradead.org; linux-rdma at vger.kernel.org;
> dledford at redhat.com
> Subject: Re: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data
> structures
> 
> > Hi Sagi,
> 
> > If we keep the patch as it is in 4.10-rc, than I think IB/rxe will
> > break with plays with virtual addresses.
> 
> I've been seeing reports that nvme-rdma is not useable with rxe as it crashes
> pretty consistently.
> 
> In any event, we can either add this with 'ib_' prefix into 4.10-rc and add a
> patch to Bart's series or we can send a dedicated patch for stable.
> 
> Christoph, whats your preference?

I see there is some discussion with Bart's patch with respect to SDMA.
So I guess it might take a while to merge his patchset.

How about doing this?
- add this with 'ib_' prefix into 4.10-rc.
- followed by cherry pick this commit in linux-rdma tree.

When Bart rebase it, changes of this fix will automatically get converted from ib_ to dma_.
So shall I send patch for 4.10-rc with 'ib_' prefix?
