From: keith.busch@gmail.com (Keith Busch)
Date: Fri, 7 Jun 2019 07:56:21 -0600
Subject: [PATCH 0/2] NVMe 1.4 Identify Namespace Support
In-Reply-To: <20190606212854.122478-1-bvanassche@acm.org>
References: <20190606212854.122478-1-bvanassche@acm.org>
Message-ID: <CAOSXXT5vsi4Fp20dj9TrouwNAYfOAMxAsbFZADZQ9pZE8uo3VA@mail.gmail.com>

On Thu, Jun 6, 2019@3:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
> Hi Keith,
>
> These two patches are what I came up with after having read the Identify
> Namespace sections in final draft of version 1.4 of the NVMe. These patches
> compile correctly but have not been tested in any other way. Please consider
> these patches for kernel version 5.3.
>
> Thanks,
>
> Bart.
>
> Bart Van Assche (2):
>   nvme: Introduce NVMe 1.4 Identify Namespace fields in struct
>     nvme_id_ns
>   nvme: Set physical block size and optimal I/O size according to NVMe
>     1.4
>
>  drivers/nvme/host/core.c | 14 ++++++++++++--
>  include/linux/nvme.h     | 12 +++++++++---
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> --

Series looks good. There doesn't seem to be much in-kernel use for
these preferred access attributes unfortunately, but this is a good
start.

Reviewed-by: Keith Busch <kbusch at kernel.org>
