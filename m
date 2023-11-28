Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D981C07E97
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 21:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04BEZCsgFxLlwbKcZQ4v+Sn5suFkH2WZj27LJ7UUDV4=; b=cOHRwiJgAGNOGghmEw4rCVoR7L
	jZd4CcAZbU4QheaG3gf9C/4TJ3zHX/Oq2z2TU3qgR/0sKUjSxeY+/ixVMIdaxGwXffi2IQRc2noJi
	wh7B8icaqw0N08NYc3vQ/QyBNquIlXZUHho90Edk9jTgoQVa89ITs5wN+2vzmcLFTSmjmikD6HmmX
	td9zucUEcB4gnQTgfC6nq2iyehGCz/o5GCrZ2DOtSgMATSBxXudPERBxgvUljGfcYd2JRJdFTAQWU
	Lwv1ET18k8w+stY+G00Eg68WStdxUDE2CEjV8z3qc+Tz34BkT1pJE6nm8+w8TG43b5PakkksiI+F2
	rlSlqiSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r85I6-006LGf-0o;
	Tue, 28 Nov 2023 21:06:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r85I2-006LDR-2t
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 21:06:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6445A61782;
	Tue, 28 Nov 2023 21:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328EC433C8;
	Tue, 28 Nov 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205602;
	bh=J2EZoT5nf42IyT+2nOUc2PQyHkSw27y/9C6HWxKjDDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLW2QL62+GM3PzvPxGZoNIVOCBC0lNRTZXSjl2Cch+21OQvi+JGdD+qdc3FjUlyqr
	 9qmWfapct6SO2YY1oY0e6WDUbKhMw1RdbTCYsRZhzqAA68GUxzfC+eSwim09l6RE0d
	 O0a+efKl/VuB0u/CjbiTevq9g73bUSVA1+awSJPooBN6/XkUQMtfCxaUVkxhP5kg5H
	 4vpGnfFqV3cRZfFdGBuKNVMEZTXwZHNGYSNdkd7NQD5SrsMczEdI9A/ZylPGnuRLtL
	 1i4hdPcT6/b6+rN+YtpiT/Yt6AosYp2OM/9L+melhdYSJkhzE3PIUbOfQ1JJimh9hZ
	 wkKB2LtvLMXKg==
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
Subject: [PATCH AUTOSEL 6.6 14/40] nvme-auth: unlock mutex in one place only
Date: Tue, 28 Nov 2023 16:05:20 -0500
Message-ID: <20231128210615.875085-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_130642_974969_FB9479DE 
X-CRM114-Status: GOOD (  10.53  )
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
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 064592a5d546a..cc02a95a50c9a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		__func__, chap->qid);
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		chap->error = ret;
 		goto fail2;
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	/* DH-HMAC-CHAP Step 3: send reply */
 	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
-- 
2.42.0


