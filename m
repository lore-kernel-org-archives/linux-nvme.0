Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3641CA9EC3
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 05:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21022067D
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 05:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l51shPrx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC9Ql59H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21022067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=DFCXAaMFolwkdp0xYzIym4/PCQlrR4bu+vvRhZu4UU8=; b=l51
	shPrxLUQ5xVnOtcbrTEnpeHGBBp8nHC1UVknCwny+FjXxpKPnG9tkMU/XFKcuDnM35KtYE4LLvGv7
	lt7HJ6DNfR/zz+VjQ2AAPOez8ONJHJp2817smq2OM89wDEbLIIc1usD9tnIeXXHT+D5rUgKVi4Shi
	CoaqbOuGwswFf70Er3Mun18rQjzQkcRIhA8C+Gs/A4EABQp2a/s6TNXyJpnhi2nS9/AmHKh86sB3K
	rOULF3rZLZCJa+52/a4eZx4K1ZgNqq7Dv15NumO9waLQohlgPoepzqRkI4CcxwZFP58f7AzPr3bC7
	K58zMRwxaHt7XxTNfNoiL5HRcyotoUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQ2d7-0003Cm-NL; Thu, 31 Oct 2019 05:04:17 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ2d4-0003CR-K9
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 05:04:15 +0000
Received: by mail-pg1-x543.google.com with SMTP id c8so3159945pgb.2
 for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2019 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Q8TzIHOB34wunGGFvG3qDuYMqHP3uwgf9+UhSlvIUAw=;
 b=vC9Ql59HkHjZBIv0+Qrdcm4yjn9AbvOeO/5G+LtGu77Ij7J+/0Y6NSrfvvb0M7qLW2
 59zp1ZanJkN4gd26qrkXRwhXi/R5sRDYyyAdT0/Mlqh5cqfkBfvx80uc8R0T+1EJnaP5
 i4IT8PkUo88AygfTJ9Ydtj4UEfDWRaTNlvrzmuAhJlQWnWmcI/CV5rVO+4c9DehHT7bW
 bbb/T2faM6X2+WJcZK0grS3ipFHNv3gVZAz5yRuqvxmv+aBRZcjP8q0VutnKxlswwjmS
 Ib9uoNxzw1ER1bpXnCfco36fRlFEqrbeCYaPud7bWbMzHnbwNi4f4xZlb7Rd2ayFXBYH
 6qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Q8TzIHOB34wunGGFvG3qDuYMqHP3uwgf9+UhSlvIUAw=;
 b=DD3UMfZ5WaX+Cn6Am3CgNVJmKnYypgTAwFXXdY6uSNeZzUpzNZL8HfZKYFJU39hgWF
 fScpIh0BlX3Jr463053hmUfRJ8xEYgs2BskpEFTR1BjHGw4m0gtvPnDK5035aL5buC79
 S46JFb5+iXXDQSTr2C0pAZ0t5W6f9nWqolBLj4NrmK0KC/78uhYzwy9UBfGLQRNdAIlT
 7zvjKRR4Nc3kdNW37yVV4Jajzq9Tmv/E9ay8FtLRzlp5K5UfissyyWBNgL6m5ERtTGps
 812ZoG1/NedJ8fw6CtC9TxAyRjlVP2zcNLD5J9/THt64dAPfKFGCgJJTTeeF40xvsL0f
 b+5Q==
X-Gm-Message-State: APjAAAWJoqYKSm18LZsY6/MGK6P4dIdcVgLj2y+QH7WqVIL0NR978EPV
 LgGtjqfZxZiht01777xBpWZ58NzSapSZDA==
X-Google-Smtp-Source: APXvYqzhfX06D2X9smqNQnw7ToE/n97hSatioUOx52Ftu/g4VKY4Zq57v2uLymMAP/fVh+iD1BOG6g==
X-Received: by 2002:a63:3d03:: with SMTP id k3mr3880999pga.375.1572498253048; 
 Wed, 30 Oct 2019 22:04:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-48-141-28.hsd1.ca.comcast.net.
 [73.48.141.28])
 by smtp.googlemail.com with ESMTPSA id d16sm1899658pfo.75.2019.10.30.22.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 22:04:12 -0700 (PDT)
From: Charles Machalow <csm10495@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Date: Wed, 30 Oct 2019 22:03:38 -0700
Message-Id: <20191031050338.12700-1-csm10495@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_220414_685614_51A897C7 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, csm10495@gmail.com,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 marta.rybczynska@kalray.eu, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changing nvme_passthru_cmd64's result field to be backwards compatible
with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
field. With this change the first 32 bits of result in either case
point to CQE DW0. This allows userspace tools to use the new structure
when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.

Signed-off-by: Charles Machalow <csm10495@gmail.com>
---
 drivers/nvme/host/core.c        | 4 ++--
 include/uapi/linux/nvme_ioctl.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dc..74a7cc2dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1453,11 +1453,11 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, (u64 *)&cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
-		if (put_user(cmd.result, &ucmd->result))
+		if (put_user(*(u64 *)&cmd.result, (u64 *)&ucmd->result))
 			return -EFAULT;
 	}
 
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index e168dc59e..4cb07bd6d 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -63,7 +63,7 @@ struct nvme_passthru_cmd64 {
 	__u32	cdw14;
 	__u32	cdw15;
 	__u32	timeout_ms;
-	__u64	result;
+	__u32	result[2];
 };
 
 #define nvme_admin_cmd nvme_passthru_cmd
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
