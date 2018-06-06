From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 6 Jun 2018 08:19:32 -0600
Subject: [PATCH 1/6] nvme-pci: Remove unnecessary nested locking
In-Reply-To: <20180606141309.19389-2-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-2-keith.busch@intel.com>
Message-ID: <27bfed2b-e1cd-9870-6376-af2451aca774@kernel.dk>

On 6/6/18 8:13 AM, Keith Busch wrote:
> The nvme pci driver no longer handles completions under the cq lock,
> so the nested locking is not necesssary.
                                 ^^
necessary

Other than that:

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
