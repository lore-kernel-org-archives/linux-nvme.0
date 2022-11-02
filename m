Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51574C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUm4kmXTA4IwI/CuervrgapGiKcYi0sEGpltrofpvRE=; b=Ozk6zEMjmTwiJE3yefTEX8WNB/
	TT2dpkR51EGMIeH/rUMoQt388j85Yqs9jCt26NbLr1v33QaFFdsdzewpuCnUGIeOadaHMf8/179Rq
	i1KXUvhhRVcRY/UScPyv+EAqXo2SZys4vGfweoJ9zVJ8S1KwEQ4fidfldQ4vX5PDJF55az1WuHCFd
	mTpifU4x8aCEmS9YH9Xz6+JRDXElcWycRU8DpMqg7GOQLThNJtPRwH5BmXJnkkbmY9pvIEYU9xR/d
	rdEoCrois+nIbZ6eSBNfH/AZlqOYNO4UM12aUwWXf5vp5caSU0YvNEtPG4N6VZA4c6J7BmWqvF/Hk
	hglKMbkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8YH-008gcR-Gu; Wed, 02 Nov 2022 07:52:45 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y5-008gVQ-GV
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9A9E31F8BE;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUm4kmXTA4IwI/CuervrgapGiKcYi0sEGpltrofpvRE=;
	b=DxhVpGVJoFxNaa1bRYSGrEEqEQ0iq5n4mo6fWYQREaJUaoz1FZh0USCS039W8kp1KOpxwa
	g/k5J8GgwlBedo3wHz2YUTWvBAH3qUn5cpqIFp3TLkfRzkbCHyW0nKkRWXa2PrPKtBwPyV
	b6hPF/9MeLCBEGwWcX3dE5hTJ30oRZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUm4kmXTA4IwI/CuervrgapGiKcYi0sEGpltrofpvRE=;
	b=/qTMRq02LYAPQKtGTxsJEpRwK41HNWfIS7fGtPmMTyRJw8WRia4lEFkjiABJ8ZudU9sewu
	0YnW3nveJrrOXKCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 945AB2C143;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8DB9A51AD6C5; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] nvme-auth: do not queue authentication if the queue is not live
Date: Wed,  2 Nov 2022 08:52:20 +0100
Message-Id: <20221102075224.70869-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005233_721359_01DFF0B9 
X-CRM114-Status: GOOD (  12.38  )
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

If the queue is not connecting or live there's no point in trying
to start authentication as we won't be able to send commands.
So terminate the work functions directly if the controller is
in a wrong state.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b68fb2c764f6..719c514363ee 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -696,6 +696,12 @@ static void __nvme_auth_work(struct work_struct *work)
 	size_t tl;
 	int ret = 0;
 
+	if (ctrl->state != NVME_CTRL_CONNECTING &&
+	    ctrl->state != NVME_CTRL_LIVE) {
+		chap->error = -ENOTCONN;
+		return;
+	}
+
 	chap->transaction = ctrl->transaction++;
 	chap->status = 0;
 	chap->error = 0;
@@ -937,6 +943,10 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
 	int ret, q;
 
+	if (ctrl->state != NVME_CTRL_CONNECTING &&
+	    ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	/* Authenticate admin queue first */
 	ret = nvme_auth_negotiate(ctrl, 0);
 	if (ret) {
-- 
2.35.3


