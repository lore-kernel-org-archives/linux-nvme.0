Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA11BCCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EzKVFjQGe+jWAmTEUe0D+gI/RJOMWb4HvNc93E+xx8c=; b=scikhDtVsmpP+8fjkP1aNsgCJW
	dcQ4lrhv70lXwzT6/FiME6ecI1QD/KjSoJ7ZDUTNVAy7wYF4Ia011UmzK6UhNh1Kp9DR3XJIejpuJ
	yWOQo/zZMbMxO3kABS2myTwIBBPohRoCaC4Qi36a0+bQzcXUdVWQiRHPYCf0G8AiKCrVVCdESqGYK
	KF77BZrg0ZYT53weB4AK992qw1NmSSqq0LvZGPFycCsQySiG6nPJcB2ZTUtTIZwJY7IHEu2buFmE/
	0SYLxvgYoLJn3ZqY/jWyJWScUrTrjBFR/VRfRf+M7KWI/kQUepZDAmbYn1xkKoAApli+kNKFeNkP7
	n5Ao0ZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlav-0000000GAew-0grU;
	Tue, 28 Oct 2025 15:26:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlar-0000000GAdd-0RPt
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 878C862023;
	Tue, 28 Oct 2025 15:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A4EC4CEFD;
	Tue, 28 Oct 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665200;
	bh=YGr8oqXsuwQl2oaUuC5Tyt7qh0xLJoY3vVHoY91jBAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y3OzIWXxOgFPQG6dh/EqiDS08OFQV3bFSvXHMGOIpuJQ+LHFdaocmoA1on+H8os5o
	 /mMsLpTdkvWKuOg8eXHonN22bgow04jLODZISZqQW+dJ8ywW57/kRrk1GEx7FEdxE9
	 bQJYob8jGTagkCoULYnM3mbqWMLKcyM98Q6xNA8ApGDUjk3M0kgB+96PQWZ2LUioLf
	 TY8/fslTj4oPF/HjsMYqm7UVXABeRqx1AEbHkMMoKz5sIXxgexvgRjYmp5MREzh1je
	 FbqdBXoed6TvaslrBdQJScMQ2uZUoxnE+Jg6HWoSsUkRLIOBDJXSRG1MhQGhPbH0I5
	 3uKa4Y/DMhW/w==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:23 +0100
Subject: [PATCH 4/5] nvmet-fcloop: remove unused lsdir member.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-4-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

Nothing is using lsdir member in struct fcloop_lsreq.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 4e429a1ea2bd..c30e9a3e014f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -254,7 +254,6 @@ struct fcloop_nport {
 struct fcloop_lsreq {
 	struct nvmefc_ls_req		*lsreq;
 	struct nvmefc_ls_rsp		ls_rsp;
-	int				lsdir;	/* H2T or T2H */
 	int				status;
 	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };

-- 
2.51.0


