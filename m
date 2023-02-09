Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E8FC636D6
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJVv0BqEdtVJlQ/Zx4t2+kbeGJwrCwyJoMiijw1Ggzc=; b=a4PoPk8JutbracA8ASsoMSUNhs
	yWhpw/AttDbiGKcSSaV0cKADaip7kNGeYcg2+ED2mpCl8KPMLVieptwGENHlSXxfOhU+AZPmk9dny
	7HnKg3/CwizeqBguh8fYTSBhPbiTP+Zqti+yjgK7OkkqYvM8VTQ1FPjpDF3ZgIcqe6gHTNOkEjEm9
	ZSI+0xWp4BqBMewkN3H6abQZOV9C57lijZvX3kBZ0zl95u6WL2CiFxTazgfoVqGRKH41qSm+OpkKK
	B5F6SC70Ipg73y0pTnpgyZhmRVkAz9dj5LLvis9iyyikKB5w3zrcjRsYhhPVa/qWwKhSxr1C5nRgp
	kgSI9xuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84U-0020mw-12; Thu, 09 Feb 2023 14:38:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020ew-RI
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C73DA375CF;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJVv0BqEdtVJlQ/Zx4t2+kbeGJwrCwyJoMiijw1Ggzc=;
	b=omKiG5b/qGCsZSUeqo1cPpmGShTeMEXU+3HkkIHWMjZj8cRXkjWxgjmTnWOLG9h9T3ap83
	3kaDkNgDvQquAtvA5lBY+jzJKua9UFdjqTRtw4craGb1eSgpvqgWmCXHW9jFlzBbMLfwyA
	LqEsjJC+fTXGMyN2SXBSzEgmcoaG/jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJVv0BqEdtVJlQ/Zx4t2+kbeGJwrCwyJoMiijw1Ggzc=;
	b=Rtf5jueu/E/DYmKC+gjKtZ+wb00/DETcx9jWPgKkAMc0UFYb4gJpy7aPulMU6OBnXYBYUs
	BCUKShc+/WplnYDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AAA3E2C142;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 990A751BD13A; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/5] block: make blk_rq_map_kern() to accept a NULL buffer
Date: Thu,  9 Feb 2023 15:38:17 +0100
Message-Id: <20230209143820.118097-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209143820.118097-1-hare@suse.de>
References: <20230209143820.118097-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063832_045557_63B20D97 
X-CRM114-Status: GOOD (  13.05  )
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

We really should accept a NULL buffer as argument, avoiding conditional
coding in the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-map.c           |  2 +-
 drivers/block/pktcdvd.c   | 10 ++++------
 drivers/nvme/host/core.c  |  8 +++-----
 drivers/scsi/scsi_ioctl.c |  8 +++-----
 drivers/scsi/scsi_lib.c   | 11 +++++------
 5 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 859590be077e..4615386b85d3 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -783,7 +783,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	if (len > (queue_max_hw_sectors(q) << 9))
 		return -EINVAL;
 	if (!len || !kbuf)
-		return -EINVAL;
+		return 0;
 
 	if (!blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf) ||
 	    blk_queue_may_bounce(q))
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2f1a92509271..9e49cca82bfd 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -694,12 +694,10 @@ static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *
 		return PTR_ERR(rq);
 	scmd = blk_mq_rq_to_pdu(rq);
 
-	if (cgc->buflen) {
-		ret = blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen,
-				      GFP_NOIO);
-		if (ret)
-			goto out;
-	}
+	ret = blk_rq_map_kern(q, rq, cgc->buffer, cgc->buflen,
+			      GFP_NOIO);
+	if (ret)
+		goto out;
 
 	scmd->cmd_len = COMMAND_SIZE(cgc->cmd[0]);
 	memcpy(scmd->cmnd, cgc->cmd, CDROM_PACKET_SIZE);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ad2bcb412944..78da9c6cbba8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1044,11 +1044,9 @@ int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
 {
 	int ret;
 
-	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
-		if (ret)
-			goto out;
-	}
+	ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
+	if (ret)
+		goto out;
 
 	ret = nvme_execute_rq(req, at_head);
 	if (result && ret >= 0)
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 1126a265d5ee..1e182d71ce74 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -581,11 +581,9 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		break;
 	}
 
-	if (bytes) {
-		err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
-		if (err)
-			goto error;
-	}
+	err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
+	if (err)
+		goto error;
 
 	blk_execute_rq(rq, false);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9ed1ebcb7443..b15ddf6820a3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -221,12 +221,11 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	if (bufflen) {
-		ret = blk_rq_map_kern(sdev->request_queue, req,
-				      buffer, bufflen, GFP_NOIO);
-		if (ret)
-			goto out;
-	}
+	ret = blk_rq_map_kern(sdev->request_queue, req,
+			buffer, bufflen, GFP_NOIO);
+	if (ret)
+		goto out;
+
 	scmd = blk_mq_rq_to_pdu(req);
 	scmd->cmd_len = COMMAND_SIZE(cmd[0]);
 	memcpy(scmd->cmnd, cmd, scmd->cmd_len);
-- 
2.35.3


