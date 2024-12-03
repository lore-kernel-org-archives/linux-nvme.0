Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03A8E6C5F7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y605Yoqum/jZcE7U0+5pZo9sFjv/Z/YWwjaxKaUzHJk=; b=o0OEc6Hzl3Nb0iyMPn4lnAu7gH
	ZxTLMkEiRQi4BNjFOxovFB/aIpWs69nKMpr1FVivNjMku7BGKqn+OG2pPxW9n4zGBetqD/tjyDgFd
	6pZNTEV5wuKbjvVfrtcqdpukcWjQ0CXsDOGGN108pzmzNsG8BzWR5kqAcZ2mKR7qk0OQ8UOCOlszS
	IvojCMZA7Xdc3cHa2QrZrUZYjOdn9yJANCuiggNi57HDYGA5jhKNvJfVJC0dcXV9WPc4SqcvNvTK8
	n3ok56+r7eY0QGrgnBBi/B1hvktLzO+JhyrZFR0J+MEcoM2PAqdYfOlSJr7zYYUXACmPhVwbQ1Mqr
	3PDF5yyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgj-000000087cJ-1P04;
	Tue, 03 Dec 2024 03:35:01 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgh-000000087ar-20kh
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:35:00 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-21583cf5748so16845735ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196898; x=1733801698; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y605Yoqum/jZcE7U0+5pZo9sFjv/Z/YWwjaxKaUzHJk=;
        b=kSLrgxMiTjorNYwVvC8L6Yky+wmWTdC+ve89sI2Xjb2AoPm72UT4I5PlNQmnE6RZj7
         0HaJ2xKzmWGJHYqz2FasYjfGb3s6V2Wrr6EUeJXBBdWMI5EbgrAilk9nrJ/dmLc3GZo8
         W/ETcOklRoLcgClWy9q4Gd4Yv6BVKTaElOlXsZaSRRzSOrehRBLJ9ak4A2FGxQAj0A7m
         bwenlu8r8kH2G5JpzZq/k1qCYkrLkA0e/oqQJ0MRr0P9rz8kXf124qxzGMmRCoYi32LT
         KhEO7zsla5cTAe7496u80B58K47YvIsApRuhgaYMeQvoEzc4g4vPqN2RU3CfEnSpk91y
         +kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196898; x=1733801698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y605Yoqum/jZcE7U0+5pZo9sFjv/Z/YWwjaxKaUzHJk=;
        b=V35x9GpWEcIvMaWwjzFJS+6HzI6Qkqrl6nRcDqgwPI+WqDjgB/XmnxLvi/Wtn04WLv
         sM0yDXmeLhYh4vUKAj2sBYXbF+r7sQuvuWhQijQjHDFwu/wLbqdJxASAdN0slkkv+uyv
         p2wJkuf0/buNlvbhPaLFjE18vb1AR/G4/sysY9EPyhOKafjIXv55eZGHACqJGkgLs1HF
         gEfimxTakPSGM8lYRExUhQctjrHpC0B3Qwr6Hum6qbTE9RHH330hlnCXojNUAXAzYl0x
         j+wietF5mVOx5rrZN0aR3IO708zDsOxd0pU1qPxJUulIf0k+oY7vEcr95zuOCutcQ5Lc
         7bCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnEid6Lebzg/NdeODRGGPMhm3HLcEHGnimh5l9yiqCYMijjwjO3EhClq57FsyiMW5r4smUjM4G9fSS@lists.infradead.org
X-Gm-Message-State: AOJu0YxrWqVrwC6gGQgY6+rw6Ew76QBNo2yn+z1GKhyp5ApoAIgQh5+F
	2/bQKrJvrPwETsLoQPj63dyEAIIVJ8n5RXKnQt9/bGdzHtbIz0ef
X-Gm-Gg: ASbGncs0IMIdyCK/IuPh4vJ+3OYXSbOSUKu+KVSSjrq+9HExodHe2aG2wR7zd9R1J30
	08UJy03+FzCpL773jw/vBMk2dSzPTXqyyU4hWsjtF5dd6fNovVDjo80vWijXde5eTew3DmTodaT
	ITgXTVSn4xsrV8mQw+41Ciiv2tK2ZBLqBJJ6tGh8G/FQ6qRVZk8uRFbzWVk0/o+g31c7kNG6Pge
	pH/k05uXtVPyy/WeJGtuj9cg0BRsRZ0g6u45k0DyoJqvMuuyxDXFSL86qc1zg==
X-Google-Smtp-Source: AGHT+IE5D0txWF2LyZfs5ncf+l0eY3tlyVCpC6uLbHvVEXZiiJms0ww6O9iF/3o7GF7mHDnYmdng+Q==
X-Received: by 2002:a17:903:41cc:b0:215:603c:2f15 with SMTP id d9443c01a7336-215bd0f2a87mr14653445ad.21.1733196898556;
        Mon, 02 Dec 2024 19:34:58 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:57 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 4/4] nvme-tcp: simplify nvme_tcp_teardown_io_queues()
Date: Tue,  3 Dec 2024 11:34:43 +0800
Message-Id: <d2c6f0988078af74438223c31a88ac867126caa2.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193459_518155_F480BA24 
X-CRM114-Status: GOOD (  12.84  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As nvme_tcp_teardown_io_queues() is the only one caller of
nvme_tcp_destroy_admin_queue(), so we can merge it into
nvme_tcp_teardown_io_queues() to simplify the code.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

v3: Update the commit log, no code changed.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 98bf758dc6fc..28c76a3e1bd2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2101,14 +2101,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove)
-		nvme_remove_admin_tag_set(ctrl);
-	nvme_tcp_free_admin_queue(ctrl);
-}
-
 static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
 	int error;
@@ -2163,9 +2155,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
+	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, remove);
+		nvme_remove_admin_tag_set(ctrl);
+	}
+	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
 			ctrl->tls_pskid);
-- 
2.25.1


