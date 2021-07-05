Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC52C07E95
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287906138C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287906138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KyJ5js6IsFu+9fWJJYEpjfhrHjEe7kJ/6mFI+hD6cws=; b=L0A4sHmTZEFIoL
	Jthl2qbYyZ1IoNEcPcLWn5h9drY78okiFQB229eFfTRNKjcoucQtY+HcfwQYQznyJoPA3RpXN9jqN
	+MjZ6Sg1U8L3lfdDxwWPYnhr0N8dBIi85fcRA0OKsIOGIrQJyhsGfjg1rgaQiT6IxPZBGGSzRh/aM
	sSgW7AC5t4IL5ptz6+YsK3cHCwAhO/ZuZUE4o2phWANKsecR8/SYf4JwfMNaUYeGmYmE/hc4E5H5e
	t7p3ZI/AVgGgHJ/Zljz3twvujn9hTH7oCQQPXfdS/iFJLiBWcRJGdetLxA/Cv0CJvj5Y6wJkDt9I8
	2xMPW153Ioj1262CnftQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0F5U-007Ypt-Gm; Mon, 05 Jul 2021 03:16:00 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0F5K-007Yoo-Vq
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 03:15:52 +0000
Received: by mail-pf1-x434.google.com with SMTP id 21so15544282pfp.3
 for <linux-nvme@lists.infradead.org>; Sun, 04 Jul 2021 20:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U5Nth9SgQ77j/I0cvVXxw/uZt+dCFB0/dH/7DKp8P2w=;
 b=VL2VJ0CEaHDHL9aaXYh03XmONv5gORdK7ObyqZuimX/+rEs//0x9EFU1HJbdjCkFHJ
 E8YvEfM9eFES6B/4/SWtIlaoiDx7TEVsDbu6F9cvLGB235+zynXCKQzE3eu9CHPEjxDq
 8COHMYuPVbGgPjnjGnzVFD0OXOGJILqejMvrThV4F7yPwdgcViQ5AhMb9F4OB8MCTCln
 Py8klepG90YbBptuu6qHahRaYQeQhUo/2X8kqk0abd5mZD4odnVk5WukV+KV7/vuXdPu
 ropT/vtaJXHR6AhRME7gF+K+BCFBrVwPPvcgswTjMeOOtDTPYXmC6riOHlFIJ6TCuIr6
 xgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U5Nth9SgQ77j/I0cvVXxw/uZt+dCFB0/dH/7DKp8P2w=;
 b=bwC/5IQwPCk21t8vZaMxPgHYx5+V6IX87z/+ony+aQ/Bcy4lFa2lRnOFjH77YaRkPo
 XtGntomIYj46Tmm/HtHegCtBDQFLTVZVl5fIrSFGgxohlQXHbyGq+kghl5FnBOdFM1k8
 t1/8GgJHt6Vppmtnp6ZJc+HFYWBcze/yDNc1CJqD06gDrTLFNCa+/qz6b2WCDxJv4zaK
 Gh9iuN/Wihnh0s08uIv/iqW1FxoYokmW3Xajz2NsddRXHASYGau4fx7+4iotGr5T74JJ
 qR/9/EF5Y2+J1eSWdG3T82OOljJ3fjPbutZitTSwvRHDIH+oaWUy8eN6Zy5TkQ7m9ci5
 7lHg==
X-Gm-Message-State: AOAM530dy8yQc7F+sQv2gA4u+QZnAjvRPjr7A8QttcGaBrEHzaw0+J5I
 OCrR3L1J5zIwypB4LW00r1I=
X-Google-Smtp-Source: ABdhPJwFDCX/tFXV06ERJbB5IjYU+otgCoa9hw/ldRTmkLaM4qLMKo629i33C+BwtbFfH7DL4OQ+YQ==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id
 c5-20020aa781c50000b02902f7d4e378e9mr12915932pfn.31.1625454949982; 
 Sun, 04 Jul 2021 20:15:49 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id 136sm11455570pfa.158.2021.07.04.20.15.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:15:49 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com,
	maxg@mellanox.com
Subject: [PATCH 1/2] nvme: add set feature tracing support
Date: Mon,  5 Jul 2021 11:15:28 +0800
Message-Id: <20210705031529.36001-2-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210705031529.36001-1-houpu.main@gmail.com>
References: <20210705031529.36001-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210704_201551_078310_16372F7D 
X-CRM114-Status: GOOD (  10.84  )
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

A nvme connect command produces following trace.

Before:
/sys/kernel/debug/tracing# cat trace | grep feature
    kworker/5:1H-98      [005] ....  3221.294844: nvme_setup_cmd: nvme0: qid=0, cmdid=25, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
    kworker/4:1H-124     [004] ....  3222.009186: nvme_setup_cmd: nvme0: qid=0, cmdid=17, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features cdw10=0b 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

After:
/sys/kernel/debug/tracing# cat trace | grep feature
    kworker/0:1H-253     [000] ....   196.060509: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0x7, sv=0x0, cdw11=0x70007)
    kworker/0:1H-253     [000] ....   196.763947: nvme_setup_cmd: nvme0: qid=0, cmdid=29, nsid=0, flags=0x0, meta=0x0, cmd=(nvme_admin_set_features fid=0xb, sv=0x0, cdw11=0x900)

Using ',' to separate different field like others in
nvmet_trace_admin_get_features.

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/host/trace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 6543015b6121..2a89c5aa0790 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -72,6 +72,20 @@ static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_admin_set_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sv = cdw10[3] & 0x8;
+	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+
+	trace_seq_printf(p, "fid=0x%x, sv=0x%x, cdw11=0x%x", fid, sv, cdw11);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_admin_get_features(struct trace_seq *p,
 						 u8 *cdw10)
 {
@@ -80,7 +94,7 @@ static const char *nvme_trace_admin_get_features(struct trace_seq *p,
 	u8 sel = cdw10[1] & 0x7;
 	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
 
-	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x", fid, sel, cdw11);
 	trace_seq_putc(p, 0);
 
 	return ret;
@@ -201,6 +215,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_create_cq(p, cdw10);
 	case nvme_admin_identify:
 		return nvme_trace_admin_identify(p, cdw10);
+	case nvme_admin_set_features:
+		return nvme_trace_admin_set_features(p, cdw10);
 	case nvme_admin_get_features:
 		return nvme_trace_admin_get_features(p, cdw10);
 	case nvme_admin_get_lba_status:
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
