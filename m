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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20CC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:29:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD1C61279
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD1C61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fq9tS/OvUUxTPTonOXU2rmDv0/FgqbP6PxUjRtHFS2g=; b=MlFwe22jYVcS9c
	wYQm+isB5qDfqxWARL5TcF8Am6vSkNXVnfcZpQ3ml2fHgKTM9yOikWxNEsY19SK/QhitdENR7H2iB
	7F/OakMPWjH77HJ9YM9PCLcZehURDqVVQ49SnIl64s3cRhX8mbvTlON8IXybCBjBw0XOzPZrmSLLe
	zNpgGcIPWWlYk6tvk5mRJXXmbo45kodvLl841His0JM+B8sHJO3WOQg3cx4rVjEVSH0G8/ePXLhFr
	4jUV5hfVZSXQmEPnvFgZ/ztTFCaoNqZu/tdOuX5eygVj91IhVuCAIxHaiO25xKwYjYXrst0XcsJp0
	8EJjbtL9YDzOO7vMhpow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Mn9-008mg9-OL; Mon, 05 Jul 2021 11:29:35 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Mmp-008mZX-LZ
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 11:29:17 +0000
Received: by mail-pg1-x532.google.com with SMTP id y17so17986631pgf.12
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RKb4a7pTV4O46QWRmytY+m/08AjyFpI6lKBsJ6HUE1k=;
 b=NvhHrH/y7aBZmdzTisWJD2qpGWTWG2e6Qxu1JpoxbyzYiR7TRejeXWw4DTcXFmi1i4
 nvPiiS+EDARwJAhjwIjoVJudS3iYctmn9fBAW5zEHxMLUbpFRq39e2x93JT/EyfhXXRi
 8JALbzux17tZfLyCmWSzfT8hGvkll8uKvWwhPG9KUSHn+eWIUl9i0buej23t4dzs5/08
 wKAfu8OIsVyOQLfdNXn5VMK2qHohb5QSDB6D1IyQbtBZZdiwEjsfRteLfJ/krEwsCUyL
 8cl2N1PXUYzsKUqdG+LT2Xkkp3oM8s4Vr2apHmesd8tS0LlxsC6hJb13TaYHmQCco2QQ
 iXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKb4a7pTV4O46QWRmytY+m/08AjyFpI6lKBsJ6HUE1k=;
 b=e/N/Pbp7umy8toQzGpPPxSK8QFd811bHqsQPU0FYQb9UhSqj1lD6uNjQm5yXW+xFSd
 CN80TAJHWIXlyP40EVk3w7xEG/f6kYlmY1aPzbRtoH/Pq72gjH24L73Q+sF8kbOTNjf4
 n8ZiA+C7TM1dreHeJmbsBee+w9EMf7nM7EXvRI3UwLE0SyNGXyFf4uXmqQ9EO1cETJus
 GX/ZVVQzRD4kcFw9jTBhGwQjl/aJQ9T6fMh+tCOmlQZ/kN+5B4RkkO8tMfKDIaVWHXLq
 eF80UYpbFNffKlWoYbOhBHBhO4zzD58x2dftBXtim3dLVLIRBTrTXK6zKact7fUKoGM/
 o2Kw==
X-Gm-Message-State: AOAM530Vsus5aLlnZxHhjzqmt45ISDf7rJj7Pul9vVu7awj02qJi20/N
 HuGaEa6/pxLoKTquSu7584Q=
X-Google-Smtp-Source: ABdhPJwfZN8Hx9gjXchTSTJZUSPN/CR7B9wXdOAYCmM+wZDJMC+yUhSda33J08LnIvxffYvgZtE/aQ==
X-Received: by 2002:a62:520e:0:b029:30b:fc21:975d with SMTP id
 g14-20020a62520e0000b029030bfc21975dmr14904726pfb.57.1625484555028; 
 Mon, 05 Jul 2021 04:29:15 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id u14sm12705654pfk.10.2021.07.05.04.29.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Jul 2021 04:29:14 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com, maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH v2 1/3] nvme: unify trace output of
 nvmet_trace_admin_get_features
Date: Mon,  5 Jul 2021 19:28:16 +0800
Message-Id: <20210705112818.49577-2-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210705112818.49577-1-houpu.main@gmail.com>
References: <20210705112818.49577-1-houpu.main@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_042915_764051_34CF3B93 
X-CRM114-Status: GOOD (  12.08  )
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

Using ',' to separate different field like others in
nvmet_trace_admin_get_features. Also ouput uuid_index
in cdw14.

For example:
nvme get-feature -n 1 /dev/nvme0 -f 0xf

kworker/0:1H-56      [000] ....   283.696969: nvmet_req_init: nvmet1: qid=0, cmdid=21, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_admin_get_features, fid=0xf, sel=0x0, cdw11=0x0, uuid_index=0x0)

Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/host/trace.c   | 4 +++-
 drivers/nvme/target/trace.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 6543015b6121..0e441bdad453 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -79,8 +79,10 @@ static const char *nvme_trace_admin_get_features(struct trace_seq *p,
 	u8 fid = cdw10[0];
 	u8 sel = cdw10[1] & 0x7;
 	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+	u8 uuid_index = cdw10[16] & 0x7f;
 
-	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x, uuid_index=0x%x",
+			 fid, sel, cdw11, uuid_index);
 	trace_seq_putc(p, 0);
 
 	return ret;
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 1373a3c67962..902500a57185 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -26,8 +26,10 @@ static const char *nvmet_trace_admin_get_features(struct trace_seq *p,
 	u8 fid = cdw10[0];
 	u8 sel = cdw10[1] & 0x7;
 	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+	u8 uuid_index = cdw10[16] & 0x7f;
 
-	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_printf(p, "fid=0x%x, sel=0x%x, cdw11=0x%x, uuid_index=0x%x",
+			 fid, sel, cdw11, uuid_index);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
