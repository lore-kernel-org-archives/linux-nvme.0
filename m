From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 20 Jun 2017 11:33:09 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
References: <9465cd0c-83db-b058-7615-5626ef60dbb0@grimberg.me>
 <20170515143632.GH3616@mtr-leonro.local>
 <20170515145952.GA7871@infradead.org>
 <20170515170506.GK3616@mtr-leonro.local>
 <779753075.36035391.1495025796237.JavaMail.zimbra@kalray.eu>
 <20170518133439.GD3616@mtr-leonro.local>
 <CAANLjFrCLpX3nb3q7LpFPpLJKciU+1Hvmt_hxyTovQJM2-zQmg@mail.gmail.com>
 <6073e553-e8c2-6d14-ba5d-c2bd5aff15eb@grimberg.me>
 <20170620074639.GP17846@mtr-leonro.local>
 <1c706958-992e-b104-6bae-4a6616c0a9f9@grimberg.me>
Message-ID: <20170620083309.GQ17846@mtr-leonro.local>

On Tue, Jun 20, 2017@10:58:47AM +0300, Sagi Grimberg wrote:
>
> > > Hi Robert,
> > >
> > > > I ran into this with 4.9.32 when I rebooted the target. I tested
> > > > 4.12-rc6 and this particular error seems to have been resolved, but I
> > > > now get a new one on the initiator. This one doesn't seem as
> > > > impactful.
> > > >
> > > > [Mon Jun 19 11:17:20 2017] mlx5_0:dump_cqe:275:(pid 0): dump error cqe
> > > > [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> > > > [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> > > > [Mon Jun 19 11:17:20 2017] 00000000 00000000 00000000 00000000
> > > > [Mon Jun 19 11:17:20 2017] 00000000 93005204 0a0001bd 45c8e0d2
> > >
> > > Max, Leon,
> > >
> > > Care to parse this syndrome for us? ;)
> >
> > Here the parsed output, it says that it was access to mkey which is
> > free.
> >
> > ======== cqe_with_error ========
> > wqe_id                           : 0x0
> > srqn_usr_index                   : 0x0
> > byte_cnt                         : 0x0
> > hw_error_syndrome                : 0x93
> > hw_syndrome_type                 : 0x0
> > vendor_error_syndrome            : 0x52
>
> Can you share the check that correlates to the vendor+hw syndrome?

mkey.free == 1

>
> > syndrome                         : LOCAL_PROTECTION_ERROR (0x4)
> > s_wqe_opcode                     : SEND (0xa)
>
> That's interesting, the opcode is a send operation. I'm assuming
> that this is immediate-data write? Robert, did this happen when
> you issued >4k writes to the target?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170620/cf9d02f2/attachment.sig>
