Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0347BC4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A81221EB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oewyBl+A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDvOMvrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A81221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=blGK3tq8or88+UXspYBSYL+/Aen3G8vy5d003/y1wu8=; b=oewyBl+AKfQQxL9dNYyamS4hs
	vEX9FeV5C1sFB+pxccHvVYBse7jo3eCpuQVCLz3+wSAajJL9KEkT5CNLXL8l30FeA+xUDU5v3xOYl
	ehJxOVGcEPmMeu0eB3P7JlA45+FHuAGJXpMC7OyP+633w/dIgRhZpU3YCguKmBdRm2VNIRhgNHb92
	lcnCgQiS5d3hsx2MH4YspXCyhKQemQE2kOA213l6wPb+p42zvjkpvS06tW2ZuwBkvKAGMmMmfquC4
	BdTz7VOG1ZWOaQasxxT3vf/Rchi1doELsYghOa+++bZwYHbPDXSz1ATUBywGNB/r+DFuwl/I0VLua
	Jgr7Mkq3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLYFO-0002um-Jh; Thu, 24 Sep 2020 20:53:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLYFG-0002rY-Gj
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 20:53:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C542239CF;
 Thu, 24 Sep 2020 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600980818;
 bh=TjZ/h/RB5ENBHC8z4Y+xgQryaV4G3HwztlJFGYzWI5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZDvOMvrwNw/XuF6F2CX6aUa9gg7WrJUWG2LvHs5+7kRSnZS16OyH3eILgSuf7mHEB
 ud2Miar6qUIa/cDNPnMtvdrw9Yro0kl5Zsf87JJOlMu1v2X2lkNSHZTwbnSXDRNT+5
 1gpsN9i2QSDJ8N8ZDWjI07s0pEynF0+EFfPzlBNA=
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [PATCHv4 3/3] scsi: handle zone resources errors
Date: Thu, 24 Sep 2020 13:53:30 -0700
Message-Id: <20200924205330.4043232-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924205330.4043232-1-kbusch@kernel.org>
References: <20200924205330.4043232-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_165338_689273_DC214D03 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Damien Le Moal <damien.lemoal@wdc.com>

ZBC or ZAC disks that have a limit on the number of open zones may fail
a zone open command or a write to a zone that is not already implicitly
or explicitly open if the total number of open zones is already at the
maximum allowed.

For these operations, instead of returning the generic BLK_STS_IOERR,
return BLK_STS_ZONE_OPEN_RESOURCE which is returned as -ETOOMANYREFS to
the I/O issuer, allowing the device user to act appropriately on these
relatively benign zone resource errors.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/scsi_lib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7affaaf8b98e..c129ac6666da 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -758,6 +758,15 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 			/* See SSC3rXX or current. */
 			action = ACTION_FAIL;
 			break;
+		case DATA_PROTECT:
+			action = ACTION_FAIL;
+			if ((sshdr.asc == 0x0C && sshdr.ascq == 0x12) ||
+			    (sshdr.asc == 0x55 &&
+			     (sshdr.ascq == 0x0E || sshdr.ascq == 0x0F))) {
+				/* Insufficient zone resources */
+				blk_stat = BLK_STS_ZONE_OPEN_RESOURCE;
+			}
+			break;
 		default:
 			action = ACTION_FAIL;
 			break;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
