From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 5 Jul 2017 11:06:12 -0700
Subject: [PATCH] nvme-rdma: unconditionally recycle the request mr
In-Reply-To: <1499238818-17963-1-git-send-email-sagi@grimberg.me>
References: <1499238818-17963-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170705180612.GA12334@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

(and btw ib_dereg_mr seems horribly misnamed, it really should be
ib_free_mr)
