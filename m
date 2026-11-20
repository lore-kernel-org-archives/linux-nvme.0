Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A185606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=19Hv+WOd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exk20NVe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=TvxyiNCGdB3dVoMPcMs9gnDui3F/bIpkJgmIVmY1Oow=; b=19Hv+WOdzyD9fDucDaK29bGitw
	oX3GY9V2DiqnzFJeHP8nixjZl+eR99adJvA2dSn4wcdIRArKS2CcXkuGYhdqOhzoHacNfssmlBaec
	YkJnJhV7xXwIr6JAYHdeTd3fDyY0OmO8STZqulmK1TwhfppCNvfNRyFQyyXit/PZDWWowabum/q6y
	ihNNuTVoBLUx2q8RoODicVuHqUX+qai73UMttKq5vv2cgVDmUXQKZ79yMaAxcm7SVAJLUV9cV8xw6
	TjgPX6NVv0+fqap65qzF81Z/iQWpPOUr45p/XOVj+CxYUiAFTBeiLRAtHV5PBNUeKKWuLz55AwOJh
	4FbJcbJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZQ-0000000EkdU-1Gol;
	Fri, 20 Nov 2026 11:14:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZO-0000000EkdN-2UBN
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A01E457E6;
	Fri, 20 Nov 2026 11:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FBE1F000CA;
	Fri, 20 Nov 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173257;
	bh=TvxyiNCGdB3dVoMPcMs9gnDui3F/bIpkJgmIVmY1Oow=;
	h=From:Subject:Date:To:Cc;
	b=exk20NVeXLvRvazj99ZD3gNOV8A4lKFAVjr16sLBJtaJWZIncyBlhdTIpoQvbJaS9
	 kY6Bka8in1DYWhyAzS4eGa/fCHsLt5JX+mu2P1ZCMu1wY7H9TCV6u/82cmUWXfFUa7
	 Sv1DaapVW0CL4EaMXSbOTuEhMfjLEHRRSKph3nlBWwpR10vCbRLeZe8S7rcOVeTm4J
	 LrxMHV5lRZIQnYRkpRG/5gGsgulz8Wq25xgESd1kN7hfGFLm9vokkZaAdQRTxjaoCs
	 ZMq3D8eymcRi5GoJjMiljimScfVBWt59XUhxDERE1FXKQM+QYw+UMCt8Jspqa4nTnl
	 fcz5AuQasfzSg==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v4 0/9] nvme-auth: switch to use the kernel keyring
Date: Fri, 20 Nov 2026 12:13:59 +0100
Message-Id: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgrAGsC/x2MQQqAIBAAvyJ7bkHFovpKdDDdaglMFKKQ/p50n
 IGZApkSU4ZRFEh0ceYzVDCNALfbsBGyrwxa6k4pLdHv1Uc86EkcNrwMymGVi3XK966F2sVEK9/
 /c5rf9wPsil5MYwAAAA==
X-Change-ID: 20261120-dhchap-keyring-v4-09f0bac1d8c5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=3227;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=JMQrTDzvVUh645kB4vsxAScpfmUl0DvgGW9gAwgUvWg=;
 b=rzzq6JnUGWOWwrcssrS7Qu8spR/KSjEnKkTYYw+Nc45H7nAbjUHJBeViPtSo+K/HwUoD0uhW4
 8xRIuZElh3+DGvNQkcO1Fg/RWcPi6GG1vsOGO1MKc1Xyfb35J1rapM8
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
branch dhchap-keyring.v4

As usual, comments and reviews are welcome.

Changes to v3:
- Update to 7.4
- Add patch to set keyring for nvmet

Changes to v2:
- Update to v7.1
- Include reviews fromn Sagi
- Clarify decoded PSK length
- Add more function descriptions

Changes to the original submission:
- Dropped patches merged with upstream
- Modified the interface to refer to keys via the description
  and not the serial number

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
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
 drivers/nvme/common/auth.c     | 213 ++++++++++++----------------
 drivers/nvme/common/keyring.c  | 314 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   1 -
 drivers/nvme/host/auth.c       | 171 +++++++++++++++-------
 drivers/nvme/host/fabrics.c    | 121 +++++++++++-----
 drivers/nvme/host/fabrics.h    |  12 +-
 drivers/nvme/host/nvme.h       |   6 +-
 drivers/nvme/host/sysfs.c      | 212 +++++++++++++++++++++-------
 drivers/nvme/target/Kconfig    |   1 -
 drivers/nvme/target/auth.c     | 229 +++++++++++++++++++-----------
 drivers/nvme/target/configfs.c | 144 ++++++++++++++++---
 drivers/nvme/target/nvmet.h    |  16 +--
 include/linux/nvme-auth.h      |  11 +-
 include/linux/nvme-keyring.h   |  26 +++-
 15 files changed, 1092 insertions(+), 386 deletions(-)
---
base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


