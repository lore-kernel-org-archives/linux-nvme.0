From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Mar 2018 21:24:32 -0600
Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
In-Reply-To: <20180327153908.3732-1-keith.busch@intel.com>
References: <20180327153908.3732-1-keith.busch@intel.com>
Message-ID: <973b51a9-d340-3c9e-bec0-12db96002d9b@kernel.dk>

On 3/27/18 9:39 AM, Keith Busch wrote:
> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0; a driver may allocate pre_vectors for special use. This
> patch adds an offset parameter so blk-mq may find the intended affinity
> mask and updates all drivers using this API accordingly.

Looks good to me, I'll queue it up for 4.17.

-- 
Jens Axboe
