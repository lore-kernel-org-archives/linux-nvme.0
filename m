Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B320FC636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SdOKPys10+s90HwEwcRvVsoRqRW9tQm2oB250QRj8CY=; b=Ld3YXVp5HuT1HFW5/3NtX981Lg
	smHixyFI9Ac2/QUdcYdWcOjALh7wAB+ognAwn/ohUqzM1KSbhNGxQL3liXuH6ZJpavhVXn0DM1t9L
	r7FmRy7/j+QmPqIfOJKsf/SkHIyf4QaMNcEmZjyJOA4BvU3vRiHVxJDOJIxeUBB0P24RqNZM80Dpb
	VoNQUgBTBXWgC92seGFeNR4aOLjd0cvoe7YKye1NJSe+8/48jJpOhJ3Ho7lMnvnGBIRaqHMDg/2xt
	mm7VSq727Gw7RkjIhuXIYho8cXeJjpvuOyLUT0ptqiV4IhE55d0Bud4t69uWG/7QzvWqg2pViXLUc
	JM5QY8jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmwK-006zp8-Ap; Tue, 31 Jan 2023 09:28:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMmue-006ywX-On
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 09:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675157208; x=1706693208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mypstlDWo3hd3kEN8snvSpw5q7BNT1dboEmVC2C1rJg=;
  b=K7sj6ajsFWazH76kH//AN+uCI53YEv+oUJ913ijOhPvoFP0PPgG7tEk0
   aXYipz2sNHsXuPRB0QWdFsekQeDD9AsTFdo3sdbL/9DD33gD1yHQ3QuiT
   afxpkQ2CjG2Nqty6e6+aGlxOdZiJlJCTGHLk85J/BQhZ+SXsFsSpzkf42
   ycAjMXAgRYWnjhBdme4IF1V4HCeMclJioVSKJ5y+jZeBX9OYlja8AzYPR
   SxwIpIMbNWkaEG5hWMDy+4nI6dqqCFV9ZJqcXz1Rg5n69J6Bjy3JXUINi
   CT9O5zxyYhyKGXYaOnskvp+z69ZqduovjKI5BJ3m1d+bw19YM/9Z0nTwe
   A==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="220491945"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 17:26:45 +0800
IronPort-SDR: NLGlocFUXUCmJs4g79O9NFaVTQnHLUjlHR4ytbgoL0cO3GMml4HgdHTDzDh7MXKjSJRtpMmouz
 m94yIeoIemwKwIjMx7W9zR+rXdt2P/p7uNFuEd33Y7FMA7m0IiYB1QRbtp3iNnQSAg7AOQL6Hq
 eSMX6hKtWkvO/LdI1/nzlT98uKLmJYDjEZmbEgPyl6WYxopj7smKhJydBLVLdsLlrKDNSbYZwh
 fNizVNsFNTNiIvqOx4j7qyMgiGy7d1MW6jCKVMDeAZAgNr750VfucgPfyHV+A7FjvVqh33Syai
 EBE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 00:44:10 -0800
IronPort-SDR: xl1c50hLvzl/NKeJwV8zSLEypuFtXWcRSe+2SK6hcVg7lsuGNoq4g/7KJqS613u9BeHnTHKxq6
 rZSktS3Zvs9WzfgjLb1uMmeuJV9P+2LIZE9GX6N9cyR8HEOScdUa7RB9JgtzdFZ2dvAf3ROxve
 ZCl2SV+/N9DPJQPZ/CwaFwkDArVR4xseSq6O41qowAX0JObueVd8qvpeBjfCmfd3I8j26zKU5C
 9JV/UHeZ5mkMRV+i2WTypC+E/KlgYoNLurHOn68bkXvoc7fZs5o+KpT80Da1jFicOLMcKVTuJa
 7aI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2023 01:26:44 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Daniel Wagner <dwagner@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme-auth: use workqueue dedicated to authentication works
Date: Tue, 31 Jan 2023 18:26:44 +0900
Message-Id: <20230131092644.1428477-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_012648_920985_02BF8F51 
X-CRM114-Status: GOOD (  14.27  )
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

NVMe In-Band authentication uses two kinds of works: chap->auth_work and
ctrl->dhchap_auth_work. The latter work flushes or cancels the former
work. However, the both works are queued to the same workqueue nvme-wq.
It results in the lockdep WARNING as follows:

 WARNING: possible recursive locking detected
 6.2.0-rc4+ #1 Not tainted
 --------------------------------------------
 kworker/u16:7/69 is trying to acquire lock:
 ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: start_flush_work+0x2c5/0x380

 but task is already holding lock:
 ffff902d52e65548 ((wq_completion)nvme-wq){+.+.}-{0:0}, at: process_one_work+0x210/0x410

To avoid the WARNING, introduce a new workqueue nvme-auth-wq dedicated
to chap->auth_work.

Reported-by: Daniel Wagner <dwagner@suse.de>
Link: https://lore.kernel.org/linux-nvme/20230130110802.paafkiipmitwtnwr@carbon.lan/
Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/auth.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4424f53a8a0a..b57630d1d3b8 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -45,6 +45,8 @@ struct nvme_dhchap_queue_context {
 	int sess_key_len;
 };
 
+struct workqueue_struct *nvme_auth_wq;
+
 #define nvme_auth_flags_from_qid(qid) \
 	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
@@ -866,7 +868,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 
 	chap = &ctrl->dhchap_ctxs[qid];
 	cancel_work_sync(&chap->auth_work);
-	queue_work(nvme_wq, &chap->auth_work);
+	queue_work(nvme_auth_wq, &chap->auth_work);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
@@ -1008,10 +1010,15 @@ EXPORT_SYMBOL_GPL(nvme_auth_free);
 
 int __init nvme_init_auth(void)
 {
+	nvme_auth_wq = alloc_workqueue("nvme-auth-wq",
+			       WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvme_auth_wq)
+		return -ENOMEM;
+
 	nvme_chap_buf_cache = kmem_cache_create("nvme-chap-buf-cache",
 				CHAP_BUF_SIZE, 0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!nvme_chap_buf_cache)
-		return -ENOMEM;
+		goto err_destroy_workqueue;
 
 	nvme_chap_buf_pool = mempool_create(16, mempool_alloc_slab,
 			mempool_free_slab, nvme_chap_buf_cache);
@@ -1021,6 +1028,8 @@ int __init nvme_init_auth(void)
 	return 0;
 err_destroy_chap_buf_cache:
 	kmem_cache_destroy(nvme_chap_buf_cache);
+err_destroy_workqueue:
+	destroy_workqueue(nvme_auth_wq);
 	return -ENOMEM;
 }
 
@@ -1028,4 +1037,5 @@ void __exit nvme_exit_auth(void)
 {
 	mempool_destroy(nvme_chap_buf_pool);
 	kmem_cache_destroy(nvme_chap_buf_cache);
+	destroy_workqueue(nvme_auth_wq);
 }
-- 
2.38.1


