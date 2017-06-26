From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:59:07 -0700
Subject: [PATCH 9/9] nvme: add support for streams and directives
In-Reply-To: <1498004526-4543-10-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-10-git-send-email-axboe@kernel.dk>
Message-ID: <20170626095907.GG14057@infradead.org>

Looks mostly good,

but two nit-picks:

 - can we keep a module option to disable streams, or in fact for
   now maybe to explicitly enable it?  I expect this to be interesting
   at least for the first devices that implement it.  Also given that
   it needs to be explicitly enabled I would expect some overhead of
   just enabling it when never used
 - do we even need the < 4 streams fallback now that they are global
   instead of per-ns instead of just disabling the feature for now?
