From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 11:42:42 -0600
Subject: Fwd: [PATCH] nvme-cli : fix offset advance in nvme-ioctl.c:
 nvme_get_properties()
In-Reply-To: <CAPrnrPDMfkXRGLG_wb13mQjDfGLKP6u+RYg0FaSWQ4nAuqy2FQ@mail.gmail.com>
References: <CAPrnrPAFO-0WDcbrkx-JdbG=JtzLVmpNPSs1wjJtUg+TUR3Yiw@mail.gmail.com>
 <CAPrnrPDMfkXRGLG_wb13mQjDfGLKP6u+RYg0FaSWQ4nAuqy2FQ@mail.gmail.com>
Message-ID: <20180627174241.GB9361@localhost.localdomain>

On Wed, Jun 27, 2018@08:34:13PM +0300, Eyal BenDavid wrote:
> In case it was missed.
> Thanks

It looks like your email client damaged your patch, turning all the tabs
to spaces. This won't apply as-is. Could you possibly resend, or send a
github pull request?
 
 
> ---------- Forwarded message ---------
> From: Eyal BenDavid <bdeyal at gmail.com>
> Date: Sun, Jun 24, 2018 at 10:37 AM
> Subject: [PATCH] nvme-cli : fix offset advance in nvme-ioctl.c:
> nvme_get_properties()
> To: linux-nvme <linux-nvme at lists.infradead.org>
> 
> 
> In the case of 64 bit property, the offset loop variable is advanced
> correctly only on error. When the call to nvme_property is successful
> (and thus err == 0) the offset variable is advanced by 4 bytes only.
> 
> Here is a small patch that fixes the offset:
> 
> diff --git i/nvme-ioctl.c w/nvme-ioctl.c
> index 63ff8fb..d52dd0a 100644
> --- i/nvme-ioctl.c
> +++ w/nvme-ioctl.c
> @@ -572,8 +572,10 @@ int nvme_get_properties(int fd, void **pbar)
>                         continue;
>                 }
>                 ret = 0;
> -               if (is64bit)
> +             if (is64bit) {
>                         *(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
> +                       off += 4;
> +               }
> 
>                 else
>                         *(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
>         }
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
