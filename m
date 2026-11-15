Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5834606A88A
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2026 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W8zHvaQS;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wYv+fPno
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8AUMAeaBpyNOsmFgWdnd2rtuFWotkqg/Z9hQF5Wti4s=; b=W8zHvaQS8E0TL2
	drq7uFCWFpea/mU85EK7ePd3EAfi1fP+uGrZ/HzLOhClFrR9H4YdB4JBP4yfu5kFWTh07WUph30an
	HTS5JoSrOYGBX85sTlKmLeIf3uWbhXOJ6StqnaJiKZ2TWCUXj2b57VqEFEeYTY8ALBoKB/QgFU3BX
	hcM+mOBRVoWodp8gTtw8njarHJl/gZNiigRF5KAp1xrPiXqby/jZFoKp6+pFVDNJv43n2tF2gtkAi
	jrGO9UAspJe72Y6YWfgGjL6qb1F2WnK+8EwC+x0TV1Bhsdo4ZeuqDwfsjBEbkTVNxRsvBlEKt+58a
	UbZ3D3fjVNm6zeV9/YGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSPmc-0000000GzZE-3Xlk;
	Sun, 15 Nov 2026 02:15:54 +0000
Received: from out-43.mta0.migadu.com ([2001:41d0:1004:224b::2b] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSPma-0000000GzYS-3Zv8
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 02:15:54 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=9/8G2LjUUlHPlw5gdjS0rjihOShSck/9PxHol6w9Ts8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794708950; v=1; x=1795313750;
 b=wYv+fPnoJur7Ny04Dmj9zxkRo8/bwqfrpuDxWFyDphzfdRViLaFYYy0QPfAaPlU6pC6h3Uhg
 gW57j+862BjysGxw/CB5agpl9E8sKEm6jZIExqQ8A6GzBHO2Xo/0rUmtVZM/+Gw7PYrbHyn4FDE
 CTUOV5qsiseZz0YeApXMfJ68=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id bfbb94a456fa27d0;
	Sun, 15 Nov 2026 02:15:50 +0000
X-Mizu-Trace-ID: bfbb94a456fa27d0
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sat, 14 Nov 2026 21:15:38 -0500
Subject: [PATCH v3 1/2] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-bug-nvme-mpath-set-live-srcu-v3-1-d84651de6334@linux.dev>
References: <20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev>
In-Reply-To: <20261114-bug-nvme-mpath-set-live-srcu-v3-0-d84651de6334@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_181553_054827_F10B2CEF 
X-CRM114-Status: GOOD (  12.72  )
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

With delayed_removal_secs set, removing the last path of a namespace
head doesn't delete the head right away. nvme_mpath_remove_disk()
queues remove_work with the configured delay, and bios submitted in the
meantime wait on head->requeue_list in case a path comes back.

A write to delayed_removal_secs only takes effect for removals that
start later. A removal that is already pending keeps the old delay, so
clearing the attribute leaves the queued bios waiting until that delay
expires instead of failing them, and lowering or raising it doesn't
move the pending removal either.

Requeue a pending remove_work with the new delay when the attribute is
written. Cancel it first so that the module reference taken for it
carries over, as nvme_init_ns_head() does when a path comes back.

With delayed_removal_secs set and no path left, the attribute is
changed two seconds later and the head is removed after (mean of two
runs, min-max in parentheses):

  delay (s)  before (ms)            after (ms)             change
  30 -> 0    26510 (26053-26967)        8 (8-8)            -99.97%
  30 -> 5    27994 (27457-28531)     6194 (5589-6798)      -78%
  10 -> 30    8131 (8086-8176)      29802 (29522-30082)    +267%

A direct read queued before the 30 -> 0 write fails after:

  before (ms)            after (ms)   change
  26466 (26017-26915)    4 (4-4)      -99.98%

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..35278b9c4de60 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1242,6 +1242,9 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	mutex_lock(&head->subsys->lock);
 	head->delayed_removal_secs = sec;
 	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
+	/* Apply the new delay to a removal that is already pending */
+	if (cancel_delayed_work(&head->remove_work))
+		queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);
 	mutex_unlock(&head->subsys->lock);
 	/*
 	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen

-- 
2.43.0


