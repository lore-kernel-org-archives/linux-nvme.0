Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFACFCD8CA8
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2026 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83FViusHAgAv8RQHShdTkXHANc0iVtVFHqQVHBHoaVc=; b=akTDiWNh/BIg0prK+AQmhV1XeM
	Xt3610F0teYE/QkCFzlK3VRXl4NAEEAJFlEBNvvQ9lDy0zn9ugHlMAf0oA5CbVkxwwRDRzCtS3+JW
	suUXIcPHVKOPFRmbtjf1g/d/ir6qJ/NSMFnhZUmCyHBkCtMBAqoOE8jrhCx5FHTMABlPVKl+xNGa+
	aIOZIc0zOEfhhE18N3o/TDHdyohUagLAcfCan/cIFDAgdRo0LcE9kxRPtu7Zg5L4O1k8+VmmajWEH
	W5Yoc2YthQW92E532V6tWfgxJsrMyaMMKU4OUXZ0I2plLsfgMVLmoPiYQmF2BGAnX5FAPjdWL3gxM
	ASRSwm2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXySE-0000000Ah42-0XGE;
	Fri, 12 Jun 2026 09:45:34 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXySB-0000000Ah2P-1igw
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jun 2026 09:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=MCI2inSJlJLyBe
	NPP6V9PSatmiA6lvsbDiT7RKNcBvo=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=W7kK/D8K6cvaQGozcHoygLNpYuoQKR4N6/Pi0
	wuzC5L9JUdYJPMgoYgqiGEyWtXrFnUgvohpj7NEcPyf0IDa4WG6YtzC7e0AybKEUg7FIse
	CZigv757i8r0kHvTjDmpkFmTil+xqyvXj0bxTgzlkdkRppjJRhzIH6/c4N/C1PCwTYb1jh
	1gw27fIJhQ2+AZgsheIuNPvKPeRpXeoEJW7wDwYO4ig6j29YregvnlDQbeZ0Q8jL7SL1nA
	+R3HTHRdEgr9GPkJnT7TiRaXdZYsXl4E+vkNIlUHGEEdVynuxCJq+iU14RCEW9sqgPfn/n
	YLnekulljZjBX+WnVHE7AE2ug==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e76f0e4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 11:45:26 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 11:45:26 +0200
Message-Id: <DJ6Z3EVG32PV.1CXC6PRBH1CIY@arkamax.eu>
Cc: "Daniel Gomez" <da.gomez@kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: unmap the data buffer when metadata mapping fails
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Joel Granados" <joel.granados@kernel.org>, "Keith Busch"
 <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig"
 <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>
X-Mailer: aerc 0.21.0
References: <20260612-jag-fixes-v1-1-24423dc8afdb@kernel.org>
In-Reply-To: <20260612-jag-fixes-v1-1-24423dc8afdb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_024532_111525_A7B40A07 
X-CRM114-Status: GOOD (  17.82  )
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

On Fri Jun 12, 2026 at 11:40 AM CEST, Joel Granados wrote:
> Commit d0d1d522316e ("blk-map: provide the bdev to bio if one exists")
> dropped the "bio =3D req->bio" assignment in nvme_map_user_request(), but
> left the local bio variable initialized to NULL and still used it in the
> out_unmap error path.  The "if (bio)" test is therefore always false, so
> a failure of blk_rq_integrity_map_user() no longer unmaps the already
> mapped data buffer.  The callers only call blk_mq_free_request(), which
> does not unmap user pages, leaking the bio and its pinned user pages.
>
> Use req->bio directly to unmap the data buffer on the error path, and
> drop the now unused local variable.
>
> Fixes: d0d1d522316e ("blk-map: provide the bdev to bio if one exists")
>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Did we forget to unmap?
> ---

Isn't this already fixed in mainline tree?

2279cd9c61a330e5 ("nvme: fix bio leak on mapping failure")

Maurizio

>  drivers/nvme/host/ioctl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 9597a87cf05dc32a7eb0373485f575502c32a105..9ae3c0aadfb8f35790c8e5761=
9d1af69ca41af0c 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -122,7 +122,6 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
>  	bool supports_metadata =3D bdev && blk_get_integrity(bdev->bd_disk);
>  	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
>  	bool has_metadata =3D meta_buffer && meta_len;
> -	struct bio *bio =3D NULL;
>  	int ret;
> =20
>  	if (!nvme_ctrl_sgl_supported(ctrl))
> @@ -154,8 +153,8 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
>  	return ret;
> =20
>  out_unmap:
> -	if (bio)
> -		blk_rq_unmap_user(bio);
> +	if (req->bio)
> +		blk_rq_unmap_user(req->bio);
>  	return ret;
>  }
> =20
>
> ---
> base-commit: adeac771f4901bb66267eaddb9fcc538925f92a4
> change-id: 20260612-jag-fixes-6b459ea16d53
>
> Best regards,


