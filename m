From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 5 Oct 2018 19:16:04 -0600
Subject: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <20181004212747.6301-8-logang@deltatee.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
Message-ID: <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>

On 10/4/18 3:27 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory. This will be used by P2P providers and
> orchestrators (in subsequent patches) to ensure block devices can
> support P2P memory before submitting P2P backed pages to submit_bio().

Nit pick, but the subject line still says that it checks support
for requests. This patch just adds the ability to flag support
in the queue.

-- 
Jens Axboe
