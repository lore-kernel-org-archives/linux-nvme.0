From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 30 Apr 2019 08:23:59 -0700
Subject: [PATCH 1/2] nvme: nvme_set_queue_count should use descriptive
 macros
In-Reply-To: <20190429173533.10366-2-ednadols@linux.microsoft.com>
References: <20190429173533.10366-1-ednadols@linux.microsoft.com>
 <20190429173533.10366-2-ednadols@linux.microsoft.com>
Message-ID: <20190430152359.GA11751@infradead.org>

On Mon, Apr 29, 2019@10:35:32AM -0700, Edmund Nadolski wrote:
> Implement macros to set/get the number of submission and/or completion
> queues requested by the Set Features command. This replaces the bit
> masking/shifting code which is harder to read and more error prone to
> maintain.
> 
> Signed-off-by: Edmund Nadolski <ednadols at linux.microsoft.com>

I have to say I actually find this much harder to read than the old
version.
