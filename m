From: keith.busch@intel.com (Keith Busch)
Date: Mon, 1 Dec 2014 15:07:17 +0000 (UTC)
Subject: NVMe driver within hypervisors 
In-Reply-To: <53cea8aa3891427498928f77e6b9dc46@hioexcmbx06-prd.hq.netapp.com>
References: <53cea8aa3891427498928f77e6b9dc46@hioexcmbx06-prd.hq.netapp.com>
Message-ID: <alpine.LNX.2.00.1412011504440.4225@localhost.lm.intel.com>

On Wed, 26 Nov 2014, Bhattacharya, Indranil wrote:
> Hi,
>
> Is a NVMe driver available for the Xen hypervisor? I see that a Vmware ESXi driver has become available (http://www.nvmexpress.org/blog/1556/); but I don't see any similar announcement for Xen.

Correct me if I'm wrong, but doesn't Xen derive device driver support
from its "dom-0"? Just use an nvme-capable Linux guest there and you've
enabled Xen to support nvme, yeah?
