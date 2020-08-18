Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB71C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80423206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HRv0o9YD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFI18qQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80423206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5IfBJVkAAKATmE9JdFFAcb/9YtWhh1IryCyuQl3JHog=; b=HRv0o9YDpUjMdB8DXImevPLouP
	Llgly6SdhqvGtCRdi7b76SFAqHptGcw5rMf3V6MviOUB70UT9TarAoWy4CWenLrwD3mWHtBQSMhYX
	YN59tMVaSWS+akAebIDuGDNHfNsbFp73KqII2IhQewQJe1frac7/QhgMwcdeMuYCBN5zi4L1WknQQ
	PamffjfbK9vDvVvSc81Ulj76HcR9ANh8qzJPy7Wp1VCTLOIwBtC+7h0BQ20QPoQlYts61IEbM4aoc
	dyBbEvuulBdKmozp/jjvsasIn62Hi+XMuytGdbEE/+sBFycAMRhh4lzYxlthIYe0PcMPJ0qlmkYZL
	xXZO3g6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k84Ue-0005NT-9N; Tue, 18 Aug 2020 16:29:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k84Uc-0005Mo-8A
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 16:29:46 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 988072067C;
 Tue, 18 Aug 2020 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597768184;
 bh=zziWaMJptU39EWcNrWK+9Nw64GGWM8m3xDIZQumbzaE=;
 h=From:To:Cc:Subject:Date:From;
 b=dFI18qQS6Xatbaskw8TiNpYn0SLacMkOrSqjmktGMuTCEFAzwqXeVTm+YTd2TAYFT
 9368bQAwjimui1xjVzLXsTamLwmBxiITEwzyl+rl/gl4psexR2Me5B5VPnE3kPeCNO
 kBScAm3kQqXlc8b3L21q+Li77nnYsP2qLijmq+Gs=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv3] nvme: skip noiob for zoned devices
Date: Tue, 18 Aug 2020 09:29:41 -0700
Message-Id: <20200818162941.2674340-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_122946_349770_C6903687 
X-CRM114-Status: GOOD (  14.10  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Zoned block devices reuse the chunk_sectors queue limit to define zone
boundaries. If a such a device happens to also report an optimal
boundary, log a warning of the conflicting attributes and do not use
that to define the chunk_sectors as that may intermittently interfere
with io splitting and zone size queries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2 -> v3:

 Emit a warning on the initial validation if a zoned device reports an
 optimal boundary.

 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..10cf40d2cfef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2075,8 +2075,13 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob)
-		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
+	if (iob) {
+		if (!blk_queue_is_zoned(disk->queue))
+			blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
+		else if (!(disk->flags & GENHD_FL_UP))
+			pr_warn("%s: zone namespace has unused IO boundary:%u\n",
+				disk->disk_name, iob);
+	}
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
