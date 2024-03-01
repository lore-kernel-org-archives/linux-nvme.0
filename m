Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDDAC54E41
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g7vvrtONLFjG/TYF8Jpr/BFlixKP5ByukR+gS/8GeX8=; b=RekBXhKVWAQti6TfYtc/PBQTNQ
	a7vUTyv3VZmjsfL/PnfIXpwX9dmdmHU+ogzNa42V+3bArIwgl1u7TG7UG5E36K9SwvGu2qccuP1ma
	Xf5gwsRVaiqVRxY/ZYiN8DWF4XEBC6+OVITkIoKnl9dY1oFqmmBVS+a6puJ0Y3Jlbr6BxwZtuyqcp
	w4MJP4NFnubbdECmgOLecPNBI93xCb6N71uC+GSExX8xKYKHX/nifEmK7080rgrLWusrNFuy2NI1p
	VycKIUUq+XN7fBLMwXyAdhlHI8Mxgfu/KFQGe65IKAK/9sexz0469g//sW24NP4LOs5Uzs2HNKXDJ
	rvnsmaYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg148-0000000HZYz-3uV0;
	Fri, 01 Mar 2024 11:28:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg145-0000000HZXD-22rL
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 11:28:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 61AB1CE1B1B;
	Fri,  1 Mar 2024 11:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5681FC433C7;
	Fri,  1 Mar 2024 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292510;
	bh=EAmEslhS1RP8j0esIEij7JsFOiqPPleN8zk88NfeYi4=;
	h=From:To:Cc:Subject:Date:From;
	b=W1cGWlsP2GhM88jKiN6Ls3xcKX7r+1RHJLqElnri3A0n4zA9VDkI6+7uNQFfQhOJF
	 QIW/uwzUdjtJNavrz+RPakOUOpd8VtLhdn4DzlonRur1SeaiImhlimNZ9B8fJ72XM7
	 vJaYP3U6quzoJeuuI//axo4uJdnVv2uVJ4JjOr2LWbvB/cuzRZYDMcQ/2vsiVYyxkG
	 dX6E+rWZfK6ef+LYzlEEJj/iEPpjYYliJigYgRVVzXNd2PSaeGoXue5Im7D9H1r5mH
	 sTpl1UnGegJHoNggAjSK0ZXHkzRi5wdgWz+DLTQ4MuRIt3EGSCXB+VIbkDEulscjqG
	 hJO5s97U3xM/w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/4] nvme: fixes for authentication errors
Date: Fri,  1 Mar 2024 12:28:19 +0100
Message-Id: <20240301112823.132570-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_032833_752667_0EE0AB1A 
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

here's a set of fixes we've encountered during blktest runs.
Turns out that any authentication error we're generating
internally a in fact non-retryable, so we should map them
onto the appropriate NVMe status.
That caused some fallout on the target side, which gets
fixed with the remainder of this patchset.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme: authentication error are always non-retryable
  nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
  nvmet: return DHCHAP status codes from nvmet_setup_auth()
  nvmet-loop: do not call nvme_ctrl_put() after nvme_ctrl_uninit()

 drivers/nvme/host/core.c               |  6 +++---
 drivers/nvme/host/fabrics.c            | 29 +++++++++++++++-----------
 drivers/nvme/host/nvme.h               |  2 +-
 drivers/nvme/target/auth.c             | 19 ++++++++---------
 drivers/nvme/target/configfs.c         | 22 ++++++++++++++-----
 drivers/nvme/target/fabrics-cmd-auth.c | 11 +++++-----
 drivers/nvme/target/loop.c             |  1 -
 7 files changed, 53 insertions(+), 37 deletions(-)

-- 
2.35.3


