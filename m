From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 25 Apr 2017 21:06:30 +0300
Subject: kernel NULL pointer during reset_controller operation with IO on
 4.11.0-rc7
In-Reply-To: <97bb90ec-4337-62f7-f08d-a673975a5637@grimberg.me>
References: <1413097100.14743757.1492668219336.JavaMail.zimbra@redhat.com>
 <97bb90ec-4337-62f7-f08d-a673975a5637@grimberg.me>
Message-ID: <20170425180630.GU14088@mtr-leonro.local>

On Thu, Apr 20, 2017@07:21:29PM +0300, Sagi Grimberg wrote:
>
> > [1]
> > [ 5968.515237] DMAR: DRHD: handling fault status reg 2
> > [ 5968.519449] mlx5_2:dump_cqe:262:(pid 0): dump error cqe
> > [ 5968.519450] 00000000 00000000 00000000 00000000
> > [ 5968.519451] 00000000 00000000 00000000 00000000
> > [ 5968.519451] 00000000 00000000 00000000 00000000
> > [ 5968.519452] 00000000 02005104 00000316 a71710e3
>
> Max, Can you decode this for us?

I'm not Max and maybe he will shed more light on it. I didn't find such
error in our documentation.

Thanks

> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170425/8d9465e4/attachment.sig>
