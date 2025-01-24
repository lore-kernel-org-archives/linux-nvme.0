Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04011C0218B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BG3i/KMpNy3WjfcdQcd84nk2ZYgWsrl+YymbEQrdqO4=; b=PjUTC1o++HGhlifzyF1ye7G8qy
	70GTwlGBzVL6u7dbcMZdLf7ZmpuFAE5LFAoidECduNXm+TYxybRq7N692W/OEbe9hILpdVSv7lTRR
	gV6FdQ+SBvnu2oDn//72vNzm8owXzav4T43ZOVeheWSLkJE54FYxjGZILO5LzDFNpI2IkyiLcZWmb
	J4XPWirTm5oeJwRgsQxGZdfWq3Hoie8cuhLhYYiq4DIGd6i0kUBUVgxvqOOVJXrygQd10/wlNBt8O
	n4i9JMfbW1SitiRxpv9vanou4owqquW/Y9N5XnjE9fsQaKiKNpM7Xw4wNNpe2jqdpJsvHaqQ11M5h
	8xxPKdeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA5-0000000EbK8-2tpZ;
	Fri, 24 Jan 2025 11:47:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbIA3-0000000EbJH-0aVs
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:47:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2CF145C5CFB;
	Fri, 24 Jan 2025 11:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D5BC4CED2;
	Fri, 24 Jan 2025 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737719262;
	bh=OTelJEi3F+ysITL66IBNoiUAygdI+BuLDR599EYmrw4=;
	h=From:To:Cc:Subject:Date:From;
	b=PBHiVOVW7f2I/9aoAfgObVnI3R8TrIB2Acd68s4wAFaZ6UiRM2UeYdj6bVfk/THc9
	 9etGPHbWwEluUAjJMizibOa0tCycfs22gKY8GV+hQISGCdAMvuOaQhgt4sqanc3el+
	 WgrjotljFyxWg9SU4vj1umrZRFpXa9Xu4glwKa68bjpJdYjr5SOFmRTuFez4yTDGX0
	 pxzk1xI/1wgbaw4ltsZFxR6IbmidydsiX6NA0RFbV+wMblkRi0cNUWk7tkZ2WrzGi4
	 9FjY7Oq+g4S9K8eB8sqqbj6DkQ1jofiLI4BWjNw20fizbwCP6lQHxf/vy8VzPXZ8jh
	 g8EOV2JWYVUvw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/2] nvme: restrict authentication to the admin queue
Date: Fri, 24 Jan 2025 12:47:36 +0100
Message-Id: <20250124114738.115882-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_034743_226206_D7F0C30A 
X-CRM114-Status: GOOD (  10.63  )
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

From: Hannes Reinecke <hare@kernel.org>

Hi all,

with secure concatenation the spec got more explicit to state that it
would be perfectly fine to implement authentication on the admin queue only.
But once a partner implemented that he found that re-authentication was
failing as we continue to start authentication on all queues.
So these two patches implement this functionalify, the first one on
the target (to have a testbed to test against), and the second one
to the host to have it fixed.
Patches are on top of my 'secure-concat.v14' branch on kernel.org.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Rebased to nvme-6.14

Hannes Reinecke (2):
  nvmet: Implement 'admin_only' authentication
  nvme: Do not re-authenticate queues with no prior authentication

 drivers/nvme/host/auth.c               | 12 ++++++++++++
 drivers/nvme/target/auth.c             | 11 +++++++----
 drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
 drivers/nvme/target/fabrics-cmd.c      |  4 ++--
 drivers/nvme/target/nvmet.h            |  2 ++
 6 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.35.3


