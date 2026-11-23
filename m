Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83C606A334
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tVDLxMZD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmu2Hitq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=FHfB4b13tpFBuJgHG6kRNMJBbppuWmH69oa3I3gZvZI=; b=tVDLxMZDKE8xfIhMUuC17q8CzG
	CZB7oXtHDf0WOaeFdSS2i7HDfiVXhJk1FnYeWso/H50tFvA4CoF1yO9CGi+YzIr2QuqZzE8PuVVYL
	oEYWC5sBfrZvkF1TZ5IgV2WOm6d7RCAH3YGSLNhwrLByzjVwLD8hO1jr4k883otqYq5tp4mP/YXtM
	8ZV8i7wGUlD5UBH6wFvtqUQnNGTAUHJf68H+/wwuY5j/xDI4GaKG2omzwueq+v5PQtzetcbS+/ZWo
	QDn4wjhAXoyAJR3ezgT8m4/ZyRU6Ssl8KNRAC4kish9ChWEL1w1vFTcl7xiZqFChHXZqWEHAsE4xG
	Po6/FxgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSwl-00000003JGu-3dl3;
	Mon, 23 Nov 2026 12:14:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSwk-00000003JGE-0tkL
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:14:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C3E1601C7;
	Mon, 23 Nov 2026 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAD11F000C6;
	Mon, 23 Nov 2026 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436096;
	bh=FHfB4b13tpFBuJgHG6kRNMJBbppuWmH69oa3I3gZvZI=;
	h=From:Subject:Date:To:Cc;
	b=nmu2Hitq8MzSF4qnVcpiEsUZgT6jHr27QaUBje66Y2YZDQeayrRw88nOG3EMv9uig
	 +NThDHtPXuVG85f6qysIQYlO18J1FfHnXGJZudMxDwHvhhmkUFpHztugSLoyGDH2jH
	 BzZ5AD67rbSSGjhbKDfDVlCbwCCmUNopWWmKOnsqMBgK4udxGfeWLBVurYL1v0xQ4r
	 EN7IqDCEqFQw7AhiXccqDhBqNIgk0XhIlWWw11YOMMIyyJ6MZU2+tE6JyBdl1KYowo
	 FdHwTYXR1YjAJdO+DpbbuTnEbS8Yfs0c/wc1WPof6xLL2cDrV3Dy4NmLmYKB2a/3PX
	 +fPpf7u9cqMOA==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v5 0/9] nvme-auth: switch to use the kernel keyring
Date: Mon, 23 Nov 2026 13:14:45 +0100
Message-Id: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUuBGsC/32NQQqDMBBFryKzbkoSjDVd9R7FhU1GM1gSmRSpi
 Hdv9ABdvgf//Q0yMmGGe7UB40KZUixgLhW40McRBfnCoKVulNJS+FD8LCZcmeIollpIO8hX75R
 vnYGymxkH+p7NZ1c4UP4kXs+LpT7sv9oRFGZo3c1bqxvEx4Qc8X1NPEK37/sPEHPzWbMAAAA=
X-Change-ID: 20261120-dhchap-keyring-v4-09f0bac1d8c5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795436094; l=3378;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=IFrc+m9kk11Z/sGNV+kj67e/sA2wXW5SbtFXLe93GEA=;
 b=+M9cVibTzVUkMZBusg/TzgpMp0/oARwrFiklMHwEQW9d0HO7hcgCHA1I3nS+0K9E1r5GCh8JO
 y4yL1qSXoHKDsmkyGQyw/OXmN1vgMvu7B0990nhyy2ZQRtyOlUM8nOK
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
Changes in v5:
- Fixup issues found by sashiko
- Link to v4: https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org

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
 drivers/nvme/common/auth.c     | 214 ++++++++++++--------------
 drivers/nvme/common/keyring.c  | 333 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   1 -
 drivers/nvme/host/auth.c       | 179 +++++++++++++++-------
 drivers/nvme/host/fabrics.c    | 143 +++++++++++++-----
 drivers/nvme/host/fabrics.h    |  12 +-
 drivers/nvme/host/nvme.h       |   6 +-
 drivers/nvme/host/sysfs.c      | 236 ++++++++++++++++++++++-------
 drivers/nvme/target/Kconfig    |   1 -
 drivers/nvme/target/auth.c     | 231 ++++++++++++++++++----------
 drivers/nvme/target/configfs.c | 146 ++++++++++++++++--
 drivers/nvme/target/nvmet.h    |  16 +-
 include/linux/nvme-auth.h      |  17 +--
 include/linux/nvme-keyring.h   |  26 +++-
 15 files changed, 1170 insertions(+), 392 deletions(-)
---
base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


