Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4CFC433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 06:07:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C0220759
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 06:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjoBfFLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C0220759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lk/RGPBAQDWd6znCms4AGkAvSX633G0AfT0OmYeA32M=; b=WjoBfFLV/6M3XEnlTjNEQ7wDkX
	HHuke7eizTfP5bxtMNPbW5nCknJPZLg8WqWXfPfp0KKzxpZd/hS4PeVszgzGt2tMIPvjAzaOxvdTK
	7H3rzsNJ3bl7xqIC97UcjyAY9fAyWgiZc1Umciim0MDCeg+ZhYtqporBoHiwtGSHx+k8sSswP4OqW
	6TVv6ODBH+5moFBZNRTiiobLk7H/PC/VZ+PFO3mkNZRz9i6hKveGb45V8cNIRT1FheGVY2AYQPvxl
	lNCcSLEtQxhaPC/CS85bwQeK+8FfXx9if+f5VCSsp0xIc7g14wFyxpjLda5OXQJcke0qpWFQkng8x
	gQnu5o7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzwHr-00084n-Tk; Mon, 27 Jul 2020 06:06:59 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzwHp-00084I-0z
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 06:06:58 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D921AB22F1BB2482BD1D;
 Mon, 27 Jul 2020 14:06:52 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 14:06:44 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-core: introduce the preferential local retry mechanism
Date: Mon, 27 Jul 2020 14:06:44 +0800
Message-ID: <20200727060644.22782-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_020657_617212_B05977F1 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We need a mechanism:the host retry io in the current path first after
a defined time in some scenarios. Because if work with dm-multipath or
other multipath software, the multipath software will set cmd_flags
as REQ_FAILFAST_TRANSPORT. If io return with any error, nvme will return
io error to block layer now, the multipath will set the path fault and
retry in other path, but realy need retry io after a defined time
in the current path in some scenarios.

So we need introduce nvme_req_local_retry to check if need retry
in the current path, if needed, do not need checking the cmd_flags
through blk_noretry_request. According the protocol define,
the error code NVME_SC_CMD_INTERRUPTED is a good choice.

Scenarios which need retry io after a defined time in the current path:

Scenario 1: user configures a QoS policy on the storage system.
Storage system need to tell host to retry io after a defined time
when need control QoS. Host should retry the io in the current path
instead of return io to block layer.

Scenario 2:many hosts(more than 100) access the same storage device.
I/Os are not delivered at the same time in most cases,however a large
number of I/Os may be burst delivered at the same time sometimes.
In this case, the storage device can not treat all I/Os, needs host
retry in the current path after a defined time.

Scenario 3: storage software upgrade inline. The storage system may need
host retry in the current path after software upgrade completed.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a1ad5e5212c..3d39528051ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -242,7 +242,7 @@ static blk_status_t nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req)
 {
-	if (blk_noretry_request(req))
+	if (!nvme_req_local_retry(req) && blk_noretry_request(req))
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226d3299..17064455f2db 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -710,4 +710,12 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl);
 static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 #endif
 
+static inline bool nvme_req_local_retry(struct request *req)
+{
+	if (nvme_req(req)->status == NVME_SC_CMD_INTERRUPTED)
+		return true;
+	return false;
+}
+
+
 #endif /* _NVME_H */
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
