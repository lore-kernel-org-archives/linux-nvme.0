Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39F1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qC5ZjDz1jxbD80yDTz2Rc+U55zYiA77SUaKSYQ9nDDk=; b=aMsxZjfmwb9NoNJE8Ls0tlKpyT
	daTGtD2GJ8nBRNKdAf9rtxJjFSG+vwn5E7g6zujisM5TWv0xeadxFmTuxsq2WJiPEucpC7zGjz/56
	WlcNyeA/02E3EWG/HC8SWVMKsbrlw6UtzgYzkArsApg+VF15I8sbUJ8cLEEr/5o69huVbC6dHOdcd
	BUEJLL09V1Y3TQEx4pJ2KqB2IrMqOBuJDwqb6jtSDh6ueF6/v2t9kCoq++1tXwZt/aYiqWnbFFdYF
	RUvQuzRTb6q5EFsFeDGgMGMJ0YdWhU5FYYPbujJWyxgS0ATLuLw0ZluiI6Yk4B6WA/dpu2Q+nYpNg
	NvDZqxdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHs2B-001DPp-OF; Wed, 09 Feb 2022 18:49:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrwV-001BF0-Io
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:43:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C26261191;
 Wed,  9 Feb 2022 18:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EDBC340E9;
 Wed,  9 Feb 2022 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432230;
 bh=NF7bdpEtaimpaeLESco45AbjdDq6hHf0+u3NDa3F2lg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kxn7pHNRoELDApvPska0m3txiJVXoAo3mGYwanxt3sF5rxxVBIN3g5kmj0geek1K4
 oA3HM6DoqwVHUfIMi4IsM8nKg5YFvbVKXViMZWclJSYbQbCpMoZNnF4XyYOVvC6sUf
 tvHCWA5MSUz/zdyx1WSQ7X0zqu8qGe03BobQE6Co/TgT71Rmbt4B7kzfZPrZL53nZQ
 Qrz4lV1ZgUjsP7eugS0HJfcbkrEh5obj8ZAcbaSjxkrSJj4tayn5lTzs8drj08pGur
 +BN9dEuSFCvjRP8HDiIldd2t2iNSTi0FvUh5Q9gumGRdYj2uTy3BZ2xUg8TRaVzTdI
 1jmlhaedcm2qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 12/15] nvme-tcp: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:42:58 -0500
Message-Id: <20220209184305.47983-12-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184305.47983-1-sashal@kernel.org>
References: <20220209184305.47983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_104351_717016_33523759 
X-CRM114-Status: GOOD (  11.23  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit ff9fc7ebf5c06de1ef72a69f9b1ab40af8b07f9e ]

While nvme_tcp_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

Tested-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ff0d06e8ebb53..284d5e756bd6d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1947,6 +1947,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
-- 
2.34.1


