Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A50C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QjiL06Ld5iUKLs2mtth6/H6goltsVN934tKi1iewC0A=; b=Hv5xTjEwlzH6bRgdQLrwOea8/T
	fCJKxZMD5ATSMCIDD1BRkwNnHHQpSwlz+9pFIvX978wXlSYJmFUkyEUi8CGW9nES707YfQxgzqTZc
	Lhh4A82OHhTwecJw/TeycItSWWFJH1RiYvG2QRQJLTScOQ9pv7+Xj6b3KNe7AeV81mOCTSl9pyb7B
	QFay/+ZqWIK7+O7Qc/s9ooHP9r2fHTBJUjRhDQAcGMzEbAdzt2hvqwugQCJPtL2To/iNY69W6u0Ou
	C1vrjzcUHc420L8zcsyIMpopiUyQkxGnKv1KVXYoFPPavheo4ci66d0hYTa2Vax32Q6xN5S/x9ACA
	zbN+m+HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0R-0000000GtTf-2byS;
	Fri, 25 Apr 2025 11:14:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgl-0000000Gbr9-3OF9
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B480D6845F;
	Fri, 25 Apr 2025 09:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B97C4CEE4;
	Fri, 25 Apr 2025 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574582;
	bh=wL/3DL3yhKTWYxWkMq+uC8iKz3y98oun12oyu+T/R2E=;
	h=From:To:Cc:Subject:Date:From;
	b=aD71e7WOinwHGCDCvoqfAeA+QgelKBGLnDAoKvtnp6zC1kSDZAeimrpcSm57sFkZU
	 5udKlSdI3qXGPCHKAqNjKogG75KxuZaOR7HneqYfSmBiyHjMxouYECdl7oVqr76P6T
	 EG/Lg1bgN+JZxyMNVeZMxfxZJAYT0mRss3kIJTXxO4nnY6yavyJq6oZ9yFFrIWqDJb
	 e3IkUGiNu8hAbO+y3/0g8+kK5jy/IHb6Dx66HI+ca9C5rSnKpGRXN5j2wgUDCsJjdu
	 nYqSmhRox8n2/LPJT1UKwmhiBxzBXaoTTRK5ivbonW4bbUQLkfgsYBR822j/wG02H+
	 v/58Lkol7035Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 00/12] nvme-auth: switch to use the kernel keyring
Date: Fri, 25 Apr 2025 11:49:15 +0200
Message-Id: <20250425094927.102656-1-hare@kernel.org>
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

Hey all,

the current NVMe authentication code is using a hand-crafted key structure;
idea was to have the initial implementation with a minimal set of dependencies.
(And me not having a good grasp on how to use the kernel keyring :-)
That had the drawback that keys always had to be specified on the nvme-cli
commandline, which is far from ideal from a security standpoint.

So this patchset switches the authentication code over to use the kernel keyring.
User-facing interface (namely argument to 'nvme connect') remain the same, but
the key data is converted into keys which are stored as a new key type 'dhchap'
with a random UUID as description in the kernel keyring.

With this I have updated the dhchap arguments to 'nvme connect' and the configfs
interface to either be the keydata (ie the original interface) _or_ a key serial
referring to a pre-populated dhchap key in the kernel keyring.
This allows for easier provisioning of keys and avoids the security risk from
having to specify the key data on the kernel commandline.

The entire patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch dhchap-keyring.v1

As usual, comments and reviews are welcome.

Hannes Reinecke (12):
  nvme-auth: modify nvme_auth_transform_key() to return status
  nvme-auth: use SHASH_DESC_ON_STACK
  nvmet-auth: use SHASH_DESC_ON_STACK
  nvme-auth: do not cache the transformed secret
  nvme-keyring: add 'dhchap' key type
  nvme-auth: switch to use 'struct key'
  nvme-auth: drop nvme_dhchap_key structure and unused functions
  nvme: parse dhchap keys during option parsing
  nvmet-auth: parse dhchap key from configfs attribute
  nvme: allow to pass in key serial number as dhchap secret
  nvme-auth: wait for authentication to finish when changing keys
  nvme: Unify Kconfig settings

 drivers/nvme/common/Kconfig    |   1 +
 drivers/nvme/common/auth.c     | 245 +++++++++++++-----------------
 drivers/nvme/common/keyring.c  | 266 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   4 +-
 drivers/nvme/host/auth.c       | 171 ++++++++++++++-------
 drivers/nvme/host/fabrics.c    |  94 +++++++++---
 drivers/nvme/host/fabrics.h    |  12 +-
 drivers/nvme/host/nvme.h       |   6 +-
 drivers/nvme/host/sysfs.c      | 204 ++++++++++++++++++-------
 drivers/nvme/target/Kconfig    |   3 +-
 drivers/nvme/target/auth.c     | 238 ++++++++++++++++++-----------
 drivers/nvme/target/configfs.c |  61 ++++++--
 drivers/nvme/target/nvmet.h    |  13 +-
 include/linux/nvme-auth.h      |  18 +--
 include/linux/nvme-keyring.h   |  22 ++-
 15 files changed, 948 insertions(+), 410 deletions(-)

-- 
2.35.3


