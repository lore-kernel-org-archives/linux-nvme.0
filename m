Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB464CD8C9F
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSjGYxse3jm5W/hIzY9V4YJn32Pkonr6h++q8mqcL8I=; b=YV2FlRmf7uarKOXvpL5ClCfjwu
	GuQMjWnLLKE5i7bjZNxb8S/pKMEbWlwsBQBYb6iEPyUP425y/bB44FHHBBln4ap5AHVqW/3O8RcgY
	CcE1eA2Biixn6nExnbKEkU/esmJL5beoxrGC7uvIi8mqnYlv7sROcdGBu7+KCMqgJ5UsI/gvNq7SL
	Qb45kPbA5GyQivCFuFbJLQeb4elcFeU83Qy3evgO8SJKiD60tJYTP/6a/FT3xJNsLJt8uqcGPQOuO
	7zEjlVbE7rDgI4XrdccacqcJOkRcL+8GlqlyJguzwzdxBYs3C4JM8rVs1KljjoIEfmWKkI+mz5EkL
	UJ3bUpxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJm-00000003RMo-2Q8D;
	Mon, 08 Jun 2026 11:38:58 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJi-00000003RKg-2BBL
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 11:38:57 +0000
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYqmh23kKzYQtjx
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E20240574
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with SMTP id cCh0CgAndzzBqSZqe2I+BA--.24728S6;
	Mon, 08 Jun 2026 19:38:43 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH 2/2] nvme: avoid possible double completions for the same request
Date: Mon,  8 Jun 2026 19:34:25 +0800
Message-Id: <20260608113425.3836619-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608113425.3836619-1-yebin@huaweicloud.com>
References: <20260608113425.3836619-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAndzzBqSZqe2I+BA--.24728S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1fGr4kGFW8WFWfAF1rtFb_yoWrXFWDpF
	WDJa1YkF48Gr17tryUJr4UZFy5Jw4IyFy7Gr1xtw15XF1UK345tr1DKFWjvF13Jr4UXr1S
	qF4DJw1Iqr1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUFoGdUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_043854_929493_10B8156B 
X-CRM114-Status: GOOD (  12.17  )
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

From: Ye Bin <yebin10@huawei.com>

Multiple instances of null pointer references have occurred in the
production environment due to the same request reporting "done" twice
when hardware failures happen. The exception stack trace information
is as follows:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x96000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000020ce32d000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] SMP
CPU: 18 PID: 577 Comm: kworker/18:1H Kdump: loaded Tainted: G           O  K   5.10.0-182.aarch64 #1
Workqueue: kblockd blk_mq_requeue_work
pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=--)
pc : cc+0x60/0x1a0
lr : blk_mq_request_bypass_insert+0x40/0x1a0
sp : ffff8001046fbcf0
x29: ffff8001046fbcf0 x28: 0000000000000000
x27: ffff800103aa3c48 x26: ffff800101b4ac10
x25: ffff0027fff49005 x24: 0000000000000088
x23: 0000000000000000 x22: 0000000000000000
x21: ffff00208c86bc40 x20: ffff00208c86bc40
x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800100db2c70
x15: 0000aaaaca58e4d0 x14: 0000000000000000
x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000eb0
x9 : ffff800100640420 x8 : fefefefefefefeff
x7 : 0000000000000018 x6 : ffff00208a700d74
x5 : 00646b636f6c626b x4 : 0000000000000000
x3 : 0000000000000000 x2 : 0000000000000001
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 blk_mq_request_bypass_insert+0x60/0x1a0
 blk_mq_requeue_work+0x154/0x2b0
 process_one_work+0x1d8/0x4cc
 worker_thread+0x158/0x410
 kthread+0x108/0x134
 ret_from_fork+0x10/0x18

To avoid the preceding problem, the NVME_REQ_COMPLETE flag is added by
referring to the implementation of scsi commit f1342709d18a ("scsi: Do not
rely on blk-mq for double completions"). The flag is set in the interrupt
entry processing to prevent the same I/O from being executed twice.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c06f18dc5a65..d162a713a00c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -532,6 +532,10 @@ bool nvme_cancel_request(struct request *req, void *data)
 	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
 		return true;
 
+	if (unlikely(test_and_set_bit(NVME_REQ_COMPLETE,
+				      &nvme_req(req)->flags)))
+		return true;
+
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 	blk_mq_complete_request(req);
@@ -1091,6 +1095,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 
 	if (!(req->rq_flags & RQF_DONTPREP))
 		nvme_clear_nvme_request(req);
+	else
+		clear_bit(NVME_REQ_COMPLETE, &nvme_req(req)->flags);
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1059976b413b..a60ffb6f463f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -261,6 +261,7 @@ enum {
 	NVME_REQ_USERCMD		= 1,
 	NVME_MPATH_IO_STATS		= 2,
 	NVME_MPATH_CNT_ACTIVE		= 3,
+	NVME_REQ_COMPLETE		= 4,
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -807,6 +808,8 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 	nvme_should_fail(req);
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return true;
+	if (unlikely(test_and_set_bit(NVME_REQ_COMPLETE, &rq->flags)))
+		return true;
 	return blk_mq_complete_request_remote(req);
 }
 
-- 
2.34.1


