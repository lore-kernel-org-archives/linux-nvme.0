Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B89BC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bi0GG5GiEtYwHDbjKw7XuvyebpNCyzBpq0dQgdUe1Q=; b=RR0j2lIOCk0bSF+mRpanLca3Ur
	Or7XfgbM0f4fgitu+KbMcsmpdp+JQ/CTbqyOOwWOTma8zzUth4ioZKKJ/VxKRJpJWoRyZS7aKTRmr
	3OXIT+qLZ/35SoHZnSRjL+1ZE7VHj0/30Xp6EL8u4mzCvusVpRsL5jd8jQFwwjddfnQmTe2UDPBuQ
	kq3AHetEAf6ngBztssXvhHQDu5qPRmjFYkEKsIK9wqvQA8YOmsdotHYNYuZH1dwR9HvUbKUoMQgvE
	+ie9SL537Tr8McpAEhxo4OzzXiV5PUISCEcbGngI0kSbDRI3tmH7wzJwbmbzGPaZRpMlxAWx6RRd3
	igvFGfxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPa-0000000Brob-3WVJ;
	Wed, 07 Feb 2024 21:24:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPY-0000000Brmu-0wLy
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/bi0GG5GiEtYwHDbjKw7XuvyebpNCyzBpq0dQgdUe1Q=; b=BDHiWVL8g4e4SJj47gjavA7t9C
	94VGkys0VnVupPxsqn1fYFXpl8ddiPc4dSF6ZjI+BKk7Ouv2IQHyzc92IyDPvU64Bhz7yz+zNYgrk
	gdqoMVYj5L/6UJgD+dSVhvaaR2HZVmOeHmKYuXGnqvtV4SXfo14FjHMWKEElMBnLl7SyP4azjifBk
	IsZru8HQlLqLnJ8M3FMCmuPfiP4JvyqpSn90rmSb6Q0bQiZx/yGykRGVDrx9F6alcmKAM42EglHbt
	kEg9LlJEFbO5DJrUsQmQZxbsaky0XxptcnXFEv9pXdNUf2yxc2IZw+Xd6yFUKsbvJNAQvaYLcUANg
	7DWUbNXw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPR-0000000D7ud-0llk
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6E53F61AAF;
	Wed,  7 Feb 2024 21:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68AFC433A6;
	Wed,  7 Feb 2024 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341083;
	bh=8DgjKcNwoJ0gbR303YsGNUiN+N+KYeLLmrDtZWXZQi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8Nkdx8joXni6LLiSoUfRjGH/8iSo438fD8G+tbvCbLObUezj7GEVDY3KR1IPCZSj
	 vo9I+B8W4iKPGz5RbA7zdf1JCOJHdqssMPAYUZeoV5btTZOaAZWKtm+STexnaMGIbp
	 nbKLx6q57GXnPPWfwU1iWAg+oMtTV2Kn27jyuFjT8B+0XvoT9dQUswlyzINtj1XlBz
	 v38vR/AwwKI+I7bLvoA2v1Ki4mSQinSF4rBnc3KEJ/a9Sc0x6qOSXPlEGlCdKx+HiN
	 Wy7UMSXfkvFLoilL4fxj8oHMxH9XpWHaFkhPGV72b3H9DOnom16T9JOV77OGz7H4On
	 FT/wKC1dz7sXg==
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
Subject: [PATCH AUTOSEL 6.6 32/38] nvmet-fc: abort command when there is no binding
Date: Wed,  7 Feb 2024 16:23:18 -0500
Message-ID: <20240207212337.2351-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212445_597487_FB6365CE 
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
index 64c26b703860..b4b2631eb530 100644
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


