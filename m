From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Apr 2018 03:22:23 -0700
Subject: [PATCH 1/1] RDMA over Fibre Channel
In-Reply-To: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
References: <20180418094240.26371-1-muneendra.kumar@broadcom.com>
Message-ID: <20180418102223.GA27364@infradead.org>

On Wed, Apr 18, 2018@02:42:40AM -0700, muneendra.kumar@broadcom.com wrote:
> Eventhough it is inspired from the Soft RoCE driver, the underlying
> transport layer is FC-NVMe (short for 'NVMe over fibre channel').
> The request, response and completion state machines in the driver
> have been heavily modified to adapt to the Exchange based Data
> transfer mechanism of Fibre channel.

That sounds like a bad joke.  Please stop abusing the NVMe code for this
otherwise reasonable idea.  You should be able to layer this over plain
FCP just fine.
