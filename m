Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245AFC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 16:35:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF71A207D3
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1sTTwX3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xsMURmZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF71A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mklMvYtKgXADeUqTtHHDUH8XcDvj36M5s/dQKxxt9fk=; b=X1sTTwX3ToWeCsgBhGqZkArNUf
	48Ins5MSvuOTlvHeGjptUdn9h8S31XHdEpqU89SrmrUotfYe5FTH03BD47f7/ljRUj0C4zst1aYK8
	jx9oXDOH1fuEwhuRSxzEdbrIFHi45KbceYpSj3OtFlTDeFkpyiQQzHzY44wqGHJakky95mpPdsZHi
	VKvK69GH5LNwT/96ykEMI/Y7ricTHB3kbXoTB4nVvdNsNkTFs4npmOJR4pNehofO5t9vI7buqfQOq
	tjduUUV1r9KUZ9uFX8XIEyz86DgW44Rz7OXRyDWOJRxLYL97Ud7A1oKsTni7zAuF3Ry4sLUUG1rId
	8zRREDxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAbuq-0007Bk-VD; Tue, 25 Aug 2020 16:35:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAbuo-0007BM-LC
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 16:35:19 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F975207BC;
 Tue, 25 Aug 2020 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598373317;
 bh=fLfTdoNVBYJe0WiaPDpXLN6lSozzqkhMZpffSFvfjRk=;
 h=From:To:Cc:Subject:Date:From;
 b=xsMURmZO+H1Fx1jckwKP8lsn1QD/m60nR13ZzAoab8aNfdvySFqop7C2Jhv3F2Y5s
 m/GYdII31AjQxZO8KHUDrecx0WstFJcjhMtaWUd7+GMneFisIKpG9zEULG+8atsTg0
 4YzPTzMnp3YpXqeAl6XSqxHCtQJnNjMEM/rmO4ws=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme: only use power of two io boundaries
Date: Tue, 25 Aug 2020 09:35:16 -0700
Message-Id: <20200825163516.1706267-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_123518_792532_F7D6510C 
X-CRM114-Status: GOOD (  14.73  )
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

The kernel requires a power of two for boundaries because that's the
only way it can efficiently split commands that cross them. A
controller, however, may report a non-power of two boundary.

The driver had been rounding the controller's value to one the kernel
can use, but splitting on the wrong boundary provides no benefit on the
device side, and actually incurs additional submission overhead from
non-optimal splits. Don't provide any boundary hint if the controller's
value can't be used.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 154942fc64eb..2a398de624a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2097,8 +2097,8 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob && !blk_queue_is_zoned(ns->queue))
-		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
+	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
+		blk_queue_chunk_sectors(ns->queue, iob);
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
