Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF757C369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hyazZB1s587bf2k3T5zFrJWa5bIzmXh3+1GbsyHSymo=; b=W9KapXZcBVNzKc3eJvwiT6Eeax
	yaN8zCGt+e5JeVnKLr8JBUOSddzsE+KEYv1O5eVlIVtI6SYAZZszrQm1uMgi0TuS2xswlODE7xb9f
	hPqpJFeI/dN1r6McTPxH++OXkLaIHE//41PbyaMBz4bqA32oUdzojEG+dOmzaZrGM9qszk9Y3PlOO
	Q2Zu1xR4HxhZaHytejLztkmmOGxHxOnxJQQzjT+oLplxBMriUEntkbjXlbYtbTzmpSENiMM5F3Z9O
	dd3/n2U/NQOOQeU4qNxrcgMP3NCVpH2gKGtj9dL+Y/CKOBAHpZGttm/T6E383K2TbDSEdsob4UIFF
	5PjF+8sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtE-000000028ja-15WU;
	Mon, 14 Apr 2025 13:30:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Js4-000000028Pm-3O91
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hyazZB1s587bf2k3T5zFrJWa5bIzmXh3+1GbsyHSymo=; b=Hh1alR6ZSY7xYcAy3cAs6cbDpd
	l+i75LaNVLLtCq90+/AOlw8TiRa5oTC0c+obS0UaFCzDP7pjYvuwJJv6hCp0QvQUZ0AioJc3bwJ5H
	ixJdyypX5Ea2Gc+OwA6HxyJlHNt6Jk2CrQPdOUE5tbK5GZk1kCRO1/6wr33I2vGF6naOCb6+CSnUa
	u6novRHXB+a6o/I12lrdddmDq43+E9no0KIkk4bpvNZvlVMbt4D0/PQyjGyjC1AJM/eDdDkloylPZ
	knbjeXyAkfecLMz50Wc1mwX59A1z8ST+FKTMtYrXKlsMHT38/fNV3J1907k61Zcj5xW+yfgiIWDYe
	TNKaOwyg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4Js1-00000009h1v-2xTf
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:29:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6A0B85C0F9C;
	Mon, 14 Apr 2025 13:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA32C4CEE9;
	Mon, 14 Apr 2025 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637344;
	bh=9hY5+zVfs+pL21mtsAaULpMOnydMqkceFDf/9FixZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF+UmHDCvgAJX/rttm/v9/4uSrdlJV77hGXiCG503mQybxOU3Me/E8qadSz0TkwzG
	 Aq+CgOmPVbU9Vd/gfh9rtKjPnjQJeGYtCzUZQk8ADB8D1fA9Ix+pxiDkWdGAU2txzu
	 xdVBoTgYQOMO+tmLn5Gr+gjpoX91MxbX8pDeOmimumUcXINjc7QSFd4J2mKFGwiLyP
	 18D5JnHx+IjvWc2HhcgnORXr9RyMNp5mwnRqGKNqSYLIomsxtpL7cektJ6MBOfJsIL
	 njtz/g1dUyscaR2xAsfxfx7d/XYziDg+mt06Ba0+vgoGnOdXdbeCyLYNwGzkOg3GNA
	 37IH2PdnYNOeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 07/30] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:28:24 -0400
Message-Id: <20250414132848.679855-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_142906_129367_0EB489AE 
X-CRM114-Status: GOOD (  11.92  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bdf6fc53697c..587385b59b865 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4273,6 +4273,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5


