Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18360A2618
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R6VCEt0Y;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYbmmvwn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=UHI5BSckwNpcy+5/aNggAOxJP93aAxDcEdnUedESl1E=; b=R6VCEt0YN9MMtO7H7gQO9OphPo
	PQXb3ZCtCjjXZu/B4flp9dXIBv8BlANreoq9VLjRovas2DpPdG/LqP/rolRvHtdlY6jykclPPcBKB
	QXz2qJFSVVcHEO84ncPKMxdjkablsuLx3GSAkbdjoaF1Wr+FOgGdURjTGh8TEiZ0z8cz6xjkJb4BX
	S+YQRhpg64DOVfdLkpHnIMUweOVQLHq62Mj2VuiXBI0llA0nAFM85Gl/C4qB5valfdgCLEQTTBnEE
	ZgwZSPUiAUnrUJ6Pq5DG0IcNRYJOK04ZaITR17RJLRygTF1HDoHZtpYyDwP/prHaEIKAVGaQWizLF
	9wGxNTxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOMHy-00000003kui-4B9s;
	Tue, 03 Nov 2026 21:43:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOMHx-00000003ktq-2vla
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 21:43:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 72DF3413AB;
	Tue,  3 Nov 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793742209;
	b=jwY2puHUTUPakcr0j5EumCvKfN4jhxaj2W2vmfvbZEXQG9rfI6ZfFyQmg2nvpY5iCvEg
	 RR0PRKkpeTx2rd+ikU/ybB7zEn6BZa5u6sxquZwaFqKU1iOcKGOTDK6mc2Gt3EHBk2eYE
	 0GkIYyNOWb2MOq5+7JNAk5RIX1UNtgczwk/u96ha5dnMglMh+1eNVa0N4QNHkmCu6Edhl
	 QuuHenQWOLayq4TxBdcyHk8g69VsgNu2VRWhY01HBPjy21tCUBoPcxyFYqqF2dqPTtZfU
	 s5dnMc/fwMalNU/j/tbyVW6O86Eublx3gjzK3iHsanuY9zEtA5aBMFaRt8FWsdE9RDg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793742209;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=UHI5BSckwNpcy+5/aNggAOxJP93aAxDcEdnUedESl1E=;
	b=enngrnoGGE6Rugh17ytwtregbLD1nezq9yWR/RmsRExDLMYYlQIsVxQlIJT8Il6iZbzb
	 0O2iAMie21w+ai1uDMQIDwINzU10yzjxBBtfOkmadyWZhx/8yWw+606NUNvJfBH/SepGm
	 L5kDE9UDOpnCTWROW9VXUmQe/KGI/cSp/75LG2dm/cSMfPjkeEj0Mra/USRoe/4LRaaCX
	 hB6mcNgSPAtUfYNLXwRu2lEnIt7P8XSiFLk96IBPio2wO55MUlb3yyWmijsXz/5d2gEWk
	 HeZfUpOjxhHahpUA6bOCMUQgvdaxRSzunvIOYrcerAMEoYr5VBDqVtjIg0u0O0dEp6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B8B811F00A02;
	Tue,  3 Nov 2026 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742209;
	bh=UHI5BSckwNpcy+5/aNggAOxJP93aAxDcEdnUedESl1E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=WYbmmvwnOjFg0ZF2mIKiZr/se0z9JuFfcZ3dbtQQWM/2KWDWPup75FlHcuyIMsZlr
	 tytCf39sWugCDZHEihuwb0+yVTodmEq17Upcb2oY5PEUmbQkCPWVT5CiKjDSao+DCR
	 B2+k7ZkKMChsT4djyDEbQoGNxBOgshVumicStOThSfxiCoaI9XdpXThyKaE28y9oGU
	 CFq6cjv3tnzyKHHLGQnBcSKA9oDy+7R5uy5VSYSnm97Aog4iyh0+BdGWXsIINMo4xV
	 TI6GXAEeZbfsqqQEif9Fq7cEMoGsnunAr3dRkZVuzDbstnBJ3cBHKCy8VyCuswDh5Z
	 ZW/y8jsJsmrIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4903E46B43;
	Tue,  3 Nov 2026 21:43:27 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH net-next v5 0/6] tls: perform TLS 1.3 KeyUpdate in the
 kernel
