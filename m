Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7460A262A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W11rAkgM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNx1wiUF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZqrYyC3+GC/TqFv0dbS5jMAL2lbu60cx0lMAlfRFVpM=; b=W11rAkgMSxEwum8+ECNDJQ1uae
	urIdJXeJfAkJeHkFA4xpeOP2lH6UsQxurY0S5uTFddfuM1oA2m+xkPMAg0BiV+8ASmoyd7370U5hE
	g0065T3dtZjg6QO5Y7ppIsRth9jVpQCv9rohT1SO9RmpsG7ZbkR0Swf+O3UUYcex3vi7+MDO/OOON
	HWUZSnkCsQ1vdWdZlhD1S2EPuZ8o6ZR+IAIe1Bbx7gy8UV06DCg7Nti1dqQY1kYnvgp4NJgUvkgBJ
	rE4xd/3/dJ+c8BwaLw1idrIDDUQHOSjoT50yN/UDGJM0lz9H9y/fBkDsUHEAtghRrMaM4WfRuc129
	mAtIR5oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM45N-000000077db-0DB2;
	Wed, 28 Oct 2026 13:53:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM45J-000000077aN-1At1
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 13:52:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8C47F43E91;
	Wed, 28 Oct 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793195576;
	b=pM3+lhXspxUIyFF8qmrktCiinHIEmLTjgOzqF2MYVSVCOgod0R0zp61l9AjCrHNlBa8W
	 skgwBemq16ic61dYTIGBfns71B8RxHaKTVYcNahaHPlcME9SXC06DFYJpf/+Vi8Ob/PME
	 YXeFOrQDJtCc0LemF3wMleBwuT1KI5N/pfMt6gkxai2BqyYi53PJrFHsz1x+FsclGwLAv
	 KaNz4ZNbrEZTNrahEoX5QG6GGmNbc2lUkY3duq3bjDlNxbbnLB0jYBlpXpoYO2ycSmoZR
	 693uHde96/iYB/+YFAfEicgUCiZFMnc6gU0YskhD5I+ie+IxtNA+Tc1tHD++cNF1w0w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195576;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ZqrYyC3+GC/TqFv0dbS5jMAL2lbu60cx0lMAlfRFVpM=;
	b=ZBCYKhMSjfuNDFAxxCiAsD0vzXQDets5uthvAsFAN0Ly2qRrrUd0RnQXPZiPRDsBWdDZ
	 Xv3HBzos/7cgbKGf+ypPg63EDLzj6wxYHFWoTg1XNv45rpKWPaRvktP/Ppep3mxaBtYEp
	 /mlbJDIftDuHCK764Ghd9SzpppKfksPUKxcsOLmfa0fDJ5R5Gva7h9ShmXX6Ilm2ZIuYF
	 zYH+r8HoNTytPHapxWA+YlWElGUm+jlml+k7FR4fPKkcQnkbvnutLwUGaW3sPiUD9/ujH
	 1HKE8FcOSPGFY8B2FNyxc5NlHDIpvWfah1yWqqpwc4VXFsfZZtxHlkCasXVmhcnSIRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 53EC61F031E0;
	Wed, 28 Oct 2026 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195576;
	bh=ZqrYyC3+GC/TqFv0dbS5jMAL2lbu60cx0lMAlfRFVpM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lNx1wiUFvV4Djivg+ZSELz+JWbcSNFbljd+zcmq3I+dU0hhbrIf3DBrkbJyPOuOBp
	 OANEUYJ/xVVeJQac/Vgp0jNPo5b/SV8j/ukWymYTepSBjGctO8PM687xaecRo0R5wX
	 jgFUwhWlg3qfI/NUBSEf+CRtsXaNUZg5+JEyaUA5Gzn3h5SJLC7u/Sx9cTFsDCQqy9
	 GJGXFzggB/ESc6cIkRtu+aJuf/0r+9tDtczIFIBIJynQTSx++CxwoYkV1owmHhi/J5
	 H0yTBGbd9NO+Dh0nvFq54X0uCzC0kzEQ+dwV9bp4PPq052YasW5iqG8d4ypwO3tEE+
	 8Zn/S9NDCycxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A65DC45488;
	Wed, 28 Oct 2026 13:52:53 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
