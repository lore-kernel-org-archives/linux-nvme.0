From: hch@lst.de (hch@lst.de)
Date: Thu, 31 May 2018 19:25:54 +0200
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
 <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>
 <20180531170201.GB31715@lst.de>
 <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>
Message-ID: <20180531172554.GA32068@lst.de>

On Thu, May 31, 2018@12:17:07PM -0500, Steve Wise wrote:
> Ok then, I will leave them as bit numbers...

Btw, modulo the debug printk 1 & 2 look fine to me and I'd like to
pull them in.  Sagi, are you ok with the patches?
