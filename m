Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F2606B27C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bqgT+hLd;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hRtg7l9t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aQ+79e839SpSVcGAQZBfUwer/H2CE5FduVC0M7Zwuf0=; b=bqgT+hLd41Hw7Wh5e92d5O0MwE
	h4j6ogab7xvKVzIvCj3B/bsn3gymlrmpzacKXmo+5qamSn4pwXDlKYxRopGZ04Y+q6siePQBGNq1U
	27RRrwcjm9ixzE2MQ4K1nKwY4qfdP8FofHFzzR7f55J1YmepTmjGa/sYvqLdwc1Ef5vOo+JwStZ3L
	qAIkqwoTbEEOGPWi0/PInjj1zqM+Oi5YZE/+f/zSiTEdmro0S3+/3vbGgui/momOPouW/mN8rGB7E
	wPcG/dxhdleNow5U5iy4eoUaQOn1U37lnGTr5OJT3OV5wnMDE6rL3drdmBuZhM3jSdevS4Zt53sM9
	tyQFDqYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhx-00000007lYE-1Emf;
	Wed, 11 Nov 2026 21:18:17 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNY-00000004J7Q-3f2d
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:22 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zQ5M91z4xPS8;
	Tue, 10 Nov 2026 23:03:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322994;
	bh=EVZeKEIEIa3KCIHtY0Mwx/UqHhx8qiT/szHFc92i6Vw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=hRtg7l9tE89rfzguh6lzOjwysYVO4MmlJQX9FJpInZzBSekGgRDYnLgflMPwOoUdP
	 HKQJKd4uGkW4W4pGBOSqyeTYUZxx2JSdXwv5Zqpf6vjVoV4cQZH0YX9fjuI8+G6c0l
	 hAQA62XeuuyKE7bCMcBJr9sQNU5fkHQ3WpYoDfuQ/nY3WPL9bTCp6At7lg6Q3zHuYq
	 q7WOs8Jhnr5Ij6QBx5B8nmfDK82eLkJeAPPF0XLCwlS/q/DO77YJVU7a3+JavGoMi0
	 yxcmojVjwaZECiPgTPCawakVNCThxQ1mvb6KkEFQIjMMuUy4JMoj6FS8sfb029Ggwl
	 kA0VBVovf2i3A==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAF3BiH030696;
	Tue, 10 Nov 2026 23:03:11 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:15 +0800 (CST)
X-Zmail-TransId: 2afc6af33233366-019aa
X-Mailer: Zmail v1.0
Message-ID: <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:15 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNl0gbnZtZXQtZmM6IHJlamVjdCBkdXBsaWNhdGUgcXVldWUgSURzIG9uIENyZWF0ZSBDb25uZWN0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AAF3BiH030696
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33232.000/4jP8zQ5M91z4xPS8
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070321_098716_A5AD37FD 
X-CRM114-Status: GOOD (  10.97  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
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

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2b7dc3f03912..181f8028a841 100644
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

