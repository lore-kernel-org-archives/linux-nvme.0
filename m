Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E3CA5FAB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=StVMALYl7NrhXL0BqWH9nKh8uCpTcpQuXS9uSRoi8JE=; b=Bj6l/WEojoGFTt/XHbXWKGyt0Y
	z1URzCQWv7Ibw91i57C62VoIT5WFeT+Lr9LCvzhLwhZAdzX1Hbz4nvl+BBs5ORGi9HRW1F4jdeoYh
	N9U/WFOgMBKlQRgbX8NT+tk8DOoNJUM70eOSd9GjnG6zPZPcZ15zEE5+cuYlpQz/gIUSMNR8aNEaj
	GjJ1EKQ8Y/TLtkmZ0FA8CGTcTMs4ncBU3O1oXGX2Tu1kZ9xB9pMUyd+A3YFeSNJySnqCiG1KDTd6E
	RKpHUb4NPdfwQPnJBGxU9mE3BrDOM/Wpg+a0pgrHGSfJeMDjtSfu08cVJhtqYj/OqgPvM1CDbNbgF
	y9lzqPVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnmM-000000058XX-1CEy;
	Wed, 30 Sep 2026 06:26:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnmJ-000000058XO-43WP
	for linux-nvme@bombadil.infradead.org;
	Wed, 30 Sep 2026 06:26:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=StVMALYl7NrhXL0BqWH9nKh8uCpTcpQuXS9uSRoi8JE=; b=Ybk4yMZRBNpd2d1EfSIQoIr1Ka
	GaooQmBStLQpPxy1Hy10uer4SkChDZDd3FNIRS/YvH/jOr4tZ2BSN9YItesIFHvX19OmEf9HIAHaZ
	7yRlx89StgNENFAuslleIefoQH0aHIkiKil9cf00jCiG5XiSUVdQHQTXxGfwtfwpVmdGfRV8kGPAY
	3wfEkt1q2VwAJay9wLMgiKUsvJofXe+ATLTo0Q2298Xlq9aoGdARbs31WCsr2f9GadaKozlgrFQZF
	5eDx4WYPvcXW0Tr2byZcOcKA/Op0GtyFPtpnZ8LFE5VjObni6hXYBtAlzdQatRVYaqd+RHxUiaBZN
	OcbJz5jA==;
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBnmG-00000003Pdb-2jml
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 06:26:54 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912d3931so37197515e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 23:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790749611; x=1791354411; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=StVMALYl7NrhXL0BqWH9nKh8uCpTcpQuXS9uSRoi8JE=;
        b=s3r4hbyw10oR3MHRjO3CZLqSI16YQyW1wm62b6BaUSKWHdKYqN9lQtjZ9nSo9kseS/
         +JzzhDzKIuUdIYow/ZiaSJc1BricdQvONUXcysI/Swo/6l2xcjB13Ri2ZGKKUdW7lxll
         jF/sT4izp86Q+UxHHU1SauID2d0cZDzQwwZMf1++YcQAoUtrgvCcJtM59VteQImUW8jq
         nxwR30hEH3gMuqEtU7wvZ/BASa9NpxMzzF2cqHfUQ8/M2FEoTwoiVIefmJ2e1+0HlF1T
         /gCkHg0xFvzmurjWV3tHbaC6bWo1BdCsTOJ07OBUtPclJrJbCvDnE53xJvcud+Vrcmfa
         K/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790749611; x=1791354411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=StVMALYl7NrhXL0BqWH9nKh8uCpTcpQuXS9uSRoi8JE=;
        b=C1GITAxhf8RkddxlsFieMI0dO5r+4Z89t4U/MiJTsMg8G3ToqK7piXcWdAgBMLfr/h
         /ImZbqpfO06xGfjW7ua7Z4kMqFsJCC7xUVv6FJWCneUXVY41x1zPmLlo1CEiv5ALnbMG
         UqMiqdh+QScuPfAxtyJ66zNWa5WBUt62zM7bBM7LV3E3W14ja5aGjMJ5T5rc1H6N+Oa/
         /YVQelzk/hTKNnX+MI+RlvBCbLQDjhOMIGD0dJTYCAfzZBKArNPLLC2N+13KjoojeoT+
         BG9JkFn7gEgv6DvnKuQ7xhu1C/rpe1ZNsLLfYTHXS87Xyrk7zK5A0JbxHNo2sHDgGZxe
         ceTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjDJ4UEaTiJDJ+aOorWOab6GUUYq2mdLdAa9UPomEyxPnMzm6+oFl1p+A9UUdjcfZbUl5cEs7nSLl8@lists.infradead.org
X-Gm-Message-State: AFuF++mxmb7B9cdVy0LYTOPotitaaBaEorOo/57Zrlkexq47BrzXPKPy
	pFTc9PoZoxeebmzx3cmuTjKSKIMXykIALKUAIfYDD1xbX6U2cdMYMge4
