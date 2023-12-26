Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE4EC46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MHna+1UpryQaftTlx3OIhzBIiGi6VOLPwPbBwgrDePg=; b=CwDVTSCswOs4W3I9jYl6d4dPoR
	pPC2Hs6ZMrspl5k+0XnUa4xSAiqxGGfcOZejZVNuhd4e+ltMFaSL3sZ3MiDnKzIOd2yDzSCGQN1ba
	5ZAPy5q71abaNRCZWPYc3Lcf2MGQuvvcnn8z/nypD6H3lHv4s3hNM6q5XEBbnywgw9DSDXakrMp3o
	tyFW3yGTCV17ip+WxsW1cesdOvBSPvZg0RyzG6AUgdLeq4IpFIdGS518047fV2u8VzA0kHHCX/9gk
	vJk/Ejgen848YaJrsBc/NDvww/kQ5/VfjvG866bAbAGkjpWZaE850X8oZbVbK3ruBmo0IKgmNz+cc
	rupm9yZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3H3-00Bvxc-0C;
	Tue, 26 Dec 2023 08:58:53 +0000
Received: from [89.144.222.247] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI3H0-00BvxU-28;
	Tue, 26 Dec 2023 08:58:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: nvme discard limits fix and tidy ups
Date: Tue, 26 Dec 2023 08:58:40 +0000
Message-Id: <20231226085844.203878-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series contains a fix that makes sure that the discard limits
are properly calculated based on the LBA size for each namespaces,
and also tidies up some code around that.

Diffstat:
 core.c |   41 ++++++++++++++++++++---------------------
 nvme.h |    3 +--
 2 files changed, 21 insertions(+), 23 deletions(-)

