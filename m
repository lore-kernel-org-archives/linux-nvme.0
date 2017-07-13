From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 15:06:52 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <d32c32f6-3f8f-c63a-f961-ee16407c2fd6@grimberg.me>
Message-ID: <20170713130652.GA24376@lst.de>

On Thu, Jul 13, 2017@03:30:39PM +0300, Sagi Grimberg wrote:
> It seems weird that a subsystem has a serial.

But that's actually how NVMe defines them.  Which mean we first
need to fix our code to generate a serial number per subsystem,
and on top of that the patch from Johannes seems perfectly reasonable.
