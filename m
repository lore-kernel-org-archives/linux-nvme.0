Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61143606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qHfOUAHJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtqXe8qJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YVyO34/+vwkp8pkrCOkfsJrmVw+ShcRwN5uH3EK9AOQ=; b=qHfOUAHJt98OqbCzwOdGq5PymS
	UZNHwSnQY0rivoOv0Pl6kvaT7dyWvzqSaV1CvIzedKpncAoTBgWa0QNfTOWSPLDLepwE8Ddw9nT/P
	1eNhuWJNGG7/hCkVA3mG90Hk/5MD/oTZx2B76qTym7AokQYiWXrRO3nlK68sVTfCtASYyNwol6vUx
	Fqa6Xa4iEhP1eh9Bvrpxnkn995OP1jChIqocMrSNYJ0noFKsMYhFhqAkpVtuv+aTY4Sjd/2fikxEk
	ItVnUT65EbArlc11vqQSV0SCF/+eEixuyYWl3r1jblC0cJDb72aFN8yZ8L4Dk9RW29KWQ0zs1UFvy
	lPoXoGvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoYX-0000000CNFX-0cXu;
	Fri, 13 Nov 2026 10:30:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoYV-0000000CNFH-3Q0a
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:30:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 113D36258B;
	Fri, 13 Nov 2026 10:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B041F000C4;
	Fri, 13 Nov 2026 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565850;
	bh=YVyO34/+vwkp8pkrCOkfsJrmVw+ShcRwN5uH3EK9AOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LtqXe8qJjoCs6EgAPAbRpq91b52a2VyeQM1Gmbh1aszCIQsHw90zu2II0XhvZBVPf
	 MYe4sCeWsUIT4Qk1u+8y141B9pvooL1UVPFd4jVeuj583/dWSS0d8wIZXTRqeo8Cmr
	 jX0clMTXPzsOgqjpxbfc1oq46h+KocQFM3MQ934rxvl7SR7DdRoDmc6Oxb3/xmKe2C
	 wl8K8UDU/hOCVkeESaZt2xwyECXACM3PlylmDK3o568qfqNsFmFKM3uzFK4Va3DPl2
	 ljQeGJWVYW2W0/PMV9BcmlO9j3pNwLvEEUbnzib0+EcpdDyUPufXUZKKoMr92Uz2ED
	 0eedJIL8aZeJQ==
Date: Fri, 13 Nov 2026 11:30:34 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Arthur Simchaev <arthur.simchaev@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, Pankaj Raghav <pankaj.raghav@linux.dev>, GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>, Avi.Shchislowski@sandisk.com, Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 1/2] block: add BLK_FEAT_ATOMIC_WRITE_MULTI
Message-ID: <20261113103711.1-da.gomez@kernel.org>
In-Reply-To: <20261103093849.203851-1-arthur.simchaev@sandisk.com>
References: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com> <20261103093849.203851-1-arthur.simchaev@sandisk.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-11-03T11:38:49+02:00, Arthur Simchaev <arthur.simchaev@sandisk.com> wrote:
> On Tue, Sep 29, 2026 at 01:17:11PM +0200, Daniel Gomez wrote:
> [...]
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index d003a9d2d1f6c..92efd4ff67f26 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_features_t;
> >  #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
> >  	((__force blk_features_t)(1u << 15))
> >  
> > +/* device writes each atomic write boundary window of a command atomically */
> > +#define BLK_FEAT_ATOMIC_WRITE_MULTI	((__force blk_features_t)(1u << 16))
>
> With this flag set, a request with REQ_ATOMIC may now carry several independent
> atomic writes rather than one. Code that looks at REQ_ATOMIC on a request (e.g.
> blk_insert_cloned_request(), or a future SCSI WRITE ATOMIC user) needs to know
> that. Could the comment here (or Documentation/block/) spell out what REQ_ATOMIC
> means on a merged request, and what a driver must guarantee before setting the
> flag?

Makes sense. I'll update accordingly on both places.

>
> It might also be useful to expose the feature in sysfs next to the other
> atomic_write_* attributes, so users can tell whether merging across boundaries
> is active on a device.

TBH, I was initially hesitant with the idea of adding another attribute.
I'll add it and if we find it not useful we can drop it during review
time.



