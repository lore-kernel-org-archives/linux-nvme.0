Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9572C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 21:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7OXC17G9u/8wRhNpjH6CFhKb08/oYo+gDHl7yt3l/M=; b=1bIZfelZESnBnG/9PXCToAfr9j
	8VD/0q71uUgv1GRIRtRPOa+ymOQiYylDY/DrzGAHtV1JBgbdF6IATRUBLHY6kjWyy55x+ivSM5Smz
	zRznK6msJhxRju2ZwF66kjmBKt4xpih9wMCbQ0Ccl+v10e63e5ffTSibMpAVZExjC3nLxAPIC6pWp
	0KpASUZNJVH8Sd5QYTjMcR+3bJiPRk+lxYzzC6Csd/m3CXacV/y4fe7cx8/hVUIPFG2mi1DI3Ih79
	7eX3x6cHeZExhRyWcfQOw/Zm/o71vCe/0N7obmN4jnHrxlPuYDmQnJLhe4nowHoaeJKRZ0Ccl6qsr
	hWETRl8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PW-00C6pK-00;
	Wed, 03 Jan 2024 21:04:22 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PS-00C6nM-21
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 21:04:19 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d3f29fea66so45864675ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704315858; x=1704920658; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7OXC17G9u/8wRhNpjH6CFhKb08/oYo+gDHl7yt3l/M=;
        b=UtaXZBsPhFO09b2rbTbugYmSvQicmdk+aZGucrWIIthvefs0Y6bDOhbROF7jOmCnS4
         /rdWir4LOBivI6gDsgf5VRJ1Zl6Dh0+isKliaHmnNpcU831croQou2F9SIusHDBFLICl
         0J80x+MyPZkSqEpuep1UN2C/Rehvk0LxuFEYzch1sn7FEeY6At1viZ5XjyCooEuRTP6B
         j7tva/zmua7oyEEmAkmUL6pqV9Uf39dFSLOMXht+fFpUXM8uETD6wPzERjZrq62Mc8RH
         wmqItzGrf2/+8dyPAltlJnqL7VBaGmgw3FceVzd9o7VhpQUuPefXiBwHttqN14Hq8nDJ
         2+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315858; x=1704920658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7OXC17G9u/8wRhNpjH6CFhKb08/oYo+gDHl7yt3l/M=;
        b=OxBov/bA7b+NF9VkvKPlAmn8RAnv+071+w3U7FZBMVXz3NvY8bpnjV4rrPlSn7LAOK
         aiEuMXRIbHogqrxIaucQEMkWvpmv7zpPADOA7kfvhAsRR3RcU5BNL5TSU+s5GTsYf/DJ
         HQAWqCU01BY7qMIx2AFuJNfXO00hqg2/FsU5gnMQ3amTalW8MqE3oAKtFMppOwD9158I
         Z19ghhIQSp4SmcaDD48Ao3K0GgPZzgpJLIOIljInuTWI9/HLoMmX/Y6K5oyNuZmjzhlu
         /qvFcYQIi8FQ2TuEQAkXebnD5Obcvp0m58vYX1mk6jpHe7K7l0i0pQhewZXq3GxEkT9o
         +YXA==
X-Gm-Message-State: AOJu0YzkcD4mGGqBHJp+bSWffaBU4zenvPWEJBJT/shDCHu3muNI8U33
	qAugIuV7Fsb79yXVJbymyyThebLg3Nn2Dw==
X-Google-Smtp-Source: AGHT+IHiPG6bI9gm8r7ZgW3Z9tY+h5oR/2Dq4+iMC1BX8mfLBTXsTM8Y6IBOdqhrQhsFYviV2trYzA==
X-Received: by 2002:a17:902:7d89:b0:1d4:a4a0:c60d with SMTP id a9-20020a1709027d8900b001d4a4a0c60dmr3803321plm.48.1704315857867;
        Wed, 03 Jan 2024 13:04:17 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d414a00fd9sm22505837plb.29.2024.01.03.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:04:17 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvme: Export nvme_wait_ready().
Date: Wed,  3 Jan 2024 13:04:04 -0800
Message-Id: <20240103210405.3593499-5-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
References: <20240103210405.3593499-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_130418_664671_54D4CA64 
X-CRM114-Status: GOOD (  11.46  )
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

We will be calling this from drivers/nvme/host/pci.c
in the next commit.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1b2facb7d6a..c7d448f186fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2192,7 +2192,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
 {
 	unsigned long timeout_jiffies = jiffies + timeout * HZ;
@@ -2218,6 +2218,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_wait_ready);
 
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1a748640f2fb..8c30f9856621 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -754,6 +754,8 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
+int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+		u32 timeout, const char *op);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
-- 
2.39.3


