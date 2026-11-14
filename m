Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEF606A331
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JuJHL7s+;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Z2KfI1FV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=/zJvyhXVmWQ8n6ulJrzTmjWsDytDY/8DsGllw13TDE8=; b=JuJHL7s+7o0ex/Jkjfef3OippA
	p1r+jFZirhAdjs/q5qC1H/eK1KDQ54wNTCSPDhWdfiDCOtm0IIy7kbgmDAe2dPzHs1a+xeyI+NVw3
	PxPlkNJ7Ir/9/J5K6Q056AIiThso8zbYI8OvrkMdCdFea+0uFjrsQ5uEMn+AovSft9OAGLsqa0Jrp
	NxRmNEdsPf1Xdg8HEmnV027jY3tCWK5sGYLxQazANZ6AAvT385dFHLyJLkfB7/9a5dqRv1UWzYVh7
	Wy6vfE1siXBCyaLb579lvSfcGiM1gpnM2yEw0FOFObqIuYVchrdWm2xAbiHFlVDwgdpR2mFO2nZG9
	G6Je2G0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHYA-0000000GXCA-3ech;
	Sat, 14 Nov 2026 17:28:26 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHY0-0000000GX7r-2Don
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:24 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0t2Pk1z8XrrM;
	Sun, 15 Nov 2026 01:28:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677294;
	bh=g2Pv6nwAGtwV6QX8+pn88NBhcXvjxGhcFYlL9Fzu+Io=;
	h=Date:From:To:Cc:Subject;
	b=Z2KfI1FVzaXNz+uvodFMcTb0jg19SG14R/i4Hzol3FnybUFkK2pDiijjhD8wLGOHF
	 CRdOZ3cH2I2U7jdqLKqBgHD4wriLUD6/PL6DPAp+P1WgoEYqjoAsLLkubIFBmBQu2a
	 fEvr3vY81IHj+Ij0Ku7RsOQrXHHamdksF5VZPcu9W2ZXapYatQiv0xKIhyosrJOpm+
	 SqLSUl5aISWsRkk0Lp2VpT4JMvYV1cmZ0CprZKKRNFp0nX+6JjJm5lcS6MVq3cVQ9+
	 R6Wcl5GD0p5Os+kb4jrY8wjz8gDWP+6UmZNWEg826w3e62zO1TCxrKholdDcQW3x78
	 mkgi9mFDLK2kw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AEHS5kp016868;
	Sun, 15 Nov 2026 01:28:05 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:28:09 +0800 (CST)
X-Zmail-TransId: 2afa6af89a29b80-55b2b
X-Mailer: Zmail v1.0
Message-ID: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
Date: Sun, 15 Nov 2026 01:28:09 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lLWZjOiBpbml0aWFsaXplIEkvTyBxdWV1ZXMgYWRkZWQgZHVyaW5nIHJlY29ubmVjdA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AEHS5kp016868
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A2E.000/4jRh0t2Pk1z8XrrM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092819_380772_EF8ACAD6 
X-CRM114-Status: GOOD (  12.57  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_fc_alloc_ctrl() initializes only the admin queue and leaves the
other nvme_fc_queue entries zeroed.  The initial connect path calls
nvme_fc_init_io_queues() before creating the tag set, but reconnects go
through nvme_fc_recreate_io_queues(), which does not initialize the
queues it adds when the controller grants more I/O queues than the
previous connection.

blk_mq_update_nr_hw_queues() then publishes the new hardware contexts
while the corresponding queue entries still have qnum == 0 and
ctrl == NULL.  nvme_fc_connect_io_queues() builds Create Connection
commands from qnum, so the new queues are connected with queue ID 0
(the admin queue), and __nvme_fc_init_request() also classifies their
requests as admin commands.  Worse, nvme_fc_queue_rq() dereferences
queue->ctrl, so any request dispatched to a new hardware context before
the queue is initialized crashes.  This includes the connect requests
themselves, since connect_q belongs to the same tag set.

Initialize the newly added queues before growing the tag set, matching
what the initial connect path does.  Existing queues are left alone so
their connection state is preserved, as required by
nvme_fc_recreate_io_queues().

Fixes: 3e493c00cedb ("nvme-fc: fix nulling of queue data on reconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 with nvmet-fcloop in a single QEMU/TCG
guest (2 vCPUs); no FC or network hardware is involved.

The controller is created with one I/O queue (attr_qid_max=1), then
attr_qid_max=2 deletes it and forces a reconnect that grants two
queues, so nvme_fc_recreate_io_queues() grows the tag set from 1 to 2:

  unpatched                              patched
  nvme0: reconnect: revising io queue    same
    count from 1 to 2
  Oops: 0000 [#1] SMP NOPTI              no oops, 6/6 cycles
  Workqueue: nvme-wq
    nvme_fc_connect_ctrl_work
  RIP: nvme_fc_queue_rq+0x21/0x190       queue_count=3
  CR2: 0000000000000020                  I/O from cpu1, ret=0
  Kernel panic - not syncing

The NULL dereference is the Create Connection for the new queue: it
goes through ctrl->connect_q, which shares the tag set, and is
dispatched to the new hctx whose queue->ctrl is still NULL.  CR2 is
0x20, the offset nvme_check_ready() reads.  The target also warns about
a duplicate queue id on the same reconnect, because the new queue is
connected with queue ID 0 instead of 2.

 drivers/nvme/host/fc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..f3603c793ede 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2932,7 +2932,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	u32 prior_ioq_cnt = ctrl->ctrl.queue_count - 1;
 	unsigned int nr_io_queues;
-	int ret;
+	int ret, i;
 
 	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
@@ -2959,6 +2959,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
+		for (i = prior_ioq_cnt + 1; i <= nr_io_queues; i++)
+			nvme_fc_init_queue(ctrl, i);
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 	}
 
-- 
2.43.0

