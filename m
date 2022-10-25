Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA100C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EroC0KtZuKyAa/OOEJyLAILYRdxp/Tc/77xWQSkcMcg=; b=xZeAKyuOqOPGMKYRFM1WWl1gVz
	JYjgfhV3jHHVyF+CppNOiztFaFq4Hns8Apf+iYHVPN9IGekdp1Y975qjctOWV2qasRsKKxH2DZ+h7
	hFAkQmhMsugVaQTt3yz8WcrTUrywcUX7aOAWX0ALYRUzxgQSvgQ6uFISnNOnIjSG+a6/cKGisF/vN
	uyW2L+DNt49nypbbKw6Wu7GiKuSNCa3o/CyWKeUVMZVm2rq0QHpmTN7b69w+HvSyjHoS7wf58Wkl/
	I3o4Gi51mee8fclXBASZhz3z3QGymWzZ/gOEdelxtMD0/c61/B6kpSc49dGm709lrdI4gmjlxKxzS
	Mv8x3yUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMC5-006BU0-B8; Tue, 25 Oct 2022 15:50:21 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMC2-006BRp-17
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:50:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A84A21FC7;
	Tue, 25 Oct 2022 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666713011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EroC0KtZuKyAa/OOEJyLAILYRdxp/Tc/77xWQSkcMcg=;
	b=vZbsgxCnRw3IkSigINrkw3JBmo0/xxO7m47sP+y6VS9U3YECNgqPxzLb/+s0qOzsCltDA4
	fl2f89FL1tB8ZsvQmTv+1bHmoWgwBBchl3C0kok5EPRUeuVKJqF3bsn/jWiZxAmBN7Pzxj
	WVPjiUQPO3p/qq5G+eRSJbGQ69XfOng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666713011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EroC0KtZuKyAa/OOEJyLAILYRdxp/Tc/77xWQSkcMcg=;
	b=Y9uLjlLGM2QUVZIsH/ak8gb8esdJjix0xVU3B+Tad7idlHODfSsxj4B5IGTgwT/c3Rx4sX
	qk2OsNYGAIO4m4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B248134CA;
	Tue, 25 Oct 2022 15:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fR6uArMFWGPVCQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 25 Oct 2022 15:50:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v4] nvmet: force reconnect when number of queue changes
Date: Tue, 25 Oct 2022 17:50:08 +0200
Message-Id: <20221025155008.30028-1-dwagner@suse.de>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_085018_268653_D5819B5B 
X-CRM114-Status: GOOD (  16.35  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v4:
  - Rebased on -rc2
  - invalid memory fix went in as separate fix
    94f5a0688407 ("nvmet: fix invalid memory reference in
    nvmet_subsys_attr_qid_max_show")

v3:
  - Updated Fixes tag
  - Updated commit message with some additional information
    from the v2 discussion
  - https://lore.kernel.org/linux-nvme/20221007072934.9536-1-dwagner@suse.de/

v2:
  - instead preventing changes, force reconnect by delete ctrls
  - renamed patch
  - https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/

v1:
  - initial verison
  - https://lore.kernel.org/linux-nvme/20220913064203.133536-1-dwagner@suse.de/


 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9443ee1d4ae3..051a420d818e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1290,6 +1290,8 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
 	u16 qid_max;
 
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
@@ -1299,8 +1301,13 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
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
2.38.0


