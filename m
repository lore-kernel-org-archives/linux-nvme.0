Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956B606A332
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S1MonpLG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNfWwSiF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LTOyfSafE7hzPVwGZzuR3rXkPkrl89SpKVv0e1Q7gmU=; b=S1MonpLG9Gi1eP5FOO6l7oInuW
	E9SSkssde4Y5V1j2hgaN8FEso5UgWn8r7CjmasxfuYD0htf4H3mpXC8wQwQrALW07kFVeJpvcLwNo
	LMLKvt3hsa+lZCDg+G+v4Cw4zOkUng4EjA5R4gaKJYJHHlj7hUwBmhiVDOTMjJZ/1AY2CpangTkUi
	Xwx9w1bRz9FRaQACZNZ+uW7hBstBSI7rrCd7aSyLDOoAnG8JmcmvC1knp7BOSTTl4kQVdMvWgqxwa
	bpg3ka61zgv4D4xjnrm2Y+pD2uqPBgnSj5ZqpmWkXhpGRY5vcGsp4eYjG1j1AEl+CI1EOllcwUUGy
	9cdURlhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLeaA-00000004JXb-0QXI;
	Tue, 27 Oct 2026 10:39:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLea9-00000004JUt-0NpV
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 10:39:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0BD4E60236;
	Tue, 27 Oct 2026 10:39:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793097540;
	b=pJTdZRIgaPiw2lvYznHnB2iEOXCsJC+rmMIV/FptMfzng6gWpWteO5t8Df9LXzw3WRlC
	 86VeaSdq7Y0ErqgaS2u+lU8oXyFx/rMK1MBC3gj2I7SWZZvCOr/ym+8ugPQxo/Xb9Oiye
	 5VJtVCc+sm1ymt8EyBAyKN82a0LjL2RMU5XHfw7C6nmcQs1XHL695Xuu7LRwiam4EwrkO
	 azHDSy7OwjFgqOsoutJRU/VIQNnFpvVo8zrIhnO5DMcWfndOhPVl+Iv+1DgtAGGbLYn5l
	 3c9FrR9bQyAWwPyrB7ruRFBuymRYfwgBxZSyX0o5E5RrnoZYBUFwfZXMKLihZL72ZkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793097540;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LTOyfSafE7hzPVwGZzuR3rXkPkrl89SpKVv0e1Q7gmU=;
	b=IvIB8UUO9Sr+NyndVcUoeOTvwpnJ+v4n/DooxI0HnSLlhNs1XrWI4u+EMSSlDSaPW8I/
	 A6/VQjLdenU7onkO0U8FFGBZ9tcd+O1RkIOb1AHqEtjWz2hOwpN8mDuF3ts86+BUsk5HI
	 UHGG/w+ULK8ll6ySSAfZZk6y/mevGdEYtRbIdeHL+XbsTgX4fz7H1QcRs5O/aUvYhrDtA
	 zXGSOX70sY7Jc/np0a4EqxHTnGPB1dLEetRGtTETj29sLwUNOP928jezyCvf2nAyx+uH+
	 eXVe09iMw2I5KxdPesnXd5vQkJ8gDlD3tYaVyssA7FWnrldyyX74aJpPsawuEHtxiEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C8C931F031E0;
	Tue, 27 Oct 2026 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097540;
	bh=LTOyfSafE7hzPVwGZzuR3rXkPkrl89SpKVv0e1Q7gmU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jNfWwSiFc1xozKzVN4zArNa6trt0V2kvqGUW976K+YRftnelthRZTDZGqyjiABI0x
	 FMqE4dXAAazcA0/j7mKuw2tL09tv1L98oKgLlsGYR8MnugyZkjskEZTF7NZsIWeTWA
	 jt79/10SVtXlfd4aqoYyyZurinXz4piKFahdfjSR5+QyUIWCCrxvnGEpTm+yRwV9au
	 ojOTYdfPPiCEYz/y6sUNPcYdpi0+kKIBE2Y+DIWFOkFH/CdccT+TwlQGwjyXuHCe+X
	 PDhgNDGjQkPAhvfA3tXJW8JVPU0l5wmFo1LS7UoUWooMM1IeU/dlPJq8Z621HPE4gX
	 lIv4/efqeocKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 288534508A;
	Tue, 27 Oct 2026 10:38:59 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] nvme-tcp: handle TLS control records at connect and
 on receive errors
