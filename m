From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Jun 2017 13:03:02 -0400
Subject: [nvme-4.13 V2] nvme: Implement NS Optimal IO Boundary from 1.3
 Spec
In-Reply-To: <20170615165731.GB13399@localhost.localdomain>
References: <20170615154726.8337-1-scott.bauer@intel.com>
 <20170615165731.GB13399@localhost.localdomain>
Message-ID: <20170615170302.GC13399@localhost.localdomain>

On Thu, Jun 15, 2017@12:57:31PM -0400, Keith Busch wrote:
> Let's say we've a large noiob (16k) with a 4k block size. The above would
> shift beyond 32-bits, so I would rewrite this as:
> 
> 	unsigned int chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));

Oops, please disregard the fact I'm can't count overflow correctly...

I still prefer the alternate shift calculation, though.
