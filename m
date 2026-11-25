Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811E606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LzVoBnxF;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i7jh0Bdy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=TYIrA2bEc7vi7GsCVOnYEhD5OK0EsRjEDph/2j8WO2g=; b=LzVoBnxFig0A3Or44AuOwI9L2d
	8qAH07Qxptmj0X7t85nx+8N/EXLUvCLldj1hf0lSHtyAfAmQrf2H/iPUCyQ50YTx7AAoZjapirBKC
	3Hzgt59mJ6E8XuZSHBUocLjecyJhW6nCKdFQ7+rkYgu4LIHHzHfgMnN3uk44u6yIsJ1+GpUDFpOfG
	t47ydhTnaKtN3DRrnwf3VcZ2wgXjTmE9BuVeqvwCJi5o1FieXokLT/yVo5RhbglwuJwGnpNgDWtSY
	vbD/AhspC3G6jFKLSXy7WdPLxnTpe/VaCIXY49WoK2NI0iBeWpcsgMpU/y7ieqzv6y9xy9lcSOaG2
	jgSueZjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW654-00000008VyP-3tkB;
	Wed, 25 Nov 2026 06:02:10 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW64x-00000008VqU-28Lh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 06:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795586520; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TYIrA2bEc7vi7GsCVOnYEhD5OK0EsRjEDph/2j8WO2g=;
	b=i7jh0Bdy8nF7IrNlZ2p0fqH0r409QfrLWqaqh7fDVoLWTNPztuaQLnV1qq4IXXtPX1Ie6X2cCt9uKlDZXQudZJfk6wIF7rheT/qfv0TZNygCbiPcuVFv/4kG3Nt1E7x7gMeqTga+Isy189B58ARdWxYRIG3u3YRE8CYWhDxiLlo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFQaMPR_1795586518;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFQaMPR_1795586518 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:01:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: protect ana_log_buf teardown with ana_lock
Date: Wed, 25 Nov 2026 14:01:53 +0800
Message-ID: <20261125060153.206699-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_220204_057906_A44516A3 
X-CRM114-Status: GOOD (  11.41  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_parse_ana_log() reads ctrl->ana_log_buf under ctrl->ana_lock, but
nvme_mpath_uninit() frees the buffer without holding the lock. When
nvme_mpath_init_identify() reallocates a larger ANA log it frees the
old buffer through nvme_mpath_uninit(), while a concurrent namespace
scan in nvme_mpath_add_disk() may still be parsing that buffer under
ana_lock, leading to a use-after-free.

Take ana_lock around the buffer release in nvme_mpath_uninit() so it
serializes with concurrent parsers. Keep the ana_work drain outside
the lock: ana_work itself takes ana_lock, so cancelling it under the
lock would deadlock.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Reported by Sashiko AI review as a pre-existing issue (not introduced by
the ANATT timer fix). Confirmed by source analysis and reproduced in a
KASAN guest with nvmet-tcp loopback and ANA enabled.

The race is in the reallocation path only: nvme_mpath_init_identify()
frees the old buffer through nvme_mpath_uninit() before taking ana_lock
in nvme_read_ana_log(). The out_uninit path (failed ANA log read) takes
ana_lock first and is already serialized against parsers. The FROZEN
guard does not close the window: a tcp reset runs nvme_init_identify()
(in configure_admin_queue) before nvme_start_freeze() (in
configure_io_queues), and reset does not flush scan_work.

Reproduction: with a test-only delay in the add_disk parse path and a
forced ANA-log growth, buffer address tracking shows nvme_mpath_uninit()
freeing the old ana_log_buf while nvme_parse_ana_log() still
dereferences it; the reallocated buffer lands at a different address,
so the parser reads freed memory. With this fix the free waits for
ana_lock and happens only after the parser completes (free timestamp
moves after the parse dereference), and the use-after-free disappears.
ANA change/optimized transitions and multipath I/O remain unaffected.

 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3685c792181b..28ed3a677c10 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1648,7 +1648,9 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 	 */
 	cancel_work_sync(&ctrl->ana_work);
 
+	mutex_lock(&ctrl->ana_lock);
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;
+	mutex_unlock(&ctrl->ana_lock);
 }
-- 
2.43.7


