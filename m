Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534BFF34C5D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=NKT4W5VKvuov5D+qmwCoNxxm16jth67YrTvbSuiOZvI=; b=j6Oqf/iF4W5LqmmUBsVOcJ74HI
	Yn/ytLCL1JPAJhlKdCbjLMf4GzAng2Aiqh5kUpfeKmXYhhuL92IRNMC0eFtdbDaziEcK/X32+aNoS
	zDA/ljxjk0xaH47QBQQjfLLel4y+f4eFFbUtSM58fiFajtDcNSSLAng/SZVJUeB/rRCAjHvfDxcAb
	0MVh9sezFft82V1nMxk5Yyhub1ywQc5aUZydCGZSEglHe5omPQBVWVeKRQAmBvwDAGmarkzhimpeV
	T8Z03AegyTS7p/rhTn67fyTi/f0caoqgtr3ygqHVFoKGIyEA3SAGZO4/m+nIYE/MTJQEqjZrIsZQB
	kMM2dW4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCIWy-0000000FtFC-3QE0;
	Mon, 13 Apr 2026 14:44:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCIWx-0000000FtEv-210Z
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 14:44:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5DC161332;
	Mon, 13 Apr 2026 14:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4936FC2BCAF;
	Mon, 13 Apr 2026 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776091490;
	bh=NeDbZEubpRWgV60E8uloH8SKxLntxpTNZ7sW/q9yqzw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pw9WwycXdDkxX9hdJWejG5XslwU4QJsBXYSfbksrRpQ226TftkBSGejmHJM0F+HRM
	 LsFMiMGVXPO70RovP2P4xzoHaVoyPUN5/sHfFtH5k74nffErOJLNCG4G8dFBn4Q2Nf
	 gR31OzJ0cIIbzDWPOhXABsULp//G36v1mr4Yq8f0=
Subject: Patch "Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"" has been added to the 5.10-stable tree
To: axboe@fb.com,gregkh@linuxfoundation.org,hch@lst.de,james.smart@broadcom.com,jsingh@cloudlinux.com,kbusch@kernel.org,linux-nvme@lists.infradead.org,sagi@grimberg.me
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 16:43:31 +0200
In-Reply-To: <20260223172241.291649-2-jsingh@cloudlinux.com>
Message-ID: <2026041330-grape-uncooked-9534@gregkh>
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

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-217798-greg=kroah.com@vger.kernel.org Mon Feb 23 18:23:34 2026
From: Jaskaran Singh <jsingh@cloudlinux.com>
Date: Mon, 23 Feb 2026 22:52:40 +0530
Subject: Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
To: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Jaskaran Singh <jsingh@cloudlinux.com>
Message-ID: <20260223172241.291649-2-jsingh@cloudlinux.com>

From: Jaskaran Singh <jsingh@cloudlinux.com>

This reverts commit 3d78e8e01251da032a5f7cbc9728e4ab1a5a5464.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Revert this commit so the correct fix can be applied.

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3259,6 +3259,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nc
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3322,7 +3323,6 @@ nvme_fc_reset_ctrl_work(struct work_stru
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,


Patches currently in stable-queue which might be from jsingh@cloudlinux.com are

queue-5.10/revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
queue-5.10/nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch

