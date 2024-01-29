Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E27C47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EyBujdvsX1zceQ9he+1hD2X0gLEm9/yMPHBzsSkGlxo=; b=G9LLvrK+yv6sOkqKBG4hcTByRf
	ykXzuRKFlgTy+88eISy8JjK4i+nER0oNRLSkfM/SlddpO85LUR4pGLPsaxpAsVN0XogCljfEBzUtY
	SkT16cIS+o+ZO3RkKL++0gTwUwTn6rIHeb8nUu1vM/23QXFjL4Yihs/8pTK+YYRyUyM55Woh3PnE4
	aziMT6hy8P2QwJCMCSn+Np79W1uM92FIwcngWABbC7ahICmB4edPrbBGiUli3rMoG8eFucFDsb0hD
	LBlbeY7LVBIIEai1ZMEjdXzvHkcC76QxO+y9tnURjCimT0ziD+kNicUJln21Ecwg+/7/c1Y4Ua/pt
	2Sonx3Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJu-0000000BWlB-2zvV;
	Mon, 29 Jan 2024 06:40:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJr-0000000BWk7-3Ciw
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 07D4661E20;
	Mon, 29 Jan 2024 06:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CADFC433F1;
	Mon, 29 Jan 2024 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706510404;
	bh=w9HQLVGZW4ZIEVQ6JlGwHYmtNTdEbDAILMNS5YM2KMY=;
	h=From:To:Cc:Subject:Date:From;
	b=czoXvWxBPE+9hwmdMxjdH4VerNGR8j28P1n6fwjaGMr2oQwZq47lNPEXOS5KcZgHh
	 4ZwozcENBGsVe9xzTJfIoGiGHykHJn/kwNr5B2UOm+WU6JP406j4bQo/zHdYw7obYk
	 h1/+RuCGjXqwyq/d0tjZIidZwxFHiLEqYSPDy1K5oKrMRWkBuZyzgEQ+uZI0liceYj
	 moDF26E0HjK4EMVuOUcdABQ+zEkmZDuiFu3XoA8/tO3SpLCm/73Brkn1QlRSNPym1p
	 d9tm+ERMyQQRzn/bdSR63Z18CQQ/8yyb5Xb72nh6CRzaKYBEY0ynM7AxYKJC2rKaMn
	 yaDDlr1dK2UjQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/3] nvme: enable retries for authentication commands
Date: Mon, 29 Jan 2024 07:39:44 +0100
Message-Id: <20240129063948.3105-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_224035_899625_2B8F021E 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message.
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

authentitication commands are normal NVMe commands, and should be retried
if returned with a status where the DNR bit is not set. But instead of
having the caller retry the commaand this patchset enables the function
__nvme_submit_sync_cmd() to not set the FASTFAIL flag in the request,
thereby making the functionality generally available.

As usual, comments and reviews are welcome.

Changes to v3:
- Modify patch description as suggested by Christoph

Hannes Reinecke (3):
  nvme-auth: open-code single-use macros
  nvme: change __nvme_submit_sync_cmd() calling conventions
  nvme: enable retries for authentication commands

 drivers/nvme/host/auth.c    | 17 ++++++++---------
 drivers/nvme/host/core.c    | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c | 18 +++++++++++-------
 drivers/nvme/host/nvme.h    | 19 +++++++++++++++++--
 4 files changed, 50 insertions(+), 25 deletions(-)

-- 
2.35.3


