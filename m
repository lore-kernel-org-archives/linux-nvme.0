Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7A606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VIkIMLCo;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcjT46M2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uCdDRmBQIkSJQok090TA/cSiDkBImgNSr1zRq+PLUu4=; b=VIkIMLCobBDvMXgHUrM6Uys4sf
	rEmlXrco7nO+bGbrhHq0PKXw38vQn6/QhDQODNzUSIr4z496qwllL5ujAGUQZBf87pcphxP2f0yJR
	fsdZlHC1qdDffn6NcE7v1v57amMTZkjnmSmpqwu/ALZJyGO+hkftYXirRfWpZiQIW1T7SMBSaWtzm
	SxBvpeGh3zZ6OEvRfZ5gIpuwJC82vSnNAmaJCgQM8TFfohxeUjXT/qnWbU88TVct1xRkR7JNJXZdf
	9AEvdRq18U2Eqnix0c6STw0IwcHknoh4jbCArU7jbMfm7zp1kLZvKNCs/wukowqGKfuLwhU7Bgo7+
	4fJ7VUqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaQm-000000083xh-1Qbs;
	Wed, 18 Nov 2026 07:50:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaQi-000000083xY-2IGy
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:50:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 027FE43BFD;
	Wed, 18 Nov 2026 07:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16051F000C4;
	Wed, 18 Nov 2026 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988207;
	bh=uCdDRmBQIkSJQok090TA/cSiDkBImgNSr1zRq+PLUu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcjT46M2Eb6KTuaPOtaNkP25RV1NwcL02BQ8ieXYjCjRS+HbK9LUX3tbwazJUtT7e
	 PFX0iCretHR4JTkM3ysuLJrXh8hwv3hrkko5vPC9S9L/z93MTiYPXXt0VJb9hf9MTa
	 en4dTf8NdlmmfEXDH4WpTp+QU2eK7y8PZA0pdLdBvHIDkV0H7Rm14O3qJF9sgTO9fw
	 x5osgw15lnLGFe5lAWI7UC+I74Qi6b7tY+5dO6K5jmLONT2nGJEGuVz8vcN1Bk4g3m
	 XYA+rFxn73EPMvhbHoexR2hKPMiPTYpj3R5eDa1JzQ2Rk9QrrA5jrHh0usUoOmeAo+
	 MErMBpzdqWcTw==
Message-ID: <sashiko-outbox-220364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/22] nvmet: add context annotation for
 nvmet_ns::size
To: "Nilay Shroff" <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261118073505.288910-8-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-8-nilay@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:50:07 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvmet: double READ_ONCE() in nvmet_file_check_lba_range() can
  underflow
--

commit d3bcca86a53dabf9c0c2d63509a67010aa5e3ea3
Author: Nilay Shroff <nilay@linux.ibm.com>

nvmet: add context annotation for nvmet_ns::size

This commit annotates nvmet_ns::size with __guarded_by(&subsys->lock),
introduces nvmet_ns_size() using data_race(READ_ONCE()) for lockless reads,
and pairs those reads with WRITE_ONCE() on updates.

> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index e1e02f5f5efb1..c87de131037d4 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
[ ... ]
> @@ -123,7 +123,8 @@ static bool nvmet_file_check_lba_range(struct nvmet_r=
eq *req, u64 slba,
>  	u64 pos64;
> =20
>  	if (check_shl_overflow(slba, nvmet_ns_blksize_shift(req->ns), &pos64) ||
> -	    pos64 > req->ns->size || len > req->ns->size - pos64)
> +	    pos64 > nvmet_ns_size(req->ns) ||
> +	    len > nvmet_ns_size(req->ns) - pos64)
>  		return false;
> =20
>  	*pos =3D pos64;

[Severity: Medium]
Can calling nvmet_ns_size(req->ns) twice here underflow nvmet_ns_size(req->=
ns)
- pos64 and bypass the bounds check?

Because nvmet_ns_size() uses READ_ONCE(), the two calls perform two separate
loads of req->ns->size.  If a concurrent nvmet_file_ns_revalidate() shrinks
req->ns->size below pos64 between the two loads, the first check passes aga=
inst
the old size while the unsigned 64-bit subtraction in the second check wraps
around near U64_MAX:

CPU0                                  CPU1
nvmet_file_check_lba_range()
  pos64 > nvmet_ns_size(req->ns)
    /* size1 >=3D pos64: false */
                                      nvmet_file_ns_revalidate()
                                        WRITE_ONCE(ns->size, size2)
                                        /* size2 < pos64 */
  len > nvmet_ns_size(req->ns) - pos64
    /* (u64)size2 - pos64 underflows */

An out-of-range write request then passes nvmet_file_check_lba_range() and =
can
extend the backing file past the namespace capacity instead of failing with
NVME_SC_CAP_EXCEEDED.  Reading nvmet_ns_size(req->ns) once into a local
variable and using it for both comparisons avoids this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118073505.2889=
10-1-nilay@linux.ibm.com?part=3D7

