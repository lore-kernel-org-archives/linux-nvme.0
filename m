Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD3606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YXVDbMYn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hkZ4pXmc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8Ko9iVPV9Hd/8nJ9dEhgIFeMVshg4jHuRwXXoeQEYQo=; b=YXVDbMYn3DVpc5VjkS5vuYK/kr
	d0cEWpy8UrCcj3fndeJi1zF6cShNo2MwQ85N4MMGWZs68TvwuwSc9zOw3WZMGF7OIq1+O08+PlixH
	YjBtRIgt6LcFrwv9dkMPfjHi5yczAu/LV+FB8kETYEOqDckmWos2SVDqhdf0KJvcBWX7eilqlRBBC
	koqxMIxlUB4NUnghgwLuT9uO3Rs1WunbfW00iysK+BgCqb8fEY60zfN9Br4OIhxjlqo5M97/3oSe4
	ptGrR2G+6kMAnSCtzwl6yTJFqpZlodUzo5pmoBK/G8ut9PRiDnSJT5bscoOZNCBJZiwidNIh8XGcp
	EtC6gM/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVrQ-00000001dcZ-1kOV;
	Mon, 09 Nov 2026 20:21:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQVrM-00000001dbs-3vvq
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 20:20:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FD5C43F4D;
	Mon,  9 Nov 2026 20:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D8B1F008A5;
	Mon,  9 Nov 2026 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255656;
	bh=8Ko9iVPV9Hd/8nJ9dEhgIFeMVshg4jHuRwXXoeQEYQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkZ4pXmcjIPnBJcOyFt+0076eVY4MyzF6fqs5tCdio0aPaHpkjoG58nYmsihCuRRz
	 tHpXe32GWydta5/Ot/RqMHTDQRmaWe+rWkEpe1meoBVz2qzkExmhtROICfuwGN2ZLa
	 07kOQAkTEuKJz3NROBivr6fG0pTfzzB8YrqlcUxsLmuVmhyrX44HFnJLdOlAdezxGF
	 Ce4TSb1XOIgJPJ9EmJ0oonXrCDbpEqABIafYV41GoDLKojkG2/8nBz5VLS8x3Syb7v
	 EyomCPuxMXQFm96UB4K3WQESgUAbMrh3r21GCzKV1/CTlqDnaGAdqnN3TYSV34BP5K
	 TI2ckz4o5coUQ==
Message-ID: <sashiko-outbox-205572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/23] nvmet: add context annotation for nvmet_ns::file
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261109033102.982191-28-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-28-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:20:55 +0000
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
- [Critical] nvmet: slba shift overflow in nvmet_file_execute_discard()
  [1]
--

commit 0b0e76ffccc07fe576097865269793cd78b566d9
Author: Nilay Shroff <nilay@linux.ibm.com>

nvmet: add context annotation for nvmet_ns::file

This commit annotates nvmet_ns::file with __guarded_by(&subsys->lock),
introduces the nvmet_ns_file() helper for lockless I/O hotpath accesses,
and adds __must_hold(&ns->subsys->lock) annotations to the file-backed
namespace helpers.

> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index 695963dd932ee..4307232c9160c 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c

[ ... ]

> @@ -293,7 +306,7 @@ static void nvmet_file_execute_discard(struct nvmet_r=
eq *req)
>  			break;
>  		}
> =20
> -		ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
> +		ret =3D vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
>  		if (ret && ret !=3D -EOPNOTSUPP) {
>  			req->error_slba =3D le64_to_cpu(range.slba);
>  			status =3D errno_to_nvme_status(req, ret);
> @@ -347,7 +360,7 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>  		return;
>  	}
> =20
> -	ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
> +	ret =3D vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
>  	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can shifting slba by
req->ns->blksize_shift in nvmet_file_execute_discard() and
nvmet_file_write_zeroes_work() overflow offset [1]?

drivers/nvme/target/io-cmd-file.c:nvmet_file_execute_discard() {
	...
		offset =3D le64_to_cpu(range.slba) << req->ns->blksize_shift;
		len =3D le32_to_cpu(range.nlb);
		len <<=3D req->ns->blksize_shift;
		if (offset + len > req->ns->size) {
	...
}

drivers/nvme/target/io-cmd-file.c:nvmet_file_write_zeroes_work() {
	...
	offset =3D le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
	len =3D (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
			req->ns->blksize_shift);

	if (unlikely(offset + len > req->ns->size)) {
	...
}

When a Discard or Write Zeroes command carries non-zero bits in the upper
blksize_shift bits of slba, the left shift discards those bits or wraps
the signed loff_t offset (or offset + len).  If the truncated result falls
within [0, req->ns->size - len], the bounds check is bypassed and
vfs_fallocate() punches holes or zeroes data at an unintended offset in
the backing file instead of failing with NVME_SC_CAP_EXCEEDED.  If offset
wraps to a negative value, vfs_fallocate() fails with -EINVAL and the
request completes with NVME_SC_INTERNAL rather than NVME_SC_CAP_EXCEEDED.

[1] https://sashiko.dev/#/bug/linux-db20adf5-cf8b-4a83-bea6-a689b8eaa9de

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109033102.9821=
91-25-nilay@linux.ibm.com?part=3D3

