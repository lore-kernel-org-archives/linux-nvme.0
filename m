From: daniel.stodden@gmail.com (Daniel Stodden)
Date: Mon, 01 Dec 2014 14:32:43 -0800
Subject: NVMe driver within hypervisors
In-Reply-To: <alpine.LNX.2.00.1412011504440.4225@localhost.lm.intel.com>
References: <53cea8aa3891427498928f77e6b9dc46@hioexcmbx06-prd.hq.netapp.com>
 <alpine.LNX.2.00.1412011504440.4225@localhost.lm.intel.com>
Message-ID: <1417473163.6910.10.camel@espiritosanto.int.convergent.io>

On Mon, 2014-12-01@15:07 +0000, Keith Busch wrote:
> On Wed, 26 Nov 2014, Bhattacharya, Indranil wrote:
> > Hi,
> >
> > Is a NVMe driver available for the Xen hypervisor? I see that a Vmware ESXi driver has become available (http://www.nvmexpress.org/blog/1556/); but I don't see any similar announcement for Xen.
> 
> Correct me if I'm wrong, but doesn't Xen derive device driver support
> from its "dom-0"? Just use an nvme-capable Linux guest there and you've
> enabled Xen to support nvme, yeah?

Correct. Backends in dom0 eventually translate guest I/O to bios issued
to a kernel blockdev. Such as an NVMe one, typically implemented by a
normal Linux driver.

Daniel
