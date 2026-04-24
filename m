Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620D5FF885D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSzpFoKs2c7iGR0jCRAU1YHjT5r/vjcUwHf2IThLqYs=; b=jCbCQ37f/wDpN+6egBdqYgJ7L7
	bYrYgs1X2Ks3I1BCxIjUbhdxwL/C9GEnOWHqamKJS5fqCm/vAi9zKaC7lKXzg4wgRESQsGDgjlP3R
	AN1AHOOHl2QTCx7z0pywrWmvpGSEf2c8O7DfH7+xHZ63JTXFRLMwzMI+CY4jZ8RiYCZDwaZwRX5g5
	hXS/GpiysbBB6SmGsZwoanOF5O56Jr4w4ijRlUvC2bLI/vK8J3zL5IJbOSONI3p+kS/sFrg0idBIH
	Hu4kb74HdXwBPDcf2X3gJNEYFXuhxzR3TpLKWA64+dlQpprbS12WiOuJXEZkeVJQOppILkCsBvvZ+
	6T3jMHOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEP-0000000Dpr9-3h7O;
	Fri, 24 Apr 2026 22:42:41 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPEO-0000000Dpof-1Fsl
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:42:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g2Sdr0DGRz1XLDnV;
	Fri, 24 Apr 2026 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777070556; x=1779662557; bh=RSzpF
	oKs2c7iGR0jCRAU1YHjT5r/vjcUwHf2IThLqYs=; b=ffyEo62/oTvAV704uqzub
	GlthaD3P5kWyMM7zpkK3sQKEHpfQS3cED/+Trbn4ajDw8zZQVM91kmT8wnSWqdZH
	sJvcTxJso25JolGhttrDpHLlkJM4T6RpAQDkD55JAe67X3CKt0dtNHT4MUXrSYsn
	9pyZJdCVOUQYZOmLg09y6LiVmCD4TF/n+H6+DVd4eO6iCHGrmyLP8Kd7QDEgej7z
	4ChPrxxOA2sOr16SAyGyJpL/4cLJdwz8mGB1ZK9EVPfPMtJQfYusH8UXDifH+dIZ
	w6Jxv32nEyp8XGQWy84KclXqVwjh2bYVj4sQn7XQ3VxgMNeKqkOmYlJTSiAMYTBI
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 91GQYhTGq13t; Fri, 24 Apr 2026 22:42:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g2Sdk6Lpdz1XQmtn;
	Fri, 24 Apr 2026 22:42:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/12] dm: Add support for copy offloading
Date: Fri, 24 Apr 2026 15:41:59 -0700
Message-ID: <20260424224201.1949243-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
In-Reply-To: <20260424224201.1949243-1-bvanassche@acm.org>
References: <20260424224201.1949243-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_154240_356733_5B0CFD29 
X-CRM114-Status: GOOD (  11.70  )
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

In dm_calculate_queue_limits(), clear the copy offload limits if the
device mapper driver does not support copy offloading. This is necessary
since blk_set_stacking_limits() sets the copy offload limits to their
maximum.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index dc2eff6b739d..888c5bdca5f1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1816,6 +1816,14 @@ int dm_calculate_queue_limits(struct dm_table *t,
 			return -EINVAL;
=20
 combine_limits:
+		if (!(ti_limits.features & BLK_FEAT_STACKING_COPY_OFFL)) {
+			ti_limits.max_copy_hw_sectors =3D 0;
+			ti_limits.max_copy_src_segments =3D 0;
+			ti_limits.max_copy_dst_segments =3D 0;
+			ti_limits.max_user_copy_sectors =3D 0;
+			ti_limits.max_copy_sectors =3D 0;
+		}
+
 		/*
 		 * Merge this target's queue limits into the overall limits
 		 * for the table.

