Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E28C369A4
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qT+qyYQzUw77bm57EfZvxmThbGtniGpKGKLzkLCzv6o=; b=XM+K+dsAfyYYHs
	6BRvaDzU2kK+g+7V0basld2VZkBebWXRYquNTIVka3qVdd5N9RvtFehY7eJfRfchl62Vtq2yoO9Bw
	Zxy6qwRKO1uSBT9VqVlGJca9FXHBA5+kh+ZQZwffZkJwNfutR9aTER9eUaatzSvUkwWJVTyTBnrmG
	feOaU58PTEh4oUSOAvJi7Eb3g/qenLGq5eRYh1ATteZDQBc2MN2Fl5nl07FENPsUsILIvPfmaV2JV
	8VFGQsYPVzA7PkrP78zzoMV6rgVxV3E5W6vCXDh3ap7UNeEkyGG2Oryj6uysILEkvKdt4/eYoG4F5
	yw/8VcORV9LzywlE43lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atf-00000004cOp-3COq;
	Tue, 08 Apr 2025 15:29:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Asz-00000004cFk-0xFZ
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7101768429;
	Tue,  8 Apr 2025 15:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAB0C4CEEA;
	Tue,  8 Apr 2025 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126152;
	bh=aIoMkgJTvkjTjvFmIUdpv6qDltcnB/ZgVTiXC4CU8BE=;
	h=From:Subject:Date:To:Cc:From;
	b=k7cHhRXfqXqM+rOB73brR5i91oVIRlWW/ZrrFuRVZHwqCgHlLyUR+Lg2y7Sel8Boh
	 8ExGdPehfrc4vrVc8uOuZ1+rtjGBUtUu/lgI3nAdONahJHYPYBWnFHDFrVxMQpkNvA
	 L3b4GfBAw+bx9nzmI/LxvQvjUUVTfqtB1aQsr9bVw6GMA9b6w4iQ6nbq8rdjM2hTpY
	 5zQqy+IcFWgXL907IT6r0d1QK+NR3fdSVRUlI8TTi09WaB9DpZEINSntO95ldgVnXp
	 uh4smA/aKy3ARVwOJQKFo/2DNhbNXhdDtye1yvMCM4fg0hwNiu2odxmMMmAKrh6eY3
	 QYK7rNhextjsA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/8] nvmet-fcloop: bunch of fixes and cleanups
Date: Tue, 08 Apr 2025 17:29:02 +0200
Message-Id: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5A9WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3byy3NQS3bTknPz8At2CxKIS3fy8VF3jJDOjVBOL5NREQ2MloN6
 CotS0zAqwudGxtbUAyyitCmcAAAA=
X-Change-ID: 20250408-nvmet-fcloop-part-one-3b62e48cea13
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

The refcount nvmet-fcloop series is getting a bit long [1]. Here are the
various fixes and small cleanups which are independent of the refcount
changes.

Only the first patch is new, the rest has already been revied by
Christoph and Hannes. I've gave this series a good test run and there
shouldn't be any regressions.

I've got a some more simple patches (with reviews) but they will
introduce regressions, because they depend on the refcount feature.

[1] https://lore.kernel.org/all/20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org/

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (8):
      nvmet-fcloop: swap list_add_tail arguments
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

 drivers/nvme/target/fc.c     | 60 ++++++++++++-----------------------
 drivers/nvme/target/fcloop.c | 74 ++++++++++++++++++++++++--------------------
 2 files changed, 60 insertions(+), 74 deletions(-)
---
base-commit: 0514a1379e11c6b8038674f43a478b0857d47a5e
change-id: 20250408-nvmet-fcloop-part-one-3b62e48cea13

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


