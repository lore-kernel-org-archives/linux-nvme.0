Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA1D609B8
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GtxWVprwFSDZdPsXr7xdLKUG1hqK8KBIerN+AEHe+w=; b=T+IPNw08f20lmF5l0vl3BepZOF
	/96XRwed70zPaqAJf0w7n6a+PCV6TGd63EKI+t/OwcbfNBXHk0TME4+Ld6BW/bfSoIRIftC/NJf23
	6EPGUwGthuRUsqXM/W5PnP3x3RtIsDKTixYp04yb2T6L9/gwpGKD2XLZMpksLYvRj56+RTfQCuNSq
	g43Jyukiam85SAmAZOofjFlLxjVo2i/E4G33d8uOGO0YWcdENOqN9wAjFr9VSfGBwagQOdnN/uvWg
	I3BGgME1xq2qH9yMmMmqB6kiUbjVcuLf/KwPmEtDc36ShyZfHxsqvNxqAiTU/vTiGW1WRiY+VoZfO
	Xl1JHGMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDml-0000000CcVQ-0q06;
	Wed, 27 Nov 2024 08:52:35 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmi-0000000CcTj-3gZk
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:33 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so5183862a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697552; x=1733302352; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GtxWVprwFSDZdPsXr7xdLKUG1hqK8KBIerN+AEHe+w=;
        b=D09kl3BHxhFtq1ox9JzHU+246xwR8uTtdFJoazz6c1bkbQhKIOmzmZIS9Iqkp+7MET
         gz1FeYRBanBXmKfk4i0PGSivrPDwz2ufQpanKGYQwqviZrwU4pTEfqxL+F3xXBlIgSve
         tFc+KsILVFhOjUBAlekJsvosyFL2Zb0o4ptHFDpn5UawVW9GjBKh5cCFP6nMSvZHF+Yy
         xt78xyDES1Phczzq6Vab2vdjhFnOzlPOlsRmQ7AYmLHlQzB8P4OY/iSz8J/dP7AgxwLq
         Eol624VjWIGVBtggXdRznb3LRhtCLWmMeZwuQmWBFBWd4TVpR5f2I39NKgvNjr/yofzh
         5FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697552; x=1733302352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GtxWVprwFSDZdPsXr7xdLKUG1hqK8KBIerN+AEHe+w=;
        b=LL4CXmfh9lKy8sdb+5m9uY9wo3m0u1ifl0APC25aeBJ0dB2b+gOMab6hC5j02Dt0As
         b2IXFVfZ/Fv1GCGvhaFKTAceGZE6OsQlja2eA3KSR4bhrLQv0Y9G9EwW7W76/ns/PDHx
         oVms+w8JMvj/nRe/9IQbu2n6Z9GmonRxcKhHEsbV6c3ntIS43VY2kVDEWEPXgASZIlRc
         NTMdFZiEyK9DHulvEDW/daaa2qVjknN8isVRrVlZTdoij1wOX/i8vu3ijqWAA1/9Vs87
         QAnR4ya2LJpTCWnEzdvRzrEYnC7uEVAU5mM9L7ntS6KPKB28PVIAhhud34B1BofhcQ7B
         vl0w==
X-Gm-Message-State: AOJu0YwYejTlMirnVeT/KRH+TvBsftHlZItqkx/wDpP5ii2t6R9NXU/c
	TBSmPVCiF2Rt39ArK8tv5/th2aV5pTlubIIB43fHtw8MhDsi0laupZiq1VV+6qM=
X-Gm-Gg: ASbGncvijvxL+94+5Zyempbi/2MIM5bSz+iiE7AU+HBImxJGtfdiJizJ1wf0I3QvCcV
	qCbbQ4ZUvTNfjG6mrP+ZeezWMWXh4BqAmS0+LHPPnb29iE3+02wn4EQ2G8OCpVLJByicJFqFwLd
	felNx2BuODyFN7YIu3JIKqGAfbk2UH5Fwm9r81pbbHMLTAiw3u7CLR7igeTmIiih64WdduOWucu
	5mj8Pqui+1oIULnub1iBVZQBZv2LeXDdodk+9zV2InUxJogCAZ8OGScvyrGKw==
X-Google-Smtp-Source: AGHT+IFWgNHtIL4lvZGnwj9qigjzUulsGL+kOLu8IJhe2WdfqgdGC624KR6Weud4TWGjUNI3BzGSWA==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:a7c7:1b8d with SMTP id 98e67ed59e1d1-2ee08e9f0a5mr3324430a91.1.1732697551857;
        Wed, 27 Nov 2024 00:52:31 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:31 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Wed, 27 Nov 2024 17:27:51 +0800
Message-Id: <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005232_917387_CADA47AF 
X-CRM114-Status: GOOD (  13.00  )
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

Now when destroying the IO queue we call nvme_tcp_stop_io_queues() twice,
nvme_tcp_destroy_io_queues() has an unnecessary call. Here we try to remove
nvme_tcp_destroy_io_queues() and merge it into nvme_tcp_teardown_io_queues(),
simplify the code and align with nvme-rdma, make it easy to maintaince.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..36c7e49af38a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvme_tcp_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		if (remove) {
+			nvme_unquiesce_io_queues(ctrl);
+			nvme_remove_io_tag_set(ctrl);
+		}
+		nvme_tcp_free_io_queues(ctrl);
+	}
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
@@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(ctrl);
+		nvme_tcp_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-- 
2.25.1


