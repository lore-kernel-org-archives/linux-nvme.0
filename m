From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Nov 2015 11:53:06 -0800
Subject: nvme lightnvm comments
In-Reply-To: <20151123160319.GA7208@localhost.localdomain>
References: <20151120105022.GA22131@infradead.org>
 <20151121111210.GA19360@infradead.org>
 <565206C3.3000200@bjorling.me>
 <20151123154557.GA20924@infradead.org>
 <20151123160319.GA7208@localhost.localdomain>
Message-ID: <20151123195306.GA18448@infradead.org>

On Mon, Nov 23, 2015@04:03:20PM +0000, Keith Busch wrote:
> We also thought it'd have been cleaner to have a different command set,
> but the committee hasn't taken on assigning these reserved bits for any
> new purposes yet. LightNVM detection is done with the vendor + device
> id at the moment.

I saw the vendor + device, but even with that I'd rather see a reserved
value in the command set in addition.  Claiming that we're NVM if we're
not is a bad idea.

While we're at it - the NVMe driver really should check for these
reserved bits and reject a PCIe device that doesn't claim to implement
the NVM command set.
