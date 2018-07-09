From: leon@kernel.org (Leon Romanovsky)
Date: Mon, 9 Jul 2018 11:17:18 +0300
Subject: NVMe over Fabrics I/O Error with RDMA/RXE
In-Reply-To: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>
References: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>
Message-ID: <20180709081718.GA3014@mtr-leonro.mtl.com>

On Mon, Jul 09, 2018@04:06:05AM +0000, Bairen YI wrote:
> Hi all,
>

<...>

>
> Does NVMeof support over RXE or other software RDMA (like SoftiWarp) now?

NVMeof is card-agnostic, so it is supposed to work on RXE.

Thansk

>
> Best,
> Bairen Yi--
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180709/1d373a25/attachment.sig>
