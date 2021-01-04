Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 15:48:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6822245C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 15:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6822245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mEwVflaAGNFVsr72kqcP/7PCUPxurx6U3MrPQ234YPQ=; b=K6e5MxMzO/pUpBl1oXP/1XTUy5
	7w0vWoCn4BEx0FeGEABcAITa8TJm8WtMs33PSSAJwlnUZvLvc4X0d5z91SALX8qilUhdBm+ep7rVZ
	+K2+7fAjPLu4i1qMdCB4O73zD9zmpsjxPOVyMfOUDsrawTjdcNfw/zXszeolN0od6c4rYVupnzib9
	48s9heVYk811UJ3SLr80m/mhZGcJTlE7NchW88C+pTjUJI8N4rqWRhj6BEcoWIOGko3gVhh1Rq/Vw
	HE0fwBJouE+WXC2wElGsC//9lGGCIFkqWMjl6j2HIdR49j0iRTMl4Tokt3+pfSxxz7PW0G8r1sU7w
	3bvSGIZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwS5l-0001Jv-F4; Mon, 04 Jan 2021 15:48:21 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwS5j-0001JC-B0
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 15:48:20 +0000
IronPort-SDR: yZktKXz3xnv502pM8gLaMxBUGhg9QXXJgpWkzMFV7RQohdRGk3MgR9zcSXS9CXNTvS2aUQHozi
 HIh7j+/zGt0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="261728539"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; d="scan'208";a="261728539"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 07:48:15 -0800
IronPort-SDR: OeiV2dok42sYso8rDASRp45ErpXBbrpAbt1GZWHmkG7eB7JdSQcv4Th6r5TSVPOVtQYutPw0FN
 +y8kt/gqAIBg==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; d="scan'208";a="378464043"
Received: from michal-desk.igk.intel.com (HELO michal-desk) ([10.102.102.231])
 by orsmga008-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 07:48:13 -0800
Date: Mon, 4 Jan 2021 16:53:43 +0100
From: Michal Krakowiak <michal.krakowiak@linux.intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210104155343.GA26034@michal-desk>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_104819_561804_EACEC71F 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

FTrace does not parse NVMe commands consistently. There are commands
that are being parsed in detail and commands for which the trace log
contains only raw bytes of command dwords. Add detailed parsing of
format nvm admin command to make the trace log more consistent and
human-readable.

Signed-off-by: Michal Krakowiak <michal.krakowiak@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvme/host/trace.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5c3cb6928f3c..e0400de713b5 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -102,6 +102,23 @@ static const char *nvme_trace_get_lba_status(struct trace_seq *p,
 	return ret;
 }

+static const char *nvme_trace_admin_format_nvm(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 lbaf = cdw10[0] & 0xF;
+	u8 mset = (cdw10[0] >> 4) & 0x1;
+	u8 pi = (cdw10[0] >> 5) & 0x7;
+	u8 pil = cdw10[1] & 0x1;
+	u8 ses = (cdw10[1] >> 1) & 0x7;
+
+	trace_seq_printf(p, "lbaf=%u, mset=%u, pi=%u, pil=%u, ses=%u",
+			lbaf, mset, pi, pil, ses);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -159,6 +176,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_admin_get_features(p, cdw10);
 	case nvme_admin_get_lba_status:
 		return nvme_trace_get_lba_status(p, cdw10);
+	case nvme_admin_format_nvm:
+		return nvme_trace_admin_format_nvm(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
--
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
