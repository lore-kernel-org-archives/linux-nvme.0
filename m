From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Dec 2014 19:49:21 +0000 (UTC)
Subject: [PATCH] NVMe: Asynchronous device scan:wq
In-Reply-To: <01de01d01487$a66e95b0$f34bc110$@samsung.com>
References: <1415204395-3136-1-git-send-email-h.vinayak@samsung.com>
 <01de01d01487$a66e95b0$f34bc110$@samsung.com>
Message-ID: <alpine.LNX.2.00.1412101935070.4026@localhost.lm.intel.com>

I realize this is based on an older propsal I wrote, but looking at this
again, I think it's a bit over engineered and memory intensive for many
namespaced device, but only nets a small win. It would get through probe
faster, but a single device namespace discovery is still serialized. We
can get the same benefit with a lot less work using async_schedule
from probe.

On Wed, 10 Dec 2014, Swati wrote:
> Hi Keith,
>
> Is there any feedback on this patch?
> Are we going for the asynchronous add_disk approach, is somebody working on
> that?
>
> Regards,
> Swati
> -----Original Message-----
> From: Vinayak Holikatti [mailto:h.vinayak at samsung.com]
> Sent: Wednesday, November 05, 2014 9:50 PM
> To: linux-nvme at lists.infradead.org
> Cc: Vinayak Holikatti; Swati C
> Subject: [PATCH] NVMe: Asynchronous device scan
>
> This patch provides asynchronous device enumeration capablity.
> This patch is based on Keiths patch of Asynchronous namespace discovery
> http://lists.infradead.org/pipermail/linux-nvme/2013-September/000470.html
>
> Signed-off-by: Vinayak Holikatti <h.vinayak at samsung.com>
> Signed-off-by: Swati C <s.chawdhary at samsung.com>
> ---