Date: Wed, 28 Oct 2026 09:52:50 -0400
Message-Id: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3VOSw6CMBC9Cpm1NaUCVVcmJh7ArWEB7QCDUkhbC
 IRwdwHXLt//zeDQEjq4BjNYHMhRa1YgDgGoKjMlMtIrBsFFEnIRszdOfaczj8wWil0ifVISzxG
 XEtZMZ7Ggce97wfNx3ziDnhkcPaQ/g+vzGpXfWje5IudbO+0PhnAP/hkbQsZZwnMp4wSVyvWtb
 DL6HFXbQLosyxcEuZRnzQAAAA==
X-Change-ID: 20261025-keyupdate-rfc-94d3c7e84077
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793195573; l=7775;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=1N8ztvltpxCgLjG4JCYeAP0U6mmOIq99oUVPwvzatY4=;
 b=kGG+fFh2LD1Iu4Z+nzZ/m5P/t+epO0cfX1R/YRXMafPgpSqafLGvKKdwCcJCCZ6dfaElmk2p5
 bHsq7B1vuIDC4xJ60W1W0hVTMEW6r5XURsEK42DblbxAPJOaw3pRuT1
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kTLS does not currently handle TLS 1.3 KeyUpdate. It never sends a
KeyUpdate. And when it receives one, it blocks the socket until the
application installs the next key. kTLS also does not enforce the key
usage limit on transmit.

This applies to TLS libraries in user space as well as kernel users such
as NVMe/TCP or sunrpc:

- GnuTLS sends a KeyUpdate after 2^24 records when it runs its own
  record layer. With kTLS, the record layer is handled in the kernel and
  GnuTLS therefore never runs the check. OpenSSL never sends a KeyUpdate
  on its own.
- NVMe/TCP and sunrpc don't have a mechanism to install a new key. A
  conforming peer that sends a KeyUpdate stalls their connection.

RFC 9846 (July 2026), which obsoletes RFC 8446, makes the limit
mandatory (section 5.5): "Implementations MUST either close the
connection or do a key update as described in Section 4.7.3 prior to
reaching these limits." Long-lived connections with small records reach
the limit quickly. One NVMe/TCP queue sends at least one record per
command, and more with large I/O. Depending on the load and link speed,
the 2^24 limit can be reached in less than 10 minutes in many cases.

With this series, kTLS handles KeyUpdate in both directions for a socket
that registers its traffic secrets. A socket that does not register them
behaves as before. A user can opt in by passing the secrets after the
handshake. GnuTLS and OpenSSL install the kTLS keys themselves, so they
could register the secrets at the same time. tlshd gets the secrets from
GnuTLS through a callback it uses for QUIC.

Why the record layer
====================

KeyUpdate must be handled where the records are built.

The 2^24 limit is a record count, and only the record layer can see the
count precisely as it changes. A user sitting above kTLS can only read
the count with getsockopt(TLS_TX) after each write. A kTLS user writes
bytes, and the kernel splits and merges those bytes into records. I
counted send calls in an NVMe/TCP prototype trying to guesstimate the
2^24 limit. The count was correct with 4 KB I/O, but was 21 times too
low with 1 MB I/O. Each send call translates into a different number of
records. It's simply not possible to precisely guess the number of
records based on the number of send calls.

The KeyUpdate must also go at a precise place in the record stream
(section 4.7.3). It is encrypted with the old key, and every record
after it with the new key. When the peer sets update_requested, our
KeyUpdate must go out before the next Application Data record. The key
can only change between two records. Only net/tls has control over that.
Fixing this in one driver or library would leave other drivers or
libraries to re-implement their own (imperfect) solution.

The in-kernel QUIC series under review on netdev splits the work the
same way as this proposed fix. The handshake stays in user space, the
secrets are passed in with a socket option, and the kernel derives each
key update with HKDF-Expand-Label (quic_crypto_key_update()).

What the series does
====================

- Two new socket options, TLS_TX_TRAFFIC_SECRET and
  TLS_RX_TRAFFIC_SECRET, are used to register the application traffic
  secrets. The secret is passed as raw bytes. The kernel derives the
  hash (SHA-256 or SHA-384) from the cipher installed with TLS_TX or
  TLS_RX. The TX secret must be set first because the RX secret needs
  the TX secret in case a received KeyUpdate asks for a reply.
