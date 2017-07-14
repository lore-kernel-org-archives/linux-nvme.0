From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 11:41:37 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170714075612.GE17877@lst.de>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713225739.GE14716@localhost.localdomain>
 <20170714075612.GE17877@lst.de>
Message-ID: <1500025297.4808.6.camel@suse.com>

On Fri, 2017-07-14@09:56 +0200, Christoph Hellwig wrote:
> On Thu, Jul 13, 2017@06:57:39PM -0400, Keith Busch wrote:
> > For example, my device's wwid attribute looks like this today:
> > 
> >  nvme.8086-46554d42353235363030304a32383041-
> > 494e54454c2053534450454431443134304741-00000001 
> > 
> > But would this cause a problem for anything?
> > 
> >   nvme.8086-FUMB5256000J280A-INTEL_SSDPED1D140GA-00000001
> 
> It would have been nicer, but it will break existing setups.
> 
> Distros should instead switch to use the nqn for the char dev
> uniqueue identifier (we now fake it up even for controllers that
> don't provide it), and the EUI64/NGUID/UUID if provided for the
> block device names.
> 

The "if provided" is the crucial point here. In real life currently
many people struggle with ugly overlong identifiers because these IDs
are _not_ provided by default. I daresay that this attribute is pretty
much broken in current setups, in particular linux host with linux
target.

If it's late to change this attribute for API stability reasons, we
should consider keeping it as legacy and add (yet) another one with a
saner format.

Martin
-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
