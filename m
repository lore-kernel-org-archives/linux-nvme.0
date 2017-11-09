From: leon@kernel.org (Leon Romanovsky)
Date: Thu, 9 Nov 2017 20:52:39 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
Message-ID: <20171109185239.GL18825@mtr-leonro.local>

On Thu, Nov 09, 2017@07:22:58PM +0200, Sagi Grimberg wrote:
>
>
> > Additionally, on many setups each
> > RDMA port only runs a single ULP. I think that's another argument to let the
> > ULP allocate CQ pool(s) instead of having one such pool per HCA.
>
> I think that most modern HCAs are exposing device-per-port and will
> probably continue to do so, But yes, mlx4 is dual-ported HCA.

I have patches in my queue for -next cycle which introduce similar
functionality for mlx5 too - one mlx5_ib device with two ports.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171109/74b937bf/attachment.sig>
