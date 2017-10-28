From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 27 Oct 2017 23:45:08 -0700
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
Message-ID: <20171028064508.GA20977@infradead.org>

And what about sanitize?  I guess instead of looking at opcodes directly
we'd better look at the indications in the Commands Supported and Effects
log.  That's what the Windows driver does, btw.
