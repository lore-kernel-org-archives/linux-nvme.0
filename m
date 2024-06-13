Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33467C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mR3cQQ3xEcN21aqHjOm8yCju37+svyuREx2lWkvuc+A=; b=KZr49PG2ZdTzzogPfhUERWrZZL
	8eTbtuW/ckvKkEVgUkSgDP/rStZLR+KpfIWGvw5eWCnyPJRFKjdudADr0OHRCDHNEEUNxrrw01k0q
	irSyIFAqnsuys0cz7oQTa6hIErskWS40nOhKgSOlcFSZe1PQXWAd3a+cVsyjlF4vN+OLuJ7/Poxfw
	EFUEW0hnsdlTtIjd3aYkQ6VmYdVQ6VLAX7lUT+CAd7ll2HMrpF5acOA2BH1LzphAnNB9XXZzMDQti
	zf+hsFsKs956r270zGjSMaf4DO2dxzRcwFvYXXQnqFGOuETv2nxkMBLT020L56CQyl3Y8h8ZQIwgT
	vmsj8crA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHphu-00000000Bru-1hE1;
	Thu, 13 Jun 2024 19:01:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHphr-00000000Bp4-1gYH
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 19:01:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9BC4CCE2760;
	Thu, 13 Jun 2024 19:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853E0C2BBFC;
	Thu, 13 Jun 2024 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305309;
	bh=ccsmvgxIUfCpGMi3G2ZrOk4uWb35kwfIYQSprfqXJ+8=;
	h=Date:From:To:Cc:Subject:From;
	b=gSIg/KPbfyTTNEHWjC2314OlSC0gjcB5LmpnBrGpE3Sgcs2EtsxGcJIu0z1mtBu4O
	 ZLNUm3xVkW3C84yrYznIg31GhpMl1RK5s1eFAQLlSSXfGsOIvAWMSikFhroyqv0hcU
	 LY6W4U/mqQ+MVNCZEFa8lj2hTH5YxjbvW5FYDpr6P7uwavjwEVd6E/Gurw1lA97Zx2
	 2+/CZf/xFY7fvxr+ihp5wj7NWj6u7OBO7lsvWhPnUExwPqRbNDIPCtfT+XQrUai7OT
	 iE0DQIDzI7wRryRlEFzxeHrzkPY5Og3O1bRYMjmrSHj+/uHg4QAD2cb3VnkJXVwy3G
	 K3N83RP42nmwA==
Date: Thu, 13 Jun 2024 13:01:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: nvme fixes for Linux 6.10
Message-ID: <ZmtCG9l7m2lTYErI@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_120155_683524_AFFDD3BD 
X-CRM114-Status: UNSURE (   7.18  )
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

The following changes since commit b1a1fdd7096dd2d67911b07f8118ff113d815db4:

  nvme: fix nvme_pr_* status code parsing (2024-05-31 13:50:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-13

for you to fetch changes up to ff0ffe5b7c3c12c6e0cca16652905963ae817b44:

  nvme: fix namespace removal list (2024-06-13 11:47:40 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.10

 - Discard double free on error conditions (Chunguang)
 - Target Fixes (Daniel)
 - Namespace detachment regression fix (Keith)

----------------------------------------------------------------
Chunguang Xu (1):
      nvme: avoid double free special payload

Daniel Wagner (2):
      nvmet-passthru: propagate status from id override functions
      nvmet: always initialize cqe.result

Keith Busch (1):
      nvme: fix namespace removal list

 drivers/nvme/host/core.c               | 10 ++++++----
 drivers/nvme/target/core.c             |  1 +
 drivers/nvme/target/fabrics-cmd-auth.c |  3 ---
 drivers/nvme/target/fabrics-cmd.c      |  6 ------
 drivers/nvme/target/passthru.c         |  6 +++---
 5 files changed, 10 insertions(+), 16 deletions(-)


