Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA7C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jUCnlKLDyTj97t5QT8ls0N2tt/LQJuho6YajTUIpHmM=; b=y0x6BNMZUDM773SkSLKf++Qxgl
	Fl+4l/FUzceDPwn5dR9QU8KUdKlJiRjCqKzF0KbW5Dv2I31ejwqa08yLxRiWtG7o4OtWSlDExZEC3
	BDiLtxZ6qUuNSPv38Arb6Ao8q50BMnPYZaypPznRNHdK4tVM6VxJiDmpzPx2WVGtztBRG0yffsRRy
	ky6gZrCBiHKkFaG1DVetFK/lnnGX3SSyXHJ9Lx8XfF8HwytYigT8iWBnxwSx9WNZ9uKpEGVsfVi8B
	8PUd78XLzTmlNbpmkTduTQclrbiwVJDKK6QuMjjEiD6JAcbHhzhtvMCtUv9bfq4a4LcpADV7gj2q3
	wnUzMhZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLU-00CNVw-2j;
	Tue, 21 Mar 2023 12:44:08 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLN-00CNOe-1Z
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id D42B121DB2;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jUCnlKLDyTj97t5QT8ls0N2tt/LQJuho6YajTUIpHmM=;
	b=GkWdu9llBnz4x4Wp2LtcrbBts3ATTzTb2vcFUJgmjoZgWX/xe50DeVacREDDh9jgriPbs+
	TfuP9y+LmGH4RNSmPcZDgBsi3k0+uhY8lJvixT5GOCTMUF8S8NK+0ixFl8A0OkDnYJOYtU
	Suz8MMPSdQygtfLV+WKweITb4CoPaU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jUCnlKLDyTj97t5QT8ls0N2tt/LQJuho6YajTUIpHmM=;
	b=wTNDvEKrTIR/3bBPFvJlmi6uEYiRWbdeePZ+++VHsDuz7wx2/Gimgff2dcvuB/sQDzFZoJ
	vrG4kqlyBfgxPMAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id BE1772C143;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9FF6951BEE94; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 00/18] nvme: In-kernel TLS support for TCP
Date: Tue, 21 Mar 2023 13:43:07 +0100
Message-Id: <20230321124325.77385-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054401_727707_1B2ED39B 
X-CRM114-Status: GOOD (  18.21  )
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

Theory of operation:
A dedicated '.nvme' keyring is created to hold the pre-shared keys (PSKs)
for the TLS handshake. Keys will have to be provisioned before TLS handshake
is attempted; I'll be sending a patch for nvme-cli separately.
After connection to the remote TCP port the client side will check if there are
matching PSKs, and call the TLS userspace daemon to initiate a TLS handshake.
The server side will be doing a MSG_PEEK on the first incoming PDU after
accept(), and check if it's an TCP ICREQ packet. If not it's assumed to be
a TLS ClientHello and the TLS userspace daemon is invoked for the TLS
handshake.
If the TLS handshake succeeds the userspace daemon will be activating
kTLS on the socket, and control is passed back to the kernel.

The one issue of note is the multiple identity handling.
The NVMe TCP spec defines up to 4 PSK identities, and
TLS 1.3 allows for several identities to be sent with the
ClientHello. So in theory we could sent the all in one go.
Sadly none of the userspace libraries implement this feature,
so we have to test each possible identity and terminate the
connection on failure.
With this patchset all possible identities need to be part of
the keyring, and the client side will be trying to establish
a TLS connection with each matching PSK from the keyring.
The beauty is that this method works without modification
to the existing nvme-cli; one only needs to provision PSKs
in the .nvme keyring and TLS handshake will be attempted.
As I'm not sure if that approach meets with general approval
I'm sending out this patchset as an RFC for now.

As usual, comments and reviews are welcome.

Hannes Reinecke (18):
  nvme-keyring: register '.nvme' keyring
  nvme-keyring: define a 'psk' keytype
  nvme: add TCP TSAS definitions
  nvme-tcp: add definitions for TLS cipher suites
  nvme-tcp: implement recvmsg rx flow for TLS
  nvme-tcp: call 'queue->data_ready()' in nvme_tcp_data_ready()
  nvme/tcp: allocate socket file
  nvme-tcp: enable TLS handshake upcall
  nvme-tcp: add connect option 'tls'
  nvme-tcp: fixup send workflow for kTLS
  nvme-tcp: control message handling for recvmsg()
  nvmet: make TCP sectype settable via configfs
  nvmet-tcp: allocate socket file
  security/keys: export key_lookup()
  nvmet-tcp: enable TLS handshake upcall
  nvmet-tcp: rework sendpage for kTLS
  nvmet-tcp: control messages for recvmsg()
  nvmet-tcp: peek icreq before starting TLS

 drivers/nvme/common/Makefile   |   2 +-
 drivers/nvme/common/keyring.c  | 132 ++++++++++
 drivers/nvme/host/core.c       |  10 +-
 drivers/nvme/host/fabrics.c    |   5 +
 drivers/nvme/host/fabrics.h    |   2 +
 drivers/nvme/host/tcp.c        | 450 +++++++++++++++++++++++++--------
 drivers/nvme/target/configfs.c |  65 +++++
 drivers/nvme/target/tcp.c      | 407 ++++++++++++++++++++++++++---
 include/linux/nvme-keyring.h   |  20 ++
 include/linux/nvme-tcp.h       |   6 +
 include/linux/nvme.h           |  10 +
 security/keys/key.c            |   1 +
 12 files changed, 965 insertions(+), 145 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

-- 
2.35.3


