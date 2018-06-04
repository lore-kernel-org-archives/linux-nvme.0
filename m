From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 4 Jun 2018 09:21:16 -0500
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <05438bc4-61a0-e4ca-a00d-d918c20a0dcc@mellanox.com>
References: <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
 <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>
 <20180531170201.GB31715@lst.de>
 <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>
 <20180531172554.GA32068@lst.de>
 <702f1949-02eb-07e4-f101-58c32929b29d@grimberg.me>
 <010001d3fb68$99d01d80$cd705880$@opengridcomputing.com>
 <55bd8f56-5261-4f2e-d5a7-5bc50970deb3@grimberg.me>
 <20180604121136.GB29545@lst.de>
 <05438bc4-61a0-e4ca-a00d-d918c20a0dcc@mellanox.com>
Message-ID: <019101d3fc0f$4d32a4f0$e797eed0$@opengridcomputing.com>



> -----Original Message-----
> From: Max Gurtovoy <maxg at mellanox.com>
> Sent: Monday, June 4, 2018 8:52 AM
> To: Christoph Hellwig <hch at lst.de>; Sagi Grimberg <sagi at grimberg.me>
> Cc: Steve Wise <swise at opengridcomputing.com>; 'Ruhl, Michael J'
> <michael.j.ruhl at intel.com>; axboe at kernel.dk; 'Busch, Keith'
> <keith.busch at intel.com>; linux-nvme at lists.infradead.org;
> parav at mellanox.com; linux-rdma at vger.kernel.org
> Subject: Re: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed
sgl
> support
> 
> 
> 
> On 6/4/2018 3:11 PM, Christoph Hellwig wrote:
> > On Mon, Jun 04, 2018@03:01:43PM +0300, Sagi Grimberg wrote:
> >>
> >>> He's referring to patch 1 and 2, which are the host side.  No page
> allocations.
> >>
> >> I'm good with 1 & 2,
> >>
> >> Christoph, you can add my
> >>
> >> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> >
> > We've missed the merge window now, so we can just wait for a proper
> > resend from Steve I think.
> >
> 
> There are still issue that I'm trying to help Steve with their debug so
> let's wait with the merge until we figure them out.

I would like review on my new nvmet-rdma changes to avoid > 0 order page
allocations though.  Perhaps I'll resend the series and add the RFC tag (or
WIP?) with verbiage saying don't merge yet.
