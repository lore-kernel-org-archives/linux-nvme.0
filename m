Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFFF10F9940
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ac+ld7PBnDtntUMS9S8A9+sf8tF7fABnrLxBZdtfty8=; b=K5rMdXhj0PwxoHP6GIwXy/EDnu
	uXy4B0Zj2t7Oj3xQD4NdzMveBK+NuqgxOY6/4ORGKwoPYbeMMZzMXYVlMgYKxei/1SJJAZZoTooUq
	uFE777QIFbDCKlJjKSZ0xaobDiaGuBbb02iV63LDRB9MJHmLpIl+RdXTZCavG0tz7muc2N0IgE6dX
	LzvJzCyAWs7HLmQHv1XlJ1mFfE4wQohXKrfwrtV0QiiFltn5oA5ryGkVLqyrttl84epcarBSqjKcx
	xlGpv+K5wvT0I4i9Xx+oEA6IAJ3kyAYDyQDDZ0WWg9GYBzkyZjPzzONYXw/4vuie4sMdhoP+3tWr0
	DXfpQL4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wATk4-00000008zKh-2fNL;
	Wed, 08 Apr 2026 14:18:52 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wATk1-00000008zKA-3j7S;
	Wed, 08 Apr 2026 14:18:51 +0000
Received: from debian.intra.ispras.ru (unknown [10.10.165.28])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6C47745F7988;
	Wed,  8 Apr 2026 14:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6C47745F7988
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775657925;
	bh=ac+ld7PBnDtntUMS9S8A9+sf8tF7fABnrLxBZdtfty8=;
	h=From:To:Cc:Subject:Date:From;
	b=KkOo6rDzgOhzmt/Dv2vYogRIIsqUNDCEo1aBqC06+JlxEM7oF8ShhurODjlhSnhiO
	 8Gc5YQxtPgh9priKaqEXx32AGIIOFoPduVUoOh8SjzvOQ9W+6tKlcNU4dxlOoaiB4I
	 Zx+p18z7AqSXSL1VrJzTPLlanaWSPAsQ+9NEoGH8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Heyne, Maximilian" <mheyne@amazon.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme-apple: drop invalid put of admin queue reference count
Date: Wed,  8 Apr 2026 17:18:14 +0300
Message-ID: <20260408141815.375695-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_071850_099374_FE550221 
X-CRM114-Status: GOOD (  11.62  )
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

Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
admin queue reference ->put call into nvme_free_ctrl() - a controller
device release callback performed for every nvme driver doing
nvme_init_ctrl().

nvme-apple sets refcount of the admin queue to 1 at allocation during the
probe function and then puts it twice now:

nvme_free_ctrl()
  blk_put_queue(ctrl->admin_q) // #1
  ->free_ctrl()
    apple_nvme_free_ctrl()
      blk_put_queue(anv->ctrl.admin_q) // #2

Note that there is a commit 941f7298c70c ("nvme-apple: remove an extra
queue reference") which intended to drop taking an extra admin queue
reference.  Looks like at that moment it accidentally fixed a refcount
leak, which existed since the driver's introduction.  There were two ->get
calls at driver's probe function and a single ->put inside
apple_nvme_free_ctrl().

However now after commit 03b3bcd319b3 ("nvme: fix admin request_queue
lifetime") the refcount is imbalanced again.  Fix it by removing extra
->put call from apple_nvme_free_ctrl().  anv->dev and ctrl->dev point to
the same device, so use ctrl->dev directly for simplification.  Compile
tested only.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: use ctrl->dev directly for simplification (Jens Axboe)
link to v1: https://lore.kernel.org/linux-nvme/20260403202701.991276-1-pchelkin@ispras.ru/

 drivers/nvme/host/apple.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..423c9c628e7b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1267,11 +1267,7 @@ static int apple_nvme_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
 {
-	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
-
-	if (anv->ctrl.admin_q)
-		blk_put_queue(anv->ctrl.admin_q);
-	put_device(anv->dev);
+	put_device(ctrl->dev);
 }
 
 static const struct nvme_ctrl_ops nvme_ctrl_ops = {
-- 
2.53.0


