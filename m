Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D690EC5B572
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDK4adcck1ZzmzEsUqspD56GIS3ZPrdpk7ZzuSIamjA=; b=HGLPCvU0HGRP11ewH13UcR/Y86
	zb7T+BFLrPEf+wPPMVteMzd4BAShEAJqDjDMSd+Tou2R3Qb5B/ns6p9q94Tur/+ZQC67JQzFDjco3
	0Skn9hM6YbVp7n9vQFaCBGNSlUsqWegmxHfl1CsmDYasfqGDvNK9DCkaBmg1sodpdSS+O500xOpJy
	SC4MSFdW/rRBtcLp9DSU7CqWqS52geXHx9OH40TUd0ViTU6dQvLqYWsmZLxqkx3bw2yMTzgIId5EG
	nw/4IN//onXCVYXvDMTkFn3Y1ONkx9rWAYN46hf0FZe2OQMuD3fWUSxam9fu756zwHIW0btWgfJs+
	UGT1horg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoJE-0000000EJ6V-2e4f;
	Tue, 11 Aug 2026 15:22:32 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoJB-0000000EJ65-2FQp
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 15:22:31 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6a205b0df35so1887059a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 08:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461748; cv=none;
        d=google.com; s=arc-20260327;
        b=Sxr2ppS0Jb8l0KukGcGDUqayD5ZrG74Js7bdAG0OGHgA3VJQgPZ1Ys/v+RXusX1CxM
         YcBGfdEyZ8Ng/xGr+ROiePGvkf7oWnPtY02X7Ei0e1F9rTNOe2VV3Y30YfJ7ahZyPcKU
         MelYuryQY22fTUVVWq3iNMEGgQD1896Qzv8pdV43swqWaghmz8xEQNuWF7PYSAQuY39l
         a6tbxf1jJc5Q0MZAW+Qmt3CU1Cdl2RAhgBTCoKeIAC78ZBmjYdy5N9iDQq4PwLz3cM0u
         OCwHPvHodwZy92U5rtpSA9In0jvw+AOutv/EIduRcF8lHkG5Ujyyv1tyD5cHCjRervbM
         EOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDK4adcck1ZzmzEsUqspD56GIS3ZPrdpk7ZzuSIamjA=;
        fh=6a95mKy1DtaxL61dGCDQcUUy5+2gtEOFQIkU2h6xRVc=;
        b=FgEp5svdYVxCYmdwreYjpv8erYXviYOOirnzgcmtcn67oO12KYVMsLoc6cSDjMMkO9
         j9K40G0PWM1yyBrFQMyC7KsxR5/90s/NgH6POVCD4SxQpEAveNWzk/TkJtdCNmPxSpbi
         0ocFtgsi5KYpolW/PKDChx1hHmSmeIScjqjBG17apTe+0eN2Qoy7+1e7MGxBy0zKvFNd
         olycoWfsMWaPk8Qu39i11RGe8UFQ0MLEG/7Voz7HiTkzZGx1OwGU3APSPq5qfX445mvK
         mYyAUl4t1B+oAwVOMmIVT5BuRmYE64EsWBBHX3LE7NWiEpmCyvmNxkCghPFj+rYshIcq
         53Sg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786461748; x=1787066548; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDK4adcck1ZzmzEsUqspD56GIS3ZPrdpk7ZzuSIamjA=;
        b=dp+9hRjfBOAKLlZgUMC88QLuq7SDNgN9UHQu6juACilaY2xOQ645AZQPoBpey1K94i
         Wre5sXPRtidkI376ZGOmpBu66Zz8Bzd4UDt3Tp7SBawxe8H2EOa5YSqHCkvQWpSaNqpT
         82zmL0CScisPqJYPu3DPOh/opWWaqZ8Pi/FtmHoJT6ewWFDoI7gIXJlo60/kFdfv0OLF
         9hs9bJQGx++M+vUt/0fSCl4W8ij3et8xX4KLw4yEj27mTG2bhOMZxATY2HwkdCKtSzcR
         dkiAUjMZ/v4QS8CLu7WiDMr2lmdKAhF+E0h8kWFje8sGZ8p6hiVzbgaTmaz45UD37DBe
         P/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461748; x=1787066548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDK4adcck1ZzmzEsUqspD56GIS3ZPrdpk7ZzuSIamjA=;
        b=HhAc6PkoeSROuPBxHlRyDMX4EM+jUr4nidQKHjp2nZ4cT4IXBntvdxTps7H2v96GQc
         JUFxA7lkEg6D9Jj2KLmREGx+qurR3kwkMlY2uGsg2tCP2QgJnfC2EWo++jOI5PyED8vf
         ZIH2CrUlMV8EUrlbemtDfmPtmWrOaNBS8kgudJgPqOzh/LX1LV5Q8gFlTeZKPGPR28k6
         6QVpNS4ul3yaF6vxKIjI7qgNfXC6/F4k9Y83QBxnrb+61PO1wZ3I8BxUwf3VUCveFj56
         fclkhunIx5J1+9DQHvxkCqLThCb34vykrZ9vbC7pLrEgGshMn4CKjc1FKid1LPpdzXHh
         IHGQ==
