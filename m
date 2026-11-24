Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A7606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uhtieHup;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vVQwKm3A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=xv2cGYUlUPKdQTQ79SVC67Asn6azRCfuPrajbcvhu5g=; b=uhtieHupYGosFFcHzWmzI5ohWJ
	OAC/vCoL1Bk1dIDIXFWK05bI0Ri+xvd/aPqlfwzt7xYtpdLsDFELh4TmgR42PoiQ5fH60X3txD7f7
	BIw+l0N1n3FUiYrHsaDZH6rpJs+T6W7WpvNXuErKAb+nPxgKfr8+rdcmezWFUuP3iKNCsnug+uSa7
	TiYeQvoRixDVkxREHYbFzIH4yoIYzAvNd38ygvOArG0epzctDRvNONvwJn4gybS8KxsHnwqWLuued
	POtM2swAaoFwhHmOU4CznqDpAegFmmIzNe9BobdTyq1DYvKP/DMJncH2z3NWr+WBmSxig0XS3Z1b0
	0UNyXyOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpPR-00000006UMt-1WRK;
	Tue, 24 Nov 2026 12:14:05 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVpPL-00000006ULj-1Waj
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 12:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795522435; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xv2cGYUlUPKdQTQ79SVC67Asn6azRCfuPrajbcvhu5g=;
	b=vVQwKm3AyZgq+rnMyo8Kg+pdn9QOYeMglNu6DQELnJQaam1L/cxgO3pKpV6w5KguSrpWNSNkQSAddbtmaPotj/u/S+/bkzs+mVBgAbbkIpdX8BL06mtbbeNfKB4vj1+8J8y56Xfi+/cOYYw8nnV9XFThQRuUDCOuR/b0nYikL0E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFOVGpo_1795522434;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFOVGpo_1795522434 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:13:55 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: delete the ANATT timer after draining ana_work
Date: Tue, 24 Nov 2026 20:13:49 +0800
Message-ID: <20261124121349.1861269-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_041359_944040_EF40C11D 
X-CRM114-Status: GOOD (  11.56  )
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

nvme_mpath_stop() deletes the ANATT timer before cancelling ana_work.
An ana_work that is already past its controller state check can still
read the ANA log and arm the timer after the timer was deleted. The
controller is then freed with the timer armed, and nvme_anatt_timeout()
dereferences the freed controller when it fires.

Cancel ana_work before deleting the timer so it cannot be armed again.
Also delete the timer in nvme_mpath_uninit() after draining ana_work:
commit 9b657c565984 ("nvme: stop asynchronous event work before ANA
teardown") added the work drain there because ana_work has multiple
producers and nvme_mpath_stop() is skipped once ana_log_buf is NULL.
The timer needs the same treatment before the ANA resources are freed.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Found by code inspection; reproduced in a KASAN guest with nvmet-tcp
loopback, two paths and an ANA group in change state. With a test-only
delay widening the ana_work window, deleting the controller while
ana_work is in flight arms the timer after nvme_mpath_stop() deleted
it, and twenty seconds after the controller is freed:

  BUG: KASAN: slab-use-after-free in __run_timers+0x887/0x990
  Write of size 8 at addr ffff8884ec888e00 by task swapper/24/0

With the fix the same recipe completes with no splat and both
controllers are removed cleanly. ANA change/optimized transitions and
multipath I/O were verified unaffected.

 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3685c792181b..bd27a5355bab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1074,8 +1074,8 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_ctrl_use_ana(ctrl))
 		return;
-	timer_delete_sync(&ctrl->anatt_timer);
 	cancel_work_sync(&ctrl->ana_work);
+	timer_delete_sync(&ctrl->anatt_timer);
 }
 
 #define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
@@ -1647,6 +1647,7 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 	 * resources.
 	 */
 	cancel_work_sync(&ctrl->ana_work);
+	timer_delete_sync(&ctrl->anatt_timer);
 
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
-- 
2.43.7


