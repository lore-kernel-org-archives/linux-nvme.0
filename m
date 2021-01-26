Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 17:50:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A7C22472
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 17:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A7C22472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VDbmkCOVgj5UPWv0Rj0nRNl0dVAHUbe21GA4809+dtE=; b=C03nBKw/VS1Fi/H9g4U9e5cVPv
	mCyqn/2tEU6I0qsKtewQzbvHnNJIB0qfN5/OB97XtDfjLWtsnGlHJ8OtgNm4eKnxNt+VX5qjWpK8t
	2mxrhwcZmSXezwix5Xo55j8i+nhM/8SIXEnIk3yGHC/4hrHRQ52Gk37KZ469FElU8hjzUljfHCdFV
	lA+EbOaXK4JuGfsek2oY3LhIVb5CKZ5jbaSA9+Ony+3umPj3MOcJC1Ap0ZYo7N5hFkaHZ3CRbvK/W
	27kX5haZTdS4zTJFiqdpCCosh/tff5gkeb1t0C5TOlqtX4M5yNRs/+QLWXuPtKuL9Nb02wNCPe0Xo
	sZ7E8OHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4STv-0001rt-DK; Tue, 26 Jan 2021 17:50:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4STn-0001rP-8P
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 17:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611683415; x=1643219415;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mv3WEn2pcMjWOdfGVl7WT3gSU4WDy6fGoCjl3MPHc1g=;
 b=bFCN1sCsYvD3b1khRsGmy9k40sgmnHf98NwE3zeppH692f6SQVnuTJ0M
 WRNHTdDD9EP/HZiwr8wCMvi5itHeLgaQBMMh00Ju2+/saDIos/9eLGvO0
 9Ih5TSl+7LIdAiID+9YNIqXTUKTNiMiwOwKND0aqlWpq+FAotplP9jPc7
 eENdYRt3eFvitOsCHQ29hJMTbfdB5z1Obs8tqm+v9Qe3eWizF1FNJajan
 8h+g7I1D8xaZ0ATrQHupGCropc5phZtP5kmYIk5wblkmbp0om6nDo1fHy
 CjaKB6o8XqkLirqU1mmktRIPxCybMS6rFzA1k7FMgFDD6mMLyt3kMKSnw Q==;
IronPort-SDR: PICGMO4hzUs/TN8bTV4GN4lJiFJaP3+gX6dQRMAjWdSzVG6CQxmq/zDqhByj/cpVdWc7sADmPo
 V/gJwwEohNfFgXruPA+G0l713DG7LSXj1qlWMWC2XJ0PbiGR/Ym0vOiN7hI9tW00EOetdn75bP
 KABcPJ7tsJEcuO44o5mnpsqyzF1cJgiYIs+B+5AEzvSErYYVNOgMqTm22KdEku0jNN+ZqMGIQb
 7SBclVxNg2cpFptMeufOAmIO11miUuBWrP1PMMo4ZIxI+5YyUEJ0YEsH5LT+y0YPRSFFm6Z+wC
 wBw=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; d="scan'208";a="159547976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 01:50:12 +0800
IronPort-SDR: bTDDhdX6MJqOVQCaH5LEwXrIHEzBGLiryiJ6VIWiohv7pd138aMSA93FTZaqQvidNHEEegNrJj
 psAgN6sgj1QvuLwttmaBU5CqSi/7eklpyn5CHrYq8+cufxioyNDOXwa87p08lj3+GCTFB+twZO
 a757PrkDHriA7gSWjzovzSPJhtpDVnWQ8ddpjX613aWDnayU9XzbKqVTOG15x4OZpAb1RFu1wv
 tJHobbEcqlnWvuV8bzfaGI7jE4JA4zp1DulPEYzJEF5fGwOjL17XSevOdNTwew+xg2q8t8+0VZ
 6HDPOO7x1nc9dpJ0woHbRxto
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 09:32:35 -0800
IronPort-SDR: +OMEKigUfdY1CdtekM1oktsOyUYGzgoEqidNNzhZMZBCRtQoECS+lxNljOQE3cgTJw+cC+fOKz
 W9YNDhG7onP3UOEBnO56bKyKwUsrZ7JG/KIxxvcP7fX7ru9gDBzwBuPPzTpJjC1oO5KE+HcvoP
 1QN4S7ciI8iFCBSvknRsnl/7aRCKRRNJHLcdRJrjJaizl7gQyTxMZF94ilwzWMojNDQe5KPeJf
 T00GhCMC0TFYv9dRLYP9eDADHFYkIVI+1bbL4bt7PbPUV8GNHzUuehGyz8pfOyFIHDRQZgTDBa
 +1U=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2021 09:50:11 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: add tracing of zns commands
Date: Wed, 27 Jan 2021 02:50:00 +0900
Message-Id: <46eeed2fcf2530d02fe5727a0a91a6e4675f6edd.1611683161.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_125015_657020_10180338 
X-CRM114-Status: GOOD (  14.84  )
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
Cc: linux-block@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When support for the NVMe ZNS commands was merged, tracing of these has
been omitted.

Add nvme_cmd_zone_mgmt_send, nvme_cmd_zone_mgmt_recv as well as
nvme_cmd_zone_append to the nvme driver's tracing facility.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/nvme/host/trace.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |  6 +++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5c3cb6928f3c..9f9b6108de7d 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -131,6 +131,35 @@ static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u8 zsa = cdw10[12];
+	u8 all = cdw10[13];
+
+	trace_seq_printf(p, "slba=%llu, zsa=%u, all=%u", slba, zsa, all);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u32 numd = get_unaligned_le32(cdw10 + 8);
+	u8 zra = cdw10[12];
+	u8 zrasf = cdw10[13];
+	u8 pr = cdw10[14];
+
+	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u, pr=%u",
+			 slba, numd, zra, zrasf, pr);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -171,9 +200,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 	case nvme_cmd_write_zeroes:
+	case nvme_cmd_zone_append:
 		return nvme_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvme_trace_dsm(p, cdw10);
+	case nvme_cmd_zone_mgmt_send:
+		return nvme_trace_zone_mgmt_send(p, cdw10);
+	case nvme_cmd_zone_mgmt_recv:
+		return nvme_trace_zone_mgmt_recv(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bfed36e342cc..325dcdd221de 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -697,7 +697,11 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
+		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
+		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
+		nvme_opcode_name(nvme_cmd_zone_append))
+
 
 
 /*
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