X-Gm-Gg: AYBFou0JuFIE/aA99a3eeZfVObKvKzh5Ybc/Ya66/mbYS+sgdbwfwVzZ4TrYAZMGcIw
	Ph7mNj8pFzGnh+hKHCk8/tD7n7GobfPchTK6QGLuYBSHaBozR5yCWIDvHJbmfjKH9aXHH9Cwd3F
	T6BCGzXBnehIk5SkBCQt8yxAQfNYOgopuvvqat6ow3tSenQBJ2XoDHT2EhA6tQ2Zktnt54Xzi5t
	UbwvRg2BVK90z8LmgCtE3KKMoArGSNFkor7wHEXqMJ++NR2zBlfIigruCP3V3vK0+geQmmueBXu
	gWsbvblOKsnV8f5LC1iMTHPOHAf9v1yUIZEEpbzG40M3JPzlYJ4nGyJRuCboO+3eA6QrYAC7j7Z
	M8nUfJAub1Y3xef/e38dEo/pduJaRpjjQQlCSCde+TvXd0IpQOsMI7VUyfH+HzX26KyxuG47KJE
	wYzg5Hy2H0zLK/7p9XV7My54lEzb4hf700ts7wqO0eXHkR7QQEDEEEVS1x1KopYBcpeDAeCoczQ
	bKAYLJsRSdJP6VryVU+QtU9Md6iDRBx91FsSaK7FzNJsczU/qSvu0Zkht6R3NaykZU=
X-Received: by 2002:a05:600d:4448:10b0:49f:fd4c:cccd with SMTP id 5b1f17b1804b1-4a01b11e83bmr2983255e9.28.1790749610287;
        Tue, 29 Sep 2026 23:26:50 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01b1e79e4sm6866825e9.2.2026.09.29.23.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:26:49 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com,
	syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: revalidate head zones after unfreezing the head queue
Date: Wed, 30 Sep 2026 07:26:47 +0100
Message-Id: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_072652_961791_48ACB9CB 
X-CRM114-Status: GOOD (  20.11  )
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

When a namespace on a multipath controller is updated,
nvme_update_ns_info() freezes the head disk queue, commits the new
limits, and then calls nvme_mpath_revalidate_zones() before it
unfreezes the queue again.

That is the wrong way round for blk_revalidate_disk_zones(). It starts
a limits update, which takes q->limits_lock, and it freezes the queue
itself while updating the zone resources. The block layer takes
limits_lock before freezing the queue, never the other way around, so
calling it with the head queue already frozen reverses that order.

syzbot has hit this twice. One report goes through q->limits_lock. The
other one is on linux-next, where blk_revalidate_disk_zones() also
takes disk->zone_revalidate_mutex and holds it across alloc_workqueue()
the first time a disk's zone resources are set up. Lockdep then sees:

  q_usage_counter(io) (frozen head queue, nvme_update_ns_info())
  --> &disk->zone_revalidate_mutex
  --> wq_pool_mutex --> fs_reclaim --> q_usage_counter(io)

  WARNING: possible circular locking dependency detected
  kworker/u8:10/3352 is trying to acquire lock:
  (&disk->zone_revalidate_mutex){+.+.}-{4:4}, at: blk_revalidate_disk_zones+0x1c5/0x1650
  but task is already holding lock:
  (&q->q_usage_counter(io)#75){++++}-{0:0}, at: nvme_update_ns_info+0x3ac/0x1200
  ...
   blk_revalidate_disk_zones+0x1c5/0x1650 block/blk-zoned.c:2560
   nvme_mpath_revalidate_zones+0x106/0x1c0 drivers/nvme/host/multipath.c:301
   nvme_update_ns_info+0x984/0x1200 drivers/nvme/host/core.c:2620

The rest of the driver already does this correctly:
nvme_update_ns_info_block() unfreezes ns->disk->queue before calling
blk_revalidate_disk_zones(), and nvme_mpath_set_live() revalidates the
head zones without freezing the queue. Do the same here, and only
revalidate the head zones once the queue is unfrozen and the limits
update has succeeded.

Fixes: 224041412693 ("nvme-multipath: revalidate zones for namespace heads")
Reported-by: syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0910be96b7c31314822
Reported-by: syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e02ccadb3c5522a5c59
Link: https://lore.kernel.org/all/2bfc96f2-7d0d-47e0-936e-8810abb31a9f@acm.org/
Cc: Shuah Khan <shuah@kernel.org>
Cc: Brigham Campbell <me@brighamcampbell.com>
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 drivers/nvme/host/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ee7d09030c18..5d7dfd7a63d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2617,10 +2617,19 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns->head);
-		ret = nvme_mpath_revalidate_zones(ns->head);
 
 unfreeze_head_queue:
 		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
+
+		/*
+		 * Wait until the head queue is unfrozen before revalidating
+		 * its zones. blk_revalidate_disk_zones() takes the queue limits
+		 * lock and then freezes the queue on its own, so it must not be
+		 * called with the queue already frozen. This is also what
+		 * nvme_update_ns_info_block() does for ns->disk.
+		 */
+		if (!ret)
+			ret = nvme_mpath_revalidate_zones(ns->head);
 	}
 
 	return ret;

base-commit: 4a5e49ba0abb8b4328d6318c9aef0c0121f95507
-- 
2.34.1


