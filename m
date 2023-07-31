Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ABFC001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4Q6nswl7adnvle4sIwtUJF9tAtvVTB8NezbTkNtatk=; b=iLNy3fJrvOuWM/G9M80WUc/8SJ
	LVZYXSbnCdLfi8Zoi42d65PlhSl5GbNSaq5bjP8yBXJ2ojQL0TyiTYAdSHLZjIo6J3e4rzbGSpmmV
	wH0fShg1EK6y0BYlBcHMOvoimrDo1pzKnKJ8+WE40iwzzrk5jxhJlvO8hj7PAMp0LN+CZTYsvAawG
	GtXI5tpbkf+Jj5eBUp4pdXjgSG35JohIKHp5XCxEcoU6kePUK2Z1fSNU+kNbCTx0R+hz6euKGUdg8
	BiEOBuqpTUg3cE3Y2DAH6rNX6w+O55UNTjerGpRSAs5MpzX3mkvMuvrf93a1vY3uN7Jtcr1r2LDF6
	yTeegGjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQUOJ-00GEuO-2W;
	Mon, 31 Jul 2023 15:00:59 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQUO4-00GEWk-18
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 15:00:45 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9394F240029
	for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 17:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1690815638; bh=IvLmPEmw9kMuEQzvbUm2FqmKdi2Hp7a+u6Dag9e2cQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=b2rJAhH7XN+U2h1IPMof9q8aYTETIZR8JWHE47jm5imuVvyCscpcIfhTAfCKl5heH
	 scCYFDGhWc9xmvUBdulpsNHCSSwapO94odN/aORyNToc3hk8bXYd4Kujr+ZWyUxCnc
	 UqUszWhAL/4pPS08fWp3At5vYzgqmzhCtEU3vmFUP0wHd6Tabvhg6axLykF7OY3cNq
	 EIvvioF2ivlt26z7jerets5aHY1V+ONjaxeIMQ9DmmwFH7a5fQ6viHKnNsw34NdZma
	 sTzD8Iw7V+qbptsC9wuDGeNYXSp3flcTtgK7pfEXtwVS7yFfXGTCGlV9NH+g3d/56Y
	 SOoT1hEJgpv6Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RF1dK2GsRz9sDs;
	Mon, 31 Jul 2023 17:00:37 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 2/2] nvme-auth: set explanation code for failure2 msgs
Date: Mon, 31 Jul 2023 14:51:06 +0000
Message-Id: <20230731145106.917526-2-shiftee@posteo.net>
In-Reply-To: <20230731145106.917526-1-shiftee@posteo.net>
References: <20230731145106.917526-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_080044_552450_BE696FAC 
X-CRM114-Status: UNSURE (   9.53  )
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

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
v1->v2: Set failure explanation in a single place if the error handling
code has not already done so.

 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..9556cfc4f5f3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.39.2


