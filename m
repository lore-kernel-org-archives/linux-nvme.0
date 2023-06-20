Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1914EB64DB
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qtiWsqvyZaCWU0PRWOqBZXRVP/g/OKzx3YKj1ldYBcM=; b=Tyrzxe1GZFoZKGrBNZZVZZOxdf
	c7tdf0KhXxvWvIlyo0gtxSTwIoEjt5DvFbJy0JW+/H39/FLy8HFzs0L/2lVn40PU//Rosd8ZqSWRN
	G6YL5+Y1Ud7r6RST3RnWIHBFNiw6W2v/jF/b3tpWYDMXRh8mD/aiNWP0s8iKXs4IM7LuX7ntGc8pO
	a5ZypshjzNVa/0C6DJCPu3Sl9HaDId49dTy6e43EWXvt/+B8aXQrTIaR3Efwh8Dcy6GXYLzp1GoVx
	P8pXeaae7a5qb4dFS57pHn4WFvj9fgUvtwpPnkC+kkkHfXLENUMXpwWBZpkyjZe53nk7XpHTFhvw9
	9WslcoMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYbr-00AvWY-2v;
	Tue, 20 Jun 2023 10:29:15 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYbk-00AvNa-2n
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 10:29:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 052842188B;
	Tue, 20 Jun 2023 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687256945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qtiWsqvyZaCWU0PRWOqBZXRVP/g/OKzx3YKj1ldYBcM=;
	b=dGicWHsDvUifjlA4pY/ZPltQnb4UsKtFcwJ2QVcTFWKE1rRMMeIzvtePqPcPcWAlSPgRuH
	3czwdnVC5CC0d/043kdj9GmA2+0jW/irf481K3v1xSjHGc9w23D0Riv8qOzIhk2ZaMnTZ+
	V3ey8YeO6dMwGeOL8MnFsTdFfUISRfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687256945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qtiWsqvyZaCWU0PRWOqBZXRVP/g/OKzx3YKj1ldYBcM=;
	b=iHVwrcQpVSjFm4qFNPx5IpeKhyWIudn3B1rR2O9jWl1LjuFTHaakMvvnpxSxBts5f9Mx4i
	m3nMGr2fEE42o9DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D37692C141;
	Tue, 20 Jun 2023 10:29:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id BFC6551C51F7; Tue, 20 Jun 2023 12:29:04 +0200 (CEST)
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
Subject: [PATCHv5 0/4] net/tls: fixes for NVMe-over-TLS
Date: Tue, 20 Jun 2023 12:28:52 +0200
Message-Id: <20230620102856.56074-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_032909_080797_D7B0B2F2 
X-CRM114-Status: GOOD (  12.72  )
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
The first thre are just minor modifications to have MSG_EOR handled
for TLS (and adding a test for it), but the last implements the
->read_sock() callback for tls_sw and I guess could do with some
reviews.
It does work with my NVMe-TLS test harness, but what do I know :-)

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

Hannes Reinecke (4):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  selftests/net/tls: add test for MSG_EOR
  net/tls: implement ->read_sock()

 net/tls/tls.h                     |  2 +
 net/tls/tls_device.c              | 25 +++++++--
 net/tls/tls_main.c                |  2 +
 net/tls/tls_sw.c                  | 87 +++++++++++++++++++++++++++++--
 tools/testing/selftests/net/tls.c | 11 ++++
 5 files changed, 119 insertions(+), 8 deletions(-)

-- 
2.35.3


