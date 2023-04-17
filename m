Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54748C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B9aVYjmRoZhBOquHaPiyXwIxJhvtNvA3HvXK8M2otb4=; b=oIMBKfWLOfyzPoZTqO2gv1hDjS
	2dIJ9HGMssWIwXqAslGR6jwWA0mfcbbjRjDoaQh9U+8DtMTmacydpXnhUJ3dAZGBKeNYp0NOz4cUH
	xcKqUJErzlBThDjwQ/k1GRcgiJJHrXcp5Hg7vJKJt/iEBZVhEgE71dOoXXpem10ujZcm5+fcO2yTC
	DyIAahuOOmRp4/RhXLcm8RVdQ2YKXoWlkKoenH1lcJHzs9xiBha40342s1rSV0lbckyZTMtDXNm8U
	VgalDKA2aaLK3CQH/71Bt8yH6Ankd7wa1oKNoy3xq2xg2Gl/CLZ/imYSYWk8PITdfQcqjcKPfKkns
	6wTYfWQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVo-00GHwa-35;
	Mon, 17 Apr 2023 13:03:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVd-00GHmP-1l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1E6661FE0A;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B9aVYjmRoZhBOquHaPiyXwIxJhvtNvA3HvXK8M2otb4=;
	b=YIhGnFLhmnOkYuflZWsu4oRZA39b6poE/ss1lB1Cygg6FsdAg1rg8RBs97G05K1SVKGXPt
	vk1hPHwFnvK4KFn9L0IT2MtIDDpKvn61dzi8nL0cHAhW8rxes/VaXo8W/EGFHgf8POi6m2
	GOzzOwQa2wgUQMugOhTbETHHSayVSP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B9aVYjmRoZhBOquHaPiyXwIxJhvtNvA3HvXK8M2otb4=;
	b=Guck+jZY8gXzxldFKBkX4FjMkXyhyL+CHiOgav39GIA/5jCgz8IdyIGCFudbI7E01WCJSs
	eR4ga6jKlIIlY7AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id F25542C142;
	Mon, 17 Apr 2023 13:03:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DAAC551C259A; Mon, 17 Apr 2023 15:03:03 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 00/18] nvme: In-kernel TLS support for TCP
Date: Mon, 17 Apr 2023 15:02:44 +0200
Message-Id: <20230417130302.86274-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060305_780747_33C42B05 
X-CRM114-Status: GOOD (  19.35  )
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

finally I've managed to put all things together and enable in-kernel
TLS support for NVMe-over-TCP.

The patchset is based on the TLS upcall mechanism from Chuck Lever
(cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
posted to the linux netdev list), and requires the 'tlshd' userspace
daemon (https://github.com/oracle/ktls-utils) for the actual TLS handshake.
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

To make this work I had to implement the 'read_sock()' functionality
for TLS; it seems to be holding up well enough (for me), but it really
could do with reviews from persons with more network stack knowledge.

As usual, comments and reviews are welcome.

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

Hannes Reinecke (18):
  nvme-keyring: register '.nvme' keyring
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  nvme-keyring: implement nvme_tls_psk_default()
  net/tls: implement ->read_sock()
  net/tls: sanitize MSG_EOR handling
  nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
  security/keys: export key_lookup()
  nvme/tcp: allocate socket file
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: control message handling for recvmsg()
  nvme-fabrics: parse options 'keyring' and 'tls_key'
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: allocate socket file
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: control messages for recvmsg()
  nvmet-tcp: add configfs attribute 'param_keyring'

 drivers/nvme/common/Kconfig    |   4 +
 drivers/nvme/common/Makefile   |   3 +-
 drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |  14 +++
 drivers/nvme/host/core.c       |  33 ++++-
 drivers/nvme/host/fabrics.c    |  77 +++++++++++-
 drivers/nvme/host/fabrics.h    |   9 ++
 drivers/nvme/host/nvme.h       |   1 +
 drivers/nvme/host/tcp.c        | 175 +++++++++++++++++++++++++--
 drivers/nvme/target/Kconfig    |  14 +++
 drivers/nvme/target/configfs.c | 173 +++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 213 ++++++++++++++++++++++++++++++---
 include/linux/nvme-keyring.h   |  36 ++++++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 ++
 net/tls/tls.h                  |   2 +
 net/tls/tls_device.c           |  10 ++
 net/tls/tls_main.c             |   2 +
 net/tls/tls_sw.c               |  92 ++++++++++++++
 security/keys/key.c            |   1 +
 21 files changed, 1020 insertions(+), 38 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


