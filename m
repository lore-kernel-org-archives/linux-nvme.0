Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F57C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B933164DBA
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 07:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B933164DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gMXN9aguFJqKxmBFvyHDcZ2R5veWyo9I+EqP6ATQ06Y=; b=08dG32LIGuPg4qmC/JKDXZ/an
	XKc/vi566DLLwKqcoe+3rJwgHefFMTCBRb5MFwOVb6TVvnGFpaztghidb/R9y0YYc812x7kaVtSmv
	6s1GrXp7ERMjMkVMVxes+pP9kuhhaTO4Q7TQVrmxkHh7trDxCtUmVuoUTgU1bDEgYQ6bZCwG/ISId
	oxZ53qTyejh4z0+jfY5LASI11dTTUQSxRhE5gTtda7csMtpxzFnHRJamoPFh0+FV6V9baHwfZeDu4
	r2iPpIXvB69Z8xJMyoCdeT0eKkWu/1XwBUWWSLtntt/GtM3+G1v6wG3z3KqXsiR+yRJh2aiHIrC7N
	dAyn40z1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lASdu-0005kG-91; Fri, 12 Feb 2021 07:13:30 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lASdr-0005jQ-Pn
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 07:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613114007; x=1644650007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z8eqEXIfTqpwbEkvm7Y27cGIu5fA93vYGC6CgAQNaUk=;
 b=lLAPhQusneDRkOLybTt5qhc7fbE0bAL/yFcrHccIWNUNh+6Z4HtokPeA
 nJKd+2q4kVgg631jdUlz0A+v2fYQp6Z9Loxaiei1KlntZiPkQjArwJZcj
 dH9n26AkiOwiyO88oLbwHMN8d5IApsOXYrpICpTcC/Z/XkgCfB0OlwVMV
 7waFVNwhCCLS8AH0FStAcy38sz+f92FpYKstyxvR/854YsZlFoAOzOp87
 1geb4UAuw7RiowzM+JB9StcWxElWlcusZsEW1D3u6cSPzVjNCPv49vj7d
 KJZAbY36iKBaFShxZL7yABdbjSBJtx+m/n7sBEc66VsW2OdUNlnuF47BB A==;
IronPort-SDR: R3BquHIrLKBInr4LMQz7WusS1O+4vqkz/NlekZc0YAY5Z7djEVoEZug4CcNJR2vBkQdwkBDzji
 5Uv3vIqQW8CBnLEYFiEIr46WS/pQ87gUIWLSrtH1/sNnIRTqOery6LXYc1iJ67TaVQUlA2ZqUn
 fT+r5U4me8oub8+yS8C3NIQy/cLrWb2+tPjaZe959bfzHITEv1SqRf5b6pAbHmridXbwICLln2
 BvTlsQbq6mq5MJNsPUmADHZptcT28s8ZdW13U09JuTG49fmsticDkMOlmsi+3xIrKXeMmSir1b
 ZN8=
X-IronPort-AV: E=Sophos;i="5.81,173,1610380800"; d="scan'208";a="159811813"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 15:13:25 +0800
IronPort-SDR: SNLMzwt45IG4xalWy6mi27iMF989srCLPZL82IKSNm6ZmgdFf3M90Y9OxdvuPRFI/4YI277RyG
 l2ByiSZKaQu/JQwJ29jn9L/fhnFLPRod0B9UcHsMraVt0ZcTumL7xfcf0azijfzcCqXJOc6QFv
 OCNiFvyh/y12fTWbdwS/+tT4HK8bHrIdkkHhr1gobyxY8s5KpwIUSVhBct9EK0aO4I/wnt0vrl
 fJRs/RzZHTlQ/EpCaXtzvqITDT/benY9vDlfxyAuyelW0WeQSXXGKCs/bWBeQpcS1Fv9/JDGmb
 lhhaFXAFeef4Ut8B6dRbLYoi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 22:55:16 -0800
