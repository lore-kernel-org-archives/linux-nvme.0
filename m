Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2231C001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jLra+6zAGQDEViLrSFvEd7XFIoB3oEcKhwi3DepJHP8=; b=VDemEBWqPRpEJFc8d9PZC0en9b
	iruepaJ7mTy+qJtdgjenMFslzMQom97B1o/ReE5GgcLEZqs3rkMkCTgg/8n0z4uewf8CyBEmY7NWq
	3um5r988wh38w9FJTkyDgi8IgxoiAkriklu5C9oDz61JsLJNGwGBx3ozcHAVDFrkifI9twiTDG3Ll
	9K+2ASIWh2dVDBl3GcK/jc3DITiCQh0CTsIHyB5EOZEvzR+puFrk3pU3QKp4eYPBBIYPEgWwntMMj
	juRGW4FK9A11LDgJREnyEfarlMA5UgZTZWYI1mHDTR4jMig/zUqE8zYUujZozzaRIwRF+6ZQ9quT3
	oS9bgksA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxV-007XPA-1A;
	Thu, 03 Aug 2023 10:53:33 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxB-007X7g-1l
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4757D21994;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jLra+6zAGQDEViLrSFvEd7XFIoB3oEcKhwi3DepJHP8=;
	b=H+0CWfS3LHMJ0U3o8tZ6KAfdJJKcV9DT0PzAeXsY6q9jYpnzKPFH5DvOJCjglaRqkN4630
	HSG/VdENwNDSFotgr83ItdgodiDsZrccKAc+m1S+8M9AA9W99NdCJatZZ6OCtL1gSbT+Za
	KDve5v1pnFya4VQAvHqtoA9xTdGINCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jLra+6zAGQDEViLrSFvEd7XFIoB3oEcKhwi3DepJHP8=;
	b=qtVCrkFNTmkOIN1/GXyErsYKIatJW3D3UQ1lZf+9yq7osxDFcdHv4Bdak2o4a7HEDDvoD0
	gF57DkKEr0TbOtDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 369B12C142;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2407051CA7BF; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 00/14] nvme: In-kernel TLS support for TCP
Date: Thu,  3 Aug 2023 12:50:48 +0200
Message-Id: <20230803105102.30949-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035314_131004_FFC86CF7 
X-CRM114-Status: GOOD (  20.28  )
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

with the merge of Chuck Levers handshake upcall mechanism and
my tls_read_sock() implementation finally merged with net-next
it's now time to restart on the actual issue, implementing
in-kernel TLS support for nvme-tcp.

The patchset is based on the recent net-next git tree;
everything after commit 05191d8896b4 ("Merge branch
'in-kernel-support-for-the-tls-alert-protocol'") should work.
Just a tiny wee snag has been discovered in the ->read_sock()
implementation, so please ensure to have the patch
'net/tls: avoid TCP window full during ->read_sock()'
merged, too.

It also requires the 'tlshd' userspace daemon
(https://github.com/oracle/ktls-utils)
for the actual TLS handshake.
Changes for nvme-cli are already included in the upstream repository.

Theory of operation:
A dedicated '.nvme' keyring is created to hold the pre-shared keys (PSKs)
for the TLS handshake. Keys will have to be provisioned before TLS handshake
is attempted; that can be done with the 'nvme gen-tls-key' command for nvme-cli
(patches are already merged upstream).
After connection to the remote TCP port the client side will use the
'best' PSK (as inferred from the NVMe TCP spec) or the PSK specified
by the '--tls_key' option to nvme-cli and call the TLS userspace daemon
to initiate a TLS handshake.
The server side will then invoke the TLS userspace daemon to run the TLS
handshake.
If the TLS handshake succeeds the userspace daemon will be activating
kTLS on the socket, and control is passed back to the kernel.

Patchset can be found at:
git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch tls.v8

For testing I'm using this script, running on a nvme target
with NQN 'nqn.test' and using 127.0.0.1 as a port:

modprobe nvmet-tcp
nvmetcli restore
modprobe nvme-tcp
./nvme gen-tls-key --subsysnqn=nqn.test -i
./nvme gen-tls-key --subsysnqn=nqn.2014-08.org.nvmexpress.discovery -i
tlshd -c /etc/tlshd.conf

and then one can do a simple:
# nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.test --tls
to start the connection.

As usual, comments and reviews are welcome.

Changes to v4:
- Split off network patches into a separate
  patchset
- Handle TLS Alert notifications

Changes to v3:
- Really handle MSG_EOR for TLS
- Fixup MSG_SENDPAGE_NOTLAST handling
- Conditionally disable fabric option

Changes to v2:
- Included reviews from Sagi
- Removed MSG_SENDPAGE_NOTLAST
- Improved MSG_EOR handling for TLS
- Add config options NVME_TCP_TLS
  and NVME_TARGET_TCP_TLS

Changes to the original RFC:
- Add a CONFIG_NVME_TLS config option
- Use a single PSK for the TLS handshake
- Make TLS connections mandatory
- Do not peek messages for the server
- Simplify data_ready callback
- Implement read_sock() for TLS

Hannes Reinecke (14):
  nvme-keyring: register '.nvme' keyring
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  nvme-keyring: implement nvme_tls_psk_default()
  security/keys: export key_lookup()
  nvme/tcp: allocate socket file
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: control message handling for recvmsg()
  nvme-fabrics: parse options 'keyring' and 'tls_key'
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: allocate socket file
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: control messages for recvmsg()

 drivers/nvme/common/Kconfig    |   4 +
 drivers/nvme/common/Makefile   |   3 +-
 drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |  14 ++
 drivers/nvme/host/core.c       |  12 +-
 drivers/nvme/host/fabrics.c    |  81 ++++++++++-
 drivers/nvme/host/fabrics.h    |   9 ++
 drivers/nvme/host/nvme.h       |   1 +
 drivers/nvme/host/sysfs.c      |  20 +++
 drivers/nvme/host/tcp.c        | 167 ++++++++++++++++++++--
 drivers/nvme/target/Kconfig    |  14 ++
 drivers/nvme/target/configfs.c | 128 ++++++++++++++++-
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 249 +++++++++++++++++++++++++++++----
 include/linux/nvme-keyring.h   |  36 +++++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 ++
 security/keys/key.c            |   1 +
 18 files changed, 891 insertions(+), 47 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


