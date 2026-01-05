Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2861C2A072
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 04:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I6GNN5FEGpEBZQa9PY3orWMn5zHGjHMw7baCNQcQt+s=; b=y1E/CbImcx6C7dcvecrGnb4R1z
	97I+mm1Z+b+hvkIPG1HN7gDeDsvJ2c5xe0zsf17ZrmIxX0iAvQJ/uXqJAjXPGTXTsg9ulEKeQnh6O
	/p/dXrshI5XiI9pgAaJOxJcZ8IaNWSFg7Bb0py4aTvSYX8yT6GFixuP2BOW2hPQMhyRGiUGks7X30
	3gl9OAFX98gf70i90tpm6cYM8EMiwkIEnNNn2hrGTJyeZN3beR32wqAOcIyv2AZdeeIG37G5y9/1r
	P/YJUFzI7LFYM3dKH7E0uKPbGwcHGA3dCgLEGrUnBwJz/VURVjy7/gmitPlXwOgfGAlUqYGs8rfC9
	3QLmeeaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcbuP-0000000Agp4-00Wh;
	Mon, 05 Jan 2026 04:09:33 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcbuH-0000000Agoi-03e5
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 04:09:26 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso11033557b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767586163; x=1768190963; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6GNN5FEGpEBZQa9PY3orWMn5zHGjHMw7baCNQcQt+s=;
        b=hY/LaTf1sxBhKhdx6+ITRhzcIur6Eppotth705PIVb2fg2s2dP8cP7J5BhZFZRq7j3
         DtzVY1OL8zNEC6jw2TAi5UGz8lnzGZ0kEE1jDpJhqxpE7a+ZkAMi6IrLs9N3kydmImhN
         XMaZ33X1UJRqvJWDp71nepkJDArmVQ+kQoLhbOd7m5S3thOamcjFji9OGUtflVgNXqWh
         j0RhXIcmv6OqzSPf31YLTn8+yw4bgv7iG8eT83tpC2tcQ6Iej4uzGpwVXfH3L162yenU
         aJFZVLyOuIDths3QF8FCIgpihLsp7O32oTLDt7Ft0TmEss+PNDcrHWU0McoFH4TxBUg9
         DHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767586163; x=1768190963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6GNN5FEGpEBZQa9PY3orWMn5zHGjHMw7baCNQcQt+s=;
        b=JU3RuSswjdnr8QHn5XXNJFgh1XEfn0oZBz8SJODPh7xM4Q52fv7NHcHebkVKUXu/dK
         CpVsT3Vj7pjT2XgyYwtguP4ZQawnP8NFJazvOaw39tUMYyYb9IGtBwRZwWZWwrJczDUB
         oVq6Xn+wthwrVZ3b6+7QQdSI7f6JLgHZwxJ8gllVssSKiEyknO0X6yIGImt911o9PP3e
         cWOTWKCXgTGQeBesxfpE9t2SIgQS5NSKUK+u0LQpBQHM9XEWuMPV3lfT3Tx3pXrfjO8n
         OZPSDMZTb28B56ESREBagKAN1C4oRFeO/3ELHQZaRW9aMhxpx3EYuP1ik0qK3z1qXIp8
         fCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVC0a2hYWrAMqqAZLSdG+tILhMuY99pwFC17FDB/4fbYpdUsrMnWBGFMWgYg7iyiUzHEE+8Mcl3Vc9d@lists.infradead.org
X-Gm-Message-State: AOJu0YwIolK112i7tzB8eyYMXTNYWQDIroZtahbkMI6VhTGCNOLYJNbA
	RwScByvMrLicF789ykYFGCJ2EDLKVDlRRUvL+TleAxmNl5BALE53b/xf
X-Gm-Gg: AY/fxX6Po91S+9Z5hYyFclAP+F5/ASBXhNgU92dpyHGwDmoVokjF8oC5nTYlmeBaLev
	n4psP3PY5OPawDBw3BksVnsmeX6lLFQFsYVcRb5bHEWn58nItdFAKdvIlZaOIa4sB4MgYSW+H/o
	GPuDmjdsJwoKdjGzMPR86sZ3IIj7t7EL5u8yiKIzNreM+f4lB8xoYuPqzprUC0EinNnI/VVFg4h
	4IaUnrIF6IRm5KGzeICJV3FE6DnMtGwAncmi4N/6j1VEDZmXJB0r1g/qu2e2ZZXn6nOet1VgluZ
	HrZwM2ubNZDNlN915QVQ7don8hWvX7JgZ+qitG6J3qa8JFhiJMpTqKQLicTtZxIeGgdBXfXKB1j
	6ruuSYt9T1/c9HC58RE0bo0Y312V5Te033s4tgUYSUQ+rdUjRuV/OjpWb4VMpst+8ezjb6nnETb
	UhV+/iM9rYMnLBhEW1VglF3viuay0=
X-Google-Smtp-Source: AGHT+IFQ6FcE5lnRWLHvNXLCsDOZj4RVWqhqlwm74VXdC85w4IG9PcSKVNAd9c9fcmQcIMw7tyfkfw==
X-Received: by 2002:a05:6a00:3393:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-7ff641194e7mr42158559b3a.12.1767586163078;
        Sun, 04 Jan 2026 20:09:23 -0800 (PST)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7af2b537sm46137899b3a.20.2026.01.04.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:09:22 -0800 (PST)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v2] nvme/host: fixup some typos
Date: Mon,  5 Jan 2026 14:08:30 +1000
Message-ID: <20260105040829.732046-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_200925_061692_0696485D 
X-CRM114-Status: GOOD (  16.56  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Fixup some minor typos in the nvme host drivers.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 drivers/nvme/host/tcp.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a9c097dacad6..62d4bff7ebdd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -718,7 +718,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	/*
 	 * Handle ioctls that apply to the controller instead of the namespace
-	 * separately and drop the ns SRCU reference early.  This avoids a
+	 * separately and drop the ns SRCU reference early. This avoids a
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..8d389399187d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -25,7 +25,7 @@
 
 struct nvme_tcp_queue;
 
-/* Define the socket priority to use for connections were it is desirable
+/* Define the socket priority to use for connections where it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
  * possible optimization.  Making it a module param allows for alternative
@@ -926,7 +926,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			req->curr_bio = req->curr_bio->bi_next;
 
 			/*
-			 * If we don`t have any bios it means that controller
+			 * If we don't have any bios it means that controller
 			 * sent more data than we requested, hence error
 			 */
 			if (!req->curr_bio) {
-- 
2.52.0


