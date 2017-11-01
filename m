From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 08:36:40 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <20171028172114.2045-1-jsmart2021@gmail.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
Message-ID: <20171101153640.GA13553@infradead.org>

On Sat, Oct 28, 2017@10:21:09AM -0700, James Smart wrote:
> A transport may have a transport-specific mechanism that can signal
> when discovery controller content has changed and request a host
> to reconnect to the discovery controller.

Can you point to the part of the NVMe spec that allows this?
While the FC transport obviously could do it there is nothing in the
NVMe architecture model documenting this behavior.
