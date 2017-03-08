From: monis@mellanox.com (Moni Shoua)
Date: Wed, 8 Mar 2017 18:33:22 +0200
Subject: Need some pointers to debug a KASAN splat in NVMe over Fabrics
 with rdma-rxe
In-Reply-To: <5b16edcf-c39a-bc4b-0e32-8ccfb5d75efb@suse.de>
References: <5b16edcf-c39a-bc4b-0e32-8ccfb5d75efb@suse.de>
Message-ID: <CAG9sBKPwEryc7U+hV=XJvRrFFhNvoktDOtwwS6piUw=cQ=bZhA@mail.gmail.com>

On Wed, Mar 8, 2017@5:35 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Hi Moni et al.,
>
> I'm getting a KASAN stack-out-of-bounds in rxe_post_send+0xdfe/0x1830
> [rdma_rxe] at addr ffff8800187072e8 with v4.11-rc1
>
> rxe_post_send+0xdfe is the following (note: the pr_err was inserted by
> me to aid debugging).
>
> (gdb) list *(rxe_post_send+0xdfe)
> 0x1dc3e is in rxe_post_send (drivers/infiniband/sw/rxe/rxe_verbs.c:765).
> 760             pr_err("%s: *_wr(ibwr): %p\n",
> 761                    __func__, (void *)(mask & WR_ATOMIC_MASK ?
> atomic_wr(ibwr)
> 762                    : rdma_wr(ibwr)));
> 763
> 764             wqe->iova               = (mask & WR_ATOMIC_MASK) ?
> 765
> atomic_wr(ibwr)->remote_addr :
> 766                                             rdma_wr(ibwr)->remote_addr;
> 767             wqe->mask               = mask;
> 768             wqe->dma.length         = length;
> 769             wqe->dma.resid          = length;
>
> Coincidentially ffff8800187072e8 = ibwr + 0x28. ibwr comes from
> nvme_rdma_post_send() and has an opcode of IB_WR_SEND (verified . So the
> rdma_wr(ibwr) call cannot return a correct/valid parent object (neither
> could the atomic_wr(ibr)).
>
> So much for the easy/mechanic part.
>
> I can special case IB_WR_SEND in rxe's init_send_wqe() but I neither
> know if it is correct nor how the wqe elements (especially wqe->iova)
> should be set up.
>
> So any help would be appreciated here.
>
> Thanks in advance,
>         Johannes
> --

Hi Johannes

Your report and analysis seem to be accurate (regarding value of wqe->iova)
Unfortunately we didn't have a chance yet to run kernel application
tests but I will try to add them soon and be able to debug it myself.
In the meantime
1. DId the test fail completely or is it just the KASAN error that
made you look at init_send_wqe()?
2. You can take a look at librxe implementation of init_send_wqe() (it
looks slightly different from kernel's implementation) and see what
happens if you change implementation accordingly.

thanks

Moni
