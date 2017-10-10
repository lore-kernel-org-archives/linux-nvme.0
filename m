From: greg@kroah.com (Greg KH)
Date: Tue, 10 Oct 2017 19:47:20 +0200
Subject: [PATCH-stable] nvme: protect against simultaneous shutdown
 invocations
In-Reply-To: <20171006151455.18816-1-keith.busch@intel.com>
References: <20171006151455.18816-1-keith.busch@intel.com>
Message-ID: <20171010174720.GA747@kroah.com>

On Fri, Oct 06, 2017@09:14:55AM -0600, Keith Busch wrote:
> commit 77bf25ea70200cddf083f74b7f617e5f07fac8bd upstream
> 
> Back-ported to 4.4. The difference is the file location of the struct
> definition that's adding the mutex.
> 
> This fixes reported kernel panics in 4.4-stable from simultaneous
> controller resets that was never supposed to be allowed to happen.
> 
> Cc: <stable at vger.kernel.org> # 4.4
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/nvme.h | 2 ++
>  drivers/nvme/host/pci.c  | 3 +++
>  2 files changed, 5 insertions(+)

Thanks for the patch, now queued up.

greg k-h
