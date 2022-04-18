Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001BFC43217
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Cc:To:From:Subject:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=acHBtoIJfDEBawXiAco2X6cDYGaa7h/L6XSYKD4ZH3U=; b=MiSDcCbn0Ak1dPXMNxnogq0hBw
	U4XLwb4TGBWw1OXRr1hHwm/i4Za/WRdgTSRamWn2g8tsWhOBj3PFsxzHXJpZVkVEKYCjmIdcfb8Q8
	DPULVKuFFeQdSaJ/EQxDbcMfptrKHTpXB1tjnkMGNLPT1+7a7FQshgccxEUHViFyLlLVklvDVIm0A
	jRaTzfxfPtjFFyKsvfhFWOvdk8LMph7eaefmLNkuZc9B8TSw9Ex4Zh+5RSrkAqA5YHgK1yEd400zL
	evQZFmcHC5ow9cX4mtIS3Pw6j2EuoLFkXXxYSfknoW3C/ouH+0o/E8TrQtcMIdMsDFcOZaLc1RISu
	nTBgjGEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUZ8-0007Ch-9U; Mon, 18 Apr 2022 16:49:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUZ5-0007BT-HG
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:49:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 92318B80FE4;
 Mon, 18 Apr 2022 16:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0057C385A1;
 Mon, 18 Apr 2022 16:49:23 +0000 (UTC)
Subject: [PATCH RFC 0/5] Implement a TLS handshake upcall
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:49:22 -0400
Message-ID: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_094927_880059_F1B4B525 
X-CRM114-Status: GOOD (  19.57  )
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

There are a few upper-layer (storage) protocols that want to have a
full TLS implementation available in the Linux kernel.

The Linux kernel currently has an implementation of the TLS record
protocol, known as kTLS. However it does not have a complete TLS
implementation because it has no implementation of the TLS handshake
protocol. In-kernel storage protocols need both to use TLS properly.

In the long run, our preference is to have a TLS handshake
implementation in the kernel. However, it appears that would take a
long time and there is some desire to avoid adding to the Linux
kernel's "attack surface" without good reasons. So in the meantime
we've created a prototype handshake implementation that calls out to
user space where the actual handshake can be done by an existing
library implementation of TLS.

The prototype serves several purposes, including:

- Proof of concept: can a handshake upcall actually be implemented?

- Scaffold to enable prototyping upper-layer protocol support for TLS:
  Is there any demand for in-kernel TLS?

- Performance impact of always-on encryption with both software and
  hardware kTLS

- Understanding what features, if any, an upcall handshake cannot
  provide

The prototype currently supports client-side PSK and anonymous
x.509 ClientHello. We would like some feedback on the approach
before proceeding with ServerHello and mutual x.509 authentication.


User agent: https://github.com/oracle/ktls-utils

Who will use this implementation?
--------------------------------

This series implements only the upcall. I plan to post a second
series that shows how it can be used to implement the RPC-with-TlS
standard: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpc-tls/

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git topic-rpc-with-tls

Dr. Hannes Reinecke has a series that implements NVMe-TLS here:

https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4

We are also working with a few developers in the CIFS community
who are interested in SMB-over-QUIC. QUICv1 (RFC 9000) uses the
TLSv1.3 handshake protocol, and we hope they can leverage this
prototype capability when QUIC comes to the Linux kernel.

---

Chuck Lever (4):
      net: Add distinct sk_psock field
      net/tls: Add an AF_TLSH address family
      net/tls: Add support for PF_TLSH (a TLS handshake listener)
      net/tls: Add observability for AF_TLSH sockets

Hannes Reinecke (1):
      tls: build proto after context has been initialized


 .../networking/tls-in-kernel-handshake.rst    |  103 ++
 include/linux/skmsg.h                         |    2 +-
 include/linux/socket.h                        |    5 +-
 include/net/sock.h                            |    7 +-
 include/net/tls.h                             |   15 +
 include/net/tlsh.h                            |   22 +
 include/uapi/linux/tls.h                      |   16 +
 net/core/skmsg.c                              |    6 +-
 net/core/sock.c                               |    4 +-
 net/socket.c                                  |    1 +
 net/tls/Makefile                              |    2 +-
 net/tls/af_tlsh.c                             | 1078 +++++++++++++++++
 net/tls/tls_main.c                            |   13 +-
 net/tls/trace.c                               |    3 +
 net/tls/trace.h                               |  355 ++++++
 security/selinux/hooks.c                      |    4 +-
 security/selinux/include/classmap.h           |    4 +-
 .../perf/trace/beauty/include/linux/socket.h  |    4 +-
 18 files changed, 1631 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/networking/tls-in-kernel-handshake.rst
 create mode 100644 include/net/tlsh.h
 create mode 100644 net/tls/af_tlsh.c

--
Chuck Lever


