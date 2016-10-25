From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Oct 2016 09:53:57 -0700
Subject: [PATCH 2/2] nvme: don't pass the full CQE to
 nvme_complete_async_event
In-Reply-To: <1477411779-2993-3-git-send-email-hch@lst.de>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
 <1477411779-2993-3-git-send-email-hch@lst.de>
Message-ID: <20161025165357.GA19876@infradead.org>

> +	bool done = false;

This should be true.  Should have tested with injected AERs before
sending this out..