Date: Tue, 03 Nov 2026 16:43:24 -0500
Message-Id: <20261103-keyupdate-rfc-v5-0-de1ab90a88d5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBAF0KsY1mJggNK68h7GRaFTRW1rABuN6
 d3FurAhcfkz8/5/kYDeYSDb1Yt4HF1wQ5+CWq+IPdX9EalrUibAoOAMFL3g835r6ojUt5ZWshF
 WYymZ1iSZm8fWPea+Pekx0h4fkRy+l3A3Z7TxU/f5PbkQB/+cp0c+iz8rI6eMFsxorQq01jS7Y
 1e768YO3dw9wlKXuYak0SguhZFWljrXYqEFy7VIukSOAgAKVDzX8qfTeK5l0i3XkleVBlO1Sz1
 N0xvJwwkzgAEAAA==
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
 Martin Belanger <martin.nvme.dev@gmail.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793742206; l=11507;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=O+Cx7WWPsWN5XOdxyNZ3WBVbvkfMFLJCQK2yqhjSIqw=;
 b=E0STjfEOCfjfLJ3+ZRjTwCa/prhm8rBfPgstA2Kxjt57faq0zdXfdVXHK+gQyljcGNOCokfV5
 uVNVj2lxpTwBLCGu5FoEfzt/3ZIb1im1WEcHlw4sMmjN0zOOkqoqKa/
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

Tool use
========

I developed this series with the help of an LLM coding assistant. It
drafted code, tests and changelogs, and helped with analysis of the
RFCs and of the GnuTLS and OpenSSL sources. I reviewed, edited and
tested all of it, and I am responsible for the content.

Testing
=======

- NVMe/TCP host and target over loopback, with the record limit and the
  rate limit lowered for the test: more than 1000 KeyUpdates in each
  direction under I/O, with AES-128-GCM and AES-256-GCM.
- NVMe/TCP with tlshd and the matching ktls-utils change, with the real
  2^24 limit and no change to the kernel for the test: loopback in one
  VM, AES-128-GCM, one I/O queue, 4 parallel 512-byte direct reads.
  One direction reached the limit and sent its KeyUpdate after about
  80 seconds, the other after about 160 seconds. I/O continued.
- Interoperability with OpenSSL in user space, which derives the keys on
  its own, including the reply to update_requested.
- New selftests in tools/testing/selftests/net/tls.c for every TLS 1.3
  cipher kTLS supports. The full tls selftest passes.

The matching tlshd change for ktls-utils is a small patch to be
submitted at a later time if this series is accepted.

Open points
===========

Feedback on these points is welcome:

1. The series uses one socket option per direction, like TLS_TX and
   TLS_RX. One option that sets the secrets for both directions would
   also work.
2. When the application installs a key itself with TLS_TX or TLS_RX
   after the secrets have been registered, the series removes the
   registered secrets (TLS_TX removes both, TLS_RX only the RX secret)
   and gives KeyUpdate back to the application. The alternative is to
   refuse the key change while a secret is registered.
3. TLS_TX_KEY_UPDATE (patch 5) is not needed for the record limit. It
   can move to a separate series if a smaller first step is preferred.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Changes in v5:
- New patch 3: make the decrypt step of tls_sw_splice_read() a loop.
  This was part of patch 4 (patch 3 in v4). No functional change.
  (Hannes)
- Patch 4: clear the crypto_info for the next key with memset()
  instead of an empty initializer. (Sashiko)
- Patch 5: also check for a due KeyUpdate when the open record is
  empty. A send that fails with EAGAIN before it copies any data
  leaves an empty open record, and the next send skipped the check.
  (Sashiko)
