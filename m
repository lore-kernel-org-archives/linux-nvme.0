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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE36C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:23:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DE520738
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrJx/CDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DE520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9y+kEb1QxITmOSuXmS1/dYFH9vWb1DuPCJGBQA0c5Tc=; b=GrJx/CDGp3En24pwiakrUcvYPZ
	RIhenfVjLBlcxtoEAekQIbkBofnzxkCKJZ4cCRGxvimlzmbSxb6BFSMilxkrOegTLfBIB5XGlkefn
	8V3PyxaWmt9pWEgmwy+nEW4RQt6IVlTSaFbalgzqCfKdLodJeMHDzToqmBa2r8vj+hZ08umtREBMx
	zyya/q0hSnh9AqQ3hsJvEedcjzPijQFRFkqN4EqKrQuDjI6vScTu2IM4HObUxUrojOiaQTzazTsp2
	B48XhnIEyFjskh0kUfjRo2t8wsEdaV6w5d62YHrSNxa8cY6mH2y9Mh8KqE622z0P1haeTZhaYMypj
	aRAca6Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k90Sv-0007vg-9M; Fri, 21 Aug 2020 06:23:53 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k90Ss-0007v5-Qr
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 06:23:52 +0000
IronPort-SDR: fV9Ajgqmj6v1vSYojPnYXLzAdXMP3vdGyHVwd0w7fkIJf5zG11AfuqgSv9OSfio0THv99J3Oi2
 70CWWGDjaAMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="155455762"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="155455762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 23:23:48 -0700
IronPort-SDR: 0aqnItAG2hB098KdrDCNk457+fKa+YfSBC3SCSlzztl4CGJrqVRcN+EwZMGDC1pqbusLFcH7H2
 VXv1zGLK6vnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="329943667"
Received: from waikikibeach55.sh.intel.com ([10.67.111.25])
 by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2020 23:23:47 -0700
From: Ziye Yang <ziye.yang@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data comes in
 h2cdata pdu
Date: Sat, 22 Aug 2020 00:13:43 +0800
Message-Id: <20200821161343.50480-1-ziye.yang@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_022351_007739_21C0923E 
X-CRM114-Status: GOOD (  17.68  )
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
 drivers/nvme/target/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 9eda91162fe4..745a8e3ad61b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -427,7 +427,11 @@ static void nvmet_setup_r2t_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->hdr.plen = cpu_to_le32(pdu->hdr.hlen + hdgst);
 
 	pdu->command_id = cmd->req.cmd->common.command_id;
-	pdu->ttag = nvmet_tcp_cmd_tag(cmd->queue, cmd);
+	if (likely(queue->nr_cmds))
+		pdu->ttag = nvmet_tcp_cmd_tag(cmd->queue, cmd);
+	else
+		pdu->ttag = 0xffff;
+
 	pdu->r2t_length = cpu_to_le32(cmd->req.transfer_len - cmd->rbytes_done);
 	pdu->r2t_offset = cpu_to_le32(cmd->rbytes_done);
 	if (cmd->queue->hdr_digest) {
@@ -866,7 +870,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
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
