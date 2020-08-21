Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C1C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 05:13:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB545208E4
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 05:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BA0mPqzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB545208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MRWBglIKVyYZA7AIIWQ+MvXD6EXEXUygmSnqrtRFGAE=; b=BA0mPqzoFor80N3WqAxJcIkYVo
	6jgiqTOepI8oMj5nb6lkHXAvJ3Fr4qrUUQ2kf5YvNnym2uT0psRw/EGhlOvXA4EDfKu1hm5nsaqrB
	lTPRIdBL+jy2qklXENBwxXZje5g5L4c6cKgC55MqoHMF7pq75K72LQBy9sVY0MNCwGZsCyH/IPFDw
	Ju+APr3qsLcwwFNny9ugFfRkJR8wEwZVczIdW0b4qvJHpCvykiElgdVzpPc5BnLo+xDz5ASkW/xLU
	fhfkZXAr5MQH7oGkafeXnyzmPvRAd5XtdkfDUXy7EmSgsIvhmE9EUXtJvmhA0zVsHNa5A31DRJ84C
	5Uv7IxWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8zMU-0007oe-4C; Fri, 21 Aug 2020 05:13:10 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8zMQ-0007lf-7a
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 05:13:07 +0000
IronPort-SDR: JpCqphXlikXn87G0sU4JHFhRzcS0JI8TbiNYZ7bjgTk5F1ZDO3HDmJR4/7/aRXsoZr3nn+jtxx
 7wguUmfsotsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="135525262"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="135525262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 22:12:57 -0700
IronPort-SDR: bveVZ0hfNRbB2VrvXc6biQQfF9AexCxGH9v8jklaGuKbadtF3QLXQgabZ+gXkprLjeCeZAbBfF
 +PYqQghbFNFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="311337133"
Received: from waikikibeach55.sh.intel.com ([10.67.111.25])
 by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 22:12:56 -0700
From: Ziye Yang <ziye.yang@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet/tcp: Solve coredump issue while initiator sends write
 CapsuleCmd
Date: Fri, 21 Aug 2020 23:02:52 +0800
Message-Id: <20200821150252.40800-1-ziye.yang@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_011306_439236_6B7EE5D2 
X-CRM114-Status: GOOD (  13.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the initiator sneds write CapsuleCmd without incapsuledata, we
can use the queue->connect command to handle. If we do not do that,
we will have a coredump because queue->cmds are not initialized.

Signed-off-by: Ziye Yang <ziye.yang@intel.com>
---
 drivers/nvme/target/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 9eda91162fe4..9d3eeb9338cc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -866,7 +866,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	cmd = &queue->cmds[data->ttag];
+	if (likely(queue->nr_cmds)) {
+		cmd = &queue->cmds[data->ttag];
+	} else {
+		cmd = &queue->connect;
+	}
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.21.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
