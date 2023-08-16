Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D1BC04A94
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DZ1ncX8MD+/Gp3qJN8kGvC8a+Gt4kiciWaOpWvSDF9Y=; b=hpY18fLCDTa53joPq6t7agb9fV
	g1NOS++OSpkDUeTRvHQHtA/XyI05H9to+0+rHSbxBRIulCiCR5XA2ohQ+lddLzySglakvirSeNnkw
	QzW/e1eB2q1amvFWxN1xB4aHwA94FRyn09f9PqB7t68+0hKk8ZAraxSfEhy3YXZKWbVvIXZfq6ONz
	JUY8aM3o3PEhnRSVfmN0094o9BBAR5KSRsOZVGhMLWtHLiIvG8mpuaoZWaOjR/kLClFHLI8Xzy18n
	4aSTPngnbwsQnyhC11Dlz+MgpX271oK9MSHaTC7Id2S7mhetMtIB21Pd3iHMcBV/4h5i2Q+x+oOKY
	IGXeCJ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFIN-0043vJ-23;
	Wed, 16 Aug 2023 12:06:39 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFI9-0043iB-3B
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:06:31 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id B730D1F74D;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DZ1ncX8MD+/Gp3qJN8kGvC8a+Gt4kiciWaOpWvSDF9Y=;
	b=DrqEu7nD1hBw7snZvH0QlGUJUUBMINaIewQFhHohzo0ikO9wMfPlu2BaePevyvYZrsG7en
	06H6cGVyo7Sx44uKm0DPfIoYrOkhVKbaSAUwreyRaQJh9bM5bis4d5TZ3v8K4W/yB1ItcN
	MOTVweWrnF8s6HH9A4ihnBbNBssjHHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DZ1ncX8MD+/Gp3qJN8kGvC8a+Gt4kiciWaOpWvSDF9Y=;
	b=7vtCcX2LM+W0qGf5FkuqmajUeSBSGNWp1psxGAz2dq/P1slKkUAaL0PL1p2rAfK69WhCDd
	UMojEjPKvypc46BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8DBAE2C143;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 78AE551CB21C; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv10 00/18] nvme: In-kernel TLS support for TCP
Date: Wed, 16 Aug 2023 14:05:50 +0200
Message-Id: <20230816120608.37135-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_050626_167279_24239144 
X-CRM114-Status: GOOD (  23.70  )
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
it's now time to restart on the actual issue, namely implementing
in-kernel TLS support for nvme-tcp.

The patchset is based on the recent net-next git tree;
everything after commit ba4a734e1aa0 ("net/tls: avoid TCP window
full during ->read_sock()") should work.
You might want to add the patch
'nvmet-tcp: use 'spin_lock_bh' for state_lock()'
before applying this patchset; otherwise results might be ...
interesting.

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

This implementation currently does not implement the so-called
'secure concatenation' mode from NVMe-TCP; a TPAR is still pending
with fixes for it, so I'll wait until it's published before
posting patches for that.

Patchset can be found at:
git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch tls.v15

For testing I'm using this script, running on a nvme target
with NQN 'nqn.test' and using 127.0.0.1 as a port; the port
has to set 'addr_tsas' to 'tls1.3':

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

Changes to v9:
- Close race between done() and timeout()
- Add logging message for icreq/icresp failure
- Sparse fixes
- Restrict TREQ setting to 'not required' or 'required'
  when TLS is enabled

Changes to v8:
- Simplify reference counting as suggested by Sagi
- Implement nvmf_parse_key() to simplify options parsing
- Add patch to peek at icreq to figure out whether TLS
  should be started

Changes to v7:
- Include reviews from Simon
- Do not call sock_release() when sock_alloc_file() fails

Changes to v6:
- More reviews from Sagi
- Fixup non-tls connections
- Fixup nvme options handling
- Add reference counting to nvmet-tcp queues

Changes to v5:
- Include reviews from Sagi
- Split off nvmet tsas/treq handling
- Sanitize sock_file handling

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

Hannes Reinecke (18):
  nvme-keyring: register '.nvme' keyring
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  nvme-keyring: implement nvme_tls_psk_default()
  security/keys: export key_lookup()
  nvme-tcp: allocate socket file
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: control message handling for recvmsg()
  nvme-tcp: improve icreq/icresp logging
  nvme-fabrics: parse options 'keyring' and 'tls_key'
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
  nvmet-tcp: allocate socket file
  nvmet: Set 'TREQ' to 'required' when TLS is enabled
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: control messages for recvmsg()
  nvmet-tcp: peek icreq before starting TLS

 drivers/nvme/common/Kconfig    |   4 +
 drivers/nvme/common/Makefile   |   3 +-
 drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++
 drivers/nvme/host/Kconfig      |  15 ++
 drivers/nvme/host/core.c       |  12 +-
 drivers/nvme/host/fabrics.c    |  64 ++++++-
 drivers/nvme/host/fabrics.h    |   9 +
 drivers/nvme/host/nvme.h       |   1 +
 drivers/nvme/host/sysfs.c      |  21 +++
 drivers/nvme/host/tcp.c        | 184 +++++++++++++++++--
 drivers/nvme/target/Kconfig    |  15 ++
 drivers/nvme/target/configfs.c | 128 ++++++++++++-
 drivers/nvme/target/nvmet.h    |  11 ++
 drivers/nvme/target/tcp.c      | 326 ++++++++++++++++++++++++++++++---
 include/linux/key.h            |   1 +
 include/linux/nvme-keyring.h   |  36 ++++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 +
 security/keys/key.c            |   1 +
 19 files changed, 980 insertions(+), 49 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


