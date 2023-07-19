Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B7DC001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MjE+MOFpFadd0F3lZwj3UXnm3sqwZEpBmBb74wm7f0c=; b=Ty3m3urxSqDek3+5E+e/PW71U6
	vUZBab0FtxZeGJXUcYVe8rewdfqMvXBDqvXmJkGkTR9byE+9LKiK2a1zQRE/elAqiJmnMeUoJuVVQ
	p9KH3yvIkDTkJ3zmxzyZBob8SUvrx2HMj6DqxxW4N2SiQ8td4Y24sVDFNNE8HJ+HtGxcPIOjcQTEa
	OCIVT/Vxh6BBtNy16hse++2WQgNmEU9qAF/OxNJ2IKIyazi4/k27jVD3hUHYslI7RdXHsu3UTR42J
	AEK/jCO2ERRzUPRzO1mTFKGXtilsByGOE6OCYSyBxPWEWPtT2J+MKy1SY93ofnWY0Wm7Rxq9g0kJU
	P4YBm0uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dl-0076Ia-0f;
	Wed, 19 Jul 2023 11:19:53 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dh-0076Ed-1S
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:19:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0E9AC21B69;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MjE+MOFpFadd0F3lZwj3UXnm3sqwZEpBmBb74wm7f0c=;
	b=11wwRWF5ub6owRnIQe0giS0/SwZkfXAaGvXQRkaGTEu7zSOA8DnXwWj1VQ6rAJQDa1V1DO
	LmMiq0OuIEFuwHMVUMXAJoXPI+RtW8fHNdJu+ob4AhOOuiNEJ8Z6mT+MPOVrrGPVaLJ9fX
	O6lRsy6BmvmZHzpg5NobGY0UlYiyK0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MjE+MOFpFadd0F3lZwj3UXnm3sqwZEpBmBb74wm7f0c=;
	b=ZL8hjE7vyhQrD/66aZSe7ioJ97bkxK5mrvHHfZ3tUcYlEC27e2i1ZdVUN6fJLk+Bga81QF
	0YTJm5dPiLIMLSCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D96802C142;
	Wed, 19 Jul 2023 11:19:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C70D851C9EBB; Wed, 19 Jul 2023 13:19:47 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv7 0/6] net/tls: fixes for NVMe-over-TLS
Date: Wed, 19 Jul 2023 13:19:38 +0200
Message-Id: <20230719111944.68544-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_041949_665309_C815E626 
X-CRM114-Status: GOOD (  12.47  )
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
for TLS, but the second set implements the ->read_sock() callback for tls_sw
which I guess could do with some reviews.

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
 net/tls/tls_sw.c                  | 139 ++++++++++++++++++++++++++----
 tools/testing/selftests/net/tls.c |  11 +++
 6 files changed, 143 insertions(+), 20 deletions(-)

-- 
2.35.3