IronPort-SDR: AAgqYP1pcme7tvpKdnnXAXwsO/J7rsmoVlnYqevfibYSH3cliKbHN0J5ySwECTVwYSkzi/3aS4
 zmf2tOcRRdRMvzrJhzwHwdltYga/bAJn0wI9AeRl46/rmpjqq4ccY6gokl2C3idVEV0XnLdTEd
 jLKwE7d0zW6Za+GERVw0GHIXZHnhKr+O0qTkQUD1QO0WzazwKzVeOM/OXkU706cRqFmPs4FU6a
 LPBOVV5UAF6+NOmnKtUNyF4HpHiH59nod1en3rbLLi738jXCBSdjDdJ9JAZA1AX5+JqS0sWoUC
 QNo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2021 23:13:26 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: aligned all enum values
Date: Thu, 11 Feb 2021 23:13:05 -0800
Message-Id: <20210212071305.39901-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210212071305.39901-1-chaitanya.kulkarni@wdc.com>
References: <20210212071305.39901-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_021327_971284_CD4E182D 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
Cc: mgurtovoy@nvidia.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add extra tabs and align the values that matches the rest of the
enum definitions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/nvme.h | 108 +++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3f162e34a2c0..c0d7148f893a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1042,62 +1042,62 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_get_lba_status))
 
 enum {
-	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
-	NVME_CQ_IRQ_ENABLED	= (1 << 1),
-	NVME_SQ_PRIO_URGENT	= (0 << 1),
-	NVME_SQ_PRIO_HIGH	= (1 << 1),
-	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
-	NVME_SQ_PRIO_LOW	= (3 << 1),
-	NVME_FEAT_ARBITRATION	= 0x01,
-	NVME_FEAT_POWER_MGMT	= 0x02,
-	NVME_FEAT_LBA_RANGE	= 0x03,
-	NVME_FEAT_TEMP_THRESH	= 0x04,
-	NVME_FEAT_ERR_RECOVERY	= 0x05,
-	NVME_FEAT_VOLATILE_WC	= 0x06,
-	NVME_FEAT_NUM_QUEUES	= 0x07,
-	NVME_FEAT_IRQ_COALESCE	= 0x08,
-	NVME_FEAT_IRQ_CONFIG	= 0x09,
-	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
-	NVME_FEAT_ASYNC_EVENT	= 0x0b,
-	NVME_FEAT_AUTO_PST	= 0x0c,
-	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
-	NVME_FEAT_TIMESTAMP	= 0x0e,
-	NVME_FEAT_KATO		= 0x0f,
-	NVME_FEAT_HCTM		= 0x10,
-	NVME_FEAT_NOPSC		= 0x11,
-	NVME_FEAT_RRL		= 0x12,
-	NVME_FEAT_PLM_CONFIG	= 0x13,
-	NVME_FEAT_PLM_WINDOW	= 0x14,
-	NVME_FEAT_HOST_BEHAVIOR	= 0x16,
-	NVME_FEAT_SANITIZE	= 0x17,
-	NVME_FEAT_IOCS_PROFILE	= 0x19,
-	NVME_FEAT_SW_PROGRESS	= 0x80,
-	NVME_FEAT_HOST_ID	= 0x81,
-	NVME_FEAT_RESV_MASK	= 0x82,
-	NVME_FEAT_RESV_PERSIST	= 0x83,
-	NVME_FEAT_WRITE_PROTECT	= 0x84,
-	NVME_FEAT_VENDOR_START	= 0xC0,
-	NVME_FEAT_VENDOR_END	= 0xFF,
-	NVME_LOG_ERROR		= 0x01,
-	NVME_LOG_SMART		= 0x02,
-	NVME_LOG_FW_SLOT	= 0x03,
-	NVME_LOG_CHANGED_NS	= 0x04,
-	NVME_LOG_CMD_EFFECTS	= 0x05,
-	NVME_LOG_DEVICE_SELF_TEST = 0x06,
-	NVME_LOG_TELEMETRY_HOST = 0x07,
-	NVME_LOG_TELEMETRY_CTRL = 0x08,
-	NVME_LOG_ENDURANCE_GROUP = 0x09,
+	NVME_QUEUE_PHYS_CONTIG		= (1 << 0),
+	NVME_CQ_IRQ_ENABLED		= (1 << 1),
+	NVME_SQ_PRIO_URGENT		= (0 << 1),
+	NVME_SQ_PRIO_HIGH		= (1 << 1),
+	NVME_SQ_PRIO_MEDIUM		= (2 << 1),
+	NVME_SQ_PRIO_LOW		= (3 << 1),
+	NVME_FEAT_ARBITRATION		= 0x01,
+	NVME_FEAT_POWER_MGMT		= 0x02,
+	NVME_FEAT_LBA_RANGE		= 0x03,
+	NVME_FEAT_TEMP_THRESH		= 0x04,
+	NVME_FEAT_ERR_RECOVERY		= 0x05,
+	NVME_FEAT_VOLATILE_WC		= 0x06,
+	NVME_FEAT_NUM_QUEUES		= 0x07,
+	NVME_FEAT_IRQ_COALESCE		= 0x08,
+	NVME_FEAT_IRQ_CONFIG		= 0x09,
+	NVME_FEAT_WRITE_ATOMIC		= 0x0a,
+	NVME_FEAT_ASYNC_EVENT		= 0x0b,
+	NVME_FEAT_AUTO_PST		= 0x0c,
+	NVME_FEAT_HOST_MEM_BUF		= 0x0d,
+	NVME_FEAT_TIMESTAMP		= 0x0e,
+	NVME_FEAT_KATO			= 0x0f,
+	NVME_FEAT_HCTM			= 0x10,
+	NVME_FEAT_NOPSC			= 0x11,
+	NVME_FEAT_RRL			= 0x12,
+	NVME_FEAT_PLM_CONFIG		= 0x13,
+	NVME_FEAT_PLM_WINDOW		= 0x14,
+	NVME_FEAT_HOST_BEHAVIOR		= 0x16,
+	NVME_FEAT_SANITIZE		= 0x17,
+	NVME_FEAT_IOCS_PROFILE		= 0x19,
+	NVME_FEAT_SW_PROGRESS		= 0x80,
+	NVME_FEAT_HOST_ID		= 0x81,
+	NVME_FEAT_RESV_MASK		= 0x82,
+	NVME_FEAT_RESV_PERSIST		= 0x83,
+	NVME_FEAT_WRITE_PROTECT		= 0x84,
+	NVME_FEAT_VENDOR_START		= 0xC0,
+	NVME_FEAT_VENDOR_END		= 0xFF,
+	NVME_LOG_ERROR			= 0x01,
+	NVME_LOG_SMART			= 0x02,
+	NVME_LOG_FW_SLOT		= 0x03,
+	NVME_LOG_CHANGED_NS		= 0x04,
+	NVME_LOG_CMD_EFFECTS		= 0x05,
+	NVME_LOG_DEVICE_SELF_TEST	= 0x06,
+	NVME_LOG_TELEMETRY_HOST		= 0x07,
+	NVME_LOG_TELEMETRY_CTRL		= 0x08,
+	NVME_LOG_ENDURANCE_GROUP	= 0x09,
 	NVME_LOG_PRELAT_PER_NVMSET	= 0x0a,
 	NVME_LOG_PRELAT_EVENT_AGG	= 0x0b,
-	NVME_LOG_ANA		= 0x0c,
-	NVME_LOG_PERSISTENT_EVENT   = 0x0d,
-	NVME_LOG_DISC		= 0x70,
-	NVME_LOG_RESERVATION	= 0x80,
-	NVME_LOG_SANITIZE	= 0x81,
-	NVME_LOG_ZONE_CHANGED_LIST = 0xbf,
-	NVME_FWACT_REPL		= (0 << 3),
-	NVME_FWACT_REPL_ACTV	= (1 << 3),
-	NVME_FWACT_ACTV		= (2 << 3),
+	NVME_LOG_ANA			= 0x0c,
+	NVME_LOG_PERSISTENT_EVENT	= 0x0d,
+	NVME_LOG_DISC			= 0x70,
+	NVME_LOG_RESERVATION		= 0x80,
+	NVME_LOG_SANITIZE		= 0x81,
+	NVME_LOG_ZONE_CHANGED_LIST	= 0xbf,
+	NVME_FWACT_REPL			= (0 << 3),
+	NVME_FWACT_REPL_ACTV		= (1 << 3),
+	NVME_FWACT_ACTV			= (2 << 3),
 };
 
 /* NVMe Namespace Write Protect State */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
