Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B6606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V19hT0cX;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=nlf61GEe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pIAW8Yot1DyjUW3dhpH4QBhM+Y8QtY2oKmmkspl5CJo=; b=V19hT0cXw2HgBwn1NJkmg8cRqF
	C2Z7Evun231hSKyy6/klsWA8Gu2s1HQGzQZZxbD7BcGP1rpOcNCdd5BQyrRTxlW4USbtKx/aNKLhD
	T0TQ3ph6p2PBMtjjLoC6aBH8TR6yrgrcHRu+k+vBGZEyoxTHlajuJZWp5FYAoq5hXCRyzhP1UX7ak
	lDAZ3dSMTinUFjkrUczyWPGEfg3YjCOCmttEhbIABgGTX1uXyRJd4n9abMvE3+ouhHMRzSvI8w6LS
	3qjswblqxOVaBegw9rXelz3QnUD7pFLUqW+TpHqRiGXBkyeukr5L7ODUDRSZnSIZowWFl/sV6V6Wd
	GJRxQHAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3w-0000000EDyk-2uyP;
	Fri, 13 Nov 2026 19:35:52 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc5-0000000Dp0g-2d02
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:03:03 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qR61Vhz5BNRf;
	Sat, 14 Nov 2026 02:02:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592979;
	bh=NRZhaIT38sH6o2pY4Q5fflETNdc/XIIIPSSkImje7+g=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=nlf61GEe+brB11HJjdnV5TSnj8VEAwOSWSZ8iDfat0M9zhXF9f30hbrPkXm4HxSym
	 Unuk/TCJGTICBftY+hWWzHMKpS8xp4HB8h+P2/1VorXEOlcwAwx+CyF82ZKj8ci+i9
	 DubaPdGG3Akb1QdDIRIrj5HiZhaVwfpzY0oIY2XOFK8hKqWmWFubtQN4dU93jYoq4+
	 TEgNNwzf49XLsofXU1e/YVbF2BkK5B7XpbbiV5k3jBb99SgIdgs/JIsoWv/SNJmNsG
	 ukww1lS3Ag/Z+BJShpDWU0HIXGonsrs6QoZ2Wr83/D5My4TGrcGGqeFOWGqWs+J560
	 RHeeDm/hCrU6w==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ADI2pAo099823;
	Sat, 14 Nov 2026 02:02:51 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:55 +0800 (CST)
X-Zmail-TransId: 2afb6af750cf12d-1a06e
X-Mailer: Zmail v1.0
Message-ID: <20261114020255726UHXoNsl4k05QUPUk5CVER@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:55 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDUvNl0gbnZtZXQtZmM6IHJlamVjdCBkdXBsaWNhdGUgcXVldWUgSURzIG9uIENyZWF0ZSBDb25uZWN0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ADI2pAo099823
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:02:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750D3.000/4jR4qR61Vhz5BNRf
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100302_032879_1F78F409 
X-CRM114-Status: GOOD (  14.43  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_fc_alloc_target_queue() stores the new queue with

	WARN_ON(assoc->queues[qid]);
	assoc->queues[qid] = queue;

The queue ID comes straight from the Create Connection LS and is only
checked against NVMET_NR_QUEUES.  A remote initiator can send a second
Create Connection for a queue ID that already exists, or send queue ID 0
which was already created as the admin queue by Create Association.  The
WARN fires and the old pointer is overwritten: the old queue's base
reference is never put, so its workqueue, nvmet_sq and nvmet_cq are
never released.  For the admin queue this also leaves the controller
reference unreachable from nvmet_fc_delete_target_assoc(), so the
controller and its subsystem reference leak permanently.

Publish the queue with cmpxchg() and destroy the newly created queue if
the slot is already taken, returning the normal queue allocation error
to the initiator.  This keeps the existing error path and makes both
duplicate and admin queue IDs fail cleanly.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with nvmet-fc over the
fcloop loopback transport; no FC HBA or fabric is needed.

A misbehaving FC initiator sends a duplicate Create Connection for a
queue ID that already exists, or for queue ID 0 which was already
created as the admin queue by Create Association.  A normal host never
does this, so the initiator is emulated by driving raw LS requests
through fcloop.  The LS response and the target debugfs controller
count after controller teardown are checked:

  unpatched                            patched
  duplicate conn -> ACC + WARN         duplicate conn -> RJT (0x03)
  ctrl1 dir leaked after delete        ctrl1 dir gone after delete

 drivers/nvme/target/fc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2b7dc3f03912d5f6920612d98327f57a39cdeb1e..181f8028a84141a36109838ee6e9f4e99fe87ac1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -818,8 +818,17 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (ret)
 		goto out_fail_iodlist;
 
-	WARN_ON(assoc->queues[qid]);
-	assoc->queues[qid] = queue;
+	/*
+	 * Publish the queue only if the slot is still free.  A Create
+	 * Connection may arrive twice for the same queue ID, or with the
+	 * admin queue ID that was created by Create Association; replacing
+	 * the old pointer would leak that queue and its controller
+	 * reference forever.
+	 */
+	if (cmpxchg(&assoc->queues[qid], NULL, queue)) {
+		nvmet_sq_destroy(&queue->nvme_sq);
+		goto out_fail_iodlist;
+	}
 
 	return queue;
 
-- 
2.27.0

