Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE5C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2sovYnnLqu3ePNoGdykaYCzoGX/KrvirZkk+6UfwMw=; b=KXlWMD+RP9tnzmGIWyibLlVoIe
	pi3k/UxH5kgEmADmWm7NWGOT/7J4on/KGmSPl5cSgHxQfHfH3IfmayDrPgIkwElhdWfYOQ8Qx4nb1
	x9vIV7oAyvyXyhBNbE6CspuBN2Ls8smiMCXeUIvKrYqtB4jTSKrYsaBKN4CmWiAGyspICN6bldlfk
	vx+toeKpJ0G6sYA6h93+FuBSZjZ3s5wLxPueGPudM8vL87UHhQilTQUhcNLvZqEuQiLgZxHJk/GCX
	ysPE4kZzShHPnMi7aerl1S9YXZ+iCDC/hoEZEnyW4Ej3XsgqI0EbPopwHHMsshUep2G6OaFrVP+ZL
	BdgOLY9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEwtQ-00000007OyT-1O7H;
	Wed, 05 Jun 2024 20:05:56 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEwtM-00000007OwP-3phI
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 20:05:54 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-250bbae0ff6so89850fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617947; x=1718222747; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2sovYnnLqu3ePNoGdykaYCzoGX/KrvirZkk+6UfwMw=;
        b=E/YF5Cc09q8iUyUs8/CQcezcb30jLO4aka74p/By8dre0WN2iAToXLRsu3RYz2oZT7
         IaP9s+LbHdPmYZgUwXT00+wur64Oa1HTBBtxXHrb/82H02SnodIkxHEibnxPSxCEnfaA
         RJTHBJlPA3K7upbQspJ6408rUyfC3aX+o45/YnN55Krya/aIb2/qL9I3L9TOI8r0yFZe
         mLEh3b09AIR8Gwm8rS343t1DM0hQUvtlogpT8cfA0Ma+u+m34Dh2yBFKPajnYYOrpiev
         MVRAvzp+vS2TYRgodWg7qz4E7NYeuwxMPI4I1wVGSE6KBavCI+LCp4PTIgLqqIoK1WFE
         zP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617947; x=1718222747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2sovYnnLqu3ePNoGdykaYCzoGX/KrvirZkk+6UfwMw=;
        b=ANbC7MQDpq5W5ncpcooTK4BQQIawHyKYcX8+pMBY5Mv5avthQ+T1kXSbjHnxYUg0RS
         lTSEkS9a6Lh10CN9XOXcM8cr+PpzWfN3v9qV3WW1pWxVWEhviZdMfEGSPyP5ouVwC1jJ
         m19YoMTQgzeK/p/l1GXt2urKAFs31OkLOai082BBdQTIU76vxAti2O2qsZXvCftCWoZq
         2I+ww1Bi/N0bITnOu6w02m27zIs/LRIs3LG6fKQZ9ekkIucKwBF5HLSp6JXxXAeff9V2
         Vwkw1NcSgd25MwC9sNGIUUPsfOzjgzRjct3bL+niW6QhWKDXlzO2G28GyhaXzfKl13h/
         e6/w==
X-Forwarded-Encrypted: i=1; AJvYcCVK0ghPF1wqCWf/jnTyNJz2yv7ofvPlraVkb4/ZoPVWVfCWsoNtutTufKF8zsRGzBLJ9053+w2W+464TZxB5Bv1btif6nvO6q5qtlhXAG8=
X-Gm-Message-State: AOJu0YxRGCuHrVGjBeuUKROkV+ZvJzxHVNi88x3EL4XdnKqgZ5P1P5Io
	e4z6vKkSrnsCwyW7/dhGnLxf9a2eXUR/XixGUkTuNGLj5p28HLSC3c/4VgtYAREm/+efKHBzOk0
	P5grRSvhrhx0vFKUGyqWo9kRWZ2c=
X-Google-Smtp-Source: AGHT+IGyVhO7rSQAoGDSB+vjloBrx705BG5D6fs1Cr4EcslfrxplrQUigFncTawwbH2U8MnF7SOq8ImGhCk8Gp1b7A4=
X-Received: by 2002:a05:6871:738f:b0:24c:4f83:48da with SMTP id
 586e51a60fabf-254407aeaf0mr366594fac.16.1717617947176; Wed, 05 Jun 2024
 13:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-5-hch@lst.de>
In-Reply-To: <20240605063031.3286655-5-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 5 Jun 2024 20:05:20 +0530
Message-ID: <CA+1E3rJn3uNfkoFtm_am9qwQmwWvhu3nPVMaM63AJ2GBdxZTmQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_130552_976635_9CF5D2BC 
X-CRM114-Status: GOOD (  12.20  )
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

On Wed, Jun 5, 2024 at 12:01=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> @@ -446,13 +446,14 @@ bool bio_integrity_prep(struct bio *bio)
>         if (bio_integrity(bio))
>                 return true;
>
> +       if (!bi->csum_type)
> +               return true;

Changes look mostly good, but trigger a behavior change for non-PI
metadata format.

Earlier nop profile was registered for that case. And the block-layer
continued to attach an appropriately sized meta buffer to incoming IO, even
though it did not generate/verify. Hence, IOs don't fail.

Now also we show that the nop profile is set, but the above
"csum_type" check ensures that
meta buffer is not attached and REQ_INTEGRITY is not set in the bio.
NVMe will start failing IOs with BLK_STS_NOTSUPP now [*].

[*]
     if (!blk_integrity_rq(req)) {
             if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
                     return BLK_STS_NOTSUPP;
             control |=3D NVME_RW_PRINFO_PRACT;
     }

