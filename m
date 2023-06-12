Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ED1C88CB6
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C2k24IeuiVQYdJQsI/9NOx3TxeJ/ljqB1XUVmlBNT/4=; b=ZdS3+zFxEKXU4Q19B5eKO9uzTX
	2KHjU0K74kznQcJINNllT3Irmx4sOVrdgQlY8b5DJtncHzv/MLQ957yUz4QdjBBq4Q5uUCXRClIhR
	fvQ2sWRQzYmI/9y01KyF7pniRL4v5CIDlF8a1SkrfGrXpz/6JRJHkrFveUfgrBlW5BDFH9c/AGlNz
	sVq7W3g1NUhmGFcJHUOCgiXLO8Y4nGYXfymjGdj0G0UOulH6SOZd+pf9eihMJpkTQexMquJYmSz7/
	gIUVXCqMdnop7i796eokdeYzjrrq1ZxLSMAmIQI3HK18KCdga5aaLIPzjfltNs+71k2SHWImVwLmf
	rtMa3kUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igw-004KJd-1j;
	Mon, 12 Jun 2023 14:38:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igs-004KGP-2T
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:38:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2B8EB22809;
	Mon, 12 Jun 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686580720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C2k24IeuiVQYdJQsI/9NOx3TxeJ/ljqB1XUVmlBNT/4=;
	b=R0cDlkmbUWlIDzGjzuDQHgJoUfZdgNtIdLDZxWoCREougNEEnaIaonvMEJ3Ejq7FLkNiUW
	SZiqMBlG+qrxJ9uUeTZwKfkYH/m8qdSsDTU/XgkXpMgGu2e28rUbfXFucFTvGfFzTpPuX+
	nNFIBNr0OW+KJtUi+5m+rd50Qxoglw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686580720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C2k24IeuiVQYdJQsI/9NOx3TxeJ/ljqB1XUVmlBNT/4=;
	b=mplbfpxChyP9ketW9EONBQVPhvb/fBfpsSIu/a6QX7AwOoqOugGD9qgmeAt3FRgoymS46r
	R/rloCoYJGRVH0CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E094D2C143;
	Mon, 12 Jun 2023 14:38:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C00CC51C4CB7; Mon, 12 Jun 2023 16:38:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/4] net/tls: fixes for NVMe-over-TLS
Date: Mon, 12 Jun 2023 16:38:29 +0200
Message-Id: <20230612143833.70805-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_073842_990855_2244EA06 
X-CRM114-Status: GOOD (  10.56  )
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
The first two are just minor modifications to have MSG_EOR handled
for TLS, but the third implements the ->read_sock() callback for tls_sw
and I guess could do with some reviews.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Add a testcase for MSG_EOR handling

Changes to v2:
- Bail out on conflicting message flags
- Rework flag handling

Hannes Reinecke (4):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  net/tls: implement ->read_sock()
  selftests/net/tls: add test for MSG_EOR

 net/tls/tls.h                     |  2 +
 net/tls/tls_device.c              | 24 +++++++--
 net/tls/tls_main.c                |  2 +
 net/tls/tls_sw.c                  | 88 +++++++++++++++++++++++++++++--
 tools/testing/selftests/net/tls.c | 11 ++++
 5 files changed, 120 insertions(+), 7 deletions(-)

-- 
2.35.3


