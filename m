Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABD60A2605
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FY1zCcZr;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xPp4lP5M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EIG6neVhWP0oO2swpa/actjlZusAnOHzDTVPgCw3rRk=; b=FY1zCcZroF5ull
	CGdIU753pW52ilyef1uNrLTjrz541WKv0zySr84QHC0Gx6txFqatlliBRfAJ9JMfIUxa0QwuAkH0D
	Lb9ZrsxOdQbE+IzbSlj9cjb7T0c/1ysZdWe6ZKWQeNN5smrcYjd7xBXIG51hRu9VtbUXy8wycS68H
	2EPOM3bMJDq9mg0rQrJq96r4vfFxYy1VsbGwYLL3agCxJmXoTU1IawwPvS4+zTMN+hEJW083WAM5K
	uwe4YobZybJsANf4qmh4BAXztgm810GbWdHBJVWPymSeuq8MNiM63kghWXxA8MEDButNQdxi5o8Yr
	N6rg09fvHbD+id51NMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xThl4-00000009Kv2-3ybW;
	Wed, 18 Nov 2026 15:39:38 +0000
Received: from out-120.mta1.migadu.com ([95.215.58.120] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xThl2-00000009Ku0-1xeh
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 15:39:37 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=F2v4qu60TZjIPQx+nKg8sL3H6yfL4FsC13pDDbITfl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795016374; v=1; x=1795621174;
 b=xPp4lP5MgHMJO7DyuSQ0GUIQkZg/gL/Z9MpkYGV2N+zRgRNKgobd4IZBvd/Dnvqb1Y/TA/0I
 ez9dEU2rYmEVcYFNBZNnCf3J2C4nwbJD2/+ZvNClOkPAXwK0ffS8YvQgCM9xcfPE0vDWnvGxQvd
 CsH4Cs7NVSbu22jvTuZc3HtM=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 9a0a6b54ba0a1855;
	Wed, 18 Nov 2026 15:39:34 +0000
X-Mizu-Trace-ID: 9a0a6b54ba0a1855
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 18 Nov 2026 10:39:18 -0500
Subject: [PATCH v4 1/2] nvme-multipath: apply delayed_removal_secs changes
 to a pending removal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-bug-nvme-mpath-set-live-srcu-v4-1-21f368376c8c@linux.dev>
References: <20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev>
In-Reply-To: <20261118-bug-nvme-mpath-set-live-srcu-v4-0-21f368376c8c@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073936_655324_A093C7E2 
X-CRM114-Status: GOOD (  14.54  )
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
carries over, as nvme_init_ns_head() does when a path comes back. If a
path is already back and nvme_init_ns_head() hasn't cancelled the work
yet, drop that reference instead of requeueing the work.

With delayed_removal_secs set and no path left, the attribute is
changed two seconds later and the head is removed after (mean of two
runs, min-max in parentheses):

  delay (s)  before (ms)            after (ms)             change
  30 -> 0    26877 (26327-27426)        9 (8-10)           -99.97%
  30 -> 5    27987 (27464-28509)     5248 (5193-5302)      -81%
  10 -> 30    8152 (8095-8209)      30106 (30080-30132)    +269%

A direct read queued before the 30 -> 0 write fails after:

  before (ms)            after (ms)   change
  26801 (26243-27358)    6 (4-8)      -99.98%

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..881d8a0145255 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1242,6 +1242,17 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 	mutex_lock(&head->subsys->lock);
 	head->delayed_removal_secs = sec;
 	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
+	/*
+	 * Apply the new delay to a removal that is still pending. If a path
+	 * came back and nvme_init_ns_head() hasn't cancelled the removal yet,
+	 * cancel it here and drop the module reference it held.
+	 */
+	if (cancel_delayed_work(&head->remove_work)) {
+		if (list_empty(&head->list))
+			queue_delayed_work(nvme_wq, &head->remove_work, sec * HZ);
+		else
+			module_put(THIS_MODULE);
+	}
 	mutex_unlock(&head->subsys->lock);
 	/*
 	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen

-- 
2.43.0


