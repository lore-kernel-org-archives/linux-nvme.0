Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B410C83F26
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k1zmtx9I3wcUvfDX1bB61Q4i7/htYrOVtsy9UYWsCVw=; b=YE82yGlDEiK8xVJZkFaYu81Wsw
	A6UJeNykTeftToIWYfxYHumUf60xmAtex6veLx0ml1a3C+1mWI3DUdPfqZ6NykgOQazlKOWai/ARm
	tiW2FAVhWCaAd16Bmuf8dZEARDiTeyGN/aWh0BOXp+y996TiZ8ZRrsM81ssMgriY37wbLLT7C4YSn
	pni5RJ3hwUcBWBDT8ebMxFaCG5JMFRSJnBoB0pl26Ew/HJS1lELcG6l8LpcEZriBK21iDcYLP4Nxz
	B4XM1W8H7a4RB+TWWWakxMHBsNIVLQGddxUnb3+steN9jGf2ChsYA0YpE49GIGhSYGhzNfGz890Tm
	s1aaf0Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufDJJ-00000009IwF-25e0;
	Fri, 25 Jul 2025 07:57:45 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufDJG-00000009IvX-1NLW
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 07:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753430255; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k1zmtx9I3wcUvfDX1bB61Q4i7/htYrOVtsy9UYWsCVw=;
	b=bXWVTCkGTU/jqf5HVS7yySv30PPK3ouuQ416TrfxMkCao3N4Kee0zmbjc/QkJSi82p/OaOCBWqYOkXIbLEX+HZsBTmkdrMppqdkFqMSD9Tn3V8As2JbQ7v8OViOfYkCMsaWOu+4gcncROHELwQu9qEYHt1omYfxupIzE6zAL410=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjwrXkW_1753430243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 15:57:29 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: hare@suse.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	inux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] nvme-auth: remove unneeded semicolon
Date: Fri, 25 Jul 2025 15:57:22 +0800
Message-ID: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_005742_510174_EF8A89E4 
X-CRM114-Status: UNSURE (   7.43  )
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

No functional modification involved.

./drivers/nvme/host/auth.c:745:2-3: Unneeded semicolon.
./drivers/nvme/host/auth.c:755:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22937
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index f6ddbe553289..201fc8809a62 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -742,7 +742,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
 			 "%s: qid %d failed to generate digest, error %d\n",
 			 __func__, chap->qid, ret);
 		goto out_free_psk;
-	};
+	}
 	dev_dbg(ctrl->device, "%s: generated digest %s\n",
 		 __func__, digest);
 	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len,
@@ -752,7 +752,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
 			 "%s: qid %d failed to derive TLS psk, error %d\n",
 			 __func__, chap->qid, ret);
 		goto out_free_digest;
-	};
+	}
 
 	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring,
 				       ctrl->opts->host->nqn,
-- 
2.43.5


