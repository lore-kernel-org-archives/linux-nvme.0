From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 08:57:11 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <d6d14ba1-b17f-f635-5235-0115170b01f1@gmail.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <20171101153640.GA13553@infradead.org>
 <d6d14ba1-b17f-f635-5235-0115170b01f1@gmail.com>
Message-ID: <20171101155711.GA4591@infradead.org>

On Wed, Nov 01, 2017@08:55:36AM -0700, James Smart wrote:
> There will not be anything in the NVMe base spec about such a thing as it's
> pci, nor will there be anything in the NVMe Fabrics spec as nothing about
> this changes or alters nvmf discovery. It can and is fully documented in the
> transport spec which has been visible in drafts for almost a year. It's not
> disallowed simply because an arch section doesn't mention it. It also falls
> under the "method that a host uses to obtain the information necessary to
> connect to the initial Discovery Service is implementation specific" - but
> in this case, the transport, in a published way, is making that
> implementation easier. I don't know what you're trying to say.

You'll need to discuss this with the technical working group or we won't
support it in Linux.  I'm getting sick and tired of the FC smokey
backroom secret sauce.
