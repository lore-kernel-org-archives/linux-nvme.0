From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 14:22:40 -0700
Subject: [PATCH 05/47] block: remoe REQ_ATOM_COMPLETE wrappers
In-Reply-To: <1448037342-18384-6-git-send-email-hch@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-6-git-send-email-hch@lst.de>
Message-ID: <5654D520.3070604@fb.com>

On 11/20/2015 09:35 AM, Christoph Hellwig wrote:
> We only use them inconsistenly, and the other flags don't use wrappers like
> this either.

Also fine with this, but it should go sooner in the series (before the 
previous one, to be specific).

-- 
Jens Axboe
