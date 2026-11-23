Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48D606A331
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=q+Ump3vA;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0Wp1NYD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=c3TaoASfd8PzD5S4tgYOpeLOWlNif+silHEuUYg9+28=; b=q+Ump3vArX6r7XVFGBQ9nTyfs1
	YFVE2sSQnj7I3KsPjzCSayhFUk7jML1lnEkjPLgy+HUHsp53evqlPJx2Uhrtjw4HERLxr1qY93rJb
	XUbnr2zAUDTApHAp0eW/cKrguHG6DiOCOXkiiQJcgfgVsbHGWSTI+XMLzONrxeLtmyDk961kKC0P9
	ofepXCn79aGLxyFRjBKD0t6eUb5SYDEgwkAm4Y5iMWb0B6x9j/U4eFim6qh3pDjP/fVe4tvyW9Qi4
	Ol8ngebvK9D2La32T6DqbL6ZxntJNBXnDJSrainv7OabtUM0i6dkdg6w8rJDfgjpNmhey2hJnUpBt
	MgzB16wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYW-00000004Ilg-3mWO;
	Mon, 23 Nov 2026 17:10:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYU-00000004Ikw-4BIA
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EBBE44140;
	Mon, 23 Nov 2026 17:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA391F000C4;
	Mon, 23 Nov 2026 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453813;
	bh=c3TaoASfd8PzD5S4tgYOpeLOWlNif+silHEuUYg9+28=;
	h=From:Subject:Date:To:Cc;
	b=P0Wp1NYDxrcIM/ovxNdDS2GML5fETI33+s23IQyeMMUOPdCBGzc1Q2IuS70wSxsdn
	 kfeKfNwsLon8IYx2XhR3BYX/rg7HTYhxh5urAl8B98fMBHm4LMROASzcf5pYxWXwK5
	 WwcQR3tQNr7iHFXyK+l75GFY0EHBNr2gDfEgKeB+Y8Wqlgj4nfswpHABgZjtSkW+W+
	 tVu4XPQSlFObSZv2rvXSU3kF05Td+gpdkWMXfsStWCyJfA9FTqIhMltrMAbX2WTJsN
	 qKaQcDEu0YztWLoyzfj51efHqw1+YvExLTu6dlhiFH2/Pjh07FULonFb/pvbVy2oIY
	 LYYZj/IKlwTYQ==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
Date: Mon, 23 Nov 2026 18:10:00 +0100
Message-Id: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhzBGsC/33NTQrCMBCG4avIrI0kMemPK+8hLtpk0g6VtCQSL
 KV3N+1KQVy+H8wzC0QMhBEuhwUCJoo0+hzF8QCmb3yHjGxukFwWQkjObJ/3iQ04B/IdS4rx2vG
 2McJWRkO+mwI6eu3m7Z67p/gcw7y/SGpb/2kbyLSrTGnrWhaI1wGDx8dpDB1sXNKfxPkXoTNRC
 UTXKsNLqb6IdV3fM7+1HvYAAAA=
X-Change-ID: 20261120-dhchap-keyring-v4-09f0bac1d8c5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=3667;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=V+0LlW5boOKjqhOSfCsSFocUMOFEm9YF8ORqXxyW5FU=;
 b=87eeiZDT71LjnfENvAOJN84m+RtQNL7gTyHnReEVG5tGhUAkF29Wg60BDRpFCmW3GRDT7YXvI
 TnpyvyQchRBDIFKGTGepHpTq5BUc778P/I8fU+Jrgo1zkN/HFaECwAu
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
branch dhchap-keyring.v6

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
Changes in v6:
- Fixup next round of issues from sashiko
- Fixup kbuild robot issues
- Link to v5: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org

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

 Documentation/ABI/stable/sysfs-nvme |  10 ++
 drivers/nvme/common/Kconfig         |   2 +
 drivers/nvme/common/auth.c          | 216 +++++++++++--------------
 drivers/nvme/common/keyring.c       | 315 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig           |   1 -
 drivers/nvme/host/auth.c            | 173 ++++++++++++++------
 drivers/nvme/host/fabrics.c         | 131 +++++++++++----
 drivers/nvme/host/fabrics.h         |  12 +-
 drivers/nvme/host/nvme.h            |   6 +-
 drivers/nvme/host/sysfs.c           | 246 ++++++++++++++++++++++------
 drivers/nvme/target/Kconfig         |   1 -
 drivers/nvme/target/auth.c          | 204 ++++++++++++++---------
 drivers/nvme/target/configfs.c      | 150 +++++++++++++++--
 drivers/nvme/target/nvmet.h         |  16 +-
 include/linux/nvme-auth.h           |  17 +-
 include/linux/nvme-keyring.h        |  26 ++-
 16 files changed, 1140 insertions(+), 386 deletions(-)
---
base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


