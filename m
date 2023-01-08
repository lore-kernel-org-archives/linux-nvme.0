Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF8C53210
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dD2mfo/xkiEE0e6xuEw2hgvXbj83P7/1JuxgvDug2LU=; b=vpFs2tNcKZj7EZvpiBV7LiKqLf
	an/zNMI9+Mx36R2wLODtV7MJ/zHGgpq+XRLGZc58USAOKajaO4wRl0clniNdyEkCaNaHYvr9kTpSO
	VpVg9Q9/BK5WvqjyOeI1WIpJ5HirN4p7QuBgt+FF4aNL6rS0itpfeap46PVbzh1VVwppEQaPyfF/c
	Om3cg7ga+M4YvAHdpAAreBS70UvAlOYrPhuJGUybEfFWSZ4Pn+VCx6Szru4bJMMvZ0akdrHTLePJd
	7dV5vcEqCNJKLHM1hEQBRVUADryBrtWQfjrvQ6P09a7j++3FVPdzDLEG801kdSz/6/fPa1byn5g6y
	jFBhfxpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsZ-00EQ7e-Br; Sun, 08 Jan 2023 16:50:39 +0000
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsW-00EQ6V-4h; Sun, 08 Jan 2023 16:50:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: don't allow unprivileged passthrough on partitions
Date: Sun,  8 Jan 2023 17:50:30 +0100
Message-Id: <20230108165033.380842-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
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

this series fixes ensures that unprivileged passthrough can't be
used on partitions.


