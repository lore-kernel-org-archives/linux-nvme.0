Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49590C3DA70
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mpsmR9SAHRUsYaPQcE7Ki1Q6JuyMqPpg9lJaBVKzuiE=; b=YIDQcWuOYCOnVKILNsMyynnklz
	6qQ0ddaXc+JMPUps1XhTeh8upRu7PJt1dorxKKaxyV7q5VhH1Q54SuefIMskZav5hsiYjFBFT/I1n
	JpQflv08srKIMGchJM4M+TyP+jSsQODeU0w9wF90MQxvzgV79MSwBhiWSF3phhYb8p0HVo5YEsKN/
	xUrzU/EQa3djYrq+M+gfnHf1cVLY0GGH4H3onOGtlr/V7DhAqxzuFq3wLrP7LYnyKIgOG4rGawTnN
	bCx8fVbjDd8jvl8PNk2wMhvKMAoXwXaXyWlGQpdTI5LkQKOpo0PvtObQnZAfoIqzLUJjhfp/QOp3x
	fU/fRvxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj96-000000026Cq-1Ip9;
	Fri, 19 Jul 2024 08:39:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj91-000000026Bj-0SdA
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6338761C39;
	Fri, 19 Jul 2024 08:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16D9C32782;
	Fri, 19 Jul 2024 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378354;
	bh=rVpYHfKFOfuNIU2VtojeNgUj/ae17BLRbiOU852bNmk=;
	h=From:To:Cc:Subject:Date:From;
	b=fCEfsZK/d7HEOeoOvODGZIe2kZzs/TEFD8f3yfVKmXukZsDEd3+qdJirzfU+RIa71
	 1cjT9FLbF0gh8rBqmXNodsBZFznpffs34sPLfpXHdib2/u5TI2TQDy+HkwmGe2V1Lq
	 u698aJY07r0XkbJBbmi0nObkQHl2xTEJU1TEVkxaoyLsnLK0kysWC+h14r0u8LFYEv
	 9sUdoFvehCy8eTxzWpq27zbT2IVoaNrwrTBDz6ZG6UVjofHez6CWp0+7SdEuTHIh2d
	 RA6FilFloLLeKIWpdPdQniVjdgxunh0BePCVg4rSCIUlx/SQSIRBBP7LUzNyGhzX9z
	 m02kZPCCGXs/w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv7 0/9] nvme: fixes for secure concatenation
Date: Fri, 19 Jul 2024 10:38:52 +0200
Message-Id: <20240719083901.35399-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013915_219230_0E2F8E73 
X-CRM114-Status: GOOD (  11.58  )
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

here's a list of fixes split off from the secure concatenation patchset
as they really are unrelated and just are assorted fixes to get things
rolling.
The most important here is the first patch, which implements TP8018 to
support the 'version 1' format for TLS PSK identifiers. And it also
updates the sysfs interface to allow us to re-construct the nvme-cli
commandline from sysfs attributes.

As usual, comments and reviews are welcome.

Changes to v6:
- Include reviews from Christoph
- Add patch to split off tls attributes into a separate group

Hannes Reinecke (9):
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: check for invalidated or revoked key
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme: split off TLS sysfs attributes into a separate group
  nvme-sysfs: add 'tls_configured_key' sysfs attribute
  nvme-sysfs: add 'tls_keyring' attribute
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice

 drivers/nvme/common/keyring.c   | 58 +++++++++++++++++----
 drivers/nvme/host/core.c        |  1 -
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/sysfs.c       | 90 +++++++++++++++++++++++++--------
 drivers/nvme/host/tcp.c         | 49 +++++++++++++-----
 drivers/nvme/target/admin-cmd.c |  2 -
 drivers/nvme/target/auth.c      | 12 +++++
 include/linux/nvme-keyring.h    |  6 ++-
 9 files changed, 171 insertions(+), 51 deletions(-)

-- 
2.35.3


