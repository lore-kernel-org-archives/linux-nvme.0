Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE830E85368
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rkMgPId7pYnnvNbAuwYM5wExpHWHyYhMeO7FUfW2+ho=; b=wZa5XGyugIk6OkJrvyB0nqvaPb
	/sW8f0vD+Pd4pkvH+KVhLvEaCWAIGZrcBSDv1Zj0oRznP9im2gX0NdFM1f7tpvra00u+qJwI2rhRM
	SKTvneVQQJLfj2LejzSGL4KhH9eFjZ6k1XTtj2dBEY79/vf3eLic/cTi4Js2oxu+0EJPD1GlnbBCv
	WzpdbeCj5Ihph8t1I278AqGjH1HcjEU6Kf4yLeRhInrwCuA3H6NJDyOOYHx2NJiVEYVEaje0Hlj+B
	NutXUQhVe6vX453xnaPKZmMOvKFYavFRz1QOoGW+Lvn5HjlxsFx3qQ5c6pkZ4Rb2CyieC4k1Lszgl
	SAN6/wkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8l8h-00000002XAY-19L2;
	Fri, 03 Apr 2026 20:29:11 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8l8d-00000002XA4-3tlO;
	Fri, 03 Apr 2026 20:29:09 +0000
Received: from debian.lan (unknown [79.139.252.175])
	by mail.ispras.ru (Postfix) with ESMTPSA id CB3C045A1D06;
	Fri,  3 Apr 2026 20:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CB3C045A1D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775248142;
	bh=rkMgPId7pYnnvNbAuwYM5wExpHWHyYhMeO7FUfW2+ho=;
	h=From:To:Cc:Subject:Date:From;
	b=kOolXopkJtnCfd+9m8RNpBDmXydllXw3oykDCDNbEpSHP0DisAbGRJiGpW3FTRp6p
	 0dkuNbDhU9KFyGKb4JdvMVGzHOOgLGFHuABWqABZOiVj6x0yAlJKaigNotN5Es24jh
	 j9xqoW7gspk2ovsJBViM+PvF5ADZlvItRSQhTTgs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH] nvme-apple: drop invalid put of admin queue reference count
Date: Fri,  3 Apr 2026 23:27:00 +0300
Message-ID: <20260403202701.991276-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_132908_499296_597ADABE 
X-CRM114-Status: GOOD (  10.98  )
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
queue reference") which intended to drop having an extra admin queue
reference.  Looks like at that moment it accidentally fixed a refcount
leak, which existed since the driver's introduction.  There were an
initial ->set and an extra ->get call at driver's probe function, and only
a single ->put inside apple_nvme_free_ctrl().

However now after commit 03b3bcd319b3 ("nvme: fix admin request_queue
lifetime") the refcount is imbalanced again.  Fix it by removing extra
->put call from apple_nvme_free_ctrl().  Compile tested only.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Cc: stable@vger.kernel.org # depends on 941f7298c70c
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Also nvme-apple seems not to have a blk_mq_destroy_queue() call for
admin queue since introduction - if it's needed, the proper place would
be in apple_nvme_remove() just before calling nvme_uninit_ctrl(), I guess?

 drivers/nvme/host/apple.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..1d82f0541b0b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
 
-	if (anv->ctrl.admin_q)
-		blk_put_queue(anv->ctrl.admin_q);
 	put_device(anv->dev);
 }
 
-- 
2.53.0


