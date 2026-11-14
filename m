Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA4606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GwojgwYb;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=wh/1xGIe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LFJIrTHoNKoLywvkyABL7mHp+gK4u9o5oPm8cmfaloA=; b=GwojgwYbWHeh+X2mq2Btn/KdyN
	trhwyBRtWKSj4pn6g1QVtozRMaKBdgrp5t4T16aVvKRyZIP+4gRUpuQgne7P8xVYKiE3sLibgboir
	sKmSnIR5F24fXChZuHdraeHymGcD1aQbI6xMFOkqrDGPeLy7QU/7yWSdH+Vzj3vFFfuA9bbVhnPOD
	NPZMMMQ29ZOQjvlDrWJOuMCNAhX4Tf0SPhp1s82dPaaLCphm81OlTaE62jjQoe3wVfJug2GE9LiW8
	DqrcOEOYOoJNP4nBpHx2kW1i0wlW417XqtxF2P5jyfW7FyPHWnzfz2foZ3SemMJF9AsRBZAF+62c4
	STjQ++vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJAJ-0000000GeHg-3Dov;
	Sat, 14 Nov 2026 19:11:55 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXp-0000000GWzG-3i5e
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:07 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jRh0g6sf3z4xPS3;
	Sun, 15 Nov 2026 01:28:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677284;
	bh=1Mb+x+aS+924O00shC+z1whh+aojOH6IJCSnYH2Yy9Q=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=wh/1xGIeLHq7nomVKFii5/MBr50ubdLBMglX3cf89/OLZAQD4AvUDxTdaHlHnqFG7
	 znx28WqUBs/2W8tMtWAUpq2/xkNOrjyqIxroNPpSmh0Fy7RKbmCKx7V9iCVKIyot6b
	 Tx2WxIVV4bnVbqOp2xiLUdzS5TIco8gGU6TowSvUCrVPfEP+uBd3qzoY85sthBsKb2
	 y7HPKbZNquMk5JY1cDKzsRFAy4vkqcWkIo+nLrBlhG8+PL3Jk4IwgjiHhOa1BY/Gqe
	 2gEmrHQ0THPd913MxEoSqIFkdrtnB+N56Z2WF4Slo5jaSilDefMyWXjvmck0tDESxE
	 oaLVdDY+0F/Iw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRsme016779;
	Sun, 15 Nov 2026 01:27:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:58 +0800 (CST)
X-Zmail-TransId: 2afc6af89a1e011-53fbd
X-Mailer: Zmail v1.0
Message-ID: <202611150127588115YPbE0vZGI-FTHIHXJTI5@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:58 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gbnZtZTogYm91bmQgdGhlIHJlc2VydmF0aW9uIHJlcG9ydCByZXRyeSBsb29w?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AEHRsme016779
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A23.000/4jRh0g6sf3z4xPS3
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092806_125452_6B1C82D9 
X-CRM114-Status: GOOD (  13.13  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Sat, 14 Nov 2026 11:11:54 -0800
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

nvme_pr_read_reservation() first reads the reservation status header to
learn the number of registrants, allocates a buffer of that size, and
then reads the full status.  If the registrant count changed in between,
it frees the buffer and jumps back to get_num_regs.  There is no limit on
the number of retries:

	if (num_regs != get_unaligned_le16(&rse->regctl)) {
		kfree(rse);
		goto get_num_regs;
	}

The count comes from the controller and a target that keeps flipping it
(possible for a malicious NVMe-oF target) makes the ioctl loop forever.
Each iteration issues two Reservation Report commands and allocates up
to struct_size(..., 65535) bytes, and the calling process ends up in an
uninterruptible loop that cannot be killed.  Daemons that issue this
ioctl, such as cluster lock managers, get stuck with it.

Allow the retry only a few times and report -EAGAIN when the controller
still does not provide a consistent report.

Fixes: 28c97ba38ff9 ("nvme: Add pr_ops read_reservation support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport and
a TEST-ONLY nvmet hook that alternates the registrant count between the
header-only and the full Reservation Report.  The hook is compiled into
both kernels and only the host fix differs; no extra hardware is needed.

One PR key is registered, then the guest issues
IOC_PR_READ_RESERVATION.  The header report always says one registrant
and the full report says two, so the retry loop never converges:

  unpatched                            patched
  ioctl never returns (the runner      ioctl returns -EAGAIN after
  hits its timeout)                    three inconsistent report attempts

 drivers/nvme/host/pr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe264815..fab3bad2e2e0 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -275,7 +275,7 @@ static int nvme_pr_read_reservation(struct block_device *bdev,
 		struct pr_held_reservation *resv)
 {
 	struct nvme_reservation_status_ext tmp_rse, *rse;
-	int ret, i, num_regs;
+	int ret, i, num_regs, retries = 0;
 	u32 rse_len;
 	bool eds;
 
@@ -305,6 +305,8 @@ static int nvme_pr_read_reservation(struct block_device *bdev,
 
 	if (num_regs != get_unaligned_le16(&rse->regctl)) {
 		kfree(rse);
+		if (++retries >= 3)
+			return -EAGAIN;
 		goto get_num_regs;
 	}
 
-- 
2.43.0

