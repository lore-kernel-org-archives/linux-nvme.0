Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F2CA9EC5
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FYK1D9hAWXYaLafWV0p9wbAKSpE+RrReSAffAQBv3s=; b=F0uvIhJpdFtvFYpw9X9wR2SSb+
	qxtRifrBd/js75cZwqticbcfJYTYxctv6TDngPWVGZ3vzFtkwEWK98TrfPXGmWVANn3YrBTkg0pRM
	sYzCMEM051npGhPG9z5PiLj3rkWA+6q6SP5m0SgtvTPOAmCLpMa/2a818Dq0wFBBkPJQKOdqARWkE
	ptZbP9B3V9JGZ+oKU7oC004m4Dn3tVhaK1Q8bh04ZIQDUni84kilya3Bd9ybzIw0WGO8g8mGIhH2E
	UAJClIu2qP0TjtYBw/w9H3edTNAOjG1cGm2MvGjKV7PPI/GwJXkZNJ+YDU8gNYwAfkHNqGsHbmVJP
	WrrEAU0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8t-0000000BmVO-1IIq;
	Tue, 13 Oct 2026 02:21:27 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8p-0000000BmSV-3DEj
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858077; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9FYK1D9hAWXYaLafWV0p9wbAKSpE+RrReSAffAQBv3s=;
	b=n6CreX8dGezmLE62/osuALxHZgFq1y1/W08ylHwYPPA7deZFvn54/wQLLCi7WIvn6p+ill+zaBjWzdVOEhwSnZeWj9c2i2e0L1sDhCphMo9fi7J0koJSfhXlG3lN+r2GEU/oticaRMqzB25/s0vHQp2e7l9lOMBjV1Y4RCufLNM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCjz2ET_1791858076;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCjz2ET_1791858076 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:16 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 01/11] nvme: add the FDP wire structures for the I/O management send command
Date: Tue, 13 Oct 2026 10:20:59 +0800
Message-ID: <20261013022109.1507911-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192124_038998_E521F8BB 
X-CRM114-Status: GOOD (  10.82  )
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

Add the command definition of the I/O Management Send command (opcode
0x1D) to the command opcode enum and the command union, together with
its management operation, and the log page identifiers of the FDP
pages that the target serves, so that initiators and targets share
the same wire format.

No in-kernel initiator uses the command yet; the NVMe target FDP
support that consumes these structures follows in this series.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/nvme.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d9..9141fd386012b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -967,6 +967,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_io_mgmt_recv	= 0x12,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_io_mgmt_send	= 0x1d,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -989,6 +990,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
 		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_zone_append))
@@ -1245,6 +1247,23 @@ enum {
 	NVME_IO_MGMT_RECV_MO_RUHS	= 1,
 };
 
+enum {
+	NVME_IO_MGMT_SEND_MO_RUH_UPDATE	= 1,
+};
+
+struct nvme_io_mgmt_send_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__le16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			mo;
+	__u8			rsvd10;
+	__le16			mos;
+	__le32			rsvd11[5];
+};
+
 struct nvme_fdp_ruh_status_desc {
 	__le16			pid;
 	__le16			ruhid;
@@ -1416,6 +1435,9 @@ enum {
 	NVME_LOG_FEATURES	= 0x12,
 	NVME_LOG_RMI		= 0x16,
 	NVME_LOG_FDP_CONFIGS	= 0x20,
+	NVME_LOG_FDP_RUH_USAGE	= 0x21,
+	NVME_LOG_FDP_STATS	= 0x22,
+	NVME_LOG_FDP_EVENTS	= 0x23,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
@@ -1437,6 +1459,7 @@ struct nvme_supported_features_log {
 
 enum {
 	NVME_FIS_FSUPP	= 1 << 0,
+	NVME_FIS_EGSCPE	= 1 << 23,
 	NVME_FIS_NSCPE	= 1 << 20,
 	NVME_FIS_CSCPE	= 1 << 21,
 };
@@ -2016,6 +2039,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_io_mgmt_send_cmd ims;
 	};
 };
 
-- 
2.43.7


