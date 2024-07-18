Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFE7C41513
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=53iht1QXN9jSdhvVoaLlhrT6XF1f3+O79kxQi6Wg+qo=; b=M2Yr4zNlN9ksfVz+HQrJWhIDf7
	BnZLeOs+6553M7/CY/tvWPPDW8di4moeLNpktAa6hW/g3M4f8fasFJ1H9qZ9fbn36qFtbu0e7TSvs
	+uxoNOOKfjHMIyRBf7nZzSN2Xp6ejpou9VsI2P4lcn3xNKWsCfzIuzvto+kqof15/5iGOI1caZmhu
	XUpOHKf6SAoRs3H+X47freha2cEoTOKJ7wqrVjIPWvzc98C9jc+q8d3FtJExKjResWgvCYjxwr1ax
	6ceksd05gcCIZbnZXqx3K9TixRGROyeWIkSyGvnw1qvxNNSzEArpeEv2EsK1+mSNqPSHc0GmgbwOZ
	wOPKeR4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRd-0000000HKMV-3tkl;
	Thu, 18 Jul 2024 14:49:21 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRa-0000000HKL0-13Li
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4EBF0CE193D;
	Thu, 18 Jul 2024 14:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507EAC116B1;
	Thu, 18 Jul 2024 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314155;
	bh=HT81PRwbw70wFp/yRBArgQAOcoqznnhexLJwawyqFCY=;
	h=From:To:Cc:Subject:Date:From;
	b=K9x59XyXyfSm344Aw8v5pBOvr59q9ZuWe6ljVf/ZmiwQytaPxvO/vd5I9/RhQR9Jm
	 9GmfVcuXwzHFIiBQgS7Vpp4kS4hrkMrFFqzyRs9icwbBFLWXPfPYRcdTQ9lXaKo6rc
	 6jL545yvR1vh+hUNkPmT0KNjb94UJf0ajobjOx8aFVcAbUh5axPhbPVmtggY6Q0rmc
	 1rGUmXII3WewxCX+PFYXVfbS1m++alaNCUa46dJ4iy3eA0oEsMWOtdoPmy7fNv5/+1
	 o1wO2o/rLFs5he8XwCfZPxNexdW/a4pxF6K44Hgji/EIGOIdkjiSBrlXRxw5IOsh7v
	 dFAawYZ1Q1+DA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv6 0/8] nvme: fixes for secure concatenation
Date: Thu, 18 Jul 2024 16:48:50 +0200
Message-Id: <20240718144858.19074-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074918_479767_8EDBAFF1 
X-CRM114-Status: GOOD (  11.24  )
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

here's a list of fixes split off from the secure concatenation patchset
as they really are unrelated and just are assorted fixes to get things
rolling.
The most important here is the first patch, which implements TP8018 to
support the 'version 1' format for TLS PSK identifiers. And it also
updates the sysfs interface to allow us to re-construct the nvme-cli
commandline from sysfs attributes.

As usual, comments and reviews are welcome.

Hannes Reinecke (8):
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: check for invalidated or revoked key
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme-sysfs: add 'tls_configured_key' sysfs attribute
  nvme-sysfs: add 'tls_keyring' attribute
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice

 drivers/nvme/common/keyring.c   | 53 ++++++++++++++++++++++++++++-----
 drivers/nvme/host/core.c        |  1 -
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/sysfs.c       | 34 +++++++++++++++++++--
 drivers/nvme/host/tcp.c         | 49 +++++++++++++++++++++---------
 drivers/nvme/target/admin-cmd.c |  2 --
 drivers/nvme/target/auth.c      | 12 ++++++++
 include/linux/nvme-keyring.h    |  3 +-
 9 files changed, 129 insertions(+), 29 deletions(-)

-- 
2.35.3


