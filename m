Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B7DC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYy70I6PufCUUuTetR5ugq893/W+TKCjqMalhSchIEE=; b=JEf2PFDjmu4/52spTQAhom8EQR
	2UeuSDDP6rFi15P3YSAgASX00j4itbBmxNLcOO/Z0YTSyMeYW45nvwzS0giDY3hkWX0eqhR0n+v6S
	TrmREUGNSZ7iwQCSrRphNyVhkkZ4W5+fPwNOo515D6PYbcpXJYEWeaDLkMAlzCH2k+V8dehKm+Exy
	mOz3l5AzTisozfI7UMXSNu4wmOcjNXRLy/1LOSh1uqc5Tt1439mAPB74CnpUJLoX4I3AeFIMjEvci
	zXelCMce8bt/8L8whbz/FVbZiHwa1isb/dKg8bhLNeHjVmiMkRQJauowaH6Oe34NgfX3OheAnAtfC
	CfY4Am2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFSB-00000008VYq-3tUn;
	Wed, 28 Feb 2024 08:38:15 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFS9-00000008VWZ-1VID
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 08:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709109491; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OYy70I6PufCUUuTetR5ugq893/W+TKCjqMalhSchIEE=;
	b=QCPLANBE9OYsuOvijUY/+5IHuEjQnSadJjep2fjCuTp5/9+W68sMgkfKUce1OHeGizqs+Yell7TxYpuqcNtFSkx6GjN5VHYzQPGWNcSUKy5/INtrP4NQHuBp2IzFXPDvY444E9nDGAYZs08JX7GPoBROgILXHudV7gwD96nSwok=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1PJiQh_1709109486;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1PJiQh_1709109486)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 16:38:10 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/2] nvmet: add tracing of zns commands
Date: Wed, 28 Feb 2024 16:37:55 +0800
Message-ID: <20240228083755.125259-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228083755.125259-1-kanie@linux.alibaba.com>
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_003813_715298_73AFD2E4 
X-CRM114-Status: UNSURE (   8.10  )
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

Add nvme_cmd_zone_append, nvme_cmd_zone_mgmt_send and
nvme_cmd_zone_mgmt_recv parse to nvme target tracing.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/trace.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index ca537fae3730..8d1806a82887 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -119,6 +119,67 @@ const char *nvmet_trace_parse_admin_cmd(struct trace_seq *p,
 	}
 }
 
+static const char *nvmet_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
+{
+	static const char * const zsa_strs[] = {
+		[0x01] = "close zone",
+		[0x02] = "finish zone",
+		[0x03] = "open zone",
+		[0x04] = "reset zone",
+		[0x05] = "offline zone",
+		[0x10] = "set zone descriptor extension"
+	};
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	const char *zsa_str;
+	u8 zsa = cdw10[12];
+	u8 all = cdw10[13];
+
+	if (zsa < ARRAY_SIZE(zsa_strs) && zsa_strs[zsa])
+		zsa_str = zsa_strs[zsa];
+	else
+		zsa_str = "reserved";
+
+	trace_seq_printf(p, "slba=%llu, zsa=%u:%s, all=%u",
+		slba, zsa, zsa_str, all);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvmet_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
+{
+	static const char * const zrasf_strs[] = {
+		[0x00] = "list all zones",
+		[0x01] = "list the zones in the ZSE: Empty state",
+		[0x02] = "list the zones in the ZSIO: Implicitly Opened state",
+		[0x03] = "list the zones in the ZSEO: Explicitly Opened state",
+		[0x04] = "list the zones in the ZSC: Closed state",
+		[0x05] = "list the zones in the ZSF: Full state",
+		[0x06] = "list the zones in the ZSRO: Read Only state",
+		[0x07] = "list the zones in the ZSO: Offline state",
+		[0x09] = "list the zones that have the zone attribute"
+	};
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u32 numd = get_unaligned_le32(&cdw10[8]);
+	u8 zra = cdw10[12];
+	u8 zrasf = cdw10[13];
+	const char *zrasf_str;
+	u8 pr = cdw10[14];
+
+	if (zrasf < ARRAY_SIZE(zrasf_strs) && zrasf_strs[zrasf])
+		zrasf_str = zrasf_strs[zrasf];
+	else
+		zrasf_str = "reserved";
+
+	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u:%s, pr=%u",
+		slba, numd, zra, zrasf, zrasf_str, pr);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		u8 opcode, u8 *cdw10)
 {
@@ -126,9 +187,14 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 	case nvme_cmd_write_zeroes:
+	case nvme_cmd_zone_append:
 		return nvmet_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvmet_trace_dsm(p, cdw10);
+	case nvme_cmd_zone_mgmt_send:
+		return nvmet_trace_zone_mgmt_send(p, cdw10);
+	case nvme_cmd_zone_mgmt_recv:
+		return nvmet_trace_zone_mgmt_recv(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.43.0


