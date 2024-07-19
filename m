Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B88EC3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eJGkeZ+B4lQnntV/5x646tpUJDSE1ijXYU5aHYM3cAY=; b=fZsQEBwFocURc+VxZJro4nK2PS
	LBZz+d/staKOSTaLMGXy17utBs6FjuijUOiB3FutqZcB4JbJXjr5+TXGGWEOf8xK7JQbpJinWHJ71
	bSF96zszgKj9yuYBv+7bhG1zQyW3B0C5js4st8OqmYyUGhmFAs3JiBK9mM+moQRzOJblSDLXnB+rw
	qPUfwPcKNH7kVF5+HkBqlYGK07gHtP6N9e0Idvrcfq/wOxPKV4HsSMExlX40yrpVNDZQX9N87yuWi
	04ZMUtmqOIwlSemojjMreUdyNeTx1gwRBR8XuGNmNFMm+RCCTj/X6P66GYAzG9GJb27o1B69ZT/3k
	aXIv0+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnq-00000002D9I-1yCn;
	Fri, 19 Jul 2024 09:21:26 +0000
Received: from m15.mail.163.com ([45.254.50.220])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUjnl-00000002D7s-2vFr
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 09:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eJGke
	Z+B4lQnntV/5x646tpUJDSE1ijXYU5aHYM3cAY=; b=E3FymKGd8kQl+cVgNa7Qn
	zymGlkpMU3MqRQia/VfyNrWZ4Th+9McV4tEwKe+oWNuQogIDqcxLW6BBobVQXPjB
	NDNHSkthi3Q4zXjMO4J213PIfLXZz+TOeBGXDaqe/yPxNnecuje+afdCTLXwsLet
	S7Jy3zLTJ8t5LrC+x/GOiQ=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S2;
	Fri, 19 Jul 2024 17:21:00 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Fri, 19 Jul 2024 17:19:57 +0800
Message-Id: <20240719091959.17163-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3T3X7L5pmYK8DAg--.13202S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCry8tw47Zr4xtw45Awb_yoWfGrX_CF
	Z7ursrG3WxWF4DtFWI9a48ZrySyF98X3s7Jw48tF1UKryrZr1UArWDCr95Ga48ZF4kJrnr
	Xw13J3ySy39IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi1xR7UUUUU==
X-Originating-IP: [223.166.237.249]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSAkhKWXAmWHsaQABsQ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_022122_369435_64C9EBBE 
X-CRM114-Status: UNSURE (   9.01  )
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

When running nvmf on SMP platform, current nvme target's RDMA and
TCP use bounded workqueue to handle IO, but when there is other high
workload on the system(eg: kubernetes), the competition between the 
bounded kworker and other workload is very radical. To decrease the
resource race of OS among them, this patchset will switch to unbounded
workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
get some performance improvement. And this patchset bases on previous
discussion from below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Ping Gan (2):
  nvmet-tcp: use unbound_wq for nvmet-tcp by default
  nvmet-rdma: use unbound_wq for nvmet-rdma by default

 drivers/nvme/target/rdma.c | 2 +-
 drivers/nvme/target/tcp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2


