Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED4FC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:45:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017A160E78
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 017A160E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+gXmk8EKHsyoqU5DbX0qcOTI8R5feflhDV4b+H5vm8E=; b=j9u67xo83No7H6
	/dIajFBSCijgMLkzVpi9xJAt0007SteLxScOs81bRjoKaVhZuXQRBxkqHOTea8ZSYc5BsQZb4SJ5M
	MQYF1o4pMC4Lo3z1il9aRSZdMvCJBc8SQCGS6Mlp7HfMRA6qr9efcBNnABeAdD22oasMqtmz7UjNU
	liUZZqypINaO2ajJHU6yblEmdg9AUDw23ts77TCm6X35JlYa9Gl4HkDM2dn2LC+3TipksxF6vLGR8
	SzAkzlVz6yJIDRz8+tZ2KEkY1VI9JzKhkDBmenJWWA+mrfkGjtE+MdDWuPk+s0AYObGKEjd7nmtjB
	CHWcIlwbyes14nGH+ykw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCz20-00HHAK-8d; Mon, 09 Aug 2021 06:45:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz1y-00HH9z-Ss
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NyjYltYC/raPlF4XHxY3F3mjS/roqOl5OXN2A+UG0sI=; b=XZ6Fe+c5WNOFVTjVMBbxBIYwan
 kL5bvLiWDk3ACEJbkJIh5zEAbxuSN+MsbJDwesuoaxxImWmaxyXh/frS+U19dFu0G7r9/n+9tlNHz
 VCtOyz+kJ/h1Nlx/nuaBBjuoeTAKm2ii/Hq0fHLb7IPwS6LMFgk7zoD/2UOlQpY+nt7yhpfPkGGLu
 RaLw1uVCSJbyPY4Inv/2gCXwYecsVAxRjZdErcC0yH69I0/+GOkhPyqJo+w+anKm0FMDxNM7IV9IX
 eZVSzPRvs1YMM4n1j+x0rg2PLhIiOU9w97Z8MeA3grTRsoWNxGe5o0odFl2MQkpEiCXhaaAoHSeWe
 J8SpJHQg==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCz1G-00Aild-HU; Mon, 09 Aug 2021 06:44:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH 4/8] nvme: replace the GENHD_FL_UP check in
 nvme_mpath_shutdown_disk
Date: Mon,  9 Aug 2021 08:40:24 +0200
Message-Id: <20210809064028.1198327-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
References: <20210809064028.1198327-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the nvme-internal NVME_NSHEAD_DISK_LIVE flag instead of abusing
the block layer state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3f32c5e86bfc..37ce3e8b1db2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -765,7 +765,7 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 	if (!head->disk)
 		return;
 	kblockd_schedule_work(&head->requeue_work);
-	if (head->disk->flags & GENHD_FL_UP) {
+	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
