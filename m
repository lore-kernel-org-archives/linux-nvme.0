Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E02FFF885C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hn5gt/kr7QDgHfqk6BJtfvqJ62o4kkrmwOKTA2D2kLY=; b=BEF1ATXHQNQUMob6VB1wYZPK7L
	8m5Cepshi9r2uEN5WSnDsz7j5EKQksUN+HCjj0oQOf7xoT6/oMZQ9hOQmJz6eP3zMc7ixz5dgrgoT
	UtuwWITFW9lhYKVn3IXO/sgtJrCJurvE/oUOamfjHbQWUstB6YdnYeIgKUOS6RM5113ihaSG6hWTZ
	gO7gztugfD6g5yQl69d+/3or91aqoaXrbHKf5g5eqiygqw9SAjvSYjbnEn83HWtUq4p/3LddCtBWi
	LUV+XFwL7M4ivV82c09WZY10oRfTwmLyI6bChcPvmbHoTyfmQYzfxFIt3ziaMHeCjB5FF4IQQXb6e
	7MoZ1DqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPET-0000000Dpvt-2cW3;
	Fri, 24 Apr 2026 22:42:45 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEQ-0000000Dprz-2Ob7
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2Sdt2sj6z1XLHYm;
	Fri, 24 Apr 2026 22:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070558; x=1779662559; bh=hn5gt
	/kr7QDgHfqk6BJtfvqJ62o4kkrmwOKTA2D2kLY=; b=mJJt0tAd9F+e7XezCKlu+
	cMif01CMnok1UpTVdunNApamb3sxfj5lSTzixS/6imv6K6BFtWSWD6L3OVydV10h
	Y/QJy6zIp0IrelzGTzpXolfFjgUKEzXMzEDPUc77tlirppNFgYcP2gjGUufP5XJ9
	CcUfmNrZ14Dmh3N7kBdVenvCJOmCHvTlbTL9hW/67TBWNYNbpCfc5ImgOgVJg+tm
	+4wcm/I5aYg0N+JkbjByHd5CqEY12WTCYbkCdvvGApLYBBKvPHtiIvDRzEtVGXjK
	6bt8RMxSpNaEhZiKJcL38rYWDqcx0kTAjg7OSi1kcx3XxckhOiteClSqViXO3tlZ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x6VTYr4bWKdD; Fri, 24 Apr 2026 22:42:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2Sdm63KVz1XLF2r;
	Fri, 24 Apr 2026 22:42:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/12] dm-linear: Enable copy offloading
Date: Fri, 24 Apr 2026 15:42:00 -0700
Message-ID: <20260424224201.1949243-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To: <20260424224201.1949243-1-bvanassche@acm.org>
References: <20260424224201.1949243-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154242_628585_640881BD 
X-CRM114-Status: UNSURE (   9.43  )
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

Set BLK_FEAT_STACKING_COPY_OFFL and max_copy_hw_sectors to enable copy
offloading.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-linear.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 38c17846deb0..3de8bf5f11fb 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -119,6 +119,11 @@ static void linear_status(struct dm_target *ti, stat=
us_type_t type,
 	}
 }
=20
+static void linear_io_hints(struct dm_target *ti, struct queue_limits *l=
imits)
+{
+	limits->features |=3D BLK_FEAT_STACKING_COPY_OFFL;
+}
+
 static int linear_prepare_ioctl(struct dm_target *ti, struct block_devic=
e **bdev,
 				unsigned int cmd, unsigned long arg,
 				bool *forward)
@@ -211,6 +216,7 @@ static struct target_type linear_target =3D {
 	.dtr    =3D linear_dtr,
 	.map    =3D linear_map,
 	.status =3D linear_status,
+	.io_hints =3D linear_io_hints,
 	.prepare_ioctl =3D linear_prepare_ioctl,
 	.iterate_devices =3D linear_iterate_devices,
 	.direct_access =3D linear_dax_direct_access,

