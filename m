Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52AC4451C
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Jul 2026 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95R+xIP/87RyRb0dz+s7R+IaY6bqD6sOy0TrsJCA7Fk=; b=tyQG8c41amGcffFAhPsMkSQPWY
	G11FjYYZo6rfMnpJ1P6EORqlZfXCGl4muBqw3uj58O/gXrNbi5mVXGuuIXEMqKW4i+NpDgaDGPSTx
	VGqpv3PKjCEm2MKTfOgjVE7q/M62BfJ0M0dpiZQrHaf1Rh2rz9nWfHkXOSbXlzG9FK30ydzTvPRkf
	8EixVyA+q3sPwoJYIAKmUtqPavzJ0HGLsu4/q1WlgLfQNk0024ipEgh0iwG25ckwGmxOYiPUnORnH
	FntT2UaacnZ5CI39EsW/0lnDEzQ37lIU5ljLudg1tsoh2QTkX9BQJu2L5kjbVHNknLV/2soiynJ1t
	t5h2Bdag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7s0-00000004H61-07dG;
	Sat, 18 Jul 2026 16:26:32 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wl7rq-00000004H1X-3cbd
	for linux-nvme@lists.infradead.org;
	Sat, 18 Jul 2026 16:26:27 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso1251595e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 18 Jul 2026 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784391981; x=1784996781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95R+xIP/87RyRb0dz+s7R+IaY6bqD6sOy0TrsJCA7Fk=;
        b=cZopN5EP/oCsfc7Km0xsX3QZxPxrowuHpoMm5wALzqk96fWhR822qnOYloFURfkqSS
         dMwbLMdu79K2icaAMUyYvhgnCOVE1qBb9TZNMSnVcxFvTbeQqIkGNRwkZSXUO3KSnvKx
         IixmEwSxL7wOQq9G4P+IKSWbfOJ79Yj404NFxqAST9jU7bBWM+rU8WHDWNdxVzE43VFw
         EIMCcgSWSF4YWau8RmjChsRiGa84oS+njf8v9YiljLZQAm7eSXNyXbDwpZCmGRcUXTR/
         PeN825xjtE5NoCInAF4236M/oFKRS9HeC7U60E+GVg6cks+nUW50LCy9jAiogATKzCRA
         9f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784391981; x=1784996781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95R+xIP/87RyRb0dz+s7R+IaY6bqD6sOy0TrsJCA7Fk=;
        b=lEldNd8uNZaB6PURmvwJ+JfNpVBKWdsB3fkV2GB0t2quxlPS0Xjz8WwU1A9/mQ35Y5
         T3c1YYnSCVjFN9rOHg9jw9ugWb1VGaWy28+Pz5+KLbXxZ4HWf5A1f9hnX7pLtfom+pr7
         8UzgcznVvCbQn5yOCHcxHMT2ENy9YheDxxzJN5meByAR1mF3uFPU3AR9i84tSY6QTssq
         lWgPf7fkHAT2WVEn7pTlcVLPNxA5j0OI+9pOn2ynZOAa3jBbXDRew9dEqatHl9HlFJc4
         TJxVw5KEWds6/pyT84kWkwYLJ/WsamxzioYieM21i3+ESUD/J5giTEJA5kA7JKpafuLk
         eO5A==
X-Forwarded-Encrypted: i=1; AHgh+RrwwwV/wgd4+c9XACJnWKDp2KH9NiBNKu530ad3bDDQ8tLiXFgvGMygNRbReNTegY/1NR8Ns83XaQxF@lists.infradead.org
X-Gm-Message-State: AOJu0YxNF36R4aGCxYaAoX8RLg1h3bsYk7Gw8VZhIJ6SpsLmaPdZJaYC
	V9Mv0cKMR7y6/vhPAEwCXB3bbODWzMV8BA8xrEomvDU0XyETJ9ekyi0ZMWtP3eWlYQ==
X-Gm-Gg: AfdE7ckdesItiBFw+4VJ5UR1PQOru23ivajTw0dXDQVAif5aTzBWl7bcQStyJDTeEeq
	+Mn7cPCRgTrdAvrLCM9CemiHYpUqX8/f35kZvqhcNHlvgmXSgAx/8QvYmpPKDeyTVL6Dviszbs+
	kt0P1hCB6JlL+sUQ1d41gjibgVVCRPyv+QcCkAxkz2H7XtW8DPDpvLDBf0nRyj2ro3GpC+uYK2v
	fJA9Rtzl5LHkECfrJ63kQxRUfJQzV5WPjTuS27cbpmC9Yeyso+atmQRxSq3R4rw31AvclsYQmUN
	2Eb7fqbvON+TBhVNkyWUANKV/VtpKYb2VA7/fjYDtOMn6y52Dr6JjSZrlhglFRtz/ZcEtuGNU8L
	AGpR3pavZD7NQBMytXY4te4iBLS2s9TR5UlXcTLoOSyAElgTnier4RayFeI7VyA==
X-Received: by 2002:a7b:c054:0:b0:495:401d:9f4f with SMTP id 5b1f17b1804b1-4954a40513fmr53645805e9.25.1784391980997;
        Sat, 18 Jul 2026 09:26:20 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm266444085e9.14.2026.07.18.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:26:20 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/6] md/raid1: don't use write-behind for P2PDMA bios
Date: Sat, 18 Jul 2026 16:25:44 +0000
Message-ID: <20260718162547.448892-4-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718162547.448892-1-mykola@meshstor.io>
References: <20260718162547.448892-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260718_092622_922588_A3F99844 
X-CRM114-Status: GOOD (  12.93  )
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

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..57f64e890102 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1575,9 +1575,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags) &&
+		    !md_bio_is_p2pdma(bio))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.43.0


