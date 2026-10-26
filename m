Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fGQC2kKh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SylhSQuH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=talHnQ7/cHb/VJ7cbEQ58lXn6pqWYigIkjRL331q6io=; b=fGQC2kKhgSJ/S05hR9bPeYLDlQ
	MSozc0gI+LGhDk/MnYpfy/0vgl+qKrzKKaRcScSeH9vYt2QVtL+W1lQ2PK+WhMSPWWD/Y6Dnz/RoG
	D56Ux4we4Fhs676FT+0r8Cd/N6E25kMQTGuQYrtlc7wbPSEYgfx3uNjQC4NlgnjoLlANxTMTNxjlr
	6m83P/U2mYZ+ulCahWBeQzh/pZWqfX9V1CHKlKH/b6WKCS+4i0qGdnRusgJaseIYoNimFqtM6I+bJ
	T90+VvmhEOOvSrt4MjGH4xb6qLld9eflGe9e/2iNz+YpG520JfNq1YrNEbxSXckcrgwjUo90nXiwu
	/iGYtd5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLP8q-000000032cX-13Zd;
	Mon, 26 Oct 2026 18:09:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLP8o-000000032c7-25wN
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:09:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 93C3C601EF;
	Mon, 26 Oct 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793038189;
	b=Kkw6rW7inbBRUfwsrxzQVt4jk0Gc8F6VoD5LRDH+BHSL8ID3tz+rTGkpuhle4Ttov0Ot
	 4e17hIeL1pHe06uxc+9IX10w4lyRoOzh/ifulTLQzf6KZzfF/0lQKd5OkgWrHWJJOTC3B
	 S7CRwcbFw11uiRzVmukaI+RZmac1wCs800dvPjrZdFZ+7aQ0QaozFJxBrXXjSB0dVH3kv
	 SQ8FuRgBCfLGrI/jtF6XTBiHJ0ACmp4/h2G0Sa9qsGu/pH8ZBhEb3pRSC9KLs9DtaXrAJ
	 e3seu/JwBdgwrNzqLO3UGPfSJTALkATCPhdfsccMrunsO9ZayPTXmY2/v9xpbp8nacQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793038189;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=talHnQ7/cHb/VJ7cbEQ58lXn6pqWYigIkjRL331q6io=;
	b=bn7/gjoQwWRxGDq0vvx4c6/qHjRhY9hpMDQXT9cPjZDDLH1e7gTpqO/Dz8cT8djlloDs
	 mDlGkHkIkl5Uv6KCeOSwbaTl4N0tu7XF8kaCd241xbQB46Jx1bY3F2/cVb7IU4Sr+5N2u
	 5VInjBaUNDSulCKhZ7jXabibIpQBNi+SiI0VI1FqWITWBfZAXlhl5J477tA+O6JNkGpaM
	 IlqBhLAsafmtsf8Q2m8hjGFYFkSzHV4L8oAo7TBu382Pzc2QyLabJXguFiAo4qk4FXHcn
	 vy8CNw2jQUHCjoZlzFDAoHHGdPjfpZfVl3EofI8YRJ1gsG3KcwPlNGck0+OFLyGtMDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2FBA1F01829;
	Mon, 26 Oct 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793038189;
	bh=talHnQ7/cHb/VJ7cbEQ58lXn6pqWYigIkjRL331q6io=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SylhSQuHI5Vb4l0uCxgaakqJTmUBtV3XmPFLf2ceBTMmoO/0kgGqkAgl1OmclBTNU
	 MZRZlp8lRavwhrvxep9f5aFigQ+BlwoBCCfkZiEBgn6y3BQhVkSkc/dSe6eUSXCYAU
	 pJF9+JFUgU8rnolivHn/C/zsoibsKKYfDt2uKF9naWQWO67ULYbakhSCVhZMdTuKAN
	 1LO02g/qDdKDVSwfpGmfifzHXi8f3pqPlvRMFZERLTyKoYhsp5sx06tWJ0wzeL9vlf
	 MljRh4mp3xgKJFN0Z8tSykxhMKsshIQ8QD9EGbmAwp9h8nBPXQsRsTSQDruAb3AsFv
	 O3nt1xGqjuujQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2790A44E20;
	Mon, 26 Oct 2026 18:09:48 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Subject: [PATCH 0/2] nvme-tcp: handle TLS control records at connect and on
 receive errors
Date: Mon, 26 Oct 2026 14:09:43 -0400
Message-Id: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCUAwEf6XkbKCvWgV/RTy06VYj+izJswil/
 27Uwx6GZWYhhymcjtVChlldnzkgbSqSa5cvYB2CqambfYpxnh/gIhNLsbtBeNQ3nNsxydDu6sO
 27yjkyfA7wj2d/+yv/gYp3xqt6wdHTW6legAAAA==
X-Change-ID: 20261026-nvme-tcp-ctrlrec-fixes-5f1cd54073ba
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793038187; l=2128;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=3hTAzrQJfgElLUy2dxnWBPcmYnvUEDdOPYD2sRIU/0g=;
 b=iQQCHjO1s/DBlbEGXiWuHp59XYALtBKQvAVw7ggCh/0qNPDM8zpPbc/a/fTIYvqg3xIIRnPzb
 jCRWH4eV55OBPFaLPIlAQmq/P2cdng7mpRhoPu/NfTXIqDh3NZB81oM
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
net/tls that makes the target send a NewSessionTicket or an alert.
Also tested on plain TCP, and built with CONFIG_NVME_TCP_TLS=n.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Martin Belanger (2):
      nvme-tcp: start error recovery when read_sock fails
      nvme-tcp: skip TLS control records while waiting for the ICResp

 drivers/nvme/host/tcp.c | 173 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 23 deletions(-)
---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261026-nvme-tcp-ctrlrec-fixes-5f1cd54073ba

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



