Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518F606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AsY8rr+K;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=myKUxy+V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qOdOlNG1Yfv2s/xjB4uLj4fj4RYCUu1Qd16U83V7sdk=; b=AsY8rr+KcZdYpD
	OYAQ03Zk2anTB5yqVePBtxTRIkLtii9/Yh++PywDcxe2ndHBWaloevzXjsNTDMgiMPuDFiOTkzLgK
	xx7q+YjlawnQWwZB57LDGaCVHPFPrMVru9c3e3Ae27r8w/L0oEV7SnY1ZHVvf4AgMncwAI+jQ8poI
	ZD+novoJidL+m5lIPGGceBhHrA7Ti/012HxN29vPsENjT+NIrdr0JCpdt09vuORmVXrdocOCM5EMz
	uaF22XhxLNbOgyeZ2k1CjVMjaO1FC9o9vTpFR1Xn+Uu8/SHOx/4CE5gAmJgbDiRj0cLAzdjS/7Kjk
	VTf/B/5xrspVKxNZLWkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFt-000000099G1-08VL;
	Thu, 29 Oct 2026 12:29:17 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFq-000000099Di-1tTa
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276949; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qOdOlNG1Yfv2s/xjB4uLj4fj4RYCUu1Qd16U83V7sdk=;
	b=myKUxy+VZpdrTdvgi6YLaNFhTQcICriqbFp7dRcMtkPoYBITLcUq772ktrEtMphCdQq0kW37XQQUSwIoGUdWk3N0CPOD4GRkwfCqw0PUaYwC/PNKDA8d/P/8yf/5g8Q1izqmsMt+Cm2nwiUFlF3ssduv0Q4vbCfI69A9yp83yWI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjOyat_1793276948;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjOyat_1793276948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 01/12] nvme: add the FDP wire structures for the I/O management send command
Date: Thu, 29 Oct 2026 20:28:22 +0800
Message-ID: <20261029122833.284572-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052914_691723_5B751CA2 
X-CRM114-Status: GOOD (  10.87  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the command definition of the I/O Management Send command (opcode
0x1D) to the command opcode enum and the command union, together with
its management operation, and the log page identifiers of the FDP
pages that the target serves, so that initiators and targets share
the same wire format.

No in-kernel initiator uses the command yet, but the FDP support that
consumes these structures is following.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/nvme.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b3..ad77af010d37 100644
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


