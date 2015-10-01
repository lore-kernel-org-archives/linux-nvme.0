From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 1 Oct 2015 00:59:45 -0700
Subject: [PATCH 02/10] blk-mq: fix racy updates of rq->errors
In-Reply-To: <1443380518-6829-3-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-3-git-send-email-hch@lst.de>
Message-ID: <20151001075944.GA25051@infradead.org>

Jens,

please consider this and the next patch on their own while the rest
of the series will need a major rework.  I suspect this one might
even be a 4.3 candidate.
