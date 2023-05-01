Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19075C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EUEJrGSU9dbvr4t0fqCm6zFszLF/bFGwTNtIbcqD6dc=; b=fbDeVgVHJ8aCoSwBVTOWZH9NHw
	05DCobDJCqKL6jLAzWe2f9Mk+BUljlsMsQkILEsU1HP7dHj3dSdJs742tOrgSMabLBJU4iZvyIJO7
	S7JysvUtux21v1aGl8pqwZwJxFfuK7aGd+HZH6VWJ7tvFiN5Yw3vlTO/6/oMTf+xPePSTdf4FRWWw
	SYiJBVxSS7VBszyvriy97FkbgqFsAhAbkc6GmUFohAzaKLIgRd4rWNzt7A79gNcerDLqEdqanwDMl
	B5Q/pq6+jTo/ubk2kpiR9n2OJtw4kyQ7UyhmIymW0rvKoaxq19KO+i5Go99Kv5515XZhZuNCbDjxf
	eW+tXtGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpr-00G0Uv-2f;
	Mon, 01 May 2023 12:40:55 +0000
Received: from smtp-25.smtpout.orange.fr ([80.12.242.25] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptSpn-00G0QD-0n
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 12:40:54 +0000
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id tSpZpM6hwpwRItSpZpInaY; Mon, 01 May 2023 14:40:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682944841;
	bh=EUEJrGSU9dbvr4t0fqCm6zFszLF/bFGwTNtIbcqD6dc=;
	h=From:To:Cc:Subject:Date;
	b=nMsOv6yUj20FO78qx7cQuyqhpBbMv1MDjFjIyx23VIP1d/rxsNuHlNzevfdXkRLn3
	 IvQPtzTfUBM8ikx6ycI5t6ZAOZKII//KTEfwXglID6qMJIWUJX26whoYTczGcOsiQp
	 F+AxN4H0xgpoB4M3s2h1NAmSFaC9cMJlrF1guBP+XIzbAKaoEdzhybYsDW8sAyQaye
	 1j1upBoLJWU3kzWzhoNcM0JWTL4FmXdOK/5voGA+52uS5VBTxPG0Nb0iFKdNK7M0gf
	 1k4Xp2BnVmI58dVP6QZc18ZVec9T4PBpNBOMDUTkySsJCruKDYrsXfBepf0LLrS20X
	 BdAq+togyimJg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 May 2023 14:40:40 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/5] optimize some data structure in nvme
Date: Mon,  1 May 2023 14:40:24 +0200
Message-Id: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_054051_717736_204FB1F4 
X-CRM114-Status: GOOD (  15.29  )
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

This serie is a proposal to slighly optimize the memory needed for some
structures used in nvme.

This follows the discussion in [1].

Honnestly, I'm not convinced that this serie really brings semething.
Because of the way memory alocation works, and its over-allocation to try to
avoid memory fragmentation, some limited gains are most of the time useless.

It could still help:
   - many holes in structure can, at some point, have its size reach a threshold
     (this is specially true if such structures are allocated with kcalloc() or
     kmalloc_array())
   - it can save some space in some other structures if embedded in them
   - it can save a few cycles if the structure is memcpy()'ed or zeroed, for
     example
   - can reduce cache usage

With that in mind, patch 3 is a win, patch 4 is likely a win, the other ones are
much more theorical.

The changes are really limited, so even if the gain is marginal, maybe it still
makes sense to merge them.

Each patch gives the layout generated by pahole before and after the patch.

[1]: https://lore.kernel.org/all/67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com/

Christophe JAILLET (5):
  nvmet: Reorder fields in 'struct nvmet_sq'
  nvmet: Reorder fields in 'struct nvme_ctrl'
  nvmet: Reorder fields in 'struct nvmf_ctrl_options'
  nvmet: Reorder fields in 'struct nvme_dhchap_queue_context'
  nvmet: Reorder fields in 'struct nvmefc_fcp_req'

 drivers/nvme/host/auth.c       |  6 +++---
 drivers/nvme/host/fabrics.h    |  8 ++++----
 drivers/nvme/host/nvme.h       |  6 +++---
 drivers/nvme/target/nvmet.h    |  4 ++--
 include/linux/nvme-fc-driver.h | 10 +++++-----
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.34.1


