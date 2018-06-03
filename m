From: swise@opengridcomputing.com (Steve Wise)
Date: Sun, 3 Jun 2018 13:27:59 -0500
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <702f1949-02eb-07e4-f101-58c32929b29d@grimberg.me>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
 <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>
 <20180531170201.GB31715@lst.de>
 <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>
 <20180531172554.GA32068@lst.de>
 <702f1949-02eb-07e4-f101-58c32929b29d@grimberg.me>
Message-ID: <010001d3fb68$99d01d80$cd705880$@opengridcomputing.com>



> -----Original Message-----
> From: Sagi Grimberg <sagi at grimberg.me>
> Sent: Sunday, June 3, 2018 6:57 AM
> To: hch at lst.de; Steve Wise <swise at opengridcomputing.com>
> Cc: Ruhl, Michael J <michael.j.ruhl at intel.com>; axboe at kernel.dk; Busch,
> Keith <keith.busch at intel.com>; linux-nvme at lists.infradead.org;
> parav at mellanox.com; maxg at mellanox.com; linux-rdma at vger.kernel.org
> Subject: Re: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
> support
> 
> 
> >> Ok then, I will leave them as bit numbers...
> >
> > Btw, modulo the debug printk 1 & 2 look fine to me and I'd like to
> > pull them in.  Sagi, are you ok with the patches?
> 
> I'd like to see a version that avoids higher order allocations first
> as we can have a non negligible number of these allocations.
> If it turns out too much of hassle we can stay with this.

He's referring to patch 1 and 2, which are the host side.  No page allocations. 

Also, I made the changes to avoid higher order allocations for patch 3.  Testing now.   I'll send it out tomorrow.

Steve.
