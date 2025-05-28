Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCFC5AD49
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oUHoFT/FVTGDC9UQp1npYhQp2MOZHPj+ff05h361qgI=; b=hBb0zTb9drMZg1yuXp8H9fGf8O
	A3J/AD9TpvZED9fDDIxzC6y4U3cFVJcESAzzF9uUK0vpvXHqlfjwVZlzAPhMlwh/QUsAxVEKwuk5y
	DPcX54U/Y7iU4W35N/Kk7H/FZRUUBS7PznrRVoJ5I1BRLEFy/RsCEVFkcM53f5Nh/lbkpmdugH/ot
	AK3S5gDMhhQO84Uy6HqnIGFUtHQxf8lamvIWRd1LEU69zy+Z6cRx/+WcJztEjZB15IejuT95Iyx1K
	aEucP7/kspf4biAwDsK1i6B+SdbvHVDoOrZqudzjEiOCzOiuNN7KLtsVZPPIfWP7R/X0axm2yvqcJ
	8y2kBpiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHbA-0000000DLne-0HJk;
	Wed, 28 May 2025 14:17:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSM-0000000DKOd-0Oz7
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3910D5C55F2;
	Wed, 28 May 2025 14:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F7FC4CEE3;
	Wed, 28 May 2025 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441312;
	bh=/5TiWU0sDEvd+N54uFgzaXyNvg+SpcNBzu3/d0bw3xo=;
	h=From:To:Cc:Subject:Date:From;
	b=Nl9dITouKKvB02EQTQgw4zV/gOTZn+xL3MH2gRkww7dii4MO9V/2Z0AiakBQmWCtu
	 +dpRo3W/2+nIcG0cHAh6+IEcT3/IqzaaHVrLdpgqSbUMX45OK5gbVkGzljb1JxFypf
	 p/xcuT6R4pMCoDbzBqv+D6zu75VIPXN6dalVIuxhTHKsWpRa9O9fchgJlK7ryFE3mC
	 vCurZB3D2inVOAP8zdV0YL+rs7vZu+UktTd2LZuLZdbKXEBLzIOielfdR2nmkXfqps
	 i3itXoE4bllJOCAeqWBnorxW14HzuI9numOGPFkpFwJ0nRmgxtSwfDanq99ppIu7qk
	 fAqrb0RmbTeQQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
Date: Wed, 28 May 2025 16:05:08 +0200
Message-Id: <20250528140517.3284-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070834_222819_DB42C7E2 
X-CRM114-Status: GOOD (  16.78  )
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

Hey all,

the current NVMe authentication code is using a hand-crafted key
structure; idea was to have the initial implementation with a minimal
set of dependencies.
(And me not having a good grasp on how to use the kernel keyring :-)
That had the drawback that keys always had to be specified on the
nvme-cli commandline, which is far from ideal from a security standpoint.

So this patchset switches the authentication code over to use the
kernel keyring. User-facing interface (namely argument to 'nvme
connect') remain the same, but the key data is converted into keys
which are stored as a new key type 'dhchap' with a random UUID as
description in the kernel keyring.

With this I have updated the dhchap arguments to 'nvme connect' and
the configfs interface to either be the keydata (ie the original
interface) _or_ a key description referring to a pre-populated dhchap
key in the kernel keyring. This allows for easier provisioning of keys
and avoids the security risk from having to specify the key data on
the kernel commandline.

The entire patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch dhchap-keyring.v2

There is a pull request to blktests (PR#175) which adds a test
to exercise the new interface.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Dropped patches merged with upstream
- Modified the interface to refer to keys via the description
  and not the serial number

Hannes Reinecke (9):
  nvme-auth: modify nvme_auth_transform_key() to return status
  nvme-keyring: add 'dhchap' key type
  nvme-auth: switch to use 'struct key'
  nvme: parse dhchap keys during option parsing
  nvmet-auth: parse dhchap key from configfs attribute
  nvme: allow to pass in key description as dhchap secret
  nvme-auth: wait for authentication to finish when changing keys
  nvme-fabrics: allow to pass in keyring by name
  nvmet: add configfs attribute 'dhchap_keyring'

 drivers/nvme/common/Kconfig    |   1 +
 drivers/nvme/common/auth.c     | 227 ++++++++++++----------------
 drivers/nvme/common/keyring.c  | 266 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   1 -
 drivers/nvme/host/auth.c       | 166 ++++++++++++++------
 drivers/nvme/host/fabrics.c    | 119 +++++++++++----
 drivers/nvme/host/fabrics.h    |  12 +-
 drivers/nvme/host/nvme.h       |   6 +-
 drivers/nvme/host/sysfs.c      | 204 ++++++++++++++++++-------
 drivers/nvme/target/Kconfig    |   1 -
 drivers/nvme/target/auth.c     | 226 ++++++++++++++++++----------
 drivers/nvme/target/configfs.c | 146 ++++++++++++++++--
 drivers/nvme/target/nvmet.h    |  14 +-
 include/linux/nvme-auth.h      |  18 +--
 include/linux/nvme-keyring.h   |  22 ++-
 15 files changed, 1039 insertions(+), 390 deletions(-)

-- 
2.35.3


