From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Jun 2017 02:52:21 -0700
Subject: [PATCH 2/9] block: add support for write hints in a bio
In-Reply-To: <1498004526-4543-3-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-3-git-send-email-axboe@kernel.dk>
Message-ID: <20170626095221.GC14057@infradead.org>

Looks fine for now:

Reviewed-by: Christoph Hellwig <hch at lst.de>

(although I suspect we'll eventually move to a hints field
separate from the REQ_* flags).
