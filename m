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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97320C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:58:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5062075E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMrLjPE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5062075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D6O3MDuHxsLSLiNRxQJWIREnbzZ1joPOR8lRWyH+hV4=; b=nMrLjPE5p5ScI1ZZCdbHxHfAU
	mPWPfibWCniCq1mjacrSWbhGULYTc+k8J7ZWLFJVujkcjnNV+7D9ujRwUPin8wjj6q+5HgaBS4Wz2
	xrJQu/k4sRAoPFk3089kZWaotwKGP0jRXfWPodHtSqew0l03/dmyocbCg5fPf7lg7SxFAViJe3/ql
	NpJnpUzpaIk8mkt/O7JIG/WyRjfZLbwdwfApBVNKA3v2i/xxZcZoKtWwKmPJXt1S4RPHHY8xwWzcg
	KmBidFhzlXEXVR3DOw4adp5RJJ/i6/w8WfFp2ch2uyszh+f/VLtV2qJ5MZuIuJKbUG8Lja2J4ayd2
	/zgJNzoxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k910H-0001rT-Kx; Fri, 21 Aug 2020 06:58:21 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k910E-0001qg-TD
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 06:58:20 +0000
IronPort-SDR: knLv5DuRrdrrqtXRNLfZBTn7imsrKjUxboYgeszFgCAc+9o6ULkGdneTF3MU4zo+l92dfmmMql
 IgiAidKUoxxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="217014792"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="217014792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 23:58:15 -0700
IronPort-SDR: MCpFa/W80M9fYuHVKhP5fKgmvUEjeg5g2pQBYVIL6iYSNP7wKwlsJKt3qKtoeLmegcyx/dWB8c
 xPI8akHhlxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="297856426"
Received: from waikikibeach55.sh.intel.com ([10.67.111.25])
 by orsmga006.jf.intel.com with ESMTP; 20 Aug 2020 23:58:14 -0700
From: Ziye Yang <ziye.yang@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data comes in
 h2cdata pdu
Date: Sat, 22 Aug 2020 00:48:10 +0800
Message-Id: <20200821164810.8970-1-ziye.yang@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821161112.50363-1-ziye.yang@intel.com>
References: <20200821161112.50363-1-ziye.yang@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_025819_108593_C447AC4A 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When handling commands without in-capsule data, we assign the ttag
assuming we already have the queue commands array allocated (based
on the queue size information in the connect data payload). However
if the connect itself did not send the connect data in-capsule we
have yet to allocate the queue commands,and we will assign a bogus
ttag and suffer a NULL dereference when we receive the corresponding
h2cdata pdu.

Fix this by checking if we already allocated commands before
dereferencing it when handling h2cdata, if we didn't, its for sure a
connect and we should use the preallocated connect command.

Signed-off-by: Ziye Yang <ziye.yang@intel.com>
---
 drivers/nvme/target/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 9eda91162fe4..8e0d766d2722 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -160,6 +160,11 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
 {
+	if (unlikely(!queue->nr_cmds)) {
+		/* We didn't allocate cmds yet, send 0xffff */
+		return USHRT_MAX;
+	}
+
 	return cmd - queue->cmds;
 }
 
@@ -866,7 +871,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	cmd = &queue->cmds[data->ttag];
+	if (likely(queue->nr_cmds))
+		cmd = &queue->cmds[data->ttag];
+	else
+		cmd = &queue->connect;
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.21.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
