Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6945C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rObdVuA/O8BmrMfLFekezI6/GUIGOxTcCGnROSywp98=; b=kDWuhIkqS1Dk4F
	yd8aQh2TCd8rujlR+V8hvnQZnQtV1t/Xx1fw/pvaWatAJMPt4EcqQ8Bi9rZg90hCMc9OqKwGUOPLq
	zoj6HUvfLmEzzQ+4kWxWB6lbck+U3am+8OsE6cKmj3BJHo98YFQlb5pS1EZlj1L4XKlyg5coxAcJ0
	CXUojrNoylqC0z4XuxR1IbCCiOFyqfbChJiLnBji57ndImA58jv7dWAnuYhBMM/9wZxkjr6QMHkcw
	eL6iVMO8FtDFV1Gegby1sUOsGuJBbYMyOtNalc+ZVMAQRgDrIk9an3HaeZ/a/lg0hVoKhVo/uht8I
	qq9foZ5ZDfoanSLaE4QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpls-0000000AZpr-0o2e;
	Fri, 31 Jan 2025 12:05:16 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdplp-0000000AZp2-3jtT
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 12:05:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e27c75f4so1618932f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 04:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738325112; x=1738929912;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rObdVuA/O8BmrMfLFekezI6/GUIGOxTcCGnROSywp98=;
        b=ubLyH586LhZKzuui8qycgcapquulhzgp7oF4kM3LXHndZKVHmodrbCxXM94ifHKYYe
         KDsrMnvBaEs1bQDzvMp7eaezz2y0heU2U5l++rv4ncTgl+iPd4GlFDWee2VT4FgMBWS8
         7mLWH+UqEvMQKQRKWkmwALI+OI2sXJYImqZ8TODdqdhjssDWeGw9tD3H611+WVDbOge6
         ICd7NSU8t247FtOoD5HXhyE1nFyY9VFwKRhuLpABmW/LWGEZ3hsqsOG17st2flMJ43fY
         U5qS/qQkOZQQ1Q6WJloSGnrJJkRu56bN0enRRKuZdcvBZ7+kC5BD/bvaai2MddpQ4vbg
         El3g==
X-Gm-Message-State: AOJu0YyjnNEfJcXk1hiMmhrC0L7SmcROnsVfmln+DB/tPnhnMV0JO2tB
	QhWMQw/CEuUgPPNfpTLucSbKn/hq/8qzCxLJ/YBEXZ7Qxh1lFBgCw0OnqA==
X-Gm-Gg: ASbGncuBJLjb37IQl1gO9RWscGH30cLXe9Q7Ztf3z1q88tlIzHrUCffB7qiB+P0A/sI
	3v72cZF+yMKXU6i9m8IxKvEh4TqHyzWbF6la69lyibECf7NirFewxNWZgK6C29ZPVah+Eg0M9Rt
	nJUVm94oNWsAx1sbytEdDAwF6hmjBRzXsBAXYI1CQTJMf50kFgAcZDezTJHZIXhxt+Lx3/PSzJM
	kFgKD196NvOXxgqj7JZo4f9/uAa+yuTG9aicWMXcD5haytWYIiPVbuj0edjb3DEx2lDR6UytCpT
	xJFLNbBzRrpf/MrofphPSNovidQFy+NPQRMBs9lWL4cdnMxf059T2gfU5TSTpSiq
X-Google-Smtp-Source: AGHT+IHHJaFM2ApKC5v0bvNB11PuEOPZ4T9+Xyyliw5lrlVsgMiNbf26AyR4UPI3BDzTRXKJsh327A==
X-Received: by 2002:a05:6000:1a8c:b0:38c:5bb2:b932 with SMTP id ffacd0b85a97d-38c5bb2bc01mr4911006f8f.3.1738325111506;
        Fri, 31 Jan 2025 04:05:11 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec80esm4557457f8f.10.2025.01.31.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 04:05:11 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH RESEND] nvmet-tcp: get rid of a high-order allocation
Date: Fri, 31 Jan 2025 14:05:09 +0200
Message-ID: <20250131120509.796198-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_040513_929609_C5BEDA79 
X-CRM114-Status: GOOD (  11.43  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Allocating the queue commands array leads to a high order
allocation.

The current size of nvmet_tcp_cmd is 704 bytes. Allocating
128 of those (default queue depth) means that we are allocating
an array of 90K bytes. There is no reason why this will be
a single contiguous allocation. Change the allocation to be
kvcalloc instead.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..79b888b10c2b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1516,7 +1516,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmds;
 	int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;
 
-	cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
+	cmds = vcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd));
 	if (!cmds)
 		goto out;
 
@@ -1532,7 +1532,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
 out_free:
 	while (--i >= 0)
 		nvmet_tcp_free_cmd(cmds + i);
-	kfree(cmds);
+	vfree(cmds);
 out:
 	return ret;
 }
@@ -1546,7 +1546,7 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
 		nvmet_tcp_free_cmd(cmds + i);
 
 	nvmet_tcp_free_cmd(&queue->connect);
-	kfree(cmds);
+	vfree(cmds);
 }
 
 static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
-- 
2.43.0


