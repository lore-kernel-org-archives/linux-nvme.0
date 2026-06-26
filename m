Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC69C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LXOuub+be30iBiw/mnBtFu03c02gL1YtYSJCsUFa3HE=; b=X8GwLZQ661UVS4r8SQRu/cMxNF
	E7sn4NzodFvMO71xY0InW2c9+Wxvx86NjsI4ASMGtQSwC7H+ZX4WNIsOl70o7pIDwZz8lX1cDrHLt
	QfCHPe0GE0GaRBpDZEUqeXzWTjNEQaR+N86jsrpFZQ3DjRaQAqNlM8DodosolHCzg/Glpio/RQsR5
	AqQ17M2f2gs+Z/Kpp89VBwp0WSHkXVdba1cSkQ9W6cb/n3O6wr3CUj7y6qxmnQp5jRZ4eb3CwrGSx
	Cmy4Z2NGDO3QVpUOPWJgdmackIWwfcup+YvZpZ4mYNZIiEhJwAutoEg/4KKUoqL/fubCK+eYIHDuK
	1Attpoyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8fi-0000000BZ04-19K2;
	Fri, 26 Jun 2026 15:40:50 +0000
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8ff-0000000BYzk-1TLM
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 15:40:48 +0000
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHrNR7nT5qtqRsAw--.10415S2;
	Fri, 26 Jun 2026 23:40:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: nvmet: nvmet_sq_create: fix ctrl reference leak on nvmet_check_sqid   failure
Date: Fri, 26 Jun 2026 23:40:43 +0800
Message-Id: <20260626154043.53241-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAHrNR7nT5qtqRsAw--.10415S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWrWFyxArWUuFyUtr1DKFg_yoWkAFcEk3
	48GrnrWa48ua1qkrW7Wr9xZr97KrnYqw1I9w4ktay3tr9YgFy3Gw1vyrnxJryxuw4rXry7
	CFnrGr4rArWakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU11SoJ
	UUUUU==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUKA2o+h0E80AABs1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_084047_771930_61D89281 
X-CRM114-Status: UNSURE (   8.57  )
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

After kref_get_unless_zero successfully acquires a ctrl reference, the
  nvmet_check_sqid failure path returns the status directly without calling
  nvmet_ctrl_put, leaving the ctrl reference permanently leaked.

Add nvmet_ctrl_put before returning on the nvmet_check_sqid error path to
  properly release the acquired reference.

Cc: stable@vger.kernel.org
Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f..52fc2dade4ea 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -943,8 +943,10 @@ u16 nvmet_sq_create(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
 	status = nvmet_check_sqid(ctrl, sqid, true);
-	if (status != NVME_SC_SUCCESS)
+	if (status != NVME_SC_SUCCESS) {
+		nvmet_ctrl_put(ctrl);
 		return status;
+	}
 
 	ret = nvmet_sq_init(sq, cq);
 	if (ret) {
-- 
2.39.5 (Apple Git-154)


