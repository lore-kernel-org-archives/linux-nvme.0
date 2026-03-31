Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F962FF60CF
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FnGoddvq9sbCatoW9EQgbQjv9Y5QL+UZ9t5bvuvRuzU=; b=xazwSFKlfxijJ1tFuprFu0BCEM
	XCqfUB1iTgGNqKAGzWjY2sjl0dp+uyE4PTG8WvL5MZU3fNG/Ve/z7lIcR02dBE+gfPLV7qEDMXTLp
	r5ybOwGhvJtYSV8xBnKZjHNEYhgG4tNLUejuv3o5AUUxyj5k5sZtvWloW+SKXyIZvOUQOpa61KagS
	8fL3Q9jga936b+M/TCtyq+MMspszXfqJDPicqr3qns6eJ/ZdYQGlTKzkLv42RO67GtJp+9lP+DNWh
	ZtvbVs58X8gRjrS3DpIpYNkGdgUyaBA47RgnGmfovCLpeYDVYq1ZRvoClwxDafTqW3eprWmx5HtBH
	l9UsZRoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7Tf4-0000000CVVf-0oR7;
	Tue, 31 Mar 2026 07:37:18 +0000
Received: from n169-110.mail.139.com ([120.232.169.110])
	by bombadil.infradead.org with smtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7Tez-0000000CVUo-2meQ
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 07:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vIEXjM98q4aEqI6MCekX8/1EuxSy4cG6Hmr20/WKaZ6G7gVlVnKoz+Y5d3yJl1dQxKlMhzLHJo1dr
	 +IRDYhzCIThBVVdp0+1/4c1+Hq/3NGNaoJp6Uc1klrW//Be5uGfLg3+D/NJbwXe6avgn1ABbGTPI6i
	 SW/5y9XJQHi3kE34=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769cb799bb1b-00b2a;
	Tue, 31 Mar 2026 15:37:01 +0800 (CST)
X-RM-TRANSID: 2f3769cb799bb1b-00b2a
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	ming.lei@redhat.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6.6.y] nvme: fix admin queue leak on controller reset
Date: Tue, 31 Mar 2026 15:36:59 +0800
Message-Id: <20260331073659.3136206-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_003714_250197_BC465FF5 
X-CRM114-Status: GOOD (  10.01  )
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d ]

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f09ebcbe1179..215aa871092d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4287,6 +4287,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
+
 	ctrl->admin_q = blk_mq_init_queue(set);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
-- 
2.34.1



