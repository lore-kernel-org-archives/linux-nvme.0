From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 14:42:37 +0200
Subject: please revert a nvme-cli commit
In-Reply-To: <64647508-fd1f-9ec2-171d-88ba2a5653b7@broadcom.com>
References: <20180613075557.GA22940@lst.de>
 <64647508-fd1f-9ec2-171d-88ba2a5653b7@broadcom.com>
Message-ID: <20180614124237.GA28896@lst.de>

On Wed, Jun 13, 2018@08:51:38AM -0700, James Smart wrote:
> Really ?? sigh.? I have lots of consumers that have no issues with these 
> changes and there is nothing that acts "incompatible".?? It's been 1.5 
> months - where have you been?
>
> These conditions can occur independent of any change in kernel 
> implementation and are significant robustness corrections.

I don't agree.  For one so far we've guaranteed the device node
appears before we return from the write to the /dev/nvme-fabrics
device.  If that changes it is a significant ABI break, and we need
to fix that in the kernel.

And if it wasn't the fix is still wrong - we'd need to wait for it to
appear using libudev APIs and/or one of the file notification syscalls
rather than adding a probing loop that is in a different place than
the actual open.

And for retrying the actual I/O we need to decide on the exact semantics
we want to support first.  Blind n time retry is always a bad idea,
we need to build some sort of reliable infrastructure.  Be that
optionally marking requests as not failfast, and/or some sort of poll
notification for a device that is ready.
