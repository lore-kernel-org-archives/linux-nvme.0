Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72502C27C43
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RcNPRAsi8JblcS19gsuAauomnkwxEd71fqUmnSid7XQ=; b=Id/H6AovB1erQVQkair0IDogU6
	hQyyZSTeqWuL/pDp7qa+lEa1SJaaMyq2HJ8rxRg5Hd31DmsRnIHh8yTOXZZOs+uNQYUviUhzX5h/E
	3IjVjypeaI2gXIMoTPuNqKO9b1aapGMf7Bw7axph410NsgJF4j/DZLrUanYrdhvKyj+L7ZdRcV2nl
	rvwlBD4YGckY/I/i4A62lLPbds6FSgKYgME5hkKiGZW9GCR2kfl8jc7Krnlgdv5+8EQzzgiQrxG1j
	iD54rwHBtaZUD7wbNjdMumzL7w0c6NFL/ltf/vV8TC68EzAauKipNdqZZZqZNEn44EG/aN8fR+i2R
	APgbEMWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCILn-000000045jd-3YDj;
	Wed, 29 May 2024 12:24:15 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCILk-000000045h1-4BEG
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 12:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716985449; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RcNPRAsi8JblcS19gsuAauomnkwxEd71fqUmnSid7XQ=;
	b=Ga6cNDFRGi3lRwsYzJUt05ir+sltIWB4sGkwcknIaUWacx6VGIJIfNVuD2zFNKzcuKesABGbpezc0zs6Q+UKOIs+NDSxY//Tv46O+MwznUi6UYAn7xD3xzHAXQ7xmXVYINT1bGW0gQsTMYQYbYB6Cm1N/G1l1wr8xTD+Sx0TXXk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7Tq3Ha_1716985437;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7Tq3Ha_1716985437)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 20:24:04 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH 1/3] nvme: fix nvme_pr_* status code parsing
Date: Wed, 29 May 2024 20:22:58 +0800
Message-ID: <20240529122300.92377-2-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
References: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_052413_359856_B227CB9C 
X-CRM114-Status: GOOD (  11.21  )
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

Fix the parsing if extra status bits (e.g. MORE) is present.

Renamed nvme_sc_to_pr_err to nvme_status_to_pr_err to better match its
semantic.

Fixes: 7fb42780d06c ("nvme: Convert NVMe errors to PR errors")
Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
 drivers/nvme/host/pr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index e05571b2a1b0..25e23cdba151 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -72,12 +72,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
 	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
 }
 
-static int nvme_sc_to_pr_err(int nvme_sc)
+static int nvme_status_to_pr_err(int nvme_status)
 {
-	if (nvme_is_path_error(nvme_sc))
+	if (nvme_is_path_error(nvme_status))
 		return PR_STS_PATH_FAILED;
 
-	switch (nvme_sc) {
+	switch (nvme_status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return PR_STS_SUCCESS;
 	case NVME_SC_RESERVATION_CONFLICT:
@@ -121,7 +121,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
@@ -196,7 +196,7 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 	if (ret < 0)
 		return ret;
 
-	return nvme_sc_to_pr_err(ret);
+	return nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_read_keys(struct block_device *bdev,
-- 
2.45.1


