Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75430606A33A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=G/Axa0P0;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KvSVsHAE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oh9kDZI6DmcE1IUciALbAUumwJinDqs8TPRZ+TwAXa0=; b=G/Axa0P0X5BftN
	JNPM5yEDvoUAkhz4KRUOW/fIU4j1+hLfJTB83I+lWAV5LYoSLWnI4Rj6pQvyAxID6VbSVYljn5AuY
	8Bwx7srXs6OJw2JHS8q69pEpalS5MU+kTGJ+uiYQgl/ce6gKmrEIMmnQTdIeAwjgyobOY3wPLUsh1
	+JoGUgZqtLG1RogPy22LT7aGwYeTHKTDk8mC8IhZlg9sNNHjp55HAttUnEcS1DoprFNrKhQC4vB0/
	FIZR7kc3eEiQLBcOlHtoDKqVVOktzlegUD/tMsKJkQWqMnFEYa4zY+RV8lsLdPQXfuwIDY25FjAn4
	aWeaM5cobhGPZwQQG4ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpCu-00000006Rtj-2t81;
	Tue, 24 Nov 2026 12:01:08 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpCm-00000006Rqi-1a9L
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 12:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795521657; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oh9kDZI6DmcE1IUciALbAUumwJinDqs8TPRZ+TwAXa0=;
	b=KvSVsHAE9AauavRfdOfa7vQvbFkwbKj4En3IhrOC9BJzW+GE5KLqj5j/WeRienpMPnoZWxwKjuHzug7NAeuChD7pPCiHediBk0N7Ts6BiDGH9qYdi0BAd8ocaKzJu4rxXPqY5ATW+Is90pnFVz2UlOa6owY3zUZK+kI/OkXapiI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFOUULo_1795521656;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFOUULo_1795521656 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:00:57 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/3] nvme: define an event bit enum for nvme_ctrl::events
Date: Tue, 24 Nov 2026 20:00:30 +0800
Message-ID: <20261124120032.1824788-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124120032.1824788-1-kanie@linux.alibaba.com>
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_040103_294402_667E6F3C 
X-CRM114-Status: GOOD (  13.14  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The only bit used in nvme_ctrl::events is indexed with
NVME_AER_NOTICE_NS_CHANGED, an AER subtype value that doubles as the
bit number.  The AER subtypes are numbered per event type and are not
a bit namespace -- the notice and SMART values overlap -- so borrowing
them as indices gets ambiguous as soon as more bits are needed.  Give
the events field its own numbering.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b038063..9da2061a0c0d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4692,7 +4692,7 @@ static void nvme_scan_work(struct work_struct *work)
 		return;
 	}
 
-	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
+	if (test_and_clear_bit(NVME_EVENT_NS_CHANGED, &ctrl->events)) {
 		dev_info(ctrl->device, "rescanning namespaces.\n");
 		nvme_clear_changed_ns_log(ctrl);
 	}
@@ -4713,7 +4713,7 @@ static void nvme_scan_work(struct work_struct *work)
 	mutex_unlock(&ctrl->scan_lock);
 
 	/* Requeue if we have missed AENs */
-	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+	if (test_bit(NVME_EVENT_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
 #ifdef CONFIG_NVME_MULTIPATH
 	else if (ctrl->ana_log_buf)
@@ -4947,7 +4947,7 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
-		set_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events);
+		set_bit(NVME_EVENT_NS_CHANGED, &ctrl->events);
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358a..8948f4ecc7567 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,6 +356,13 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+/* Event bits in nvme_ctrl::events.  The numbering is independent of the
+ * AER type and subtype values in include/linux/nvme.h.
+ */
+enum nvme_events {
+	NVME_EVENT_NS_CHANGED,
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
-- 
2.43.7


