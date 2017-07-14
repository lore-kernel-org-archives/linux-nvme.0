From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 10:54:45 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170714075309.GA17877@lst.de>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170714075309.GA17877@lst.de>
Message-ID: <1500022485.4808.3.camel@suse.com>

On Fri, 2017-07-14@09:53 +0200, Christoph Hellwig wrote:
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
> 
> What standard?  The wwid field is a Linux invention. 

I was referring to patch 1/3 in the series, the Linux target padding
the "model" string with 0-bytes, which is not allowed.

Regards
Martin

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
