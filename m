Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A778D6E2C9
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jRFC/JK19gx0QT1ES1OmkrmZR8QuVUw9RBoYF3Hb6j8=; b=xSCjav/picR7COdcI2GMWFYY25
	bKHoFf+KrOor7TS/miRHrBwNy/UHQxTtLbLBtdpqUKU5jcriiEgngwZ/tvyn1+Itn2VGiZVPyg1WN
	cldkKFHnW4DNMyA9vuJu2TqiRMB+xh7XPMzKLStb9HmDRIytpVeQWUKgXjFoeGD0IjAzsI0j5I/LD
	oz0b/5h2IgEQ4PLKgMCXMKyvuo6/7xavJKZo/eA4IcbNc0O7WjIfaU5n9E3sDjf61SybPGHNK7t9p
	pliFVI3pYE9AOkyr68SL2D7RP94RlJ5Z+3HZZje5dMcVrAasNF0e0Nba6UP4xDzvXKuWTVsW0kpv6
	/0sekpCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDeqz-0000000EaJa-34hc;
	Wed, 20 Nov 2024 07:10:21 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDeqx-0000000EaIz-01gs
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 07:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732086615; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jRFC/JK19gx0QT1ES1OmkrmZR8QuVUw9RBoYF3Hb6j8=;
	b=WzQyxdhJXh8sbxiis8Cf7Iugc2H0TkxI3w8xYR/Qf4eI9/XzTpU+9ggf3j83QE+H+PCw9mDvYscjZX4Id9Lt8etGALKjeB2w4v0dRDCfuYeZkl/QqJ5Yf6DpZ2R0Nwuc8wJYmd8nrVyoQARzu4MIP0zeQ8ch+OVt8KerxG1tUUw=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJrG.15_1732086608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 15:10:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] nvme: make pr code more readble
Date: Wed, 20 Nov 2024 15:10:06 +0800
Message-ID: <20241120071008.106933-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_231019_656104_31DF79EF 
X-CRM114-Status: UNSURE (   8.45  )
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

Changes from v1 to v2:
- Move the generic definitions to linux/nvme.h and add a separate
patch for the changes of linux/nvme.h.
- Define the different CPTPL bits separately.

Guixin Liu (2):
  nvme: introduce change ptpl and iekey definition
  nvme: tuning pr code by using defined structs and macros

 drivers/nvme/host/pr.c | 122 +++++++++++++++++++++++++----------------
 include/linux/nvme.h   |   9 +++
 2 files changed, 84 insertions(+), 47 deletions(-)

-- 
2.43.0


