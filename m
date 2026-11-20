Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B617606A326
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q1oQIoXF;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tsBr0+wo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JbJuKhab/Vgh190FqNXMcJ4FqvMOMsZQYdK5z3+jxO4=; b=Q1oQIoXFpwZoGw
	ubJqUBu33kBXM1FN58ALDBk9jqAwNVJ1MBmEiIsS3+0ErodcogQvMItDS7eYO5S7vSxxG4eLQWhuk
	cyFfQ/7zmRNqi3LSpJPx3nAvGczP2QGilvlNoOO18UCgMUDBNNb3vmd/rG4PEfBKrDUsUS+phoLmO
	dCRm1ycod4Y8KP2g7Wik8FSuSOM0HsYhQHveTTdsXO9mtApLAnjtdODtkJ9/qhTdW/F7Elvn1jp5A
	wMeQRlVeXs8YVesDbPW5RaLkTBOl3PqLL1UxVWXn/0oNoJdfEGWFgWOs2JxUymcH5RF/nDwXI9pNF
	bvpwOOiQ9eVT/asz46MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNa-0000000DpO7-11cu;
	Fri, 20 Nov 2026 01:25:30 +0000
Received: from out-247.mta1.migadu.com ([95.215.58.247] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUDNO-0000000DpMX-0lCL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 01:25:20 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=3YcJAy1yoKXk+ufpr0EPa26/P7xaYqN6s9qsKgZQrww=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795137916; v=1; x=1795742716;
 b=tsBr0+woW1ZL0k7u69sBnUmdTlEjbiODwWRiRNA7GV9G+vWGRNjteww+5q8+3Jze0++gXcQW
 CBimJTJaXuErsKmVuSlo9uy9pPcLfjjxaW1KhFrqS85/hyX4rBaErelWGPyOGRt4GZnFTpV0tFZ
 tBYqMwURB+a/zzx3Cyq5O7vA=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 1f686c37af51896e;
	Fri, 20 Nov 2026 01:25:16 +0000
X-Mizu-Trace-ID: 1f686c37af51896e
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 19 Nov 2026 20:25:01 -0500
Subject: [PATCH v6 1/3] nvme-multipath: keep a large delayed_removal_secs
 from wrapping around
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-bug-nvme-mpath-set-live-srcu-v6-1-da85b18b274b@linux.dev>
References: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_172519_315986_204D2044 
X-CRM114-Status: GOOD (  12.53  )
X-Spam-Score: -2.8 (--)
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

nvme_mpath_remove_disk() delays the removal of a namespace head that
lost its last path by delayed_removal_secs, which it converts to
jiffies as delayed_removal_secs * HZ.

delayed_removal_secs is an unsigned int, so the product is computed in
32 bits and wraps around for values above UINT_MAX / HZ. With HZ=1000,
4294968 seconds turns into a delay of 704 jiffies, and the head goes
away in under a second instead of after about 50 days.

Compute the delay in 64 bits and cap it at MAX_JIFFY_OFFSET.

With delayed_removal_secs set to 4294968 at HZ=1000, removing the last
path deletes the head after (mean of two runs, min-max in parentheses;
"> 10000" means it was still there 10 s later):

  before (ms)     after (ms)
  858 (856-860)   > 10000

Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/nvme/host/multipath.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ae8059366b57d..9958d08cd3829 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -724,6 +724,15 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+/*
+ * Convert delayed_removal_secs to jiffies, capped at MAX_JIFFY_OFFSET so
+ * that a large value doesn't wrap around into a short delay.
+ */
+static unsigned long nvme_delayed_removal_jiffies(unsigned int secs)
+{
+	return min_t(u64, (u64)secs * HZ, MAX_JIFFY_OFFSET);
+}
+
 static void nvme_remove_head(struct nvme_ns_head *head)
 {
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
@@ -1523,7 +1532,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	 */
 	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
 		mod_delayed_work(nvme_wq, &head->remove_work,
-				head->delayed_removal_secs * HZ);
+			nvme_delayed_removal_jiffies(head->delayed_removal_secs));
 	} else {
 		list_del_init(&head->entry);
 		remove = true;

-- 
2.43.0


