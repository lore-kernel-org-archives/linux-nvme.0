Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78E606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HmnlXXPv;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sNkcoOVM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2noysjaSp3ERaQjsD4sxtAoulap4dK8zq09oSnMf/AQ=; b=HmnlXXPvyY95of
	wKTXtqQKzv/h9YDRCMRpvF8cSfHTC/jaVJbcrw9mSlsSzwL+zJGhGRTHWZSYqDk+d0zuUR+hFaINt
	PFlcxzDcOr2i5M/ifo9v4Kcgf7NC57iPzdhEDLhHAUYpC6uzXjZor2AyHjnPMi8L2UPtVnNDXzgZT
	/oXAJmewylrtgfQEXxyLCr9YgRicnbujb+vn4prxYe0dtP1AoAIKizGhB5otwZ+50IQTKR8QR2x0s
	zzSqJyVIVUAtSuwd9ehFIFwaxMBdM6FiTUJV6wSsGyFPXHlxWWlR76XcnzPWD3xHyz36XuTOQ0BYa
	GCxv6dKbeWSuVdidi1bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86I-00000006mZb-03yE;
	Wed, 11 Nov 2026 13:10:54 +0000
Received: from out-251.mta0.migadu.com ([2001:41d0:1004:224b::fb] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR86E-00000006mYn-2z0x
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 13:10:51 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=T4ExZyp/crnoP7oxiw7TmItFm5LUi91dgIznIGmYWtk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794402648; v=1; x=1795007448;
 b=sNkcoOVMnBNkfCpUqI/0FOkLTCu/X1atKAXJ1Px5JYFhInqvNKP3NBxY1mVhMnRmoCSVtOOn
 JI0tV58WaQ6hy3qUDaGl1XYbSxK/oBIUEb0YVQsRFT9CAwnp0xcqexoAsSDjfh4/jbSWvUDpjGI
 /sIMnFfGfq0h5HqJayA1O8v8=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 6fb6a724c8cd48c7;
	Wed, 11 Nov 2026 13:10:48 +0000
X-Mizu-Trace-ID: 6fb6a724c8cd48c7
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 11 Nov 2026 08:10:21 -0500
Subject: [PATCH v2 1/2] nvme-multipath: fail queued I/O when
 delayed_removal_secs is cleared
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-bug-nvme-mpath-set-live-srcu-v2-1-fc772914d293@linux.dev>
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_051050_922415_D4822428 
X-CRM114-Status: GOOD (  13.23  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With delayed_removal_secs set, bios submitted after the last path goes
away are queued on head->requeue_list, in case a path comes back before
the delayed removal of the head.

Writing 0 to delayed_removal_secs clears NVME_NSHEAD_QUEUE_IF_NO_PATH
but doesn't kick the requeue work, so the bios already queued stay
there until the removal work runs, up to the old delay later, instead
of failing right away.

Kick the requeue work when the attribute is cleared, as
fail_on_ctrl_loss_store() does when it is set, so that the queued bios
are resubmitted and fail.

With delayed_removal_secs at 30 and no path left, a direct read is
queued and delayed_removal_secs cleared two seconds later. The read
then fails after (mean of two runs, min-max in parentheses):

  before (ms)            after (ms)   change
  26234 (26209-26258)    3.5 (3-4)    -99.99%

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..a92a05b1f925a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1249,6 +1249,10 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	 */
 	synchronize_srcu(&head->srcu);
 
+	/* Fail the I/O queued while waiting for a path to come back */
+	if (!sec)
+		kblockd_schedule_work(&head->requeue_work);
+
 	return count;
 }
 

-- 
2.43.0


