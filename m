Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCB606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JqAlJ1rb;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTbw2A9R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=2bZHJ+NzaqOrSFu4+4BGl1SG3jfELd4rw0w18kP2wbg=; b=JqAlJ1rbyr/2SiLsSifv2Hgula
	j1OqTH/cWDRU7fEHvpx0TEvX7fYt6jc1UGnYRMzxST/Ux2xMwPwGr2ClJk52Hy85TpM/f7Hvqnt8w
	qRUV94uYeboDeJtg/gm43yZvP11bc6tT5suCIm1E42BC/XORMyi5i2NqDODtkd0AUNe+OANchp4kJ
	EkptYZAA0Db8FI7wy7nk+H4frP5Y5BdWWAncXE3wX2DXWIjr8HF7CSVfydUUZhUz7bsTY4RPEJwlS
	Dm5YcQsMR5uEWNLjouwh5OVrDpe5KLFn9GAiwhOi3gExVV74Q5CpRfwd2xNudProAexfc8D/Om2Mt
	W/PKArng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDH-0000000DUAw-1Y7g;
	Thu, 26 Nov 2026 14:12:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDG-0000000DUAQ-0rKN
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:12:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F082F42D51;
	Thu, 26 Nov 2026 14:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332831F000C6;
	Thu, 26 Nov 2026 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702357;
	bh=2bZHJ+NzaqOrSFu4+4BGl1SG3jfELd4rw0w18kP2wbg=;
	h=From:Subject:Date:To:Cc;
	b=GTbw2A9RSzuDMIwAEHA0GuV4TMo2zTYsWqIU29XfSnw3bFGheGTDSvkyRR0RgLH+S
	 bhEx85YHeAR8jCvVLzukUcYzq1IKU6LlIxWj42wbnx3YDSdTeIcltFzpIDYRu4lZ1q
	 TShe3vSuKojvVJCdieOayyDRjRiWfmUVLExHeXFDwd5os/0L/6bZk3YpnCawrz6RcH
	 Z6AztOy5cG3SGEFy70NHU5oqo+xGC7xZfWS+kMEg+QJjCg4dBpEhXvSgKQ3rDXed1F
	 +zcWPd8TdI1KbXhLU5B3RB8ZtoHFZbilKeJ4L2DTnud6XelrluxySYP/WXurzgQSmn
	 wkH7HsD8D9oqw==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v7 00/14] nvme-auth: switch to use the kernel keyring
Date: Thu, 26 Nov 2026 15:12:18 +0100
Message-Id: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEM+CGsC/4XOTQ7CIBAF4KsY1mIA+WldeQ/jgsLQkpq2AUNsm
 t5d6Eqj0eV7yXxvFhQheIjotFtQgOSjH4cc1H6HTKeHFrC3OSNGmKSUEWy73E+4hzn4ocWJY1I
 70mhDbWUEyndTAOcfm3m55tz5eB/DvE0kXtpfWgGxcJVRtq6ZBDj3EAa4HcbQosIl8UocvxEiE
 xUFcA03RDH+Qci/hCxfkIppXisqdPNGrOv6BJZw8D45AQAA
X-Change-ID: 20261120-dhchap-keyring-v4-09f0bac1d8c5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 Martin Belanger <martin.nvme.dev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=4000;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=EVI8g3eOLrBTbCyDoqJaqfs500gdELPondgS7V0OTX4=;
 b=ovEYJtFJK1YaKtphlFBOoRWM24BKtrrMquCyqbuIM8bplwP1RekL+gg8Z86KY2nEPHeiWV0bU
 Z+mD6g80RV1B7/KcxGswujiQ3Y/xNAjBkAzeFgOd7J6h1oySm8KRttS
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

So this patchset switches the authentication code over to use
'struct key' to hold DH-HMAC-CHAP secrets. User-facing interfaces
(namely argument to 'nvme connect') remain the same, but the key data
is converted into keys which are stored as a new key type 'dhchap' with
a random UUID as description in the .nvme keyring.

With this I have updated the dhchap arguments to 'nvme connect' and
the configfs interface to either be the keydata (ie the original
interface), a key description, _or_ a key serial referring to a
pre-populated dhchap key in the kernel keyring. This allows for external
provisioning of keys and avoids the security risk from having to specify
the key data on the kernel commandline.

The entire patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch dhchap-keyring.v6

As usual, comments and reviews are welcome.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
Changes in v7:
- Fixup next round of issues from sashiko
- Modify to use key_serial_t instead of 'struct key' to pass key references
- Include suggestions from Martin Belanger
- Link to v6: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org

Changes in v6:
- Fixup next round of issues from sashiko
- Fixup kbuild robot issues
- Link to v5: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org

Changes in v5:
- Fixup issues found by sashiko
- Link to v4: https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org

---
Hannes Reinecke (14):
      nvme-auth: modify nvme_auth_transform_key() to return status
      nvme-keyring: add 'dhchap' key type
      nvme-keyring: drop nvme_tls_psk_revoked()
      Documentation/security/keys: fixup function name
      nvme-keyring: link addtional keyring into .nvme keyring
      nvme-auth: switch to use 'struct key'
      nvme: parse dhchap keys during option parsing
      nvmet-auth: parse dhchap key from configfs attribute
      nvme: allow to pass in key description as dhchap secret
      nvme-auth: allow to specify the key by key serial
      nvme-auth: wait for authentication to finish when changing keys
      nvme-fabrics: allow to pass in keyring by name
      nvme-auth: link pre-provisioned keys into .nvme keyring
      nvme-auth: allow to update pre-provisioned keys

 Documentation/ABI/stable/sysfs-nvme  |  10 +
 Documentation/security/keys/core.rst |   2 +-
 drivers/nvme/common/Kconfig          |   2 +
 drivers/nvme/common/auth.c           | 232 ++++++++++------------
 drivers/nvme/common/keyring.c        | 370 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/Kconfig            |   1 -
 drivers/nvme/host/auth.c             | 176 ++++++++++++-----
 drivers/nvme/host/fabrics.c          | 169 ++++++++++++----
 drivers/nvme/host/fabrics.h          |  12 +-
 drivers/nvme/host/nvme.h             |   6 +-
 drivers/nvme/host/sysfs.c            | 300 ++++++++++++++++++++++------
 drivers/nvme/host/tcp.c              |   5 +-
 drivers/nvme/target/Kconfig          |   1 -
 drivers/nvme/target/auth.c           | 250 +++++++++++++++--------
 drivers/nvme/target/configfs.c       |  84 ++++++--
 drivers/nvme/target/nvmet.h          |  15 +-
 include/linux/nvme-auth.h            |  17 +-
 include/linux/nvme-keyring.h         |  47 ++++-
 18 files changed, 1257 insertions(+), 442 deletions(-)
---
base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>


