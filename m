Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B18ACDB482
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UeUrQlt5hsAq+06ar3lPWrVCsSYrNHp/Wj1Yuz/9t3c=; b=VcsdE1lqM2aO2J/qOGhB6Im9NF
	6XUvQuS79mEqKVbFz+nQdsR3T/8uSfHS1DmpFmi1ypKtFLLqebXMRuauZ0OMJsrYxEY2DH+XiNlJQ
	0XYKiL9rEu2jzUDmHFfl1d2QWFXTlPTbQHz5ECpzMqtSBIW259thcSThkOW4Tt0IDiwsU/WovBEMV
	21E7mqj5b5D7bP7Pa+Ds64MJYcJe5dHnwn49spZqtc6p/Hpx9BtShF0LODk/mRHz9SsM+Dle+SLAG
	lNu3mF09akYxon3gpxvigKVc6rFMi9PO4rT8fxoMM0DU1yITv7BsMujKv36h5cP8FJYNvv+ZCTBRd
	8fLrLA0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCTq-00FZEy-1F;
	Wed, 18 Oct 2023 19:45:22 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCTn-00FZEB-1b
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:45:21 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d849cc152so6430954f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697658316; x=1698263116; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeUrQlt5hsAq+06ar3lPWrVCsSYrNHp/Wj1Yuz/9t3c=;
        b=fG6eYV15AgMufqkkZc8jr83YvBcpgw5PoKDhMKgs+WffSNiYuNqBCGR90eoLXdOPGs
         fx0mo9VE9jjWQijN1uECJh1ztOu8B5teEO5bC7xZUPKS3e/8r2MxxThxm6tyEITC6Pw/
         Nzc7o5thrtePX5ULsEX+T8fv7UxdgK8Hx+lbMkeB6B05mYGyWWaDK8LORXmnR0f129sD
         P2ePyl5NOd1wADYWEGogL/A13QA+RegTAgqj/TQcKJibefheGolyKehYBDcdYJmnOILf
         tCRGH6TRicSZEy3NjuS9CqjobJRm1+vQb+vI93psFZ8CIMFZhBACaI8OkjMhVymljG3Q
         oz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658316; x=1698263116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeUrQlt5hsAq+06ar3lPWrVCsSYrNHp/Wj1Yuz/9t3c=;
        b=IcMIWqQbngPNpqFcvf9HOZAPUDr2rqpO70xoippWimymAiKg7z/jfyp1B8RnJY/dzl
         pT06Mu7yEf5ihgr6ccZrjeGk703UhRdI/qs832XB7EC3GCjPoOxZo/tDiIvGoGCcvPJI
         mVjQdoDVduKbJvi6toVxv908vvh8iflMHrISZDxA7inNlNWjJXurluZWwSwoXWcgpe58
         +c8NoqqeoyaJmoMRiFCEFWkHqo4rF6EU851oNYMIaeEjv73azbJ6NUhUt5TFRUgGSfM7
         EMoERZlAjmhjpv2AnMhtfDo2IEg1HMBuUItgYJZtxjh19o88n/pjBx7RvpT7P0NsEeig
         5iNg==
X-Gm-Message-State: AOJu0Yzr3zDW8rj67Hu78qXfXa1UuVLYV9hlgdPROGseGbru5YPFUQWU
	pq57h4nCkaTJwm5qTrGL1+Pe+FVaETmTWxpaF7w=
X-Google-Smtp-Source: AGHT+IGsHWuS6m9FnpmsSwpiWrdhbzmR95+s5VTNm5mhRwodczy54HMnqqrUtZl/I+9H9iRt7DZPWOaXsL5ZyvBi/x0=
X-Received: by 2002:a5d:62d1:0:b0:32d:8830:cda1 with SMTP id
 o17-20020a5d62d1000000b0032d8830cda1mr18679wrv.63.1697658316176; Wed, 18 Oct
 2023 12:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com> <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
In-Reply-To: <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 19 Oct 2023 01:14:49 +0530
Message-ID: <CA+1E3rJ1FNOCYQDq7oT5je85723sanD-d9L3u=Ta6kmz45q3vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_124519_537024_A27DD793 
X-CRM114-Status: GOOD (  20.20  )
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

On Thu, Oct 19, 2023 at 1:05=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Oct 18, 2023 at 12:40:35PM -0600, Jens Axboe wrote:
> > On 10/18/23 12:30 PM, Kanchan Joshi wrote:
> > > Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
> > > Patch 2: Enables fine-granular passthrough with the change that i/o
> > > commands can transfer the data only via SGL.
> > >
> > > Requirement:
> > > - Prepared against block 6.6 tree.
> > > - The patch in uring-passthrough failure handling is required to see =
the
> > >   submission failure (if any)
> > >   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@s=
amsung.com/
> >
> > I didn't have time to follow the previous discussion, but what's the
> > reasoning behind allowing it for SGL only? IIRC, we do have an inline
> > vec for a small number of vecs, so presumably this would not hit
> > alloc+free for each IO? But even so, I would imagine that SGL is slower
> > than PRP? Do we know how much?
>
> SGL for metadata is definitely slower, but it's the only nvme protocol
> way to directly specify how much memory is actually available for the
> command's transfer. PRP/MPTR vs SGL is like strcpy() vs strncpy().
>
> Similiar to Kanchan's earlier experience though, I haven't found real
> nvme devices that support the SGL mode for metadata. The scenarios this
> enables might be pretty limited. :(

What I found later was that - all the enterprise drives (of samsung)
support SGL for data/meta.
I have tested this code on one such SSD and on QEMU.

