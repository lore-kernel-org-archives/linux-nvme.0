Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6B0C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:06:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5B064EC3
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5B064EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NAC/Ue9JUkH628sRkkySh+sR5k1qWiaQIFvdsf/M7dc=; b=3fnp1nTuJdGDIGn55eI5j1oR8c
	cG6kdt/IQhLOlbPPBayJs114GzlO9B7l6Xw538TPY5aWYCloXJMryoJrg8IdZLeOlxjTU05hj+5IH
	7bayWmq5QBR+v9F+LliDEpgTUJ/jWEZQ5yzEGqmObrAAC2c7uUyD0GOvGXDR8gxeyzMc0C5+ify43
	EWujpYvFSbslh9aAH6MjfSt9N20TjIkC4bcPSS/ne5dtqRIB8qupYz5h11OxxPQ9UlnnlMlBqhKmr
	Wl3tmBtJ9gRBnmH5uC1DIOUe6XJ9Ai/4jNcqph0jkglGFZ6Er/JKWpIRoPFO93+P1W2Po6eA2JA73
	mc449J8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6plk-0003MG-L6; Tue, 02 Feb 2021 07:06:36 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6plh-0003LP-7v
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 07:06:34 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UNfE5k-_1612249578; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UNfE5k-_1612249578) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 02 Feb 2021 15:06:26 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kbusch@kernel.org
Subject: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
Date: Tue,  2 Feb 2021 15:06:17 +0800
Message-Id: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_020633_525714_EB28BAC2 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, sagi@grimberg.me,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix the following coccicheck warning:

./drivers/nvme/host/core.c:3580:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3570:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3560:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3526:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:2833:8-16: WARNING: use scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4d..5abbab3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2830,7 +2830,7 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", subsys->subnqn);
+	return sysfs_emit(buf, "%s\n", subsys->subnqn);
 }
 static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
 
@@ -3523,7 +3523,7 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->ops->name);
+	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
 }
 static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
 
@@ -3557,7 +3557,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
+	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
@@ -3567,7 +3567,7 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->opts->host->nqn);
+	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
 }
 static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
 
@@ -3577,7 +3577,7 @@ static ssize_t nvme_sysfs_show_hostid(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%pU\n", &ctrl->opts->host->id);
+	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
 }
 static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
