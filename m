Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C9BC282DE
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Mar 2025 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=; b=d2OrDRvSQLZyESNqdsgptLRwqn
	s/Ch3+6LhZbz4OiJPUk3PG6cNF+GJR+97dshcYUgYM3YL31Cw5s+JwF7pHJTHk/lSnnNssz8xlsHi
	Fhe/LyhRBsrFyNV+M19Gy7lVVEYxZmUZTAPS1su5YWUHbuAwhSnYuz2GUFRs/UB4dUW4e+BoAG36A
	ZLdAwL1QruSghkArqEmm+TVCoSRO0zJ0AYfnXkiM5jfXaIV5hJH0q6BmbbT+SWrF0mJCbYJPlbt5G
	H8Kz775mP3xJTY98xORm+f4snTfJZriMEMnxRd1SFzK5WMqIsk0TIRsitGX8GrEUuabNDpHzAXhe6
	RM+mLa0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttqJL-00000000Kmb-0NUf;
	Sun, 16 Mar 2025 15:53:59 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsiYC-0000000BNVe-3eVP
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 13:24:42 +0000
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-85db7a3da71so64447239f.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Mar 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741872280; x=1742477080; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=FHH3rBu+c66uuJfWnEdUur9/6DS4maRNYuMb2tphYFIMjMg68aB21Ml/uX1RjiNpPA
         GpTd44KCarD+aY32/KvY73M+5VgR0Bqx4CW4vR/ZVzHSsuXId1xp8SyrpNH4FwplUIX6
         bDVTfumxVSMqDafe+srQLfdl5zI69jfaXe/bm8K5ZrCS2zXzSAAntfJLxNyb/xFUTvH6
         vvpxFrh2z6h0RUS4/aiOGL+yC84weviFPytOfUMnWsEd7EZ+vPhH3T+iwhiZgyS63Rv+
         Rc208hMd7EW7wUe0zd+sOTQd9nhKZtzjVwvby/2s+l0IzxJoXj3Nvdm+CS4wYMyt9J4C
         K2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872280; x=1742477080;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=CYLB9LDnp+lXKamSaf5dgsL8Xzmm0mJ1T6WVzAYTwc4Ree+2UiIJG7uDWlOycpidzy
         w7YQDrvKMGwf2svCj9IBtImy6UbdyZwM4onoxacbxlkoF+77ntzcK0zYOHAveDN1SkRX
         CcavpLsETjHWnxM2wNLVSWIUnRMIF8q4yz/RhWpI+3c/5kWMfGUSFzDHacf4jJ3/O3fN
         kz4vSIErXqzp1+oTUnSss2C4XSXIkSRnApZQgd09SMwAsUXYZfsQRGsCBc+7Vts+vhfs
         I9x2F4FwfbFm94XF69TskW0XY7Tg6BGq1NGeTpdRAeeGxyk8Tlj+akEUmwgyYmIdwGl3
         nZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCXzzUBz0z9ZjvqaMwLZzd03nKFi13iuiH6ToMPppTRNLt5CtfZczoqACdSeXs0kJfhbUMjhWkUzD4fg@lists.infradead.org
X-Gm-Message-State: AOJu0YxzSyAkG18cJQZdjWAyskPXuy79fVyUELlNJFvpCt2VTTapVANS
	YKrBVjrWcC0fMXFS1jiNL1B6fw5ylhFTWSYihC5k1oamUi+cNtIE6KsVy1mzxk4=
X-Gm-Gg: ASbGncvTv7jm19YT/w80oiG62x48OJQOrUBECK+5i27kQceDIj/vLlJTb6vfPo2Mdda
	s22fD4Fxvi98tNCHLEVwPFweyjGPROjyAmzrijA+oQW/DAMGYpVtCvEiBx9kpeayp8e76nPEin7
	RhfoNwCpRFerKPBhKfaatHbfiOa04vjAlTTX4qNUlZEkt/RtTDufB/jQ7dWgmRma5aGn9dYqh/Y
	PjM5HARP+XPwMmrnc8bITAVPK0zvbjY5JOr3zK8CXpLQszIPP0bcgcj60KSOQaw+/rGLE5JyIXf
	MllrLjnwth2MyHSv0GetNocnjPr1fmWBUac=
X-Google-Smtp-Source: AGHT+IEer637uehs/daevOydns9iUer0NF8/Lop3Ui7LDoPjH6cMpb131IF3qkXQqxQNFL57dNEHAg==
X-Received: by 2002:a05:6602:380d:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85b54946d71mr1891701439f.5.1741872279762;
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879e512sm31580739f.28.2025.03.13.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250313035322.243239-1-anuj20.g@samsung.com>
References: <CGME20250313040150epcas5p347f94dac34fd2946dea51049559ee1de@epcas5p3.samsung.com>
 <20250313035322.243239-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: remove unused parameter
Message-Id: <174187227786.18244.14269218969550436496.b4-ty@kernel.dk>
Date: Thu, 13 Mar 2025 07:24:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_062441_179798_12497040 
X-CRM114-Status: UNSURE (   8.62  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 16 Mar 2025 08:53:50 -0700
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


On Thu, 13 Mar 2025 09:23:18 +0530, Anuj Gupta wrote:
> request_queue param is not used by blk_rq_map_sg and __blk_rq_map_sg.
> remove it.
> 
> 

Applied, thanks!

[1/1] block: remove unused parameter
      commit: 61667cb6644f6fb01eb8baa928e381c016b5ed7b

Best regards,
-- 
Jens Axboe