X-Gm-Message-State: AOJu0YzwCn2A0t9OjjhsgHya4jAv9iBrJHLRlbP3CM//10XERB+yY8+B
	j9Oee04+R8fJHa9XlVwQ6ss890WB7XeiYcSwthBxjM6H6IsW+xMcAQ5idFvNmamBmbzhd3+GKBu
	+gR7qX5ISI/1am7+jdkZCUDbS7u2zFDQ=
X-Gm-Gg: AR+sD1348P4iWReTXhWinfrazk/RaaPPnCgo43Fcyqss2h3dj/yw4e9zsdyZHMn+i9/
	lW5O12QI51+oeI3Pnf7w+IUEMuuZ6Y3EtyXd8yAJknf0RY6UgAioFuroPf9xr/aveYtjJaLpS1j
	iSP7ZtEovFUofqW4U35WdZAZbAMTrpKk8vmOhKI/oJoxJ+AC/JYoooLx0JUMJDlhS4aAJsVfGPP
	vZxktUtpDcMJ2m4D3MSho1FEQU/XZs5b2qTX8d1utVzux/LjdaPl0wq6YyoBm9sMYiyfymvAFIe
	SE6GdvCHzw8CQNEDOrxaWbo9WL0VmsUfaCrarIzyrw+J
X-Received: by 2002:a05:6402:11cd:b0:68d:92cf:52f4 with SMTP id
 4fb4d7f45d1cf-6a36bb58447mr656341a12.5.1786461747395; Tue, 11 Aug 2026
 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260715155752.3363247-1-coshi036@gmail.com> <anpbIKTNY3SeZxSq@kbusch-mbp>
In-Reply-To: <anpbIKTNY3SeZxSq@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Tue, 11 Aug 2026 11:22:14 -0400
X-Gm-Features: AUfX_mwJCxK5XCvZxprqVIekTs7guPIeOmAY9U83KUVgrH_dohNRYDJNmC3nJu8
Message-ID: <CACd_6n0KK=KnTdbnWtaanpcdpP-DOs=r0n=UScZM6WQP4K2Kig@mail.gmail.com>
Subject: Re: [PATCH v6] nvme: reject passthrough of driver-managed Set Features
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_082229_615216_327EF3B6 
X-CRM114-Status: GOOD (  12.07  )
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

Thank you so much!

Best,
Chao

On Mon, Aug 10, 2026 at 7:13=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Jul 15, 2026 at 11:57:52AM -0400, Chao Shi wrote:
> > Since commit b58da2d270db ("nvme: update keep alive interval when kato
> > is modified"), a Set Features (KATO) passthrough command lets userspace
> > start keep-alive on any transport. nvme_keep_alive_work() allocates wit=
h
> > BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set() reserves admin tags
> > only for fabrics, so on other transports the allocation trips
> > WARN_ON_ONCE() in blk_mq_get_tag() and fails:
>
> Thanks, applied to nvme-7.3.

