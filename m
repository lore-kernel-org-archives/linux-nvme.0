Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06941606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O2LdA2Sg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHAYg8Fv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cD45RP4mu3e4rcXUaMO+K2b6dXzPom7vzbN7besMSyY=; b=O2LdA2Sg5skdHpyVHJ7haR/uKW
	IWwMa8RigLEfPZQMAdiDlvgRclOct9FtPJw2HvxgH5jqeuv8pzNqik2WTJp40yOlqY7mEoKV4Uz4G
	yeM9Y2BOdiH1BD3D3j5lQp/za8Wd1O0adzeDwFdPxVr9FJPUu4W8tTIgRiU2mOfQCm2Ov1mC07eR+
	uz3yDCwe+I/Rox+uPeIOBis8qpFGvtpYITOlMNf26xJWPLtY1XJ872S6B1p/Rz2ebkEMXU/qhet4U
	stWTVwZGhR6XmecEH4C1wv43kABGshFxnno8OA1LDwEKsJgNTN9mbdl5pAvlWmJlWzNn5ZMVtm10+
	WXymF/qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVgK-00000001cV5-189M;
	Mon, 09 Nov 2026 20:09:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVgI-00000001cUx-3wIP
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:09:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AEE88436E4;
	Mon,  9 Nov 2026 20:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694871F0089F;
	Mon,  9 Nov 2026 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254970;
	bh=cD45RP4mu3e4rcXUaMO+K2b6dXzPom7vzbN7besMSyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHAYg8FvufrbNCJi2SkmA5buNoAZ0WoJdyo2BNpHQwcWCbmNtWHObgc6F8SoU+tgs
	 32uZOSpVwpOZFMGVqWNSgMzc54WACHB05H3twruNvF6WYEILEA4RA7O3yEevCAZSGE
	 ujBho2VSUsjJC6tPbLWP9qoLBqBFEnLtj9VImO3RsDwya54O8Uk2Xeuk1ebtMqHsqA
	 Xp/OVgmDo122h95FsV5zd0JOfcPWURyxVLLSv0uBXjXuRvxelh+KVpwGEClfrN5QHs
	 Ig5rQLmXcsk4NsxVn+Mg5GSeofOtNfzDamQQyfIh/oLRGMFV0cUmGas3jgpOnZb9Cu
	 92D7E3twAvgDA==
Message-ID: <sashiko-outbox-205543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109033102.982191-26-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:09:29 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] nvmet: race in nvmet_bdev_zone_append_bio_done() on
  inline_bio cleanup [1]
--

commit bd98b59eeb25b1fa920c66a35d00856fefddae58
Author: Nilay Shroff <nilay@linux.ibm.com>

nvmet: add context annotation for nvmet_ns::bdev

This commit annotates nvmet_ns::bdev with __guarded_by(&subsys->lock), adds
__must_hold() annotations to namespace management functions, and introduces
the nvmet_ns_bdev() helper for lockless I/O and request-processing paths.

> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index cea05b4bc7409..ce53094536688 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c

[ ... ]

> @@ -591,10 +593,10 @@ void nvmet_bdev_execute_zone_append(struct nvmet_re=
q *req)
> =20
>  	if (nvmet_use_inline_bvec(req)) {
>  		bio =3D &req->z.inline_bio;
> -		bio_init(bio, req->ns->bdev, req->inline_bvec,
> +		bio_init(bio, bdev, req->inline_bvec,
>  			 ARRAY_SIZE(req->inline_bvec), opf);
>  	} else {
> -		bio =3D bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
> +		bio =3D bio_alloc(bdev, req->sg_cnt, opf, GFP_KERNEL);
>  	}
> =20
>  	bio->bi_end_io =3D nvmet_bdev_zone_append_bio_done;

[Severity: Critical]
This problem wasn't introduced by this patch, but can
nvmet_bdev_zone_append_bio_done() cause a use-after-free on req or corrupt
req->z.inline_bio [1]?

drivers/nvme/target/zns.c:nvmet_bdev_zone_append_bio_done() {
	...
	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
	nvmet_req_bio_put(req, bio);
}

nvmet_req_complete() invokes req->ops->queue_response(), allowing the
transport to immediately free req or reuse it for a new command before
nvmet_req_bio_put() runs:

CPU0                                  CPU1
nvmet_bdev_zone_append_bio_done()
  nvmet_req_complete(req, ...)
    req->ops->queue_response(req)
                                      bio_init(&req->z.inline_bio, ...)
                                      submit_bio(&req->z.inline_bio)
  nvmet_req_bio_put(req, bio)
    bio_uninit(bio)
      bio->bi_blkg =3D NULL
                                        blk_cgroup_bio_start(bio)
                                          <-- NULL pointer dereference

Saving bio->bi_status and calling nvmet_req_bio_put() before
nvmet_req_complete(), as nvmet_bio_done() does, would avoid touching req and
inline_bio after completion.

[1] https://sashiko.dev/#/bug/linux-26aa255a-7ec1-4018-9aa1-cc5794fc39c0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033102.9821=
91-25-nilay@linux.ibm.com?part=3D1

