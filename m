Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301CFECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g8vQX0TOmlWz8KQOEUN5HNKluOhcRAaDnUCpUlNFrMs=; b=b+4i/rHoZ0yttZ/bCjceBXdr5Q
	S5sroUw4/62WPYRSgj+kackTcKWvTLV8p81cBzVN71FCltptRdWW0WtHu55dB0+RZ2FbUGjPwDV+G
	/iMrzhjIt0ut20YysLzC4zZM/xSN1ZmdqL8rGAwW5J3TzW4iR8u6z5aYsima57466QdwhLUjH2csd
	kolkR74iKs/ryHL1Lrayl5o3D/kBzAr+pLEcfUchJem/GoeqD/9xidTYyD5nuPlFaRBlU2+C8s0MV
	pBC5q+tBjjvwmCT6FhSwWnbLfYxY48N3hKlvSs/mZLSE9c96vkULO31r0cwyBQUaAimX0ib7eeyjh
	8HsOkcAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXhyr-009Tbt-VN; Mon, 12 Sep 2022 11:52:02 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXhyo-009TZ8-PB
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 11:52:00 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 28CBpXje026274;
	Mon, 12 Sep 2022 04:51:34 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvmet-tcp: add bound check on Transfer Tag
Date: Mon, 12 Sep 2022 17:48:40 +0530
Message-Id: <20220912121840.4501-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_045158_849513_2AE27ED7 
X-CRM114-Status: GOOD (  10.36  )
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

ttag is used as an index to get cmd in nvmet_tcp_handle_h2c_data_pdu(),
add a bound check to avoid out-of-bounds access.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/target/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 02df2fc7dfe7..6729c384f2bb 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -935,10 +935,17 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	if (likely(queue->nr_cmds))
+	if (likely(queue->nr_cmds)) {
+		if (unlikely(data->ttag >= queue->nr_cmds)) {
+			pr_err("queue %d: received out of bound ttag %u, nr_cmds %u\n",
+				queue->idx, data->ttag, queue->nr_cmds);
+			nvmet_tcp_fatal_error(queue);
+			return -EPROTO;
+		}
 		cmd = &queue->cmds[data->ttag];
-	else
+	} else {
 		cmd = &queue->connect;
+	}
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.31.1


