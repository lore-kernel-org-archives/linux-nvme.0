From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 1 Dec 2015 12:56:47 -0700
Subject: [PATCH v2] nvme: temporary fix for Apple controller reset
In-Reply-To: <9cc23b98072a89f0f469f528f6e8f74e@localhost>
References: <781f695dc3cedc678faf29070a6f6bf5@localhost>
 <9cc23b98072a89f0f469f528f6e8f74e@localhost>
Message-ID: <565DFB7F.6000807@kernel.dk>

On 12/01/2015 12:46 PM, Stephan G?nther wrote:
> The patch below has been reviewed by Christoph and reported to work.
> However, there is still no sign that it will be applied to linux-4.4.
>
> Please either undo commit c74dc7801d515d01847fd5cf2b472489fa5717b1,
> which added the PCI ID of the Apple controller, or merge the patch below
> asap.
>
>
> Currently, the driver will make that controller destroy data!

Honestly, I'd rather revert the pci id addition, unless there's 
conclusive evidence that limiting the (per queue) depth to 2 really does 
fix the issue. Is this what the OSX driver does? What testing was done 
to ascertain that 2 is the magic number? Does it just make it harder to 
hit, or does it really fix it?


-- 
Jens Axboe
