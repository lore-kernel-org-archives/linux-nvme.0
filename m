Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF06EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YS7G557bfhv6tjwR95He+fLkEsoCV+wMqVNvDDnc3TU=; b=FgcROVlAEG97iGRDXgdq3oIYXk
	xqPmI2ecz1i8GW/yRWukF/MbNNKo3gASHZ3KG5fHFrU4NjN5HFk9DiOeLsjXfcJpPhak/r1xKdNtc
	XYxGqnXjW3i7Pd0B/ER+cUKneq/pB2hE9THDJi8gtenoA/Z6T0/xuKYIhescVUYg1cz/lRFq2hxxt
	SuSqWP/fD6T6fxQrRll6ihjdgZYZ/Cjsqgbxb92WSeFkEd0NZjeE0JjqFzlupjvmnlWVVCCfj+9WP
	cVvLLDMwEF+jxO/fP2kylh10P0C5/xN5yLkMRIUlvgRL5EeYa8xqcl3po48BbkvPwN98OAu02nOwK
	XrnsYMOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUY-009qWf-2m;
	Mon, 03 Jul 2023 09:05:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUU-009qRr-04
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:05:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3732C218F1;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YS7G557bfhv6tjwR95He+fLkEsoCV+wMqVNvDDnc3TU=;
	b=DpyBdg25pUDgxVkudnUg24jmSBH8Cb9oExLeIDpLDkXpDXsvzwvMYXwMsk0imSjxSDt6Ly
	lLN8aQxoeTwJepil8yZWVmi0V+WZL35albMHg9AHNY95KRzcler0r7IC7B61bJnj8ZNcFu
	bq74X/QOWWMcot2fbN2A4hXLM5xOlBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YS7G557bfhv6tjwR95He+fLkEsoCV+wMqVNvDDnc3TU=;
	b=A7mvwYQyLS/vo5zdCmeSWgVp0sUkTpy9shHUXgY5AKqumIsMhz6aG0jt6ypvuMLsRYEmFC
	uC+Bb6emBcoCMqCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E4F882C142;
	Mon,  3 Jul 2023 09:04:55 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D134F51C5D85; Mon,  3 Jul 2023 11:04:55 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Date: Mon,  3 Jul 2023 11:04:39 +0200
Message-Id: <20230703090444.38734-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_020502_215437_31E1E65A 
X-CRM114-Status: GOOD (  13.08  )
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
The first three are just minor modifications to have MSG_EOR handled
for TLS (and adding a test for it), but the last two implement the
->read_sock() callback for tls_sw and that, I guess, could do with
some reviews.
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

Changes to v5:
- Rebase to latest upstream
- Split tls_rx_reader_lock() as suggested by Sagi

Hannes Reinecke (5):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  selftests/net/tls: add test for MSG_EOR
  net/tls: split tls_rx_reader_lock
  net/tls: implement ->read_sock()

 net/tls/tls.h                     |   2 +
 net/tls/tls_device.c              |   6 +-
 net/tls/tls_main.c                |   2 +
 net/tls/tls_sw.c                  | 121 +++++++++++++++++++++++++-----
 tools/testing/selftests/net/tls.c |  11 +++
 5 files changed, 124 insertions(+), 18 deletions(-)

-- 
2.35.3


