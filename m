From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 30 Oct 2017 08:30:04 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171028064508.GA20977@infradead.org>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171028064508.GA20977@infradead.org>
Message-ID: <ac29e201-7d60-d698-d6a3-9b4c0307c91f@kernel.dk>

On 10/28/2017 12:45 AM, Christoph Hellwig wrote:
> And what about sanitize?  I guess instead of looking at opcodes directly
> we'd better look at the indications in the Commands Supported and Effects
> log.  That's what the Windows driver does, btw.

Isn't that exactly what Keith's patch did?

-- 
Jens Axboe
