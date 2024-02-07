Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BD9C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiwdiY1NMW7HvmS4VIz0ZDMuxcgX0th84mJKAVe94mY=; b=ePsoYcM/AB5OFRscj585GFfmvr
	AE2flEayapsmkvxz2uqCiwO8eQr1XoIuvVx1YeBaZlJ/e0n75yCPKavZRXe0uH62Ipsg+ZHPY5Uni
	zgnKgGlEExJ0XRQ9SQeMGR55T5+luwzmaj4a/9nwRYtcu+lecXPjzvUP5K/SnzjMNAwVXrQncgNKC
	NQo7e73UcSA67eQ4GpJc+Wn7Y0W5XjrK0vm9y4XaG1qu+ymjoVFRlGSoBByGztfxsDovHe54hDWmX
	+NJQflGsFaz0f+o7fDTuAaomouG1kFrQh1iwZfn7DaETOhsuvAdryQ64iHIHgtjTeXxdnbJwRlLX/
	3k7jDu/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRk-0000000BtNy-4ALH;
	Wed, 07 Feb 2024 21:27:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRZ-0000000BtF1-3IHu
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QiwdiY1NMW7HvmS4VIz0ZDMuxcgX0th84mJKAVe94mY=; b=pDwGGeNTgslwo4sg/RhV1Auy6C
	C8G6rDnsnRphMyTHe5dXQcj8lf5nCXB3VWc7P3xXdbCFi1s648rcoPox92aQ2dbM8opymMmFPaUrr
	fAXpeL5CAkY8y/vG0WhAPL8JrYOH0gZ94NrlA2EgFhYklKvT4o4WExcnPXqAdV24i7KfNdDX7weT8
	ieNjePSjihofiIxxnZlEs/sFJXufpfCpYGEkb7N+ahFpL2AwE5DKufEaLmBywkKVlGW1jtRcloblu
	avfJVtVmuYN5vSMIPcq863gzsoTZUrOq5u7948N8hpgnjXoZnhdDhGGYMjUwgIWHvi6KXMsKgE/uO
	+PC75cXw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRS-0000000D8CW-2Lvk
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 80F3C61AA2;
	Wed,  7 Feb 2024 21:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CC8C43399;
	Wed,  7 Feb 2024 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341208;
	bh=FviiJagCBZHb7Fvg7aMwogccBrc+Iw0X+SEhpBKYDRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Klkow8DWj2l+l6g8t7cJtHbPLswe3/6XBVldT+hqaDMrxEbqIN96fFZoQMvDpnSwC
	 oDpDStARz++JH4Z2fG+fp7OPAHhyffmOWf3dOTqBBhiGzEGWzfwGLGIxps6H6YrwwY
	 HVXhhbTCIunNFztTvpO6r/pYfxjvkrU0nrjqYmYx4gqsLQD3HTlFYI14XIXCSi9UPR
	 C8qXpF/rShymz59eqKtz+tR/njei/xjwQk1A8Vp6jMyDqiFBhzaTyGrqtrzZzKnsBf
	 Qe+CD0FBJPaLu5T2W96Y5/WdzfSgu7ZCOWnlWFMaEBeDxiv3l1CbTxtxIbsJL8GMGf
	 oBVJpRVby7A9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 19/23] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:26:00 -0500
Message-ID: <20240207212611.3793-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212653_666781_9E505233 
X-CRM114-Status: GOOD (  12.40  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 3146345c2e9c2f661527054e402b0cfad80105a4 ]

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 06d11bb7b944..20d3013be08a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1101,6 +1101,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2523,8 +2526,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


