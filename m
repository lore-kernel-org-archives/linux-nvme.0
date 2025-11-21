Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E828ACFC295
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=; b=2S0PJu6CwGY5lpVoLcbQL+NUip
	2qPjYRH3Ky2vzovBYbx6TlKLP6C54Bbmts41b6+f0ZjaDPPkZqH/mqjuuSoAQkr4znhuSQqpu8fWF
	DeiKmXVOO8cLdsi/aI5V2rY5+HczHdmCgLttWXyfpqva+bOBFVPV/U9E19zBc3rUmfp4CmmQtmcqH
	SXaAKqeJSfoBHb5kQpv5QHNdz9mYSYQSQGcoHUkvKyRcl8+8uUZJUuUZfi1o/MDDefrFeHIQeRSoD
	cZ5pBDH2utR4mL8ir5+MZdwaFy8Nb8ALN83Esu4amZ8Jmyc7QtB392/vA3ZsGBaueA+m6kkqXLJxV
	LNC8yrMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMUgk-00000008mfN-3VoP;
	Fri, 21 Nov 2025 17:12:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMUgg-00000008mef-2DUU
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 17:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763745162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
	b=a/NuQklcDbES/wSrBnpqQ4Qx5GQyGhAT7FZMtZV3Qac35+KBCJYy+BQkvj5BJcHOWKyJ8A
	sByHyZEWJBvFWYEuPZyYOC1o1slbiKRMpLVBEgKmsqexY1wUuUgnXadAOmZgGxQkSKClBt
	CqV1q7dQI3vbBowSupvjs8A/IQcXZgQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227--j6EJ4zANVKiquNSp8kNKw-1; Fri, 21 Nov 2025 12:12:40 -0500
X-MC-Unique: -j6EJ4zANVKiquNSp8kNKw-1
X-Mimecast-MFC-AGG-ID: -j6EJ4zANVKiquNSp8kNKw_1763745160
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78a82709389so25094757b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745160; x=1764349960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
        b=VBPPJT6xWxHDOwGLRwM0FLo02e4XmRn71S0vrNnp5G7YPrqdTp9aKLb1hV9CLWMIiG
         YNskl7AkU0kEH8zjvhCXY/ZauGW21PWXWqBEdnd0sPfTVj0pFRXbjNg+Q5H2MxZ3dK2L
         UiRCZO5xxTXVVAJgm9IEp4sYRk8EWg0+T/I0Vtl41DJJ1ci+1+jKKJ0ONvRZjkv7ICLC
         O7I0hDylVeqWvP63lCAi7XLVgvu4MMDeArIxKn0bWBzivpBV+eYGjLZu++95BSFHoAUK
         JylW/8ZjbAOmcA1rDvjghC5//2wXARH7n5z86VM4CemhtA6SrxATiSMcix/kdXE7mAf8
         gisQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCIrrBsQ++OdfxjIwJv60fT/EV3/pc1zJl84xa8bHtxeHrm4pT2Q7mgyoVJIxSui8Dy4LFtl8RG223@lists.infradead.org
X-Gm-Message-State: AOJu0YwVqqJdFq5Uj/7c8DJSE2W++ah8wEavDPrX4c1cZhPN0vI93jVH
	ofifotB5U9uo5Wo/b77REZFVp+oU7JOu2IJq/l+9NRE1et3aUeAGxKGb7xMgb2N3jOsN5K0ulp0
	707VAyMtPqtjR1uxbwDIIZkgFMtVMoGkF8eSudW2OzumGJNlXTstC1zvnBilySbZiqWl3/MvXip
	NvWwZj4nwZuWsEY7c9rN9FboGymPyYy2e95GYz1qIWPBk=
X-Gm-Gg: ASbGncuMUZCpRmYPoAQk+sPb5sjdLNtkSO+PZNxwt63kk6qA/IqY+Yi/qZKvj4xPMAC
	tRyJftiTtyZqWQCDV97tcmOTIB19AwCYSYH31NG651KQ8QuYKhX2uKommCWtF3plBWjvDqaP+Qy
	1L/kUiD+RJbMR+eGiekB4FCVg/y6GHZiUMKN+h5MBfFtCWLJlyL5QPpUuYPQ1w1T2X
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id 00721157ae682-78a8b5681a0mr24167007b3.62.1763745160074;
        Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJMtLvkeHiv5tBcVk8Zunn6fcLBfbMFj2OlEQ7sDWssH1e01yWoO2IMY4KicgI4AI0qMGjQLfshccde2mHq/o=
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id
 00721157ae682-78a8b5681a0mr24166847b3.62.1763745159764; Fri, 21 Nov 2025
 09:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <20251121081748.1443507-3-zhangshida@kylinos.cn>
In-Reply-To: <20251121081748.1443507-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 18:12:28 +0100
X-Gm-Features: AWmQ_bnhlFe4bz2evbPrSI0Jb0EHnrWDpAVAemzJqi8jgCPnPPGI5CuseKDcbLY
Message-ID: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ZwKywnd4rfbGklclylfW-Tl_q73sFzvEr5Mm8-Em_g_1763745160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_091246_663055_A8A878F3 
X-CRM114-Status: GOOD (  14.74  )
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

On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..a6912aa8d69 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, st=
ruct bio *new)
>         }
>         return new;
>  }
> +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
>
>  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
>                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> --
> 2.34.1

Can this and the following patches please go in a separate patch
queue? It's got nothing to do with the bug.

Thanks,
Andreas


