Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2590C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:44:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4A864FCD
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4A864FCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mgWH8SKVFLhvwl4b0omhugaSbCTNAP4JtVqBxX4wUDI=; b=otSTBXBzU3wplgFdGIn17BDboB
	c8nZDR36wTWVHWm+C32Wj4JDAmRKQfxmI3K68juDdS9Kkw0p78G01WkacM/Kxf+sQQxSBx4gDoujf
	11AtZzPv0NcX8b1I0cK/SaN8qsYa5k19p0nWHUGgZLUBB2+LLglvf3fpQMRDY/9NVkVdV7/WCpT0D
	xHdsvsH7jOqxzzzRbsz14F8uxPWkLnIryUCn1Wnk41lhgNZW2cJLeVUF50ky+KeAcr7G9U0HKQncy
	DMimYQNIA+ZnMQ7LijGvew1wdTMQAOpuNAA3ick//eMc/tesnxG0AvzMkTdlHCn1RoNJ65HIYXNf/
	UHP+HXyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKE7k-008Pvj-FA; Thu, 11 Mar 2021 05:44:40 +0000
Received: from email6.ustc.edu.cn ([2001:da8:d800::8] helo=ustc.edu.cn)
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lKE7d-008Pub-F0
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=DPJFaSAV4N
 hZScDo04jGCQU0HMgdRtpmWXbeswbdrJs=; b=TjerB8zg8EFwA2SIwfslGDDc99
 sLp6ghyOHGQeWtLfyObHMYRwuaL1JRGl4LvIVUuqkjByQTz9Wn1z8/bMVPbLbVXS
 7F3sdt58a/5Dn1UWWjCCUdP5ZbYNtL1uWGwrZQ4z4A2ykRPpZ4RQcJY0qR4OvsZv
 g9HQi8zlgnZbsh8RQ=
Received: from ubuntu.localdomain (unknown [114.214.226.60])
 by newmailweb.ustc.edu.cn (Coremail) with SMTP id
 LkAmygB3KWIvrklgZ68JAA--.1678S4; 
 Thu, 11 Mar 2021 13:44:15 +0800 (CST)
From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] nvme/rdma: Fix a use after free in nvmet_rdma_write_data_done
Date: Wed, 10 Mar 2021 21:44:13 -0800
Message-Id: <20210311054413.8731-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: LkAmygB3KWIvrklgZ68JAA--.1678S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43Xr1kGFWDGFyUZrWfAFb_yoWkXrgEvw
 48Kr1xWa4DCwsFy3WI9r4rAr9F9Fn0gFnF9a1Dta4SyryDWa93Kryv9FnxAwnrZFW8Jrn7
 ur4xAry3Cry8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
 6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
 UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_054434_535813_711176B0 
X-CRM114-Status: UNSURE (   8.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_rdma_write_data_done, rsp is recoverd by wc->wr_cqe
and freed by nvmet_rdma_release_rsp(). But after that, pr_info()
used the freed chunk's member object and could leak the freed
chunk address with wc->wr_cqe by computing the offset.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/nvme/target/rdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 06b6b742bb21..6c1f3ab7649c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -802,9 +802,8 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvmet_req_uninit(&rsp->req);
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
-			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
-				wc->wr_cqe, ib_wc_status_msg(wc->status),
-				wc->status);
+			pr_info("RDMA WRITE for CQE failed with status %s (%d).\n",
+				ib_wc_status_msg(wc->status), wc->status);
 			nvmet_rdma_error_comp(queue);
 		}
 		return;
-- 
2.25.1



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
