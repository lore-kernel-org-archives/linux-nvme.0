From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:56:12 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170713225739.GE14716@localhost.localdomain>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713225739.GE14716@localhost.localdomain>
Message-ID: <20170714075612.GE17877@lst.de>

On Thu, Jul 13, 2017@06:57:39PM -0400, Keith Busch wrote:
> For example, my device's wwid attribute looks like this today:
> 
>  nvme.8086-46554d42353235363030304a32383041-494e54454c2053534450454431443134304741-00000001 
> 
> But would this cause a problem for anything?
> 
>   nvme.8086-FUMB5256000J280A-INTEL_SSDPED1D140GA-00000001

It would have been nicer, but it will break existing setups.

Distros should instead switch to use the nqn for the char dev
uniqueue identifier (we now fake it up even for controllers that
don't provide it), and the EUI64/NGUID/UUID if provided for the
block device names.
