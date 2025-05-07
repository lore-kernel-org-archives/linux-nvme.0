Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C45C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4g7CFUUd8eCvbavZsuoR2PM4Uo3F3fr+pg5tuKj8O60=; b=ezQVw882/G99xV1podfpfBRc/l
	7lPazYxv8q6AabzsY0/rFwhNfZSgRWJE4H23yzhlqo9yAEoI+xswoM01zZ8NqynmzYPv/TcS4q7KN
	Dwt43o/IF6evvodJt9Percs7oYgqd3/QxI7i9SbNB1EIYjSKch9D22wZU8B6AmOtmenZ1FRKKykuP
	/LUrcARVKsagJm7FiaG0SWFelhvNqG75AfIDP1qUYkDb0yXe2LDMEDurepAlvrVOIObOysM5kvTJc
	bWBkvzYjr2iMTvpfQiUTotao3Xb5XRVCVfRetfZQ+vFTg3Dj/rGmB1dTy+aQRkkEX1Zm1Pyyv9hwb
	j8PHBYkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaxQ-0000000EvGq-25GO;
	Wed, 07 May 2025 09:20:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa97-0000000Ejyu-2Gcj
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 08:28:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E8C15629E8;
	Wed,  7 May 2025 08:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433A8C4CEE7;
	Wed,  7 May 2025 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746606532;
	bh=be4WxlDvy4T8xcugXTpThJYEtttZRoUtbABYy15fTPg=;
	h=From:To:Cc:Subject:Date:From;
	b=IaQtW3yupGTWJRRNoa21vfNA/W9sKE8KTlu/Tn7Qa3odNds3TW5pxHz/kLaK20gj/
	 nNbt9EfGupEYoCeNqldn9L8NGwwMm9AWlqhBtk+6HB2TzzT6BISoAO7sBIIBXLjLti
	 zkqQtzDQ0VEya6yePITZtyDYyzj3CNhUqgyorKBelS4LAxrAEbnk3IjqBAz96WgBwe
	 OuDUNDTMqG+mRonk6ySv016UNggHWBcfBWLwKFp0StsC8Lz3cYj8pzBfQ75XlKANlM
	 6bznbFCZwXj4RzyliAAfe37099Y5PV/gE6frV4qsRuVSytzh1h1RpPQUrg9ELCidZK
	 YCdiHGw3P6crA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvme-auth: use SHASH_DESC_ON_STACK
Date: Wed,  7 May 2025 10:28:16 +0200
Message-Id: <20250507082818.46157-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

we should be using SHASH_DESC_ON_STACK in the
nvme authentication code to save some memory allocations.

Hannes Reinecke (2):
  nvme-auth: use SHASH_DESC_ON_STACK
  nvmet-auth: use SHASH_DESC_ON_STACK

 drivers/nvme/common/auth.c | 15 ++-------------
 drivers/nvme/target/auth.c | 12 ++----------
 2 files changed, 4 insertions(+), 23 deletions(-)

-- 
2.35.3


