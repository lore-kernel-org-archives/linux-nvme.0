Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E16CC36014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zhM28tVWB3zXR2MALinPT7qj4zaeGBFg9qNIBSW/QlQ=; b=n3lyClafc5wYIgDF3l8FfSR0QD
	1ORZEpEaKkwsP+EN/keexTOIeClX11X/BFwvO8Ku+nXzgZkBP+E4fGjz/QH/QwHgwh1Tj4/NpFZFq
	87ajRjeDQUC0MlCoxdLfDgMEgrvj7oASHBzsphtsZUJ+mEH/v919OdLilrj246WcS7SN5r/iW8WW5
	qc7yQ+1dhlHXhu8rzSPnO8CLHC69JKc48LW8N1W/aJVRqS4QtUBrO4o2aZ1tXv9hAswGepYoB1yRD
	Rr6SiRVRL1dz+i2g4ecevnwaT1YxW+1Jt8d6cVOf4owxkq6cCSYdROoKucfKle6nggNCcPZeQ/Dvt
	vRWsMRmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYTo-00000002Ymx-26wc;
	Tue, 01 Apr 2025 10:04:24 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXtq-00000002TRX-14qa
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 09:27:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743499615; bh=zhM28tVWB3zXR2MALinPT7qj4zaeGBFg9qNIBSW/QlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f408uEa68Y0Pbl8jekBG+WKxATFYADQukS1qlSgW46hQO4squwmKG87UQb+OGTMdG
	 O0ndpW4ZkAZPi/i5QPtCjI85/326yAC21lBr1TA72YkwVZIxSjMz5nkVGz5vuQL5/A
	 jVKSTFaYzTaIt3MHR+zKl+2LRMYPvDhA82HhhOEo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 6B53F051; Tue, 01 Apr 2025 17:26:53 +0800
X-QQ-mid: xmsmtpt1743499613t65g81ywp
Message-ID: <tencent_A06D513AE17E9D4B4AC66E84F447FE730C09@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xd9qg9PKd1L7ecbnL0lynqHNnxKuTMmdGAMkkOIYWNLozW797TD
	 ENDQVpt6rsUXT6O1fZ/bK70oUEi/UNeQXLsIEgbQFdhWCB8xkj03YMG5V/HJxwhDZ5wpCcVf8D9K
	 Hqhu+Kf0iXuGCDIe1NfXfl0CKeGuCvuGwHCCQmb1alRiFbq4v09uCXMNw6YNph6+/HjniRZOD3hL
	 yMfDpr+QLrxMy4r7WTxBQoDAplQo/GsY9WmK7fJIwd1F3byop+lP0SdUIEZ/EgySWAXYpQUqO689
	 BaJtgvxc8xLEGy2o9lGA6mBW8ZHylBFFFuISulKZ+GJtDzWzWmZaSXIb3a4ea2oLyTCq5Y3zljwi
	 qfaMF8ke7D49AN9qa49gOhT/1KRQvB/leKgicWtrxiQffR8R+EPRCNdKlc42HtmMxI5ufBt8jQvq
	 8B9CWQeiRTxvFPO269dNSc9PX6f5ROLyxD/uEruA7MsR0AZmM4kUwgy7fj4ZnKY7ZuRE8TsFnwws
	 fUznhoeJD7qrgsu+1+h+mcfOSJAirq58qG/dLzDTjWLmVC9DZ9/PKPbXG/eneJrJO/TmIAYfzlVJ
	 fRYHqqddhLVsB39wG3AeaqwatpWUfFZhETanEwsU1CoBm1Q9zmohqvHFLBZPs+/mXmnsj8Oxxw+Y
	 NvUtUoim4ZkN8CBEUSmb8H/GnB4sunoib7YGEH6ZA5DBiACALtH3g9IFgKf/l6NjmjDcvUhi8ozc
	 rmya8YrZAPs+tBwIDf9hff7+qLB06ndvwsT7TZKrs4QzV2Kgz1CNkAakiEo0PakRjMe8XfRGDo3u
	 D6gN6NijNbEOj6ZyED4mfim4YndopWFdnqBH7+Ks6UrEeb1VYUKlKK1KkBvsJU932aezMKwBEliw
	 Y1wm12IvuhrboPXvSUeIn+6oq2ws0rKRh0+vyN2OIdm9xDwDlS4ZaIgo0C/+ehvExRiIWhLu3wmN
	 NYVjjGRKQn9CS0T/NVQpMeXBr+x4p21osdlTwAY0J2T8xDIPwzJbCr9EbzWtpXr6GgleP2RF8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 1/3] nvme: Add warning for PST table memory allocation failure in nvme_configure_apst
Date: Tue,  1 Apr 2025 17:26:52 +0800
X-OQ-MSGID: <20250401092652.1557590-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_022714_599577_ECEA0E02 
X-CRM114-Status: GOOD (  13.42  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently the function fails silently on PST table memory allocation failure.
Add warning messages to improve error visibility.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2d89fac86c5..fb0404fee551 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,8 +2678,10 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
+	if (!table) {
+		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");
 		return 0;
+	}
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-- 
2.25.1


