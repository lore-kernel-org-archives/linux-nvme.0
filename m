From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 20 Sep 2017 16:01:58 -0400
Subject: [PATCH] nvme: set physical block size to value discovered in
 Identify Namespace
In-Reply-To: <20170920190752.GC1379@localhost.localdomain> (Keith Busch's
 message of "Wed, 20 Sep 2017 15:07:52 -0400")
References: <20170920170605.42161-1-andrzej.jakowski@intel.com>
 <20170920174842.GB1379@localhost.localdomain>
 <20170920174814.GA2556@infradead.org>
 <20170920190752.GC1379@localhost.localdomain>
Message-ID: <yq1fubhkukp.fsf@oracle.com>


Keith,

> I don't think it's about "reasonable" performance; it's about getting
> extra relative performance. What else can the best performing LBAF
> indicate other than the device's preferred access alignment/granularity?
> The spec provides this hint, so it's not really a guess, but maybe
> there's a better way to make use of it instead of  considering it to be
> the physical block size? io_opt?

It should really report io_min and not physical_block_size. pbs is a
special case for spinning media.

I agree it's a bit weird to walk the format list as a heuristic. Would
be nicer to have a smallest preferred I/O size in the protocol.

> The first and last are the exact same NVMe format, but they're
> reported differently.

Yeah, we should set pbs/io_min as well.

-- 
Martin K. Petersen	Oracle Linux Engineering
