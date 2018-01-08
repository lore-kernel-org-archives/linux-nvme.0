From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 10:58:01 +0100
Subject: [PATCH 3/5] block: Provide blk_status_t decoding for retryable
 errors
In-Reply-To: <20180104224623.8944-4-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-4-keith.busch@intel.com>
Message-ID: <20180108095801.GE4673@lst.de>

> +static inline bool blk_retryable(blk_status_t error)

The naming isn't really useful - it is about the fact that it's
worth retrying on another path.  So please chose a better name,
and add a kerneldoc comment describing it.
