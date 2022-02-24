Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3416BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q/o+R/HUE7IVyfY+xLSOl3PtbTwQ42KXC0rdVY1FPQU=; b=arqEZDbLBdZaZ/lplrZYaDh0Kh
	KAIpxRtrTLY75UwoBfspH4skJTYZCNbxtP0UhXRqrFi1HXm09PSDPjRViwjSMhfrvsoW1EGLyg68l
	AlnzVCgP9xE7aqzqffFaPlfxLcvBWw+XYD6QxZ9u2uhKJgQkyvzhV9/aYjuRL6qKdOcit5+n3ROUq
	GJcdUd03NGrsmY24VNq8vwQvqAPcXMTbapnG9QMF/Kxb6FY1z02Q/iWdLD2c24TRw9wkZ3kXCckJx
	RDQqPO5c8a2bfVfxApn7/zv9f/dsH1AU2ORSOF1qpGKrbSvuiYGfWhxf0pFBVTzkIA0RHT4sDVWIJ
	06GNQQ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNBpp-000Rfj-Qv; Thu, 24 Feb 2022 10:58:57 +0000
Received: from [2001:4bb8:198:f8fc:e55d:3b08:349b:3812] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNBpn-000Rf3-3J; Thu, 24 Feb 2022 10:58:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: properly validate the nvme uniqueue identifiers are unique
Date: Thu, 24 Feb 2022 11:58:49 +0100
Message-Id: <20220224105852.862715-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series fixed how the nvme driver check for unique identifier
and then also applied that logic across subsystems.

