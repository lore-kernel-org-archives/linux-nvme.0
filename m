Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB85DFD8763
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1KwZ8nz8JHs2Oqgda/ndp1RqwG+THEPWgrsJSl/X2iA=; b=tCBorhkG22Y3tVzD7Tb2rf4X7b
	sT5Tyhu3deOA0fVkiqOz3p5sX3H+beoNXjWj2d0Lz08xtvFz20t8ms52G1D+zc1AeQk5PbiCLmdbu
	3Xw9iGAgz0/CiahQsuX/i+GeIGOkbZ+pj3k0VlPErpP+4qDW/r3VMNEROSsESF3IGVlBbidOzYV4X
	1JfQqa2u1U2nKKCscutd+vzG2SlL8lcZHal916dTZKoY6by/99EZuloCJKR8iUX37hdbO/uOX/Eir
	pODta+mx/V5hh6smteI9Q1Ht5CGvsSYVEBeLXywgvcfvlozuZw8kC4LDZsWbthGBR5c2moWInMbw+
	yQrTThng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U2y-00000006LdN-0PxC;
	Tue, 17 Mar 2026 13:01:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U2v-00000006LcZ-3G2T
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D738344090;
	Tue, 17 Mar 2026 13:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C80C2BC86;
	Tue, 17 Mar 2026 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752476;
	bh=ejj9SMrkMXZCSt+WIlWshKKy/vc1v6tULc3xRD2m13s=;
	h=From:To:Cc:Subject:Date:From;
	b=mkmVXV8ocRGg1o+a0DwYpT8xjVvRF18ZuUeO/CPp8bg/wS77q5Uq/pMoqJmf9dDFU
	 NmUapXCN6SnpuWPA9JJOUT4YSuKz0F+sp74gKvmb7AJ5lucO7k9Dln5j5MZfbwMU7v
	 4N/DaQXTX102x/UqGiGuJorrt4khBOeolKb0E0k3tpe1RC9Pqi4SfoAHNpXV0WcrlP
	 bk8nSNZjB5t9ze1MMnzIj6xnAXklPGH2zwQlUYTdvD2cIyMH5VTxTTfH1Hi+YY+zqo
	 6zabk5heC2x1s921BfHEAOndAGjHCYJtStTmCiC53JLvI8b1p7dB3I+NU8NZS//jc8
	 Iq9hHzzIhMHUw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/8] nvme-auth: switch to use the kernel keyring
Date: Tue, 17 Mar 2026 14:00:55 +0100
Message-ID: <20260317130103.107360-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_060117_856273_90093434 
X-CRM114-Status: GOOD (  16.80  )
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
branch dhchap-keyring.v3

There is a pull request to blktests (PR#175) which adds a test
to exercise the new interface.

As usual, comments and reviews are welcome.

Changes to v2:
- Update to v7.1
- Include reviews fromn Sagi
- Clarify decoded PSK length
- Add more function descriptions

Changes to the original submission:
- Dropped patches merged with upstream
- Modified the interface to refer to keys via the description
  and not the serial number

Hannes Reinecke (8):
  nvme-auth: modify nvme_auth_transform_key() to return status
  nvme-keyring: add 'dhchap' key type
  nvme-auth: switch to use 'struct key'
  nvme: parse dhchap keys during option parsing
  nvmet-auth: parse dhchap key from configfs attribute
  nvme: allow to pass in key description as dhchap secret
  nvme-auth: wait for authentication to finish when changing keys
  nvme-fabrics: allow to pass in keyring by name

 drivers/nvme/common/Kconfig    |   1 +
 drivers/nvme/common/auth.c     | 211 ++++++++++------------
 drivers/nvme/common/keyring.c  | 314 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   1 -
 drivers/nvme/host/auth.c       | 171 ++++++++++++------
 drivers/nvme/host/fabrics.c    | 119 +++++++++----
 drivers/nvme/host/fabrics.h    |  12 +-
 drivers/nvme/host/nvme.h       |   6 +-
 drivers/nvme/host/sysfs.c      | 211 ++++++++++++++++------
 drivers/nvme/target/Kconfig    |   1 -
 drivers/nvme/target/auth.c     | 224 ++++++++++++++---------
 drivers/nvme/target/configfs.c |  86 +++++++--
 drivers/nvme/target/nvmet.h    |  13 +-
 include/linux/nvme-auth.h      |  17 +-
 include/linux/nvme-keyring.h   |  22 ++-
 15 files changed, 1028 insertions(+), 381 deletions(-)

-- 
2.43.0


