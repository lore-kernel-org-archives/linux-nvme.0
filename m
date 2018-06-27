From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 12:08:32 -0600
Subject: Fwd: [PATCH] nvme-cli : fix offset advance in nvme-ioctl.c:
 nvme_get_properties()
In-Reply-To: <CAPrnrPCVggtMCzHdNm4wmtYUzTx2bnqYGyT2shHzq+0tRyL19w@mail.gmail.com>
References: <CAPrnrPAFO-0WDcbrkx-JdbG=JtzLVmpNPSs1wjJtUg+TUR3Yiw@mail.gmail.com>
 <CAPrnrPDMfkXRGLG_wb13mQjDfGLKP6u+RYg0FaSWQ4nAuqy2FQ@mail.gmail.com>
 <20180627174241.GB9361@localhost.localdomain>
 <CAPrnrPCVggtMCzHdNm4wmtYUzTx2bnqYGyT2shHzq+0tRyL19w@mail.gmail.com>
Message-ID: <20180627180832.GC9361@localhost.localdomain>

On Wed, Jun 27, 2018@08:57:16PM +0300, Eyal BenDavid wrote:
> Resend:
> 
> diff --git i/nvme-ioctl.c w/nvme-ioctl.c
> index f1c7ce6..2e0abf9 100644
> --- i/nvme-ioctl.c
> +++ w/nvme-ioctl.c
> @@ -578,8 +578,10 @@ int nvme_get_properties(int fd, void **pbar)
>                         continue;
>                 }
>                 ret = 0;
> -               if (is64bit)
> +               if (is64bit) {
>                         *(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
> +                       off += 4;
> +               }
>                 else
>                         *(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
>         }

The diff is still mangled and doesn't apply.
