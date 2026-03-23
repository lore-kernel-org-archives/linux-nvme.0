Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9695FF46101
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=uPEYly8I0Oddxh6plhGzrv3JoyU7MRbs1abdNLYK0lM=; b=yJsGuw1ok913M6npxw1SKldK5t
	Iz4BgeIXq8nt2qDixWgmqB3ZTpgjXD2x3lBOD2pROvM4gWQb+W81zJCi9Az4wXErFJxVYbju9madx
	BMF5vphAeE2Ac4cqT5J8sK8y5NFQ2ycPzuApsFi6WRaMBKRkWXGjLl37LDu2OLSp+I34h7+QGAX/A
	Qsi4QEZyaln1Pxpv6VQBpUTBC7NLCvBfauYd/YvVB2i2XQJCOT93XQlb3R6kGBbQXzzhSvBuYuogF
	FBIh+zuWDKOxqkfaUeirezmBRorlCqWyLnLHYMKGmtkelpCSALDZWr8DhcO+fZf1rwdcnIUv0eax/
	vCBQkSpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4f2m-0000000Gl1J-0RQe;
	Mon, 23 Mar 2026 13:10:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4f2k-0000000Gl18-287M
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 13:10:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A59866012B;
	Mon, 23 Mar 2026 13:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9222C2BC9E;
	Mon, 23 Mar 2026 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774271404;
	bh=Vt0Ac67IHWCZ6CkP9zaM5g4a/v53RGOR0MhQNgYiI2U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nuPAh4CWTm6+cnU4r8xAJ0rBq9LiRe6qXgVfzRBfhwTta/DNoNgTjnKHb8S2Lh+nF
	 mHoG6Wm/3dqdOdxBPzdxN7Ly2j1mfqrzHRIobkC2Mvz8uXJSw/orURu9D95Sm7y+Hw
	 bCalLcWqBSRgixJ0zP79CVc3UNZyh9j16IM2aRmg=
Subject: Patch "Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"" has been added to the 6.1-stable tree
To: axboe@fb.com,gregkh@linuxfoundation.org,hch@lst.de,james.smart@broadcom.com,jsingh@cloudlinux.com,kbusch@kernel.org,linux-nvme@lists.infradead.org,sagi@grimberg.me
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 14:09:25 +0100
In-Reply-To: <20260223172405.292040-2-jsingh@cloudlinux.com>
Message-ID: <2026032324-herbs-agenda-ca67@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore
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


This is a note to let you know that I've just added the patch titled

    Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-217804-greg=kroah.com@vger.kernel.org Mon Feb 23 18:31:24 2026
From: Jaskaran Singh <jsingh@cloudlinux.com>
Date: Mon, 23 Feb 2026 22:54:04 +0530
Subject: Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
To: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Jaskaran Singh <jsingh@cloudlinux.com>
Message-ID: <20260223172405.292040-2-jsingh@cloudlinux.com>

From: Jaskaran Singh <jsingh@cloudlinux.com>

This reverts commit 3d81beae4753db3b3dc5b70dc300d4036e0d9cb8.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3264,6 +3264,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nc
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3334,7 +3335,6 @@ nvme_fc_reset_ctrl_work(struct work_stru
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,


Patches currently in stable-queue which might be from jsingh@cloudlinux.com are

queue-6.1/revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
queue-6.1/nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch

