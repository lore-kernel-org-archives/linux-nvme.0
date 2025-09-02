Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F5CA1009
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5Y36vIOkirtec74pbdc7+ytYcS1V4TiodNYHYcqJnQs=; b=sV7pfG0puj73nN
	lYhVZQdW3M/0l9hBeR5CAnVISWMZwbkcjY+Yo9ZDk8mJvhyuxiEj/PB+6wsiZSDpr9FRdr4cmyyAt
	GyYx2ii8cgG8sOU5EdfpOokSNVpN3lesz4okmG6a3GejjninW4w6Ylqwv86acwkOdcQIrwppJs49N
	C4uMzWbWNE0kn2VP5u8VTdWPI72KhfFsAdVt5GbEF6y8f3UmrBLi4qaIIQeACe/jFbdcWYYR7qI2N
	/LiZ9z1DRTGT+nsozSZjBvUabahX6YFy97z12+kcAPh8DGPh+7zmKGhQZRgs1FusnkDyGeLgjoULk
	RXfPPgshrvOdq1cBnirA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQAr-0000000HJCY-2cee;
	Tue, 02 Sep 2025 12:31:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utO9a-0000000Ge9r-1Tlo
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:22:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B048443D6A;
	Tue,  2 Sep 2025 10:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E9EC4CEF5;
	Tue,  2 Sep 2025 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808537;
	bh=vE8ikcJN4Iv3hs1bbiJIcVz//nLYeKz44RqU6unBRR4=;
	h=From:Subject:Date:To:Cc:From;
	b=dcKriVQGxeJ2H04BX7k0uiSVTZG5zgytFTzeMucgf11t6NQy+LxZlDB27ACj1wfuJ
	 AnEhgs9VcF8BoTP/mmY4z1IdplNxaVLM/f7Gq9YzqojWJ7HT1Z+0XqwHs8/uDspO+5
	 8rgIZRlLFliFoJZSuq7BPCqEHCRMbetkA9XK+NdosjnBAQZOPHubTHqUwlYopsVEDB
	 zT5U0Nvkq8qHVk8PFkI7xSxGYQP5rh0ppV5Gs+uEOfKVOoILb2VxkaorA8iq0Miimg
	 cb3R2PJdch3hdlq32diB/AwG937FTC7AWaa0CbS37JyafOyRVWRCT+plKcrgSyWPiH
	 dvH3BfnCtWFaA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Date: Tue, 02 Sep 2025 12:21:59 +0200
Message-Id: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfFtmgC/3WMQQ6CMBBFr0Jm7Zh2qEBdeQ/jgsAUGrU1LWk0h
 LtbWKmJy/d/3pshcrAc4VjMEDjZaL3LUO4K6MbWDYy2zwwk6CAakmjsE12684SmQ9ka3WgtFTU
 GsvIInP8td75kHm2cfHht9STX9U8oSZRYlkr3rTJKVny6cnB82/swwFpK9GnrH5tQIFUVCaZaU
 Vd/2cuyvAHc7xM65wAAAA==
X-Change-ID: 20250821-fix-nvmet-fc-1af98991428f
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_032218_417277_D6C36D43 
X-CRM114-Status: GOOD (  10.53  )
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

I've added the other two patches I've recenetly send out to this series
for getting blktests with FC more stable. So this series containts all
the latest versions of the patches flying around.

What is missing are the changes for nvme/041. These patches need some
more work and more review.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v3:
- collected tags, updated references
- added https://lore.kernel.org/all/20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org
- added https://lore.kernel.org/all/ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz
- Link to v2: https://patch.msgid.link/20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org

Changes in v2:
- rebased
- added "nvmet-fc: avoid scheduling association deletion twice"
- Link to v1: https://patch.msgid.link/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org

---
Daniel Wagner (4):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fc: avoid scheduling association deletion twice
      nvmet-fcloop: call done callback even when remote port is gone
      nvme-fc: use lock accessing port_state and rport state

 drivers/nvme/host/fc.c       | 10 ++++++++--
 drivers/nvme/target/fc.c     | 35 ++++++++++++++++++-----------------
 drivers/nvme/target/fcloop.c |  8 +++++---
 3 files changed, 31 insertions(+), 22 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250821-fix-nvmet-fc-1af98991428f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


