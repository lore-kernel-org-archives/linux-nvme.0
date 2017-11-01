From: jsmart2021@gmail.com (James Smart)
Date: Wed, 1 Nov 2017 08:55:36 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <20171101153640.GA13553@infradead.org>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <20171101153640.GA13553@infradead.org>
Message-ID: <d6d14ba1-b17f-f635-5235-0115170b01f1@gmail.com>

On 11/1/2017 8:36 AM, Christoph Hellwig wrote:
> On Sat, Oct 28, 2017@10:21:09AM -0700, James Smart wrote:
>> A transport may have a transport-specific mechanism that can signal
>> when discovery controller content has changed and request a host
>> to reconnect to the discovery controller.
> 
> Can you point to the part of the NVMe spec that allows this?
> While the FC transport obviously could do it there is nothing in the
> NVMe architecture model documenting this behavior.

There will not be anything in the NVMe base spec about such a thing as 
it's pci, nor will there be anything in the NVMe Fabrics spec as nothing 
about this changes or alters nvmf discovery. It can and is fully 
documented in the transport spec which has been visible in drafts for 
almost a year. It's not disallowed simply because an arch section 
doesn't mention it. It also falls under the "method that a host uses to 
obtain the information necessary to connect to the initial Discovery 
Service is implementation specific" - but in this case, the transport, 
in a published way, is making that implementation easier. I don't know 
what you're trying to say.

-- james
