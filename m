From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 09:54:12 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170713225739.GE14716@localhost.localdomain>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713225739.GE14716@localhost.localdomain>
Message-ID: <1500018852.4808.1.camel@suse.com>

On Thu, 2017-07-13@18:57 -0400, Keith Busch wrote:
> On Fri, Jul 14, 2017@12:25:30AM +0200, Martin Wilck wrote:
> > With the current implementation, the default "fallback" WWID
> > generation
> > code (if no nguid, euid etc. are defined) for Linux NVME host and
> > target
> > results in the following WWID format:
> > 
> > nvme.0000-3163653363666438366239656630386200-
> > 4c696e7578000000000000000000000000000000000000000000000000000000000
> > 0000000000000-00000002
> > 
> > This is not only hard to read, it poses real problems for multipath
> > (dm WWIDs are limited to 128 characters), and it's not fully
> > standards
> > compliant.
> > 
> > With this patch series, the WWID on a Linux host connected to a
> > Linux target
> > looks like this:
> > 
> > nvme.0000-d319fc8b2883bfec-4c696e7578-00000001
> 
> Just curious for non-hex strings, is there a problem with any
> utilities
> if we use the ASCII for both serial and model? It'd be half as long.

That was my first approach to the issue. But then I realized that the
term "WWID" is ususally associated with a hex string. 
(https://en.wikipedia.org/wiki/World_Wide_Name), so allowing arbitrary
ASCII might violate some people's assumptions of how a WWID should look
like. (Not to mention that we don't have a vendor OUI...).

> 
> For example, my device's wwid attribute looks like this today:
> 
>  nvme.8086-46554d42353235363030304a32383041-
> 494e54454c2053534450454431443134304741-00000001 
> 
> But would this cause a problem for anything?
> 
>   nvme.8086-FUMB5256000J280A-INTEL_SSDPED1D140GA-00000001

I don't know. That's why I took the more conservative approach.
I think yours is fine (actually much better for human beings), 
we just shouldn't call it "wwid".

Martin

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
