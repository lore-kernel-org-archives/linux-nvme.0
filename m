From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 3 Jun 2018 14:57:20 +0300
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <20180531172554.GA32068@lst.de>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
 <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>
 <20180531170201.GB31715@lst.de>
 <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>
 <20180531172554.GA32068@lst.de>
Message-ID: <702f1949-02eb-07e4-f101-58c32929b29d@grimberg.me>


>> Ok then, I will leave them as bit numbers...
> 
> Btw, modulo the debug printk 1 & 2 look fine to me and I'd like to
> pull them in.  Sagi, are you ok with the patches?

I'd like to see a version that avoids higher order allocations first
as we can have a non negligible number of these allocations.
If it turns out too much of hassle we can stay with this.
