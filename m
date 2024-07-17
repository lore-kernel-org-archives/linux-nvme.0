Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB5AC3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g1WtYpoCfFt7Zpywu1i00I1nsakY97axtpXa+Zj2ljk=; b=gEN4Qw4Hci+3xHQW2c5bkkX1q7
	79yXSWwE8NtcEOs38ylW4LnNx3S6FR3rzj/7qlbmLA2jdNB/zET4lJ7rxipq9jcufCmmW00Hb7Zf8
	Vtwok47Uxxe/LfARdEb/b2+kJB+lGwmKGiX2ttbPV0mTQUIH27/2HSxeKsgl/vY5G4A7iMXHp36YU
	21FAlL4uHhzxy0NsVInqCumOgRM850NxoOXTWaJVKsB4V0aXZTK1zvZ+o3HDPOdN++7Opk9XoOYkR
	r9/ldhOlcwdGd+DKOFX6nTwyqeICyTp8Q/w+GjBgmBefNGoBObdghY7e6eRHI/HPlOAc2lZ53SQMJ
	dvWL+WrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rp-0000000DYl6-2N28;
	Wed, 17 Jul 2024 11:03:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU2Rj-0000000DYjw-0gMZ
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 11:03:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9046E60FA4;
	Wed, 17 Jul 2024 11:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC26C32782;
	Wed, 17 Jul 2024 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721214222;
	bh=rixh6yPgQAl1HvjAtyPkKDDAAw67ClwTmKHIU6/g/Mk=;
	h=From:To:Cc:Subject:Date:From;
	b=EHx6m2ZLjgmd8GXpbn/+GVk5zPzg1zy7/eE2QUXCXPGeZ2vuhjIPKESAXXT4sTTnB
	 VME6U1E2Pv5jrSj4GiRX+vd3ruXftTvpns814tzcn4eBeZkwJ4IGyMCMrAsNaaE/2P
	 NuiKKkW2few1gYdBDKoUoZtJmiHsSBCZkPeO1j4iv0yCtTWM55Y+gQbjseWClKzbsp
	 s576DZsQ8UZEPPup6fuHZT7DscU6MbCDZ4+9uwiPH74eQaa1TJiVrNex2D9YMNt3Br
	 JrpOYFyqqtdjANoqL+uUpKreC/X9fx80MqgxWwR4pAE6kS1/Qe54saEi2nwb5BXdT5
	 Jxzmz96s7lqZw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] nvme: restrict authentication to the admin queue
Date: Wed, 17 Jul 2024 13:03:36 +0200
Message-Id: <20240717110338.27332-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_040343_289449_7BF63E27 
X-CRM114-Status: UNSURE (   8.85  )
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

Hi all,

it might be an idea to restrict authentication to the admin queue only,
as authentication on I/O queues brings only so much additional benefit,
and the entire authentication is noticeably faster.
This patchsets enables the host to handle this situation, and adds a
new configfs entry 'dhchap_admin_only' for the target to enable this
behaviour.
Patches are on top of my 'secure-concat.v5' branch on kernel.org.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: Do not re-authenticate queues with no prior authentication
  nvmet: Implement 'admin_only' authentication

 drivers/nvme/host/auth.c               | 17 ++++++++++++++++-
 drivers/nvme/target/auth.c             | 11 +++++++----
 drivers/nvme/target/configfs.c         | 24 ++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd-auth.c |  7 +++++++
 drivers/nvme/target/fabrics-cmd.c      |  7 +++++--
 drivers/nvme/target/nvmet.h            |  2 ++
 6 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.35.3


