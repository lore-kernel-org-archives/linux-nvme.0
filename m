Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D222C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 07:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EIZxgZmoWJ09Z9G/Gdsfje8t32lQOTLUefEPXJp/kpM=; b=J2j+p+XbIC9Nxx9dP1PNjm0Wlz
	d4oICRATvJ2o8s3X/GIdS2uZhs25t2lmZysu8VTnqtdzpVYKw1AXbAjn0lRX0/kXlv/hug1to4idk
	k4FoiZy7zoiYx7ncOAvboSVbvHLUlCy7MR/jYdplzcAG6gn7ZrNEar9uB/OjD1K7q4pfOw/4q7bv9
	KcZI96lzK24t28j+UfZV/YT52eOxsucEHKHLxfRxOF8WscWGHm37vs+HV2NyBZQspxTG/9sRUIamP
	yLZCOftRUQERf4Q0BU4THzbip2O3fwYQoCYmbka/5MgDG/0/12gH0u8c20vLoMD4A0cIDk5T2oEsp
	3a0/jrkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oghns-007tfI-F5; Fri, 07 Oct 2022 07:29:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oghnp-007tep-FW
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 07:29:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83B661F88B;
	Fri,  7 Oct 2022 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1665127785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EIZxgZmoWJ09Z9G/Gdsfje8t32lQOTLUefEPXJp/kpM=;
	b=bVaUTBTozgvkFzcdPh1D/SQD4/WxxIY/w1ShdBPpuNldxUFY9rr2rRwr4fv16RnQ8UMqfa
	pe4GnqqJ1I/AUY2eaLHJY49Z83qrLzF3wHObhkBtZS8Zp7xhDDMYK1LCq0PmwFbVxI7257
	/l1MceKgAxRnXisgJ9mcS0MgZhQaZ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1665127785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EIZxgZmoWJ09Z9G/Gdsfje8t32lQOTLUefEPXJp/kpM=;
	b=Z8wP81Ub3yeZlk/5h//L56DXE7bvSG5np9IPZoMe7468H9bHK3Lj//9rYd5xeibnhErPBS
	pzlG0LsNkOyq0dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692D513A9A;
	Fri,  7 Oct 2022 07:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6zuYGWnVP2OZXQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 07 Oct 2022 07:29:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Frederick Knight <Frederick.Knight@netapp.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] nvmet: force reconnect when number of queue changes
Date: Fri,  7 Oct 2022 09:29:34 +0200
Message-Id: <20221007072934.9536-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_002949_684458_1FED51DF 
X-CRM114-Status: GOOD (  15.97  )
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

In order to test queue number changes we need to make sure that the
host reconnects. Because only when the host disconnects from the
target the number of queues are allowed to change according the spec.

The initial idea was to disable and re-enable the ports and have the
host wait until the KATO timer expires, triggering error
recovery. Though the host would see a DNR reply when trying to
reconnect. Because of the DNR bit the connection is dropped
completely. There is no point in trying to reconnect with the same
parameters according the spec.

We can force to reconnect the host is by deleting all controllers. The
host will observe any newly posted request to fail and thus starts the
error recovery but this time without the DNR bit set.

Also, the item passed into nvmet_subsys_attr_qid_max_show is not a
member of struct nvmet_port, it is part of nvmet_subsys. Hence,
don't try to dereference it as struct nvme_ctrl pointer.

Fixes: 3e980f5995e0 ("nvmet: Expose max queues to configfs")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20220913064203.133536-1-dwagner@suse.de
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v3:
  - Updated Fixes tag
  - Updated commit message with some additional information
    from the v2 discussion

v2:
  - instead preventing changes, force reconnect by delete ctrls
  - renamed patch
  - https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/

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


