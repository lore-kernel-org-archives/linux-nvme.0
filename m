From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Jul 2017 18:57:39 -0400
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170713222533.30794-1-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
Message-ID: <20170713225739.GE14716@localhost.localdomain>

On Fri, Jul 14, 2017@12:25:30AM +0200, Martin Wilck wrote:
> With the current implementation, the default "fallback" WWID generation
> code (if no nguid, euid etc. are defined) for Linux NVME host and target
> results in the following WWID format:
> 
> nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002
> 
> This is not only hard to read, it poses real problems for multipath
> (dm WWIDs are limited to 128 characters), and it's not fully standards
> compliant.
> 
> With this patch series, the WWID on a Linux host connected to a Linux target
> looks like this:
>
> nvme.0000-d319fc8b2883bfec-4c696e7578-00000001

Just curious for non-hex strings, is there a problem with any utilities
if we use the ASCII for both serial and model? It'd be half as long.

For example, my device's wwid attribute looks like this today:

 nvme.8086-46554d42353235363030304a32383041-494e54454c2053534450454431443134304741-00000001 

But would this cause a problem for anything?

  nvme.8086-FUMB5256000J280A-INTEL_SSDPED1D140GA-00000001
