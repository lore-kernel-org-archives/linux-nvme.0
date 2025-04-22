Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DE2C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rFQzVogRW4iaBfMLDJ8Jvw/TroBFlFQnoaXjtxcyewA=; b=C2ACOuRckqPuvUfD5rUuyEvGIE
	TIjq9Hl2nmuB6CZjCqlP8TaKyxfUXNnFx1sRiZCp1yNQyK8HsdISlZ13nVvm3IizQRsyf2+ZrqS+K
	hcaSbnDCg5KYKn7/wCjzUxtKOOj95XbSxTqy91nzpu4+qWXbB1325NWirWW5X469P/WHHZquLAwgy
	qPFNeLwAzJX+l7VNBthbRCbBc7keDeS0fSspj3coz3mMOGIXgx6YnH3kdq6EWGH11/8dLA964KesK
	+AgAviWhWpsGedYTCu0pe/casXyMWpD/p8rwcrKs6dYxXfdSl1rFgPk6TfJOz4qoa7Z/Q0q5tQMUo
	DGrI+IEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ar5-00000006knX-1sB9;
	Tue, 22 Apr 2025 10:27:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79jW-00000006WYQ-1lqQ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 09:16:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 09B16A49CED;
	Tue, 22 Apr 2025 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94859C4CEE9;
	Tue, 22 Apr 2025 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313360;
	bh=EQu7Zlpwk3fE6ID3qRjxxpe50oqn/AYSEDC8Dufw9IU=;
	h=From:To:Cc:Subject:Date:From;
	b=keIFYX9nTIG75g5f9OmNbUdtMcgf/ZyMmBT1Gobfa371CdwChcQ+oLWYy3Y+D0Ngj
	 48nGi+n0tT7poXclD6DLDvVz89uZrc6Dj5a74sTevjUci1e3g/7a0Z5jQBO82ad5zt
	 al7GukIYEPI+/6va4uQwjYx9GxaUUQFrT2vz1CJrc0h5YSYNN7YRBHfkMC1mKSOsX2
	 bcCTlLjvIxYpUlrtmdw8W878BhFJBYgbWHYJkDX0Npm6X6vwlHaRIIO5h1Ch/PsubC
	 ByXucQu6xZ/derK95BR3+LVHsGxrW/jo73KmwrNMPU343wvsYlNzr5vBhyjfe3sK+Z
	 RIXUI5hqd+hgw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/2] nvme: restrict authentication to the admin queue
Date: Tue, 22 Apr 2025 11:15:54 +0200
Message-Id: <20250422091556.145494-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_021602_522436_BAFFD2DB 
X-CRM114-Status: GOOD (  11.78  )
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

with secure concatenation the spec got more explicit to state that it
would be perfectly fine to implement authentication on the admin queue only.
But once a partner implemented that he found that re-authentication was
failing as we continue to start authentication on all queues.
So these two patches implement this functionalify, the first one to
modify the target to request authentication on the admin queue only,
and the second one to the host to not start authentication on I/O
queues during re-authentication if it wasn't requested initially.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Rebased to nvme-6.14

Changes to v2:
- Include reviews from Sagi
- Drop the configfs attribute

Hannes Reinecke (2):
  nvmet: Authenticate on admin queue only
  nvme: Do not re-authenticate queues with no prior authentication

 drivers/nvme/host/auth.c          | 30 ++++++++++++++++++++++--------
 drivers/nvme/target/auth.c        |  9 ++++++---
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 3 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.35.3


