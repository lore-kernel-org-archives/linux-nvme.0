Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A92C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z9mrYk9ezevgnVRh6fo8v+zzdhxngLuWQKAfOQIGxIk=; b=Y4yB9ww1pPqnI8LTUncvOeHCtS
	TtZEXX7IZTSb9OvbVjLYC/q8gWNGIjmjVRD8SVqusLajZGGgu9YF7HUDhH+L7AH4z1OWhbt48Zwpl
	arJQpl+DaOjhZCt1s/WY5r//e0qxieH4ieLC5/1CYRLWeO4TSzLHelgwHqGDUS9XGySrLHqjKbhF1
	LE0gXx4D7kiN+/zD8rk+PaBujWyy4nacnjEiA6cigEabBo+wJrVEEWR6StwK4g0a7IxCIXltC3rUv
	ufnG6TPIpkKFUMzeNgfCDJ+Dj80k5ZfxQ4RPcIjJpffSsatfTYtPinsmUqfFkeTVPLs9PAZiJyuA7
	affPA5Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQUOJ-00GEuD-0K;
	Mon, 31 Jul 2023 15:00:59 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQUO3-00GEWG-2C
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 15:00:45 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D5ED5240101
	for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 17:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1690815637; bh=XImkWyr8X4KhNLsQctrbLiFktbFlqmuLxa0+EGeRPJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=izyE3ONGaA+0jfWhgRU//8h85d0ObOdP7jK5FSSx3X2DTKilXfgsxG5TKQn0jbw5n
	 LgEheEDXQlvdZBXqmxPJEv+C7Osk4ItDJu7cJz3+g844hRbLemMkcU+O06ugrIbupa
	 9PS7mvZ5yrDb05/OlJxf6zQDyA0+PEzjRZce2zjgLpYJJC9TfUMWbb7zl2ONGoaV6t
	 9JdqfLFyUP0H4NVNygbi270PXhv7S9HLAiFKAn4QKKyvaD1NP5rFPqRsoiTuycyNTz
	 y1HyY9x/JB1bFtI+znYZjYkBW1YUP3FqgS2GJ2P7U93sNfVsWlyHLcMAtSLic+VhqL
	 49PMktOwVpYWw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RF1dH2n7bz9s0p;
	Mon, 31 Jul 2023 17:00:35 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 1/2] nvme-auth: unlock mutex in one place only
Date: Mon, 31 Jul 2023 14:51:05 +0000
Message-Id: <20230731145106.917526-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_080043_894811_45D0D997 
X-CRM114-Status: UNSURE (   9.15  )
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

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..e1a98647c3a2 100644
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
2.39.2


