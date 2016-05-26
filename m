From: mlin@kernel.org (Ming Lin)
Date: Thu, 26 May 2016 00:16:33 -0700
Subject: [PATCH v2 0/2] move nvme_cancel_io() to common code
In-Reply-To: <1463605502-27839-1-git-send-email-mlin@kernel.org>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
Message-ID: <CAF1ivSbFUDmue3EKCdiSWReFsEugfCB61N7jfOa4zQ7d-v5hew@mail.gmail.com>

On Wed, May 18, 2016@2:05 PM, Ming Lin <mlin@kernel.org> wrote:
> From: Ming Lin <ming.l at samsung.com>
>
> So it can be used by fabrics driver also.
>
> v2:
>   - not declare "ctrl"
>   - rename nvme_cancel_io to nvme_cancel_request
>
> Ming Lin (2):
>   nvme: update and rename nvme_cancel_io to nvme_cancel_request
>   nvme: move nvme_cancel_request() to common code

Hi Keith,

Are you OK with these 2 patches?

Thanks,
Ming

>
>  drivers/nvme/host/core.c | 17 +++++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 20 ++------------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
>
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
