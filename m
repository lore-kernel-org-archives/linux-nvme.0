Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06D9C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qHrDSUeKJDVZCBua2gHhrubPkS/3tJchVGCda1DQz5U=; b=q5wmhjD6o12AAMgCbyUX3M+SPn
	IrjqWDHvEcFg6eTPBJ0PKvGz/a8MItOkwHs6wY3Haj8fFPQTwcJZe+jgeNkhRU7cLT8GkHnmae54v
	M/EO1yfgP2f9Xui0WIFba6l9KcSBWrgQI6dES/Dru6tVWe6yyInRqkSc5wF46L5mLy9rhNxFkkOt+
	3aAnvGRHjB2IYrAk7CuyEHd6JaqBM+SX72kDIF8WcOVBfTm+tzXmjrYSlt9EwirGIclcI2/B1zUpY
	nR9n62uIy62eH8Ptvi6zpZCeykYwijvSrMp/D+eEaTiqsLOg97uEtYa/7namq6vEureIECwbxYudR
	Ephjlymw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px4BS-008dJm-2f;
	Thu, 11 May 2023 11:10:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px4BP-008dJJ-2P
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 11:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683803401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qHrDSUeKJDVZCBua2gHhrubPkS/3tJchVGCda1DQz5U=;
	b=KF9zdTWX+t4JW4tFjv/RyhytHFaA9TPgD5/yML9WFMHq8eK8R7Hz+U7ASLO/nPDYqNrukM
	LOYjhKw4/wVjpCmUa3lCTDplj2mX6NX9hC6hVqNAGgImSWPgVV37wKG8dTE5J7ES5N0EYw
	MwhAoam9sW5X9MlGjgwI+PnsGZMaf9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-DaAU1rOgP0aXlnv19A5wTQ-1; Thu, 11 May 2023 07:07:45 -0400
X-MC-Unique: DaAU1rOgP0aXlnv19A5wTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A88C585A5A3;
	Thu, 11 May 2023 11:07:44 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C52AE492C13;
	Thu, 11 May 2023 11:07:42 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH] nvme: do not let the user delete a ctrl before a complete initialization
Date: Thu, 11 May 2023 13:07:41 +0200
Message-Id: <20230511110741.1883129-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_041003_879858_4495189E 
X-CRM114-Status: GOOD (  15.19  )
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

If a userspace application performes a "delete_controller" command
early during the ctrl initialization, the delete operation
may race against the init code and the kernel will crash.

nvme nvme5: Connect command failed: host path error
nvme nvme5: failed to connect queue: 0 ret=880
PF: supervisor write access in kernel mode
PF: error_code(0x0002) - not-present page
 blk_mq_quiesce_queue+0x18/0x90
 nvme_tcp_delete_ctrl+0x24/0x40 [nvme_tcp]
 nvme_do_delete_ctrl+0x7f/0x8b [nvme_core]
 nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
 kernfs_fop_write_iter+0x124/0x1b0
 new_sync_write+0xff/0x190
 vfs_write+0x1ef/0x280

Fix the crash by checking the NVME_CTRL_STARTED_ONCE bit;
if it's not set it means that the nvme controller is still
in the process of getting initialized and the kernel
will return an -EBUSY error to userspace.
Set the NVME_CTRL_STARTED_ONCE later in the nvme_start_ctrl()
function, after the controller start operation is completed.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f8..1f0cbb77b249 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3585,6 +3585,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
@@ -5045,7 +5048,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * that were missed. We identify persistent discovery controllers by
 	 * checking that they started once before, hence are reconnecting back.
 	 */
-	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
@@ -5056,6 +5059,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
+	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.31.1


