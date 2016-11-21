From: saar@annapurnalabs.com (Saar Gross)
Date: Mon, 21 Nov 2016 10:54:40 +0200
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
Message-ID: <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>

Hi everyone,

Any comments on this patch? I didn't receive any so far.


On Sun, Oct 23, 2016@10:30 PM, Saar Gross <saar@annapurnalabs.com> wrote:
> Use __iowrite64_copy() instead of memcpy_toio() when copying SQ entries
> to a SQ that's contained in the CMB.
> __iowrite64_copy() writes to the MMIO in 64-bit units, whenever
> possible.
>
> Signed-off-by: Saar Gross <saar at annapurnalabs.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0248d0e..0e603f0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -289,7 +289,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>         u16 tail = nvmeq->sq_tail;
>
>         if (nvmeq->sq_cmds_io)
> -               memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
> +               __iowrite64_copy(&nvmeq->sq_cmds_io[tail], cmd,
> sizeof(*cmd) / 8);
>         else
>                 memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>
> --
> 2.7.4
