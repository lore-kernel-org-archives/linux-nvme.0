Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DFAC44501
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p5jzsHOIycUcrMTy/H8KSOotdO8DAPpOaD75wfpgfoA=; b=THd05jxvM9lJKwOnCfPa3jib7g
	DNtH7OQmbGdwri7R+CK+K0mz4MBqZUA5mZX6nTK4aBT6lSLe2jHQZ328Z/AixvhCC24Uilwj4qZh7
	EG7bTzfzfS3IB+RRiHiomuXBSo3dIG3JLpoFygkAYa4gk367bMSW8Gs5L4BtM5ixQixich5OvC9DF
	iQ1K1NMPD4m4Ik2CkzNvm9bumYK7vSgpJ9IZb5nGJORmUj/MN8PLaFN161V46+WcvufQBE/rZbmvY
	Cjovrw/Ecrhreg6SE4vmnxpFUpBysOXxzKpW3XUzc746xtM5L8xmrdfinuCqk4Zd3IXxb/oZj5hMA
	fI6iL55w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUgZ-00000005CKw-2CZx;
	Wed, 21 Jan 2026 09:39:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viUgX-00000005CKI-0RY4
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 09:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p5jzsHOIycUcrMTy/H8KSOotdO8DAPpOaD75wfpgfoA=;
	b=L3s87W4j9ABTqYnqu5OjIraoc01BSjSW+XVp1csWINgejq9/xl2fBwFZkcxOFBTHkEEXZI
	5bb4HLQ3j5lxIG++XF+dS9SW0vsdiTblDkf7KhIfjvIJozjxlm0uBPyx0nMvc1bwOFb7fc
	jFei4rXxEeZcg08UqsjWoqJaxQmaDrQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-CGOyXWI3MrC7WyZiDbSpjg-1; Wed,
 21 Jan 2026 04:39:25 -0500
X-MC-Unique: CGOyXWI3MrC7WyZiDbSpjg-1
X-Mimecast-MFC-AGG-ID: CGOyXWI3MrC7WyZiDbSpjg_1768988364
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 799BA1954B06;
	Wed, 21 Jan 2026 09:39:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2A681800665;
	Wed, 21 Jan 2026 09:39:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	stable@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference
Date: Wed, 21 Jan 2026 17:38:54 +0800
Message-ID: <20260121093854.1705806-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_013933_216955_674EA147 
X-CRM114-Status: GOOD (  12.89  )
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

There is a race condition in nvmet_bio_done() that can cause a NULL
pointer dereference in blk_cgroup_bio_start():

1. nvmet_bio_done() is called when a bio completes
2. nvmet_req_complete() is called, which invokes req->ops->queue_response(req)
3. The queue_response callback can re-queue and re-submit the same request
4. The re-submission reuses the same inline_bio from nvmet_req
5. Meanwhile, nvmet_req_bio_put() (called after nvmet_req_complete)
   invokes bio_uninit() for inline_bio, which sets bio->bi_blkg to NULL
6. The re-submitted bio enters submit_bio_noacct_nocheck()
7. blk_cgroup_bio_start() dereferences bio->bi_blkg, causing a crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000028
  #PF: supervisor read access in kernel mode
  RIP: 0010:blk_cgroup_bio_start+0x10/0xd0
  Call Trace:
   submit_bio_noacct_nocheck+0x44/0x250
   nvmet_bdev_execute_rw+0x254/0x370 [nvmet]
   process_one_work+0x193/0x3c0
   worker_thread+0x281/0x3a0

Fix this by reordering nvmet_bio_done() to call nvmet_req_bio_put()
BEFORE nvmet_req_complete(). This ensures the bio is cleaned up before
the request can be re-submitted, preventing the race condition.

Fixes: 190f4c2c863a ("nvmet: fix memory leak of bio integrity")
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: stable@vger.kernel.org
Cc: Guangwu Zhang <guazhang@redhat.com>
Link: http://www.mail-archive.com/debian-kernel@lists.debian.org/msg146238.html
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..0103815542d4 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -180,9 +180,10 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
+	blk_status_t blk_status = bio->bi_status;
 
-	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
 	nvmet_req_bio_put(req, bio);
+	nvmet_req_complete(req, blk_to_nvme_status(req, blk_status));
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-- 
2.47.0


