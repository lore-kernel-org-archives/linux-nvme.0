Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01960C25B76
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfzAJFwlvpoHCcNZI810mCC4cEHroJTWhTYM+wGdxH8=; b=NoI5M7t6sjrxrXv9qYR3kzzuWM
	swDb0LGQhnye12p6loolKL9aCdwBW7BHnEPqxOTSpIrNGjcTpzNVByhpVfCSzhWiOcdwNgaBF2JQv
	qmBWyvORnqjfBf73R9jqCTzMk0XO+BK+IlGS5u+oaAEydHqTe3NQ+JlBXFyOXw7u8T6pAr1vnZD+Q
	AEygutBTA2hx1IYxPoxrKCV0H0DOgFsJ1Fu9zuO3PcimSHYVtFdr7QfPjxw/FrbLHTo1lHB5rFLbl
	COkBL1+kV3u6x/he+Ah3WJWJGifMjvDu2MunNq6tqIWQtKdnCCcQNqI+wVeIHaRFHzdKxPqGiALCH
	Hn0PYgjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GQ-0000000GmG2-2P5e;
	Mon, 03 Jun 2024 12:58:14 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7GM-0000000GmDo-32Yf
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 12:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717419480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cfzAJFwlvpoHCcNZI810mCC4cEHroJTWhTYM+wGdxH8=;
	b=Ua7wYXG5kNdi4L9gTVHQ4aDfIKS5qSBQ7h9wKpezBBjZD9n0SL5JOzxxpkqrrvLU6OoQovErqGy6keEnTZuxnqZ3wu7Fc6CCKTzoXoZ2xUwWMq+saFP3ngUpq68lF3k8Sd9m2QkJO4hDknKN1LieMPX2pjDySkN2kjIh/9CmHIM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7nmJ9H_1717419479;
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7nmJ9H_1717419479)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 20:57:59 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Weiwen Hu <huweiwen@linux.alibaba.com>
Subject: [PATCH v2 4/4] mailmap: add entry for Weiwen Hu
Date: Mon,  3 Jun 2024 20:57:02 +0800
Message-ID: <20240603125702.97368-5-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_055811_138206_0BC1B065 
X-CRM114-Status: UNSURE (   6.86  )
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

I have graduated from SCUT. My old email is not available now.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 43cd2995dbc2..a9517830105c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -684,6 +684,7 @@ Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
+Weiwen Hu <huweiwen@linux.alibaba.com> <sehuww@mail.scut.edu.cn>
 WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
 Wen Gong <quic_wgong@quicinc.com> <wgong@codeaurora.org>
 Wesley Cheng <quic_wcheng@quicinc.com> <wcheng@codeaurora.org>
-- 
2.45.1


