Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F5C5DF8C
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HZnYtRurIbr7fGwafUtO6fhUxr1c5+/a2CN0wLnLomU=; b=EddtKYCykFxYImXcPoTw8lii6w
	qjXemOntbgKpr/Vphy5Y/0AarElOZq0v2CNpJTUZ/zA74nPTHIO5P5DkMfB5bRu7DCklUi3qWotuc
	OTFwfzuU0aQTuWl2JXm77eKyr6UAJ8Jf3SXikBwjcd7kcM+DTR8sK4zDFBY3X27qY8Ut5VevvJuNz
	YA9z/gFXAuTXv0osXJs3Y7cLTXwhz2CpbTEihMyNQt+A0jcY4qWA9gNZ4ZqwAGXB4l/gffJ/MbyvW
	Mme16np/m/2gWJDYICfwe8sYdhaeuZLcdcysXBnvTx7sqUCpeROp10J5SV9rFh4Wb/5YnHCqlFDTG
	m0KuXM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxLZw-0000000CvTB-0OOU;
	Fri, 21 Aug 2026 09:30:24 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxLZt-0000000CvQw-1GUc
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 09:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787304614; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=HZnYtRurIbr7fGwafUtO6fhUxr1c5+/a2CN0wLnLomU=;
	b=gjuFnYhd5Q2UOyf6yO1DzmyRf7kdThyvXRFN1cNbz49bVov65nMzes5pZvgE4GASEm8UODE00BR/MRExDkvV8oQu57kjmwon8vEomZ3AvKfM5GTbLLAltkYzpLKearWBB5NX40vK3mkb+ENI0eX7VLARny+sF/ecV3ccdbNsjdU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X9LqlpK_1787304610;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9LqlpK_1787304610 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 17:30:11 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, roys@lightbitslabs.com,
 sashas@lightbitslabs.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: reject C2HData for a non-read command
Date: Fri, 21 Aug 2026 17:28:32 +0800
Message-ID: <178730451245.442148.11684394617763960186@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_023021_512301_7E131817 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A malicious or buggy controller can send C2HData PDUs in response to a
WRITE command.  nvme_tcp_handle_c2h_data() accepts them as long as the
request has payload bytes and a current bio, which is true for writes,
so the receive path ends up copying the incoming data into the
request's iterator.  That iterator was initialized from rq_data_dir(rq)
in nvme_tcp_init_iter(), i.e. ITER_SOURCE for a write, and
_copy_to_iter() refuses to copy into a source iterator: it triggers its
WARN_ON_ONCE() and returns 0, the short copy fails with -EFAULT, and
the connection is torn down into error recovery.  The write never
completes: every reconnect reissues it and a malicious target answers
with C2HData again, keeping the controller in a permanent
reset/reconnect loop.  With panic_on_warn this is an outright crash.

C2HData carries data transferred from the controller to the host and
is only valid for commands that read data from the device; write data
travels host to controller in H2CData PDUs solicited by R2T.  This was
reproduced against a target modified to reply to a WRITE with C2HData:
the host logs

    WARNING: CPU: 0 PID: ... at lib/iov_iter.c _copy_to_iter
    Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]

and the controller cycles through reset/reconnect without the write
ever completing.

Reject C2HData for any non-read command.  This is the symmetric case
of commit 6efbc52237fa ("nvme-tcp: fix host memory disclosure on R2T
for a read command"), which added the mirror-image direction check to
nvme_tcp_handle_r2t().

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -685,6 +685,13 @@
 	}
 
 	req = blk_mq_rq_to_pdu(rq);
+	if (unlikely(rq_data_dir(rq) != READ)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected c2hdata for a non-read command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
-- 
2.43.5

