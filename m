Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1CCC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qKgen87lnA9actSHJ1Y5WsBzgRVxm/VtELwSTcMaw7o=; b=bA0gyoDIxx2eBmIO/hwcudBmEN
	3NK192oHk1IxCQF1+VxZaYRmmbncfaMVjfYcc64AiuEqWDHkaJQx3WYjdWF1p+54VknD2dbuyOuZ0
	isZ6n9ZU1uVevZzKSMKtrD3EJO4W7lH5po72XI+PaoCAbiKnhIevs6Ju/Dih9FnF87qkWvDf4I7zJ
	gjQb7hr7oNtK/PtFFu9CoGFVPCS14lBwzhL+WwgXVNyGfrf8nmqP5JyHM5mBmwIVj8gS//2FcC9+4
	AIapLPCSXX6Rlo4uNbZbP8bMsCds0pUIgchNzgYYtJctq2A9wa7iSeqUHxRNOKDVobw79fZ6X+V9V
	E+FrLE5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEO-00EIWW-22;
	Fri, 21 Jul 2023 14:35:44 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMrEK-00EISp-0c
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 14:35:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 599201F88E;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689950136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKgen87lnA9actSHJ1Y5WsBzgRVxm/VtELwSTcMaw7o=;
	b=1LSJ2itWu+ovjrk1zPbRjd3i/ATYkJ5OU1btpYVA14RzpF/l5m5tiQUPQf6709S5Egzwnd
	+ZH+O/0bGDclgrL0E2jtj4N5GffRGOECO+VwmmkMPRuKRAU55kXEDZN9VXr3vO/klX0r0K
	tfK+DbLs/IgLBb5JFBrZa5NhwLXbGQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689950136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qKgen87lnA9actSHJ1Y5WsBzgRVxm/VtELwSTcMaw7o=;
	b=dFVu/+wEthKDw0+G4K2D6oYuV/ob5m8q6iPppqiyN0FeLgV4LhIXwiqc2krX3/mJxQf/IV
	8Ciqo934AL1awZBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3345E2C142;
	Fri, 21 Jul 2023 14:35:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2177551CA01A; Fri, 21 Jul 2023 16:35:36 +0200 (CEST)
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
Subject: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Date: Fri, 21 Jul 2023 16:35:17 +0200
Message-Id: <20230721143523.56906-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_073540_375227_D1464AFC 
X-CRM114-Status: GOOD (  11.69  )
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

Changes to v7:
- Include reviews from Jakub

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
 net/tls/tls_sw.c                  | 132 ++++++++++++++++++++++++++----
 tools/testing/selftests/net/tls.c |  11 +++
 6 files changed, 136 insertions(+), 20 deletions(-)

-- 
2.35.3