Date: Tue, 27 Oct 2026 06:38:51 -0400
Message-Id: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBCGr0K6dgwtr8SV9zAsYJiBMbzS1kZDu
 LsFD+DiX3z5X5tyZIWcuiWbshTEyTJHMJdE4dDMPYF0kZVJTamjYA4TgccV0NvREgLLmxwUrLE
 r8rTK2kbF8mrpNGL3Uf/YvdonoT/WjsQgzi/2cz4HfeT+ngQNKVDLJXNFzFl+76dGxisuk6r3f
 f8CZOUpQM4AAAA=
X-Change-ID: 20261026-nvme-tcp-ctrlrec-fixes-5f1cd54073ba
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097538; l=2782;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=xDMOiq++9UZ29kjwcpP4dDWjnCBrv+AXCwcTDZukADk=;
 b=yVaGlqySFRyykT+BVlZcGQur1fUfb2FlJzxyevbNmIqv2leBqsWvvKOFEKklG5m4NT4m4gnsG
 F8gkMJYnhCdDotd9ethcPAuOo3q5UoaeoEIgXtJ+kCe/Al8LHjENB5e
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A TLS 1.3 peer can send records that carry no application data, for
example a NewSessionTicket right after the handshake. nvme-tcp does not
handle them correctly. This series fixes two cases.

Patch 1: when read_sock() returns an error, nvme-tcp does not start
error recovery. The queue stops receiving until a command times out.
With a NewSessionTicket on a live queue, I/O stalls until the I/O
timeout (30 seconds by default). With this patch, recovery starts at
once. This also applies to plain TCP.

Patch 2: a NewSessionTicket that arrives before the ICResp fails the
connection with "failed to receive icresp, error -104". A target that
sends a ticket at once, such as an OpenSSL-based target, cannot be
reached. With this patch, the ticket is discarded and the connection
succeeds. An alert in place of the ICResp is now reported with its code,
instead of as error -104.

These patches replace patch 1/2 of Hannes's "nvme,tls: minimal handling
for TLS records":
https://lore.kernel.org/all/20260922133708.84522-1-hare@kernel.org/

Patch 2/2 of that series (the net/tls errno change) will be posted to
netdev separately after 7.4-rc1. It will not change
tls_sw_splice_read(), because that errno is visible to user space.
After that, a follow-up nvme-tcp patch will read control records on a
live queue, so a NewSessionTicket no longer causes a reconnect.

Tested with host and target in one VM, with a test-only change to
net/tls that makes the target send NewSessionTickets of 64 to 1000
bytes, or an alert.
Also tested on plain TCP, and built with CONFIG_NVME_TCP_TLS=n.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Changes in v2:
- Patch 2: pass a control buffer when draining a record. Without it,
  kTLS fails a ticket longer than 128 bytes with -EIO. (Sashiko)
- Patch 2: report a peer that closes before the ICResp as -ECONNRESET.
  (Sashiko)
- Patch 1: start error recovery under the socket lock, before
  release_sock() processes the backlog. (Sashiko)
- Patch 2: cite RFC 9846 section 4.7.1 in the commit message. (Hannes)
- Kept Hannes's Reviewed-by on both patches. The changes since v1 are
  small fixes found in review.
- Link to v1: https://patch.msgid.link/20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com

---
Martin Belanger (2):
      nvme-tcp: start error recovery when read_sock fails
      nvme-tcp: skip TLS control records while waiting for the ICResp

 drivers/nvme/host/tcp.c | 175 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 153 insertions(+), 22 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261026-nvme-tcp-ctrlrec-fixes-5f1cd54073ba

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



