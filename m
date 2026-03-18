Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF4A1088E52
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdHj0Tncneq9Idm3xpqrvxthZX2W5l/m+b/FubY+x+I=; b=qKArkIjQ5sGRGyV1lQsK42nAzL
	tKzMJCULxCLIdcDw6tnUrlDcpO1nncokqqJOGmobXq96XUYK9HvNNDGtmm3taBFlFzuUEGfCspdMV
	q/ZGCyOorfB7bD/fSNQ0Ad3/2vePMSa9ipmJaIF7mFSQYrzDINCrGdAZhx/LN4yaXaYMSSkUhnaWw
	zABXVFovCyLE24kB9MCvoQL7BxJx435xD8sDNmL6mt/X2sVSzm1UVkf/sxaZuLi1NM4RD5RJkzRg+
	syrtuN3rrBSp9O9XgPO6xHzskVwzK+4NVYJlEnTPtUve2vfS1mqmJmAyw0aJP/8aYGjLPEOMGDDxR
	9OFvaPUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2zpM-00000009SGF-2Nnn;
	Wed, 18 Mar 2026 22:57:24 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2zpK-00000009SFe-0wiI
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 22:57:23 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-89c52db6231so1100356d6.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2026 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773874639; x=1774479439; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdHj0Tncneq9Idm3xpqrvxthZX2W5l/m+b/FubY+x+I=;
        b=e3GmXlI/vkOXc8FzNEBQtHniHne2WXaP5XqUgVQE0J0GorncGapFtPxQwpGTrUw7dR
         ZZ2z1PdBVOiA18YshVU+U02D9voE9qzBavLHVkmdIFxLifWc3Fxcj0Lb8MFr8Q5eendz
         IzIgmxB8yggb0bKZsOQEq7q5BahDVUUwykm347d3Jhljl/+pcuKe4WGNbO3JHhB6QqHz
         W4B556zsbTPLdmFws+cqsgorkk7oNYcLrVjsQRa6unLbeN8TRxqL5F++mj+6TD9YddRo
         xFV+64eSunH8ZCEX9sZbsedh8n6YfbU3BRZZ2LVTcioHMpPfssulNZ9RqafewzpYCVP4
         yHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773874639; x=1774479439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdHj0Tncneq9Idm3xpqrvxthZX2W5l/m+b/FubY+x+I=;
        b=aEFTgHKehT5MzqyS2CgOr1A5/P5HT3JRJJv5Et/W4BNpTompMPkbZJaZhpxAPjO8FE
         FQsTk4sNyfRIwo6lZCY478JBcNT5YbIkTlhFajy0kJxBM8I1mP6hgL151CdFrEeTO3Be
         uGTQuS6WvMdz78KpOymJeTrN8Ux3JAzFfq2ZX/XW4OyVg+OFWPW2ISPdtO2wg1RGj0EG
         P4dZ8PGn5bWeDInuzNI0jHp+LbIiPOOjVVapkrEdW/T5zvLZH1SUO9eOhseGewlaqNpz
         l/uJUBHMdYxbTLz1JAdURhfef7rsdxMeSMzMDMkmQX+72ERQw3RrnyaKMt6mSnQUOsTB
         RNHg==
X-Forwarded-Encrypted: i=1; AJvYcCWylOLG5sa5c4JIszJKMH+x1pJQ1sIMIXAqjhVmHVDEola2QZ4w+E0UVvggzkff3rMjR8pyqCVRJYVq@lists.infradead.org
X-Gm-Message-State: AOJu0YwCIqOVonAOQvFW8uPNO2s2aaWI9yoa4UEz45FYTQfTRCv0qD11
	8ipQdivZRVqlb50pZuPGl2Y2vhOm9whPefWEh7C59ypy1dsOBgHJ/wxW
X-Gm-Gg: ATEYQzwaKWZMw8HUG8xhZjfK5VB7tdLHmHl3nvmGmVU+NgFZCi5is6lieaDBYaUkgqc
	pe4JMT1SzwaMyLJDUg5S88cScwxMgsLzwyOCipyxO4WSIkSb8pDaGJxegG7JQuGHvJQ+w+k+MmN
	JVRl6c9ge9gzn6xxU32ekvT20AYC9MxRUHtN2KRZTgIqTo0GTgwUAiNTTk8NUvFl3n3PFlGyYqa
	YdNtrL7JmN/u38AI8ydLUpumSq/bZVzVE1k9xkZI1p1VsatZE4nFIHxrY4TI14BhTbvnP9/xiZR
	DgrSx0PsDjlm75tConoYX0w4mkwt3ObdEDr0txeYrUFVm0w1wnN7SfDka5rZPPD+bRZuQg9E476
	zVEXEUDe6Wzkf3l7tuG9foJayZUTbe+AmYN1szXGmQ6rc/+cN2TrIrbXJRgNZGLFJlZTNUT6G5P
	W1/ASF9bEz9blXMEWnkDkN9f1hCsF3jXrgRcIGijFWJBA5WNAdgoY/H+5LTAPpgNfCDydBADkoJ
	Ocbcpys2Q==
X-Received: by 2002:a05:6214:212b:b0:899:eba1:3c14 with SMTP id 6a1803df08f44-89c6b52ffe8mr82590556d6.18.1773874638786;
        Wed, 18 Mar 2026 15:57:18 -0700 (PDT)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6ba0963dsm37956766d6.49.2026.03.18.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:57:18 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: gregkh@linuxfoundation.org
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com
Subject: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path
Date: Wed, 18 Mar 2026 18:56:58 -0400
Message-Id: <20260318225658.1760759-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026031827-carving-overdrawn-5b1f@gregkh>
References: <2026031827-carving-overdrawn-5b1f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_155722_268891_C16EE00A 
X-CRM114-Status: GOOD (  11.03  )
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

In nvmet_tcp_try_recv_ddgst(), when a data digest mismatch is detected,
nvmet_req_uninit() is called unconditionally. However, if the command
arrived via the nvmet_tcp_handle_req_failure() path, nvmet_req_init()
had returned false and percpu_ref_tryget_live() was never executed. The
unconditional percpu_ref_put() inside nvmet_req_uninit() then causes a
refcount underflow, leading to a WARNING in
percpu_ref_switch_to_atomic_rcu, a use-after-free diagnostic, and
eventually a permanent workqueue deadlock.

Check cmd->flags & NVMET_TCP_F_INIT_FAILED before calling
nvmet_req_uninit(), matching the existing pattern in
nvmet_tcp_execute_request().

Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..a456dd2fd8bd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1310,7 +1310,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		nvmet_req_uninit(&cmd->req);
+		if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
-- 
2.34.1


