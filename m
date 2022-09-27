Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF01C6FA83
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iT2K5z2lA4lGjBKeV8JimPhxP1fxuoeV9Latj28EqD8=; b=vJjXq7RVONRO0DIUjoFFquSdJy
	2a36mocPrKwqgi48grpAoSl8H36togIjPb1KYJMI4cb6tKRz3kWYeRgJfoUadEGP40E4iWESZQ6kG
	mU35cz1IxCg0uVIa1POtfQKThPBPEgO7xaRcmw5oAtgXK937RvqfNu2iuY0C7JXq1Ep8zFT6G00jD
	6nvIosVpPfcDeqQnXfeDNmWIpcGxrhY3DwX/2ospa1Scv2FcBXnxgsOmg21bxbwIhwNxDLXYIyUeQ
	PUc+OmT15Wg3iVEx5hT6CKKPH2kyLjBtxc5uDpI0PvT8U75Rx4QXCEOlBRogg1LqzAm/CMcLIZOxU
	0IjMYm2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odBd3-00BFhV-H9; Tue, 27 Sep 2022 14:32:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odBcz-00BFfR-PH
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 14:32:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2420E1FD33;
	Tue, 27 Sep 2022 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664289122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iT2K5z2lA4lGjBKeV8JimPhxP1fxuoeV9Latj28EqD8=;
	b=VPo1eNXF7Y75jfGg5KxYlinarOzQwDYWVXxiA8057LwUzuKdONMt8itKiwFVn6xSTYWc6q
	OgJh/3qY5cUHAzqQERIWjpASvZ00Qj+VkObKXepT15Z+Npe0qxiwBBANNRCSlDxFE4CaqQ
	D26/6N1ho2bKbH9cAZdzhmtCugFVxhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664289122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iT2K5z2lA4lGjBKeV8JimPhxP1fxuoeV9Latj28EqD8=;
	b=aabKA9eMuxs6TXgZMDg5mpcte+gukvIRCBjgXB1X5PMIsn2Vj/7mPj5xTXS/UFH9oKKak2
	1g+MDkhRrZBal/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17220139B3;
	Tue, 27 Sep 2022 14:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qjyeBWIJM2NoQgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 14:32:02 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvmet: force reconnect when number of queue changes
Date: Tue, 27 Sep 2022 16:31:57 +0200
Message-Id: <20220927143157.3659-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_073205_991076_F246A123 
X-CRM114-Status: GOOD (  15.64  )
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

In order to be able to test queue number changes we need to make sure
that the host reconnects.

The initial idea was to disable and re-enable the ports and have the
host to wait until the KATO timer expires and enter error
recovery. But in this scenario the host could see DNR for a connection
attempt which results in the host dropping the connection completely.

We can force to reconnect the host by deleting all controllers
connected to subsystem, which results the host observing a failing
command and tries to reconnect.

Also, the item passed into nvmet_subsys_attr_qid_max_show is not a
member of struct nvmet_port, it is part of nvmet_subsys. Hence,
don't try to dereference it as struct nvme_ctrl pointer.

Fixes: 2c4282742d04 ("nvmet: Expose max queues to configfs")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20220913064203.133536-1-dwagner@suse.de
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
  - instead preventing changes, force reconnect by delete ctrls
  - renamed patch

v1:
  - initial verison
  - https://lore.kernel.org/linux-nvme/20220913064203.133536-1-dwagner@suse.de/

 drivers/nvme/target/configfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e34a2896fedb..051a420d818e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1290,12 +1290,10 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
-	struct nvmet_port *port = to_nvmet_port(item);
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
 	u16 qid_max;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
 		return -EINVAL;
 
@@ -1303,8 +1301,13 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->max_qid = qid_max;
+	subsys->max_qid = qid_max;
+
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
 	up_write(&nvmet_config_sem);
+
 	return cnt;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
-- 
2.37.3


