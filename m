Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E9C54798
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zAkRH3m6LfPq2F8RMCdou0CnwDWYwpW8nB66E5Rc7u8=; b=41r/nbe26aQiagQbLiHYs3c+fD
	zlK+k01h6LQLsIGCu21MSHIPdYtK1n9JtF8jaqox46O4Ls44DW0oLbauwEXDJ9KwaNZ/idL/8ejas
	zqH6iDgPDv5dTFuX6r1okKwKbRzfQ4if2VW/cwAEhQLkYdnT3ve5Q9vzfsYb7jEcU4BCXNwd6C39i
	/A9JVSSklyzaZBZ58EABvxmYISB3r24aa31QvZKX5saRg7SDNdbwYdNwOUyCCS8CnZjv2Hx9L59nG
	Fi4vZCgcx86Kmi08rqAibnIR+hoA0p9vNgII16j9EcccLQ3JFJKpHRXTZW5KPI41cISbiL9m6/iMO
	LCvYduoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jR-00000007ibd-1J7N;
	Wed, 28 Feb 2024 02:31:41 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jL-00000007iYZ-2BQU
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087493; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zAkRH3m6LfPq2F8RMCdou0CnwDWYwpW8nB66E5Rc7u8=;
	b=dGGNNlyS9Rqvhn+oaQhlQJNOQvpgWWt/9hjG9EOpRxq1APt+fKuMIOkwlrvA4udKf8ms9h9zgqdJs5X2fpu/A+WnncUoxzqZhd7yxc6cW4oTObf7SrdV1F9yKUZliNXsNJwZgsO7aD3WtfoIu5HmJ0NDfQAgEtHeEUGdLuOH9/4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1OIIg9_1709087488;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1OIIg9_1709087488)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:31:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/2] nvmet: add tracing of authentication commands
Date: Wed, 28 Feb 2024 10:31:18 +0800
Message-ID: <20240228023118.84959-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228023118.84959-1-kanie@linux.alibaba.com>
References: <20240228023118.84959-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_183135_740836_83469F09 
X-CRM114-Status: UNSURE (   7.74  )
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
index 6604e5fe57d8..49e5f35b2723 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -210,6 +210,34 @@ static const char *nvmet_trace_fabrics_property_get(struct trace_seq *p,
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
@@ -229,6 +257,10 @@ const char *nvmet_trace_parse_fabrics_cmd(struct trace_seq *p,
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


