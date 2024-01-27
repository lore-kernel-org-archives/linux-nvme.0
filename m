Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB5C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jEXh8lNqe80upMa710TR99plL1npcHnKstPaRiqxEsE=; b=hAaZnwL1qRIJByNexU9pD3vHRQ
	fogaCu98emHsLjjmziCsC4UiA4PjvRTZ78HBnBVlQGscAExS0fdMJjXu7LzT8OxJkNP+j2atJ9Tei
	K7kYMgs4dl2m0f8992xz8Gscq4iKvkMZgC9KK2P4GDcjH9IZxTm5DoDRBTv/MAyxfSkI+8UjQXNB/
	IslY2+rcfH40HxXhmGC1JvaH2aPm2ViU3R+WyRQ12IbCYEBFMVBGu3zGlX/763lVReNH1hc1mhi1V
	X2ML54bqZUh7B9HAP62xPnoAoT4Va4V+o7bGH8fBux8XaARR9u4d7YEdLHHEv9A9stcGWCh720SoI
	9AMmaFdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf8S-00000007Hgx-1IT3;
	Sat, 27 Jan 2024 09:38:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf8P-00000007Hgc-46xz
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:37:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 411BBCE2FC1;
	Sat, 27 Jan 2024 09:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41928C433F1;
	Sat, 27 Jan 2024 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706348274;
	bh=U1qElGnMUQlU64LnQsuD2RlxMpI548Qnj9Q6wtTZDz8=;
	h=From:To:Cc:Subject:Date:From;
	b=pVmmpS57sSAVs0Q99HIEgV7UTcHFK/xNkoJ6bBbjs040bwdeUEmz25rOluuE/kH+R
	 rkcz6+CY9ImN1PVENC0oXo/g//ILU7Z1xpRO84kNd91eE1zobcxw3S3XTD0n5WVXBr
	 eT/VPa/4Fmnd21F1xDPmCHwekCCIjUU/rmRHoYD6rpiz6smTvSojefcPTOr528yQsA
	 nVicAFug41Qds8wH/ITPggR4GIYyLnCzGSGnd5sMDs/gQoMpa+BvFzDudhWJU0muRo
	 NSMkTpKdXGbZpBsBzRAa2fv8r+HZnAVdcEpbWtZFdmFPwjfW/Pw6DdLrVJiNepAaJ0
	 xSxulkOVfbf2A==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/3] nvme: enable retries for authentication commands
Date: Sat, 27 Jan 2024 10:37:43 +0100
Message-Id: <20240127093746.40246-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013758_216762_F8372E86 
X-CRM114-Status: UNSURE (   8.80  )
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

Hannes Reinecke (3):
  nvme-auth: open-code single-use macros
  nvme: simplify __nvme_submit_sync_cmd() calling conventions
  nvme: enable retries for authentication commands

 drivers/nvme/host/auth.c    | 17 ++++++++---------
 drivers/nvme/host/core.c    | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c | 18 +++++++++++-------
 drivers/nvme/host/nvme.h    | 19 +++++++++++++++++--
 4 files changed, 50 insertions(+), 25 deletions(-)

-- 
2.35.3


