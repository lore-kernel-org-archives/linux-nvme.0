From: axboe@fb.com (Jens Axboe)
Date: Wed, 19 Aug 2015 14:26:56 -0700
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CBE3F9E@fmsmsx104.amr.corp.intel.com>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
 <20150806135018.GA8666@infradead.org>
 <B58D82457FDA0744A320A2FC5AC253B93CBE3F9E@fmsmsx104.amr.corp.intel.com>
Message-ID: <55D4F4A0.4090807@fb.com>

On 08/19/2015 12:12 PM, Busch, Keith wrote:
> Hi,
>
> Can this be applied for 4.3?

Applied - the patch wasn't against for-4.3/core, so I had to hand apply 
some bits and fixup another spot where bvec_gap_to_prev() was used that 
the patch didn't touch.

-- 
Jens Axboe
