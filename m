Return-Path: <SRS0=n/mE=MT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3052C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 13:20:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B559D61AFE
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 13:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B559D61AFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B2VrZcxZXzjEVYrNR9i6sCqJZ1KziXQ1hzZ5egldQLw=; b=0irs8iDPW7KaxE
	hsH9dRpTK4PR4WHJnLqAQEo5lXT5//+GXh08IhhBaFcTrgyCQ0TPIUZ8UxXkNqlUrgTtd1UJmDcwi
	BevtBIiX6GtKXLS8j6D9Tr/BiAv7aKa8PYVXq+MdWzdf7/fY2NS6NSlJF5XEDjVOKEY+JleUXQE5j
	5NUTz2o42eyg8Y6or2TyoV0c5KqpXu/ou3EV8fS5RPkjTiVfjDzxshhoNluO2c4Lc1+0Ea3IcbM/i
	DoV8pzAfzzQ5BFzSnY0ab+2a7ycEH2fS+bOx4CzTJybZfa4VT0ireDl37SknwbX6HwWz/rGE9e1PD
	BvToM8kT20/k5khXmGzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8N00-00Eqvf-78; Tue, 27 Jul 2021 13:19:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8Mzb-00EqpN-4y
 for linux-nvme@lists.infradead.org; Tue, 27 Jul 2021 13:19:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C1861AA8;
 Tue, 27 Jul 2021 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391970;
 bh=K7sEvxaluQcGZVGgQ/AHGFUbIVDlE0JjgJajWOr5M40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lxmTaLBY7N9Xl6eOv/Ih3RfZus/hoouJoiZsAEA2C+RzSQWaXJNDCTlxowavO6m9p
 qJ13y47G/i4JvKH2is9HWiRtjiRnkjTXABfcWk0Z+GBJ81QV3cClHnnB5+k7pkkVFF
 6afHFGgDqlo3otJgdKZIZOUpgtvEqlgdcsKbAnFYm7MhFGlU0609ZIRXhRjThdLXE+
 bhP8jtHOV8dl9tx8kDavxENIFWQprhBfT4OQpuXz7r7M8cg2rpqshHRvr7ldEiQbbT
 jVWazEteL/g4E0qeDUkT46l8/Css0XUIypojVKPmgwRNDg8Q9Sclyq8Ef81j/cy7ZZ
 L1bbsypVPGdSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.13 16/21] nvme: fix nvme_setup_command metadata
 trace event
Date: Tue, 27 Jul 2021 09:19:03 -0400
Message-Id: <20210727131908.834086-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131908.834086-1-sashal@kernel.org>
References: <20210727131908.834086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210727_061931_275151_528B0A71 
X-CRM114-Status: GOOD (  11.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 234211b8dd161fa25f192c78d5a8d2dd6bf920a0 ]

The metadata address is set after the trace event, so the trace is not
capturing anything useful. Rather than logging the memory address, it's
useful to know if the command carries a metadata payload, so change the
trace event to log that true/false state instead.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index daaf700eae79..35bac7a25422 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -56,7 +56,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__field(u8, fctype)
 		__field(u16, cid)
 		__field(u32, nsid)
-		__field(u64, metadata)
+		__field(bool, metadata)
 		__array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
@@ -66,13 +66,13 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->flags = cmd->common.flags;
 		__entry->cid = cmd->common.command_id;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
-		__entry->metadata = le64_to_cpu(cmd->common.metadata);
+		__entry->metadata = !!blk_integrity_rq(req);
 		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
 			sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->nsid,
 		      __entry->flags, __entry->metadata,
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
