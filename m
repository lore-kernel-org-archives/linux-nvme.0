Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FADBC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kA7PDkVs1YBWJACa9uWYmQcvVEU+cgn3WF9yObdls9o=; b=NhEjVU8iQHe8fPnCZsMALpigyi
	WjkpcunlggCiYOerHvCVkONJoL5gW0WWh0N7WJfA88gcwI8PBPMM+2NSieaJDEWrdfdU2Ma9Mv1nu
	z6v/0Bky3mjAoq2Dpjc4OoL3eBHBDS+b5lrv/gsM/51Do9hwUdF9iifpQIC0clznw/Ym3VqDBvcSL
	L1uUx793Qs8OcuKuOhLgT/D0hPSooT4Z/cnVMcA1S3urUWR0QY9Wm3kjZvuWM7YBQpJfPl8jalzkl
	SyhnjqSeiUr8ixYoYXBS1lFJlV4byV6r1tv8PW40yq4sSOtYJJKFyKm3Of3cvgBzDPUEAN4CAbZ5y
	vMmTNTFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLM-000UqF-1d;
	Wed, 29 Mar 2023 14:00:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLD-000Ugy-0t
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 13:59:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A5C9B219EC;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kA7PDkVs1YBWJACa9uWYmQcvVEU+cgn3WF9yObdls9o=;
	b=Z1pMXz1jTB6tJvreF0k4oLS+k6lQe7K3TDdbYp/8QfnIiA90dXnHR0SrAU+RL051Flz+LR
	mJsJC4KiBWnPOC1OxhuApkogJ5cEm4GUj96fKfW7d5sfliTtgnPrWS/5hqzeCmrlk8Z744
	Ax7QlXLcfIJy7vt5bT2T5/P9hFNXsU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kA7PDkVs1YBWJACa9uWYmQcvVEU+cgn3WF9yObdls9o=;
	b=WpFxwVnc8kLuRwwyQJjomsRVhfqPFcTi3LgtGKRx+/E/NK/JN1yzgFLLw/sicb4Ma6VJkg
	KjtR0jGMZKY5CbCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8C3C72C16F;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 6FC1451BF372; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 00/18] nvme: In-kernel TLS support for TCP
Date: Wed, 29 Mar 2023 15:59:20 +0200
Message-Id: <20230329135938.46905-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065955_466605_2B86878D 
X-CRM114-Status: GOOD (  17.64  )
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

Changes to the original RFC:
- Add a CONFIG_NVME_TLS config option
- Use a single PSK for the TLS handshake
- Make TLS connections mandatory
- Do not peek messages for the server
- Simplify data_ready callback
- Implement read_sock() for TLS

Hannes Reinecke (18):
  nvme-keyring: register '.nvme' keyring and add CONFIG_NVME_TLS
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  net/tls: implement ->read_sock()
  nvme/tcp: allocate socket file
  nvme-keyring: implement nvme_tls_psk_default()
  security/keys: export key_lookup()
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: fixup send workflow for kTLS
  nvme-tcp: control message handling for recvmsg()
  nvme-fabrics: parse options 'keyring' and 'tls_key'
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: allocate socket file
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: rework sendpage for kTLS
  nvmet-tcp: control messages for recvmsg()
  nvmet-tcp: add configfs attribute 'param_keyring'

 drivers/nvme/common/Kconfig    |   9 ++
 drivers/nvme/common/Makefile   |   1 +
 drivers/nvme/common/keyring.c  | 181 ++++++++++++++++++++++
 drivers/nvme/host/core.c       |  44 +++++-
 drivers/nvme/host/fabrics.c    |  90 ++++++++++-
 drivers/nvme/host/fabrics.h    |   9 ++
 drivers/nvme/host/nvme.h       |   4 +-
 drivers/nvme/host/tcp.c        | 213 +++++++++++++++++++++++---
 drivers/nvme/target/configfs.c | 165 ++++++++++++++++++++-
 drivers/nvme/target/nvmet.h    |   1 +
 drivers/nvme/target/tcp.c      | 264 ++++++++++++++++++++++++++++++---
 include/linux/nvme-keyring.h   |  20 +++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 ++
 net/tls/tls.h                  |   2 +
 net/tls/tls_main.c             |   2 +
 net/tls/tls_sw.c               |  71 +++++++++
 security/keys/key.c            |   1 +
 18 files changed, 1050 insertions(+), 43 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


