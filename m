Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CA606A33C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KKF/5TbR;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T+O/kDLr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bsrAhTg4+c0RRBNyhHeFlINagfiTI3KY7KBVjgXYkec=; b=KKF/5TbRUrjq0k
	zwvYixmIlY626yS/WvGxDV5x/tJcP7UzN7vN3LoNj6xvpvnEWFBrG/e7L5Q1RtZfp6N/QSZZVr6r2
	8JkzuONt2bZl5L/VBgOyzJvaHHMv8SsN71tr1PuAyu1nHF4WkpSRSUTQtI/Etr3UW0NaIYVfFW6xT
	KFhLQmemGkSmN6wPjpx6PHO7RHfi8ZSZusocL1Grn7PeggL76n7dBvW5RuMPNfGlGP7N2O6JM7RH5
	X+D3Y8sbyzrk+MsSg65QSkRHLuzK9iTiTlO4Qx51huB3J+Zyc4zp9gsE2RhTQbS02TDmx252WPYTx
	WzJTkSrp6jFZEWqxsOYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpCv-00000006RuD-3V6g;
	Tue, 24 Nov 2026 12:01:09 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpCo-00000006Rqj-3Lom
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 12:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795521658; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bsrAhTg4+c0RRBNyhHeFlINagfiTI3KY7KBVjgXYkec=;
	b=T+O/kDLrAIMkw8ITFMf2Jvoi2N5nqVFdmqOiRFN8XBYddCJSurJSEi6/9yzMBX/6X5+AKu7fy6Us3ReySLZ2VOMLI41cpvNqqfNVjphCUOf7cS5wCYSNHeobplLsv65u/lB8fIIj8YmoE3gS7lRcd6artRmEQwP/Cvd0GpWnRUg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFOUUMN_1795521657;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFOUUMN_1795521657 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:00:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/3] nvme: define the SMART / Health Status async event subtypes
Date: Tue, 24 Nov 2026 20:00:31 +0800
Message-ID: <20261124120032.1824788-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124120032.1824788-1-kanie@linux.alibaba.com>
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_040103_295948_8FA387C8 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
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

Add the asynchronous event information values of the SMART / Health
Status event type (NVMe 2.x, Figure 154) alongside the notice
subtypes, and the events bit for the temperature warning.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8948f4ecc7567..cd9d08cf9cde9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -361,6 +361,7 @@ enum nvme_ctrl_flags {
  */
 enum nvme_events {
 	NVME_EVENT_NS_CHANGED,
+	NVME_EVENT_SMART_TEMP,
 };
 
 struct nvme_ctrl {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b37..66fcd5a160684 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -859,6 +859,12 @@ enum {
 	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
 };
 
+enum {
+	NVME_AER_SMART_RELIABILITY	= 0x00,
+	NVME_AER_SMART_TEMP_THRESH	= 0x01,
+	NVME_AER_SMART_SPARE_THRESH	= 0x02,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
-- 
2.43.7


