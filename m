From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 1 Oct 2015 10:12:24 +0200
Subject: [PATCH 02/10] blk-mq: fix racy updates of rq->errors
In-Reply-To: <20151001075944.GA25051@infradead.org>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-3-git-send-email-hch@lst.de>
 <20151001075944.GA25051@infradead.org>
Message-ID: <560CEAE8.7080103@kernel.dk>

On 10/01/2015 09:59 AM, Christoph Hellwig wrote:
> Jens,
>
> please consider this and the next patch on their own while the rest
> of the series will need a major rework.  I suspect this one might
> even be a 4.3 candidate.

Added those two for 4.3 on top of Akinobu's series.

-- 
Jens Axboe
