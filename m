Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5894EC07E97
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHA1Csc3M5O6WNu2hs8bfDTbB+z8YW2IAT/uF6Cgqfk=; b=lj/iewFny6ziD2tl48oOlSAFmQ
	aeM1UjGwaYz/1l0niSIMH5f1nhDAoX83icGDkzmz3ArfMqoQ/RGMq5K2SzplsJKZ3fOxkUufnEBN4
	uGTBto3j1Bd6vYrI8oidwnPt4lgyIouSgiGt/ioFyV3b4M3tiYymNM5OEv1o2v9r8V94laOV6UhBN
	dr0oRonYIUJSM1vp9mOnNPchdTRt36MxUaQDiocx5/7zCG1OiMl97OartL7qNEgBY7biAShgluAJe
	ALSz+f+A+D0xn0L64z5+lxvQX1GmcWn7Y6IdDU/WWP2Mdfq72UxJvRArx0zVrBjaE0CJweAneQOks
	B7sYdWLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r85Ja-006LyP-11;
	Tue, 28 Nov 2023 21:08:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r85JW-006Lu9-0e
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 21:08:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 84554CE1D31;
	Tue, 28 Nov 2023 21:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE2C433B9;
	Tue, 28 Nov 2023 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205691;
	bh=ou5g1vYpCVBpRbsuoAPA3/wFNIfrgr0OMicmp/bNh8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+bavc+nSrWU+EdUaCtphpTgDYhVaFsC3RNm2dsUW4FcWgcGcZYhghz8DhjkkfNpK
	 gMtFPhZGCDO6kg1NGazqsh6LIuWJeBr+z42yT7r7OutNUCKF2aqXRIjfsMYsk0iaED
	 sQJAolt7KpM8xR016mXF6nz55ismspOQp00v4jmjE8D/NxaqHeMVUxxbLyEWVXPTAj
	 yWtueMO1/Ep5e5dD7CCI8wQ+4xBnzVud49qXWo0tQV/1UEv+l51pLiFogTNApgkNtm
	 CRNQjaJ5CizOOEn1giZ+5+9ig+22luoEeua+fJqPf5tnZPExD6c/mYCD+rU2FUcdM8
	 hmNH+3BHYdHFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/25] nvme-auth: unlock mutex in one place only
Date: Tue, 28 Nov 2023 16:07:27 -0500
Message-ID: <20231128210750.875945-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_130814_419608_00535577 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 616add70bfdc0274a253e84fc78155c27aacde91 ]

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9dfd3d0293054..7c9dfb420c464 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,6 +758,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
 		chap->error = ret;
 		goto fail2;
-- 
2.42.0


