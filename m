Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECA6CD37AA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8lgyS5dMPeO2qFkYi30AkvOg4jJMB6frjU0fmtL/DI=; b=3fH9pgmqmMRa5kAgp2XRB/Gjny
	c5i/6+iXyt8MGdGoesea+6dkBnqYBIaCnTDt8Gg/bFzlnDQMQL/6WcGMBrlOcQZySLxuxb3zsgDbr
	cT8L68QMIZJ7KZRB8QZQV8GhVE7GPj3zN2zx77c84Ym3gKSL2xbHsLEId6Do8B0/a4RsKLZ4lt5N4
	AmjR9xCOorRwRvxLV8UvUcgV9v4MBziIADICza/eP4K+AvoSYfFUtJ62oHE9VdGRzDNxUy8JxuHra
	UPhcHCcAW1rMZpUltdvA0fLOjRPRpyH3wNkUWZKpbH7m4w/feSSGGW7bv5mxR/qcsSyLgHgSLI2n+
	BT9vYPIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXsm-00000001PJ8-05xb;
	Tue, 03 Sep 2024 18:04:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXsj-00000001PHM-18g5
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 18:03:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 69196A43D3E;
	Tue,  3 Sep 2024 18:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0597DC4CEC9;
	Tue,  3 Sep 2024 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725386635;
	bh=+gdjB79noZuxpKg7Fo8CxJSoz0h+b+eS39KuQFoFvps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nm+rWc55NDxNJAHuoN4IX7y4Wepid1+et8jhy61q92YiCeNW3q8btQXoHfwUK1ONZ
	 1nG6VhYxT6QF+d6IsNjKzbcHgVAL1vgPe7Q+byBkIF2LtV5yzjx6G1Q5lLAQHk7yeo
	 8OxpOVLZvQ9+6MFkrvQxFDaFCTnXMhw221dJBbPTQnMKxeZXtW5NQ77xOrBcsxZwvY
	 myPsoMmbHHeyplPZyJMI4Diun3ctmy50MRU0UPlzRIPy82Ielf8klnmsGfFn4Ttk39
	 GV+g+26Ul5y0M1ecsTBfj282qdDcgR8rf250s4zDCb4rcyoG++JIODYBVl4DGzRE6h
	 plY6COfxRP/rw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Tue,  3 Sep 2024 20:03:44 +0200
Message-Id: <20240903180345.35253-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240903180345.35253-1-hare@kernel.org>
References: <20240903180345.35253-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_110357_465315_2F1565D7 
X-CRM114-Status: GOOD (  11.19  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
'struct nvme_ns'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


