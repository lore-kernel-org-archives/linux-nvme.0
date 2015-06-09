From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 Jun 2015 00:46:43 -0700
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <20150609074643.GA5707@infradead.org>

Hi Matias,

I've been looking over this and I really think it needs a fundamental
rearchitecture still.  The design of using a separate stacking
block device and all kinds of private hooks does not look very
maintainable.

Here is my counter suggestion:

 - the stacking block device goes away
 - the nvm_target_type make_rq and prep_rq callbacks are combined
   into one and called from the nvme/null_blk ->queue_rq method
   early on to prepare the FTL state.  The drivers that are LightNVM
   enabled reserve a pointer to it in their per request data, which
   the unprep_rq callback is called on durign I/O completion.
