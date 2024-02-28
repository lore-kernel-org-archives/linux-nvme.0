Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57FC54E41
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2f04P9YrVPsjX4NOHZjl1ng9fufpQmpKwP1iQqcr5/w=; b=2zuJaMpS2jKr8P/xZdDmi/rnl6
	Hi/gy652DTG8M8MIrRAWBnCITJh8lXPaLF4MDACT76TjJYWClSJYDtj9aQppmUU2GQP66v+rDKeQw
	ByL4YZLjw+dEpr9ZzlwMH87JNB8MHebTHlKSZXH4n9QsA72toDOOiJ5wf1a1OMs3b2z8Jub3RXvzk
	UIVvJeTExKUEG4oA/o2JjQiHhT52kSLlYVptXPnY4enqImlU2hRfwhbsOR/DzlXI2Kn+ft4mG3dsj
	R1B+T5j1ZA2NT3hqWzWwC51wOjFb0bsDT6wkXGhlnP/YiLYND95t/HXpeb7Ib/wcu3+oOZkC628rK
	b7zwKJMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFSA-00000008VXe-0p8N;
	Wed, 28 Feb 2024 08:38:14 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFS7-00000008VWI-2ESU
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 08:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709109489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2f04P9YrVPsjX4NOHZjl1ng9fufpQmpKwP1iQqcr5/w=;
	b=OQ8nzBKUJXg6m1e1JcETfpYJhkak83bl+bf0y81UaxKJcIf3Wkdx1b621G4HtSWMGmldlfGgtO5j/P5xJjrJvGo23rLwY2CK09uuTN6HsRrkJK+9Lmr3SwKLSQOoPG2PbbFnNSWHoo/o1a8Hy4g8lJyY/tf93GNBgizmBaLHvm0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1PMDpX_1709109482;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1PMDpX_1709109482)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 16:38:06 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/2] nvmet: add tracing of authentication commands
Date: Wed, 28 Feb 2024 16:37:54 +0800
Message-ID: <20240228083755.125259-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228083755.125259-1-kanie@linux.alibaba.com>
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_003811_888852_2E072796 
X-CRM114-Status: UNSURE (   7.84  )
X-CRM114-Notice: Please train this message.
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

Add nvme_fabrics_type_auth_send and nvme_fabrics_type_auth_receive
to the nvme target's tracing facility.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/trace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 6ee1f3db81d0..ca537fae3730 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -176,6 +176,34 @@ static const char *nvmet_trace_fabrics_property_get(struct trace_seq *p,
 	return ret;
 }
 
+static const char *nvmet_trace_fabrics_auth_send(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 spsp0 = spc[1];
+	u8 spsp1 = spc[2];
+	u8 secp = spc[3];
+	u32 tl = get_unaligned_le32(spc + 4);
+
+	trace_seq_printf(p, "spsp0=%02x, spsp1=%02x, secp=%02x, tl=%u",
+			 spsp0, spsp1, secp, tl);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+static const char *nvmet_trace_fabrics_auth_receive(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 spsp0 = spc[1];
+	u8 spsp1 = spc[2];
+	u8 secp = spc[3];
+	u32 al = get_unaligned_le32(spc + 4);
+
+	trace_seq_printf(p, "spsp0=%02x, spsp1=%02x, secp=%02x, al=%u",
+			 spsp0, spsp1, secp, al);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
 static const char *nvmet_trace_fabrics_common(struct trace_seq *p, u8 *spc)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -195,6 +223,10 @@ const char *nvmet_trace_parse_fabrics_cmd(struct trace_seq *p,
 		return nvmet_trace_fabrics_connect(p, spc);
 	case nvme_fabrics_type_property_get:
 		return nvmet_trace_fabrics_property_get(p, spc);
+	case nvme_fabrics_type_auth_send:
+		return nvmet_trace_fabrics_auth_send(p, spc);
+	case nvme_fabrics_type_auth_receive:
+		return nvmet_trace_fabrics_auth_receive(p, spc);
 	default:
 		return nvmet_trace_fabrics_common(p, spc);
 	}
-- 
2.43.0


