From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 3 May 2018 08:29:31 -0600
Subject: [PATCH] nvme-cli: fix get_nsid() return value check
In-Reply-To: <20180503100445.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180503100445.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180503142931.GL5938@localhost.localdomain>

On Thu, May 03, 2018@06:04:45AM -0400, Chaitanya Kulkarni wrote:
> All the callers of the get_nsid() defined cfg.namespace_id as __u32.
> The true return value of the call:-
> 
> cfg.namespace_id = get_nsid()
> 
> will not be used in case nvme_get_nsid() returns < 0 and
> comparion of
> 
> if (cfg.namespace_id <= 0)
> 
> and will result is cfg.namespace_id > 0 due to type mismatch.
> 
> We fix this scenario by returning the 0 (invalid nsid on get_nsid()
> for nvme_get_nsid() failure case) and adding
> 
> cfg.namespace_id == 0
> 
> for error checking in all the callers of the get_nsid().

Indeed, thanks for the fix. Applied.
