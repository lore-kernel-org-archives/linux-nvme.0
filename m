Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE88C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NKxxK2BuqE/SnHG6uN+KTZeNtTB4DqPR2THoD6it3MY=; b=goS4jxE7elHuntDTQJzkCsvFcC
	rynGzqp/ixNzQV9BcY/6VLKumZj1FUFK0LqFPjf5jUCdNAdCul3+SjMHLOYsSBVydTHCwN1d4CcKo
	DvY0YvVWayTisQASotn3E5+YIbx9AsW8J/YHKSVGCqdJMN4YsRN7NoTHLeRj/JQTOnMhDFZf/Iwfa
	INdSHTtfThxbvK2At5oaYxE4JshLgixI4WAjZxTBAfL2HHQtr0ryypVGlxqkGN2ld8GX3ds4VZhjx
	8LQ6we6aJs0dBvv7uKk9hJlWxJwNvdovefySWI0D0BpoKmuXcvTcRzz1Eemp8kpfi3IRmhKexuaSG
	mR9Lfz9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcEW-00EaFq-0C;
	Tue, 19 Dec 2023 15:42:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcET-00EaDb-2B
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 15:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703000526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NKxxK2BuqE/SnHG6uN+KTZeNtTB4DqPR2THoD6it3MY=;
	b=ZctFjsVNvqGuG94FpstazobeF8UydnmsSDhu4tnrVL6LG+sJ+AguFrTUotRRzYGduHdA4T
	LxOEL2q4rFozKQo5zvuLfN7ty94PH0LcjczDuyS60I/cr4dNvhON2mTnvF3/tG1OZMmKGH
	iWNRpDsVD7Cmqi1ZO/dxeKfC0WALtQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-XVKg0EkkO0S0Vju9LfWeaQ-1; Tue,
 19 Dec 2023 10:42:04 -0500
X-MC-Unique: XVKg0EkkO0S0Vju9LfWeaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E771C0512F;
	Tue, 19 Dec 2023 15:42:04 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 201702026D66;
	Tue, 19 Dec 2023 15:42:02 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH V2] nvme-pci: fix sleeping function called from interrupt context
Date: Tue, 19 Dec 2023 16:42:01 +0100
Message-Id: <20231219154201.438767-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_074209_805066_AC986BE7 
X-CRM114-Status: GOOD (  10.51  )
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

the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
but the latter may call nvme_auth_stop() which is a blocking function.
Sleeping functions can't be called in interrupt context

 BUG: sleeping function called from invalid context
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
  Call Trace:
     <IRQ>
      __cancel_work_timer+0x31e/0x460
      ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
      ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
      nvme_complete_async_event+0x365/0x480 [nvme_core]
      nvme_poll_cq+0x262/0xe50 [nvme]

Fix the bug by moving nvme_auth_stop() to fw_act_work
(executed by the nvme_wq workqueue)

V2: Just move nvme_auth_stop() out of nvme_handle_aen_notice()
so the latter can be safely called from interrupt context

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..60f14019f981 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4137,6 +4137,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 				struct nvme_ctrl, fw_act_work);
 	unsigned long fw_act_timeout;
 
+	nvme_auth_stop(ctrl);
+
 	if (ctrl->mtfa)
 		fw_act_timeout = jiffies +
 				msecs_to_jiffies(ctrl->mtfa * 100);
@@ -4192,7 +4194,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		 * firmware activation.
 		 */
 		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
-			nvme_auth_stop(ctrl);
 			requeue = false;
 			queue_work(nvme_wq, &ctrl->fw_act_work);
 		}
-- 
2.39.3


