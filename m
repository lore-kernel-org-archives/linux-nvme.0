Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC1C5DF7E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=le080tCpWjl8pQtZtpKzmCVQuUUYFbGDmRNelF7gzqc=; b=pI9g8LI9K6d+rzIVkFkGpvtw2T
	AZ7rRk6kDT+VanD/CXe4PDY9AKUpt/8YIGjhhA6OYLgNgWeaYsNiKHXKgtgzqCoxDdLXihBMY+fiF
	gsMUsP9PJEGDbqv78cqAZ2aGc73IfOwMk7H21aYHXXmjq2YtsyD+FisWwnSf6Myd3WViGQZ7YjLEp
	dlK4B3wRXpgdBr1iwbbidL+L0sYUWrlawv60ECYV+gG99+mFz9ELY5SxEun7WZVefXdARhpltgatF
	UD1FpddfDQv35J++JK9BabN819vSZ1e0YQvGZGKxKNr1V6m7hH1PQnA8+zU3txjr7R5tGLYWWl76i
	ch7LdbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvM-00000007NJd-3UJ7;
	Tue, 18 Aug 2026 06:03:48 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCvE-00000007NEt-3jVj
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:47 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260818060332epoutp0203eae1af241b0545383f4cee5f4b73ad~M0Q52N7PV2205622056epoutp02y
	for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2026 06:03:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260818060332epoutp0203eae1af241b0545383f4cee5f4b73ad~M0Q52N7PV2205622056epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787033012;
	bh=le080tCpWjl8pQtZtpKzmCVQuUUYFbGDmRNelF7gzqc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=sDruqpKuUf86EWN4vTeXHii3NGerFZPJIWOYPAM3A/q/8r2TKifLUVfB6VdB5t4dj
	 h4IedkbGMvQrmBbD3HQYKiaoVjADZYz+6mIYYUnh4vY5wxgZciVl0fLsi2tXK6JkVo
	 2M9Ej28kcjT6XPdwZZDqe3CO7dRhKjOJzDBu5Ez4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260818060331epcas5p1064b1e13aed6261b519fcd8a686ab685~M0Q5hdCMD3082530825epcas5p1n;
	Tue, 18 Aug 2026 06:03:31 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hPJzQ6kF5z2SSKg; Tue, 18 Aug
	2026 06:03:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260818060330epcas5p4556a447149a5c2cd1e9aadd64952c01d~M0Q4JmhJc1655316553epcas5p40;
	Tue, 18 Aug 2026 06:03:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260818060329epsmtip19f5ec456c909c00f1fbf3e32a84769f6~M0Q2-tR4A3114431144epsmtip1G;
	Tue, 18 Aug 2026 06:03:29 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 0/2] fix racy access to FDP placement id array
Date: Tue, 18 Aug 2026 11:32:51 +0530
Message-Id: <20260818060253.4104-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260818060330epcas5p4556a447149a5c2cd1e9aadd64952c01d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260818060330epcas5p4556a447149a5c2cd1e9aadd64952c01d
References: <CGME20260818060330epcas5p4556a447149a5c2cd1e9aadd64952c01d@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_230343_031233_5D579178 
X-CRM114-Status: UNSURE (   9.40  )
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

Patch 1: prep to send non-admin commands from nvme_alloc_ns_head
Patch 2: avoid the race by moving fdp registration to nvme_alloc_ns_head

Changes since v1:
- Add a prep patch to unconditionally set ns->head (christoph)

Kanchan Joshi (2):
  nvme: set ns->head in nvme_alloc_ns_head
  nvme: fix racy access to FDP placement id array

 drivers/nvme/host/core.c | 39 +++++++++++++++++----------------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 18 insertions(+), 22 deletions(-)

-- 
2.25.1


