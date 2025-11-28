Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3D2D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=; b=C5qvrvb/D2Otyx5eIbBRlp/2gt
	TEhp3nS3Cotdh4E921X383SLTmWWbuT20cj3mHPpiAL2yp16ctGJ2R9A3Jhg/5cHS2VzMA77JMIhl
	XqrAiyuDrXrW3a8OoHHVfOnh75MPH+WPpqO+YUNB7XUXFMo1bl+ubDe2N6aOn5k1n76FG0gEkcAua
	0Hqs6aMbh/yaD3wCVaVlTmJapc4NRQBflukaoP1ICDKEmSSOzbf3SJI2FapPK5W3oPMpwDQF6MB6B
	FzGUw8bC4C9w/rGJITU8yNpUQ+K+H4mMmffS0pe4+WS5Cf/UKHxNZqMTMDENKdpkuZZgaZww/vEjA
	eZTczb6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtv6-000000009rv-109P;
	Fri, 28 Nov 2025 08:33:36 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtv4-000000009p7-14Un
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:35 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1828375b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318813; x=1764923613; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=nVfd6pK7pvI/Kg+vszAvyQwQE9gVfDyawMNmAcmUxa4MOyj30U2VkCQwZbEsYO5nXM
         5KHnI0LviR4+mOPqCK//Eqn13MyJ2EWgUTYlboMF86cixsYt8ugMX5b+Z++6ve/9LCfp
         UVp7L82kDCWBvGdprtpU+IZ6+ejOqpSX1mbj07EtWIqoaksB/3e0EzIZJ1kazz2AUk/k
         PxgPVegOv/w94n8qTmkYRgsKDRb0FoDiJ1W55k7Xdv8CWXptz3gkD8AmhMypAxs8EEek
         8YwkK66YShgSDai99S2pifePEDHV4OvBlUhXS/UXwviXOxm1ElQH3P85EeBtxfZB1yM8
         bWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318813; x=1764923613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZsPDOjyUTRUehf6LhbOb026Dy93eapwVzPzgOc2prg=;
        b=btb+46IHZF3Rih7xMN95PXZJUf4QnQZI8LbcZN/jl51afJ4Ps3P47y9zn1Mar0ORhl
         O2vAELjyxlEgVb00ObqxOvhEAPFUarVSi0Bc5rZzAQxXU2VqHm8cRiBev3Sa98xb8/6F
         wAekwxIsCQe36aiRpQJLTE4G0+WjyQQPEmN/uGu49LWr2jOyDRhMf8LXan4SoaASZxD0
         /4Q021IKBAgBXCLy7ueZaeMFBMvJ0YeXIMFD96CanN+nSTdhJakHPMfydf6DJumQgCY5
         xMWWLRLXMWsqm+7WVFCRUcnkcAw8u5sjhKI5ltsDf36cwLlpC8OgllXeRXhwe6H8YOLE
         7kcA==
X-Forwarded-Encrypted: i=1; AJvYcCUE/5VIGaBYDu82zcd1p3NIQq1K1JVhC2NthH7wvGv6Y3EIGCnMMGDL6QjO/cuJjmdPLElaWDMdLGZ8@lists.infradead.org
X-Gm-Message-State: AOJu0YwbDdzIR0+FsAltpkZHKhDMF2qvNzYsvM9i+OvcDNBGgH3oHP2s
	MZiTchcbhIND3LGuCQ7pERMWEdb4X8dPJPy0/Df8wH/tVWRRzHstz97d
X-Gm-Gg: ASbGncvpUcVYGq1Y8VEI8LlC6/QWt3DbDMinUIqZCA8g2MZNreYpv8lLt4N3ym0OGKp
	LHI2csql8H+Vq6RjvuTN8FC9ws8021PxBt/4nRAcibxt4Fnf7Em6QPZ2cEk6R814EtMT0mJ6AT+
	ZZZIP2w2XOOZSkkdHzkAFqTRkAiPJAHZXJWbwSXUwuRHtYO3REebWluNq5EbhwiDjD3FlKxknfz
	c4m14dmhab1/9qewOvCeGW819WqiCYOaCiOjNCLWXI9NQZoKi4dZw5NQMP1hTxlZ8ElWEXu4XpY
	miE+/Ty8wb5Z+9Yz9TShPcuM06UhxTgYoHftewFo8AB8BVEllUw6o8yCmpFaOUaxdL/A9uBvPCh
	3YDw1+xKMKJ4wdGBmTuJIjCeoejBGIy6Sf8EsqGm+HWYxrcvehEpe41Xmp2cKydI5oOCq+nrPCu
	qNhD0gYPgt0GO60xEVTD4pK7dROUE+mJRggSPf
X-Google-Smtp-Source: AGHT+IHqHdLof6s224+GbtnJAk22/n625R68t5gW5XXJrnH8NN05gDy1A3OVkHY/4+FwyWeG7e9t0g==
X-Received: by 2002:a05:7022:3886:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-11c9d867ff0mr21572562c88.41.1764318813388;
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:33 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 11/12] nvdimm: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:18 +0800
Message-Id: <20251128083219.2332407-12-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003334_299450_4EE1E961 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvdimm/nd_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index c3f07be4aa2..e6ec7ceee9b 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -122,8 +122,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 			return -ENOMEM;
 		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
-		bio_chain(child, bio);
-		submit_bio(child);
+		bio_chain_and_submit(child, bio);
 		return 0;
 	}
 	if (virtio_pmem_flush(nd_region))
-- 
2.34.1


