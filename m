Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB72606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=akS3oBqI;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab6GArGB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0lw8aVK2sERLjZvx/xekZrd1qnB5Bm7xd5BSL1uMFr4=; b=akS3oBqIjqNnPLV+Qby8tDwGV5
	vHSX0TxT1hmT9CqZWVh/6SOdCB8Ul5+S3ht9XGQumTQWi9FICSDacoYIXg13JyKA3pN/2jBV9ICiC
	1pQKELIqudlhsxywPgZsPd8BiDvGFJPd1FqRNB4UIRU+STlmQWs/pszbveyRJcdY1VoeKO6YRI2h9
	oGHm4rVQ2hJrR0+QgTmvGPjGmlZhKglI6Cb+dYQsfOE4QKtf/W2iiNr5KVAG+B+Ei9RzAU7hzz+q1
	9f6uzDqjv0eMSup+N9shdJSuK+cThsmZkSDFrshk3eyuO7ITVd5yKyt45xvclkPno5Y1Hfx5Pg0pt
	8L1OACXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdxV-00000005zud-3GHI;
	Wed, 04 Nov 2026 16:35:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdxU-00000005ztj-06Ip
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:35:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74BA06022E;
	Wed,  4 Nov 2026 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD831F0093A;
	Wed,  4 Nov 2026 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810131;
	bh=0lw8aVK2sERLjZvx/xekZrd1qnB5Bm7xd5BSL1uMFr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ab6GArGBtXoM+iPiweQTI1Yzq44rA5Ne5PD4Aw2VVNt6RyhQcmQ3RRlGVq0n0IhkO
	 DtbfBLNuId0jJv6l0U+ntm6isV/DlGLYlFU7QdufxcIdWHCyeNexWsiKyh2aQgWsFQ
	 QqDayi99HSnBD2sT1XS2d1KaaQo/tc1ppuw/3hokvjVH8knshZol5ufAw/G6wzpCw1
	 4OWKuDj25kuUUDVVeR8EhZRbLNIpl+LxNdxDNP1rvO2a1Ako5dgbUCXYr22NWotGlf
	 ZyiVNijDTKD7A90laVOymP8I5xle0i9Dxdo45lxuup5vJ2WX8qmgiW6zz8PwIFjSUW
	 6ba/B0wWErjXQ==
Date: Wed, 4 Nov 2026 09:35:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hugo Deco <hugodeco@sufficit.com.br>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, andres@anarazel.de
Subject: Re: [PATCH v2] nvme-pci: add NO_FUA quirk for ADATA XPG GAMMIX S70
 BLADE
Message-ID: <aute0dBvDO1asO9Y@kbusch-mbp>
References: <CAGFVba_n+Fhrp42X4Yn5hjBd=YWP-_2FVpCsxO_mogWGrfHd3w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGFVba_n+Fhrp42X4Yn5hjBd=YWP-_2FVpCsxO_mogWGrfHd3w@mail.gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 10:12:04AM -0800, Hugo Deco wrote:
> On the ADATA XPG GAMMIX S70 BLADE (PCI 1cc1:5370, firmware 03020P5E)
> every Write with the FUA bit set takes 200, 400 or 600 ms to complete,
> always a multiple of ~200 ms, while a plain Write completes in
> 0.0-0.4 ms and a Flush in ~1.3 ms. Tracing nvme_setup_cmd and
> nvme_complete_rq shows the whole delay is between submission and
> completion, i.e. inside the device (e.g. FUA write, control 0x4000:
> 598.3 ms).
> 
> Because ext4/jbd2 issue FUA for every journal commit, fsync() on this
> drive stalls for 250-890 ms and desktop applications freeze.
> 
> Add NVME_QUIRK_NO_FUA, which stops advertising BLK_FEAT_FUA while
> keeping the volatile write cache enabled, so the block layer emulates
> FUA with a Write followed by a Flush. Durability semantics are
> unchanged. Apply it to the S70 BLADE through nvme_id_table.

Thanks, applied to nvme-7.4.

