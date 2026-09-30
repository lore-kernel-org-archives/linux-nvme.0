Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DB6CA5FB1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87BxPdY4EjMsQSSVGjREKm+G0eKNQBAfKCSFzVf2aHM=; b=AMckzadKvlSClsOK1Q3p2Dghlg
	AZBWvFBY4xIB0l1gRU0TZTLLVfah5qgaAsySXFY2tsxkXYi9TnHSyW+l0QCiG2jTNdiiVYL8BGbND
	db1ZRbZkIZsExl+3odqfL7/NA6H/BkA2jNqc3VvIhBUEyOdseU3hphGPkVTJ/GrW31hcJld+nVAhm
	pooeQmmCH+9tubu/DfwFyaoYKfFfgZi+Aey7vngGFPZcUAY1sh0h9fLC+hTAPh9EmY+P3h2aNwUJn
	bGS2LJKDMu0kRqTdjE+axWDd1nF6FRVDtHFNQKV1WlNi6uL4iNegcRegGY+qHtgsebpFGZFqOpMZO
	PhW0xlGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBpJR-00000005NUl-3a9X;
	Wed, 30 Sep 2026 08:05:13 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBpJO-00000005NSu-303g
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 08:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=L+SpVVO/kNDrGM
	KFucYg6Wz4pw+WmQwVbWWvkvWAQ/I=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=oHTt+dNxW4u9GQv3VpABGYznhzyq/Dy6DY32oCij
	Q3yA1ouGkBtiylExyCUODNNECUXgg0STcSL+snCuBhivSn6z5wdv2tgomcUoh5HCbcqqpt
	g4KzPNEXrpknownSXxgrXf0di8bPv7VjXY8Z26IR4GJfwbX6ERlgadjXdMI8GyCvkU6kPq
	9vgv2SNe9kM4U/f29hBQ9F8z81ZmIRkIoGDd6Ej/E39SQXfrWh5sbTqMATax6MuX3d9ohz
	IHWG36JFP4ytIec5165eLML/zFvOrGpXZl2olFjohK2+TqbkZREkzANVJp21U0pzBaNgV+
	DfFaSnZqvOQUcaTEcU8gLQ==
Received: from localhost (046207048051.atmpu0026.highway.a1.net [46.207.48.51])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8034cda7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 10:05:05 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 10:05:03 +0200
Message-Id: <DLSHUHHXUD8C.2P2HXJTWO2DQT@arkamax.eu>
Subject: Re: [PATCH] nvmet: use the local P2P device on metadata allocation
 failure
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Sang-Hoon Choi" <csh0052@gmail.com>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>
Cc: <linux-nvme@lists.infradead.org>, "Changyul Lee" <lcy8047@gmail.com>
X-Mailer: aerc 0.22.0
References: <179075213853.3.11747926147721077082.idr-bug-90@gmail.com>
In-Reply-To: <179075213853.3.11747926147721077082.idr-bug-90@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_010511_382698_29FD143E 
X-CRM114-Status: GOOD (  14.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed Sep 30, 2026 at 9:08 AM CEST, Sang-Hoon Choi wrote:
> nvmet_req_alloc_p2pmem_sgls() assigns req->p2p_dev only after the data
> and metadata SGL allocations succeed. If the data allocation succeeds
> but the metadata allocation fails, out_free_sg passes req->p2p_dev to
> pci_p2pmem_free_sgl() before that assignment has taken place.
>
> Pass the local p2p_dev argument instead, so cleanup uses the same PCI
> device as the successful data allocation.
>
> Fixes: bcd9a0797d73 ("nvmet: fix freeing unallocated p2pmem")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Link: https://github.com/lcy8047/radix-tree-bug-temp/blob/main/bug_list/i=
dr-ida-xarray/missing-idr-lock/IDR-BUG-90-nvmet-p2p-ns-map-lookup.md

This link gives 404 to me but anyway the patch looks ok

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>


> Assisted-by: Sang-Hoon Choi <csh0052@gmail.com>
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
> ---
> Compile-tested on x86_64 with allmodconfig and W=3D1 against mainline
> 6f8319e3e9a44dd537d17f41565a8453c560a581. No P2P hardware or metadata
> allocation failure test was performed.
>
>  drivers/nvme/target/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..9ef29b2b49de 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1317,7 +1317,7 @@ static int nvmet_req_alloc_p2pmem_sgls(struct pci_d=
ev *p2p_dev,
> =20
>  	return 0;
>  out_free_sg:
> -	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
> +	pci_p2pmem_free_sgl(p2p_dev, req->sg);
>  out_err:
>  	return -ENOMEM;
>  }


