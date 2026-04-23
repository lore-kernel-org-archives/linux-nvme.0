Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B9BF9937D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:From:Cc:To:Subject:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=01RQWDgAIZLbzUZgwhmAnVUNKUJN69Cg0PK6sly+IeU=; b=G+5yU24ZHmpuHCfe6c1I54ZGXD
	KR80GM6IBXHeKR1zSz0FqDMLgoC19SK2el7LuFlfd49Kl46tPh0lkyBhU5Xp5sJN9CBnBEcbJ6ECL
	lISi3BWM68v4q64GWhTrwPf9S3Q1gIQd9feqzU0AbOBy8UeYuksmSAyfvbuo9fejToGLyjR45fv1a
	EiyGinj+X3ckM4VpDXGJVE8AN516kni3VwIjyKbWO2nDVBaeOI7XYl4QSSDiqspfEDZFpKC/ym93s
	qwgVxCPaE5WPl4on//xzR5FIW/yPEyy2LC3PN8JvIdKs/GBY9mg3GElJ2c4lNzs/HRhOQx3QGZ+3r
	bhhUNZVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsbS-0000000BYcV-0t37;
	Thu, 23 Apr 2026 11:52:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsbQ-0000000BYcO-2XQZ
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 11:52:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 118C0600AE;
	Thu, 23 Apr 2026 11:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B849C2BCAF;
	Thu, 23 Apr 2026 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776945135;
	bh=Cy/6bYKEovXSJGLsuDr6WEp4p5DpHll/EzqxiC30+cI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=1HcnX7SlgweBqXhHn6vCrBDWwUb/Ro9bUpfOPVVBw2Wfv4zLhVZmTYaQDP5/0saur
	 Jr+FP6naewT7aDYhSyrOOxQivI6lZpa5kHexhIoXTioWNg39QzTcqmAdVkSk7HUVfH
	 7HfXdYOASFNeQRRsmceBgEuqdfO72JB47gMRbD0A=
Subject: Patch "Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"" has been added to the 5.15-stable tree
To: axboe@fb.com,gregkh@linuxfoundation.org,hch@lst.de,james.smart@broadcom.com,jsingh@cloudlinux.com,kbusch@kernel.org,linux-nvme@lists.infradead.org,sagi@grimberg.me
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Apr 2026 13:50:45 +0200
In-Reply-To: <20260223172332.291881-2-jsingh@cloudlinux.com>
Message-ID: <2026042345-visiting-closable-98b7@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-217801-greg=kroah.com@vger.kernel.org Mon Feb 23 18:30:29 2026
From: Jaskaran Singh <jsingh@cloudlinux.com>
Date: Mon, 23 Feb 2026 22:53:31 +0530
Subject: Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
To: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Jaskaran Singh <jsingh@cloudlinux.com>
Message-ID: <20260223172332.291881-2-jsingh@cloudlinux.com>

From: Jaskaran Singh <jsingh@cloudlinux.com>

This reverts commit 60ba31330faf5677e2eebef7eac62ea9e42a200d.

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
@@ -3263,6 +3263,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nc
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3333,7 +3334,6 @@ nvme_fc_reset_ctrl_work(struct work_stru
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,


Patches currently in stable-queue which might be from jsingh@cloudlinux.com are

queue-5.15/revert-nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch
queue-5.15/nvme-nvme-fc-ensure-ioerr_work-is-cancelled-in-nvme_fc_delete_ctrl.patch

