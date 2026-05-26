Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B13CD6E44
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 06:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbEyVDKYB6brZVOZVveRW94ChbWHXbhuaSGALUdMmOo=; b=kgB0q+/FUNtG+/SdsP7r8Wl5QF
	wuRwShXanCkwpeaO27xT3tAPOpD4UmDZY70UzYIZOrwCKWXCxM+eQVpg9tlaQevGr7jOfkl7pkXBk
	8cdqv8+D61MctQbSz3bksSeiqYnsg1AvWITfduCeGc/cNBthsBqeZVfqdXjvB9P8n5ldXebPDOf0n
	ZNsVIGcFr6O1bSvIoQgacSgUS7R3QWKNIOED75e1MwH3OYuaAJPSuA1yLTqJlYyCCq3woQFO4yUqo
	UdC1XL37G1Zs16wfNwLbwz1UoN4KNXuo6wfhpEY0HaBolrguK5S4K9czWWcgyqEGPn1Pt0OdEGry8
	2HoKLMcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7gD-00000003OYM-06Oo;
	Wed, 27 May 2026 06:23:49 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRumU-00000002Ww1-0yOL
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 16:37:27 +0000
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-43b8a96ff5eso2272029fac.2
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813445; x=1780418245; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbEyVDKYB6brZVOZVveRW94ChbWHXbhuaSGALUdMmOo=;
        b=HEL4T936s/nS5h0Z96ZhVfw+APwy1p0C5+kKXnev5S8aQkzRpqp/oasBn0WwiMOLGb
         rL/KYbvRtvHe+hmn1b5jgHs9Zn8nEmJ011we0Dd/dRYwCb3IxU/q2+vPIOw03wxS9XHO
         pvnIe3hGcX5sE5rtT0mV6MStCv9kpBS4bUDJGPCd5tKX7aISOIf3bSyFm9BqHu9q4LO1
         p+73BHAa50MIyRTU4e7xBlk3ldGLN5kaqvFmhHoEMMaTPxWb8ZFVIeG6MlBcjwkRIofy
         V8MS0OofcLSDfWoSme6tXEScxOJ9gTgMeDmf28Pwa5KqueXnQHzdLNqW5CN5NjCTHll7
         Ibiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813445; x=1780418245;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbEyVDKYB6brZVOZVveRW94ChbWHXbhuaSGALUdMmOo=;
        b=FAqyMtefPTMMcEhOySwNi5Vgbex96RVY16iZGpfknERohHP+mJG4czAvII8qZ6MBxe
         El8ece3zfQ3FMgDNF1NzGHLlZc11vaUuB75Haz0AHJZumF8B0HoPNMHYYWzt4katxgc/
         TJUCvd9l/PtCWhQuFx1IkRQHRVXbxVuJJYo1CAQBeDliUZUzQ86H5pYZO4xM3KmyEjMp
         BArCg2Y55JnvBnsFdAgj+zcY2fkP0pFSWfVJV+33Oow8pJHndSzQS+nnrep5b5UuxUtR
         DGp/wI1NsHMl8Co+Sd6v92FhlikV7zNC97v7nGMX4ACpOISixcxvolgcWqCy8+0NHwom
         JdyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gmKm/79DtIqU+cdmBozQButKvKphyMb2d/lfwjbtCJAngugstcSaK6IGJd1c5oU6aQoEOG/1KFmxg@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf7zNRNLqbht1f8h19HZHneuNRumkURBQc3TwKO0K00jvwyxwS
	crJcjTQkF/iPk0ob9ZFffoedWF7Cc2tWCvjWYWhyJSknVl14OiR4SsMwnnfM5Vb0T/4=
X-Gm-Gg: Acq92OHIShYtpT0viSjseV9CYLtUmpq1rBzwc2b0QSrhF+4iOkGx2Zpw/iCk2/v+f4y
	cikZnOSvQ+HRkwHLz5/dIlzz9OZ8cCxtNyKRXKJ7OTerUTPirXoR0fwGwY109ywHDy8wbrZAsWx
	s+1H2AR09bUCGYNyObvp+1o56eHZ6z/ir8AOlSg/CI/T2I/XfZh3kky1R/yE53TCodD24N1T6Jf
	VJK7CoG27LwNnf3kALbPwunH6XmDU2N3ECx+oz4ot5da5xBfQULZV5RQVhL+mWARln1ry3sCAox
	HDsJusXtQYsbIyLw7f1i2Ecx34akKjthn4XBPGEq39Jy/ERM9je3bFccXx/ASm1msYUGcjdLdjD
	NZCzuqqEZV3NtuSYLFZFS72wP+Le+/qELrFHVOVhSB+pG8pWVqZMv4P8OMj8kwUqI+HYPt0SyvW
	cqvKlyjSeGRLhBAGvFInx6x+b+fgbMyuYSZiuixapwRhFrfTkQgV95ym7nCwWjkHo7/apK79Pva
	krFZnrgciIApnAFT/9IXN6k
X-Received: by 2002:a05:6871:289a:b0:43a:5cd0:db00 with SMTP id 586e51a60fabf-43b5adb7a25mr12258063fac.23.1779813444777;
        Tue, 26 May 2026 09:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Sung-woo Kim <iam@sung-woo.kim>, Josef Bacik <josef@toxicpanda.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Fourier <fourier.thomas@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Kees Cook <kees@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nbd@other.debian.org, 
 dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20260523125210.272274-1-mateusz.nowicki@posteo.net>
References: <20260523125210.272274-1-mateusz.nowicki@posteo.net>
Subject: Re: [PATCH v1] block: switch numa_node to int in blk_mq_hw_ctx and
 init_request
Message-Id: <177981344077.464267.4670805396521914701.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_093726_286616_8E0B667E 
X-CRM114-Status: GOOD (  10.57  )
X-Mailman-Approved-At: Tue, 26 May 2026 23:23:47 -0700
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


On Sat, 23 May 2026 12:52:35 +0000, Mateusz Nowicki wrote:
> numa_node in blk_mq_hw_ctx and the matching argument of
> blk_mq_ops::init_request can be NUMA_NO_NODE (-1).  Declared as
> unsigned int, NUMA_NO_NODE becomes UINT_MAX and walks off
> nvme_dev::descriptor_pools[] on CONFIG_NUMA=n [1].
> 
> Switch the field and the callback prototype to int and update all
> in-tree init_request implementations.  No functional change:
> cpu_to_node(), kmalloc_node() and blk_alloc_flush_queue() already
> take int.
> 
> [...]

Applied, thanks!

[1/1] block: switch numa_node to int in blk_mq_hw_ctx and init_request
      commit: 65e1c8f96ad1a1f3b72e8a91d1341d570f91d985

Best regards,
-- 
Jens Axboe




