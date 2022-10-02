Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1BDC433FE
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Oct 2022 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Pr8erL9cZfyS7aBe9lpvPxYV8i8drY/Mfbf0KNI5oQM=; b=fXLumUs6JqySr3Kjh2tirxNBde
	uP6F/1M2du2EyGLOocmOH/AnZ3ZXyh8Bx3U427gkOLjZPcXdTZFDqaqqaFu1co11YZxgCFcjtnKJE
	21spwfEgZo/KxEg0AG6lJw+EL503PNBXp9/yHEzejHkf9Wn678ybZMX43TPy6Sgb5H2KU+ZVbyabp
	3bBpQkugTD/PeWBQC8zpaVhRZTnKAh4WcuskPZpHoEx8fLXW/pMx0HDCbB/Wfdu5SQQ8FYdgk+N3S
	O8QJMCXHSK8LNw5OukKH+9+xioDHqjLoSg/BdN5widVuN3Gui2X4KGEoJrzyS+w7N+d4N8/vVF5t2
	veSwu2kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oemhz-00GepR-EF; Sun, 02 Oct 2022 00:19:51 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oemht-00GenZ-JA
	for linux-nvme@lists.infradead.org; Sun, 02 Oct 2022 00:19:47 +0000
Received: from ubuntu.localdomain (unknown [10.190.65.158])
	by mail-app4 (Coremail) with SMTP id cS_KCgAXjk3_2DhjIc_GBg--.24421S2;
	Sun, 02 Oct 2022 08:19:20 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by nvme_fc_rcv_ls_req
Date: Sun,  2 Oct 2022 08:19:09 +0800
Message-Id: <20221002001909.20070-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAXjk3_2DhjIc_GBg--.24421S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UArWrKw13GFW8WF4Durg_yoW8Jw15pa
	95WF9YkF17CF1jyasrGF4FvrWrZ3Z2gayUG3ZFq3y3uwnYqryFyrZ0ka4FvFWDuF97WFyr
	XFy8Xw1UGF1DAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIKAVZdtbvX2gBDsA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221001_171945_952146_F8107A9E 
X-CRM114-Status: UNSURE (   9.22  )
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

The function lpfc_poll_timeout() is a timer handler that runs in an
atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
As a result, the sleep-in-atomic-context bug will happen. The processes
is shown below:

lpfc_poll_timeout()
 lpfc_sli_handle_fast_ring_event()
  lpfc_sli_process_unsol_iocb()
   lpfc_complete_unsol_iocb()
    lpfc_nvme_unsol_ls_handler()
     lpfc_nvme_handle_lsreq()
      nvme_fc_rcv_ls_req()
       kzalloc(sizeof(.., GFP_KERNEL) //may sleep

This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
GFP_ATOMIC in order to mitigate the bug.

Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5..36698dfc8b3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	lsop = kzalloc(sizeof(*lsop) +
 			sizeof(union nvmefc_ls_requests) +
 			sizeof(union nvmefc_ls_responses),
-			GFP_KERNEL);
+			GFP_ATOMIC);
 	if (!lsop) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: No memory\n",
-- 
2.17.1


