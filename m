Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2BCC04A6A
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KITOh7mhAROX0DHx75ByZrgCqzDH9fXcM5TVvAo8OYM=; b=Z0bWqJ40i/Je1DsoIOYKXKRR80
	ZG7Zbe3Nvym2k/QjyhucGLST3PNTVlQ46D43/tLvQAbtjzWPmaHqjS3y/fvscpK2crn/RH932cNTZ
	RsSZYD6k0QuG2PRSdd4Zh+GXL9W5OmN9Qwe5ye9X86i3s2dtnv2dChsGSHqmywrWYkXn762UJKEDi
	LCjoQklmpEaoBIYU3cW0evAM6DgsBEoiouRIvJue+oU17DLO3SRnXWAol7Ghf0OuTUv3VCIREXPvp
	PrE/lwPqAJ/Gpcmh6fL5C0l+cQ1kCHdnwAYkhoX6sgjrKoJnPIVJeGsPpg+ICYlt2JLWbyDt33q+m
	sdk1CTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzg-00BMBi-1k;
	Wed, 26 Jul 2023 19:16:20 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzX-00BM6l-2e
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 19:16:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 19D081F459;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KITOh7mhAROX0DHx75ByZrgCqzDH9fXcM5TVvAo8OYM=;
	b=1C3e0ctjSPoSpwtQGVrW2AFt3CtWwz8+mTabngYFL9X16Ff0t0SrQ45ebY9YI6uEv5xqwd
	lH2r/zMgpRRX4BYaRS8xthjCClkzZCuTmkszZBQKLerIw5BARx+uZFxjT3ZGFTm7WmoBZo
	hsaBNYYDRv02mUyJcYeGr6Fmv4bbNW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KITOh7mhAROX0DHx75ByZrgCqzDH9fXcM5TVvAo8OYM=;
	b=4sPB6xkKaA7snlGJoFk67uN4j8KG/HgszKRih1Fn8mmpMq+8lFIvJ4+KLfrF7cximcyHES
	+G8I8cexvRk4ZSAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2209F2C143;
	Wed, 26 Jul 2023 19:16:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0F0E351CA32D; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
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
Subject: [PATCHv9  0/6] net/tls: fixes for NVMe-over-TLS
Date: Wed, 26 Jul 2023 21:15:50 +0200
Message-Id: <20230726191556.41714-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_121612_015035_7AD3D61B 
X-CRM114-Status: GOOD (  12.15  )
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

here are some small fixes to get NVMe-over-TLS up and running.
The first set are just minor modifications to have MSG_EOR handled
for TLS, but the second set implements the ->read_sock() callback
for tls_sw.
The ->read_sock() callbacks return -EIO when encountering any TLS
Alert message, but as that's the default behaviour anyway I guess
we can get away with it.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Add a testcase for MSG_EOR handling

Changes to v2:
- Bail out on conflicting message flags
- Rework flag handling

Changes to v3:
- Return -EINVAL on conflicting flags
- Rebase on top of net-next

Changes to v4:
- Add tlx_rx_reader_lock() to read_sock
- Add MSG_EOR handling to tls_sw_readpages()

Changes to v5:
- Rebase to latest upstream
- Split tls_rx_reader_lock() as suggested by Sagi

Changes to v6:
- Fixup tls_strp_read_copyin() to avoid infinite recursion
  in tls_read_sock()
  - Rework tls_read_sock() to read all available data

Changes to v7:
- Include reviews from Jakub

Changes to v8:
- Use tls_read_flush_backlog()

Hannes Reinecke (6):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  selftests/net/tls: add test for MSG_EOR
  net/tls: Use tcp_read_sock() instead of ops->read_sock()
  net/tls: split tls_rx_reader_lock
  net/tls: implement ->read_sock()

 net/tls/tls.h                     |   2 +
 net/tls/tls_device.c              |   6 +-
 net/tls/tls_main.c                |   2 +
 net/tls/tls_strp.c                |   3 +-
 net/tls/tls_sw.c                  | 142 ++++++++++++++++++++++++++----
 tools/testing/selftests/net/tls.c |  11 +++
 6 files changed, 146 insertions(+), 20 deletions(-)

-- 
2.35.3


