From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 29 Jul 2016 15:10:30 -0700
Subject: [PATCH 2/5] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <20160725091253.cq6lpgultbzleyq5@c203.arch.suse.de>
References: <5792b91c.7HwdoM0qFRAjvQId%james.smart@broadcom.com>
 <20160725091253.cq6lpgultbzleyq5@c203.arch.suse.de>
Message-ID: <1469830230.12212.46.camel@linux.intel.com>

On Mon, 2016-07-25@11:12 +0200, Johannes Thumshirn wrote:
> On Fri, Jul 22, 2016@05:23:56PM -0700, James Smart wrote:
> > 
> > nvme-fabrics: Add FC transport LLDD api definitions:
> > 
> > Host:
> > -LLDD registration with the host transport
> > -registering host ports (local ports) and target ports seen on
> >    fabric (remote ports)
> > -Data structures and call points for FC-4 LS's and FCP IO requests
> > 
> > Target:
> > -LLDD registration with the target transport
> > -registering nvme subsystem ports (target ports)
> > -Data structures and call points for reception of FC-4 LS's and
> >    FCP IO requests, and callbacks to perform data and rsp transfers
> >    for the io.
> > 
> > 
> > Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> Acked-by: Johannes Thumshirn <jth at kernel.org>

Acked-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> 