- A third socket option, TLS_TX_KEY_UPDATE, can be used to send a
  KeyUpdate now. It can also optionally ask the peer to update too.
- Receive: kTLS consumes the KeyUpdate, installs the next key and
  continues. This works for recvmsg, splice and read_sock.
- Transmit: kTLS sends a KeyUpdate after 2^24 records, a margin below
  the 2^24.5 limit of RFC 9846 section 5.5, and in reply to
  update_requested. ChaCha20-Poly1305 has no record limit.
- kTLS aborts the connection when a peer sends more than 8 KeyUpdates in
  one second, or an invalid KeyUpdate. GnuTLS uses the same rate limit.
- Software path only. Device offload is unchanged.
- SM4-GCM and SM4-CCM are not supported: the kernel has no HMAC-SM3.

Testing
=======

- NVMe/TCP host and target over loopback, with the record limit and the
  rate limit lowered for the test: more than 1000 KeyUpdates in each
  direction under I/O, with AES-128-GCM and AES-256-GCM.
- Interoperability with OpenSSL in user space, which derives the keys on
  its own, including the reply to update_requested.
- New selftests in tools/testing/selftests/net/tls.c for every TLS 1.3
  cipher kTLS supports. The full tls selftest passes.

The matching tlshd change for ktls-utils is a small patch to be
submitted at a later time if this series is accepted.

Questions
=========

This is an RFC for feedback on the design and the new socket options, in
particular:

1. I used one socket option per direction, like TLS_TX and TLS_RX. Is
   that the right form? Would one option that sets secrets for both
   directions be better?
2. When the application installs a key itself with TLS_TX or TLS_RX
   after the secrets have already been registered, the series removes
   the registered secrets (TLS_TX removes both, TLS_RX only the RX
   secret) and gives KeyUpdate back to the application. Is that right,
   or should the key change be refused while a secret is registered?
3. TLS_TX_KEY_UPDATE (patch 4) is not needed for the record limit. I can
   move it to a separate series if you prefer a smaller first step.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Changes in v2:
- Patch 2: check that the installed key and IV come from the
  registered secret. (Hannes)
- Patch 3: free the KeyUpdate record when its processing fails.
  (Sashiko)
- Patch 3: after a rekey, wake pollers only if a pending KeyUpdate held
  them back. (Sashiko)
- Patch 4: keep MSG_NOSIGNAL when sending a KeyUpdate. setsockopt()
  never raises SIGPIPE. (Sashiko)
- Patch 4: clear the KeyUpdate request state when the application
  installs a key with TLS_TX or TLS_RX. (Sashiko)
- Patch 5: derive the test keys from the secrets with AF_ALG. Add tests
  for the changes above.
- Not changed: if TCP fails to send the KeyUpdate after the record was
  queued, TLS_TX_KEY_UPDATE can return 0, as sendmsg() returns the
  queued length. The next call reports the error. (Sashiko)
- Link to v1: https://patch.msgid.link/20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com

---
Martin Belanger (5):
      tls: add HKDF-Expand-Label for the TLS 1.3 key schedule
      tls: add socket options to register the traffic secrets
      tls: update the RX key when a KeyUpdate is received
      tls: send a KeyUpdate at the record limit and on request
      selftests/tls: add KeyUpdate tests

 Documentation/networking/tls.rst   |  43 ++++
 include/net/tls.h                  |  23 +++
 include/uapi/linux/tls.h           |   3 +
 net/tls/Kconfig                    |   2 +
 net/tls/Makefile                   |   3 +-
 net/tls/tls.h                      |   5 +
 net/tls/tls_hkdf.c                 |  82 ++++++++
 net/tls/tls_keyupdate.c            | 155 ++++++++++++++
 net/tls/tls_main.c                 | 175 +++++++++++++++-
 net/tls/tls_sw.c                   | 193 ++++++++++++++++-
 tools/testing/selftests/net/config |   4 +
 tools/testing/selftests/net/tls.c  | 412 +++++++++++++++++++++++++++++++++++++
 12 files changed, 1091 insertions(+), 9 deletions(-)
---
base-commit: 1a2c35c49cc7c6be860038b8442b52424a8f123c
change-id: 20261025-keyupdate-rfc-94d3c7e84077

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



