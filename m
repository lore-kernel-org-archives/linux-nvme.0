Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E8606A330
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sTVj/gc8;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GuYxsKKp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=wUF3/8IILID0HLkvIG8NXcs9zjVwCzowa8kfUtE9rNg=; b=sTVj/gc8CM6Zb66kzd5JJJyHbY
	PdQuE2Id/Js+5T3/yNzw5MhV+zpluKImvSWxa7D7ray5Nr57CiffCLtDhi7i+DF/AohPa/ma5onjE
	16/I087sehZMXl1wDr45qL3OZ0Ocxz9vCXk1JR3wisyPCF7pWpr03qLO9o1GsEcvrAwYOvP75qXlW
	AF12UHDDEOeHDyC4Sy/yvU5z+Rym207sDfqjACFLgmnxwg2B4F9d//YICrD4ipp+ublJ9f7OmpbtY
	4/wvSs2C09EWA7Xxxc8OqclCs8yYZXla4Uru2ZUg4dzGXJgcJSrMJqBldg5OPfdGYGhPOxb3A+VxP
	h4DVkoLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJdC-0000000EIC5-33sz;
	Fri, 20 Nov 2026 08:06:02 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJd4-0000000EI9T-32fJ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 08:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795161947; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wUF3/8IILID0HLkvIG8NXcs9zjVwCzowa8kfUtE9rNg=;
	b=GuYxsKKpoivslQ9TbJkTzIpn6QnoDdrRgEcyXtMg9uP0JVLUa5TtL3m8rb+Mg3xIahhjQJcHm9HSX6nKwi5uqN3/i2I4q9g8U1CPWRNQ8iPcv4k8nrh/r4+RLdP7zlb++buFYDvScDZDzx84kCOHX34Q4JdfMqMNNcnaAbwFNkg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF5jgQJ_1795161945;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF5jgQJ_1795161945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 16:05:45 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-fc: skip hostport handling when the LLDD provides no hosthandle
Date: Fri, 20 Nov 2026 16:05:40 +0800
Message-ID: <20261120080540.1177154-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_000555_655061_34A31454 
X-CRM114-Status: GOOD (  11.69  )
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

nvmet_fc_alloc_hostport() returns NULL when the LLDD does not implement
the hosthandle abstraction, but the association lifetime code assumes
an association always has a hostport:

  - nvmet_fc_xmt_disconnect_assoc() reads assoc->hostport->invalid
  - nvmet_fc_target_assoc_free() drops the hostport reference
    unconditionally
  - nvmet_fc_invalidate_host() compares assoc->hostport->hosthandle
    while scanning the association list

The first and the third dereference were introduced by removing the
NULL checks on the assumption that an association always has a
hostport, and the second by inlining nvmet_fc_free_hostport(), which
dropped the pointer check of the inlined helper.  A Create Association
failure on such a transport then crashes the target.

Restore the checks: skip the Disconnect Association exchange, skip the
hostport reference drop (there is no reference to balance, the
association never took one), and skip hosthandle matching in the
invalidation scan.

Fixes: 50b474e1faff5 ("nvmet-fc: remove null hostport pointer check")
Fixes: 88517565b5929 ("nvmet-fc: inline nvmet_fc_free_hostport")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 5d6c1c79508a..3fb4f5b318fe 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -481,6 +481,8 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	 * message is normal. Otherwise, send unless the hostport has
 	 * already been invalidated by the lldd.
 	 */
+	if (!assoc->hostport)
+		return;
 	if (!tgtport->ops->ls_req || assoc->hostport->invalid)
 		return;
 
@@ -1183,7 +1185,8 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* Send Disconnect now that all i/o has completed */
 	nvmet_fc_xmt_disconnect_assoc(assoc);
 
-	nvmet_fc_hostport_put(assoc->hostport);
+	if (assoc->hostport)
+		nvmet_fc_hostport_put(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1533,7 +1536,8 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
-		if (assoc->hostport->hosthandle != hosthandle)
+		if (!assoc->hostport ||
+		    assoc->hostport->hosthandle != hosthandle)
 			continue;
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-- 
2.43.7


