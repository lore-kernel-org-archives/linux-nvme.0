From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 1 Feb 2018 14:00:06 -0700
Subject: [PATCHv2 1/2] block: Merge discard requests as a special case
In-Reply-To: <20180201203158.24761-2-keith.busch@intel.com>
References: <20180201203158.24761-1-keith.busch@intel.com>
 <20180201203158.24761-2-keith.busch@intel.com>
Message-ID: <d55e87e6-e59c-9a22-297b-039febcb953c@kernel.dk>

On 2/1/18 1:31 PM, Keith Busch wrote:
> Discard requests operate under different constraints than other operations
> and have different rules for merging. This patch will handle such requests
> as a special case, using the same criteria and segment accounting used
> for merging a discard bio into a reqseut.

I already fixed this one up.

-- 
Jens Axboe