- Patch 6: add a test for the case above.
- Not changed: the lock and send error points of Sashiko on patch 5
  are the same as in v4, see the v4 changes.
- Collect Reviewed-by from Chuck on patches 1, 2 and 4-6, and from
  Hannes on patch 5.
- Testing: add the NVMe/TCP run with tlshd and the real record limit.
- Link to v4: https://patch.msgid.link/20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com

Changes in v4:
- Drop the RFC prefix. Rebase on net-next.
- Patch 4: check for a due KeyUpdate only before an Application Data
  record. The check at the start of sendmsg() could send a KeyUpdate
  before a control record or a call that fails. (Sashiko)
- Not changed: tls_sw_sendmsg_locked() can drop the socket lock in
  sk_stream_wait_memory() while a KeyUpdate is pending. (Sashiko)
  - A TLS_TX or TLS_RX setsockopt() during a blocked sendmsg() is an
    application error. The existing TLS 1.3 rekey has the same window:
    do_tls_setsockopt() takes only the socket lock.
  - A peer request that arrives in this window sets
    tx_key_update_reply, and the reply goes out before the next
    Application Data record. If both sides request at once, each key
    moves twice, which RFC 9846 section 4.7.3 allows.
  - A record that was already being written can go out before the
    reply. RFC 9846 section 4.7.3 allows this for records in flight.
- Link to v3: https://patch.msgid.link/20261030-keyupdate-rfc-v3-0-8e1e32226e51@gmail.com

Changes in v3:
- Patch 2: cite RFC 9846 section 7.3 for the key and IV derivation in
  the comment of the secret check. (Hannes)
- Patch 3: count a KeyUpdate over the rate limit as TlsRxRekeyError
  and log it, rate limited. The limit stays at 8 per second, the same
  as in GnuTLS. (Hannes)
- Patch 4: rename tls_tx_key_update_if_due() to
  tls_tx_maybe_update_key(). (Hannes)
- Patch 4: check for a due KeyUpdate before each record, not once per
  sendmsg(). One call can write many records, and the reply to
  update_requested must go before the next record. (Sashiko)
- Patch 4: align the control message buffer of the KeyUpdate record.
  (Sashiko)
- Patch 5: add a test where one write crosses the record limit.
- Not changed: the lock and send error points of Sashiko on patch 4
  are the same as for v1, see the v2 changes.
- The nvme-tcp fix for the stall on a KeyUpdate, "nvme-tcp: start
  error recovery when read_sock fails", is in nvme-7.4 with Cc:
  stable. (Chuck)
- Collect Reviewed-by from Hannes on patches 1, 2 and 5.
- Link to v2: https://patch.msgid.link/20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com

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
Martin Belanger (6):
      tls: add HKDF-Expand-Label for the TLS 1.3 key schedule
      tls: add socket options to register the traffic secrets
      tls: loop in tls_sw_splice_read() until it has a record
      tls: update the RX key when a KeyUpdate is received
      tls: send a KeyUpdate at the record limit and on request
      selftests/tls: add KeyUpdate tests

 Documentation/networking/tls.rst   |  43 +++
 include/net/tls.h                  |  23 ++
 include/uapi/linux/tls.h           |   3 +
 net/tls/Kconfig                    |   2 +
 net/tls/Makefile                   |   3 +-
 net/tls/tls.h                      |   5 +
 net/tls/tls_hkdf.c                 |  82 ++++++
 net/tls/tls_keyupdate.c            | 160 ++++++++++++
 net/tls/tls_main.c                 | 181 ++++++++++++-
 net/tls/tls_sw.c                   | 206 ++++++++++++++-
 tools/testing/selftests/net/config |   4 +
 tools/testing/selftests/net/tls.c  | 521 +++++++++++++++++++++++++++++++++++++
 12 files changed, 1225 insertions(+), 8 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261025-keyupdate-rfc-94d3c7e84077

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



