Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A0C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c4bO7pOcR2JAclYTPc0ditoVVCVYnKC0pTaKvm4yzXw=; b=cnaCoUj0nqjxqqIkQAjHaoXQL3
	5hsDPwoAs2wU8sMXzbLTRvdqH+RarncwB49vlNLYM/aSGLHIVLFZ9j8rWy9ZV8fJoDwUsda3F+kia
	knohcyqmnO6oaPtIT8pc0crDS1A3POobWqBdsGg3XCgS+nYLzeSvf2JyvzB4t2hjKxdMIJm+HE9/+
	cByveHTgEvzcOCRWi49XjaoboEjpCtbmkv7LI8J5i9YzOT9TnWXtd7avMq0x8uobeah86m/bWJcSD
	wJfusLVjnDyrwP6ta3o/d4TWcklJ+sXO4GuwgfMkPshaxnEWu/jN2Y5l04G4yFIEFgnlbUj/0zZsx
	+kJ5Bj8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdGl-00ElOx-27;
	Tue, 19 Dec 2023 16:48:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdGj-00ElOP-1E
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703004512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c4bO7pOcR2JAclYTPc0ditoVVCVYnKC0pTaKvm4yzXw=;
	b=HMZP7m7LWO8/TkrhwwxtblLnddUfb6cSJzyQ7bYj1p5LCycecNo5jnopb0dBzXBbsYiJn/
	wa803nfdfsATv6stsGsGFSJ8bnxPRgHXKwATCDop1hduxL1+hFBrHIcZfdAuRWsjlHnxiC
	R3lav8FCwZ7K4jl8p2VUkLCyiB0aYZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-X2tiMyj4Nnixq10V7w9cfw-1; Tue, 19 Dec 2023 11:48:26 -0500
X-MC-Unique: X2tiMyj4Nnixq10V7w9cfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00A1B101A551;
	Tue, 19 Dec 2023 16:48:26 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 88A881121306;
	Tue, 19 Dec 2023 16:48:24 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: [PATCH V3] nvme-pci: fix sleeping function called from interrupt context
Date: Tue, 19 Dec 2023 17:48:23 +0100
Message-Id: <20231219164823.442687-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_084833_485674_D3AD7FB6 
X-CRM114-Status: GOOD (  10.04  )
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

the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
but the latter may call nvme_auth_stop() which is a blocking function.
Sleeping functions can't be called in interrupt context

 BUG: sleeping function called from invalid context
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
  Call Trace:
     <IRQ>
      __cancel_work_timer+0x31e/0x460
      ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
      ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
      nvme_complete_async_event+0x365/0x480 [nvme_core]
      nvme_poll_cq+0x262/0xe50 [nvme]

Fix the bug by moving nvme_auth_stop() to fw_act_work
(executed by the nvme_wq workqueue)

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V3: add the "fixes" tag

V2: Just move nvme_auth_stop() out of nvme_handle_aen_notice()
so the latter can be safely called from interrupt context

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..60f14019f981 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4137,6 +4137,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 				struct nvme_ctrl, fw_act_work);
 	unsigned long fw_act_timeout;
 
+	nvme_auth_stop(ctrl);
+
 	if (ctrl->mtfa)
 		fw_act_timeout = jiffies +
 				msecs_to_jiffies(ctrl->mtfa * 100);
@@ -4192,7 +4194,6 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		 * firmware activation.
 		 */
 		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
-			nvme_auth_stop(ctrl);
 			requeue = false;
 			queue_work(nvme_wq, &ctrl->fw_act_work);
 		}
-- 
2.39.3


