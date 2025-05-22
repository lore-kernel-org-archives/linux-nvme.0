Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877A9C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a/9bmY9uuBZ2JTPTJZG3B8bEcW6rLATfuK3J67UY7dg=; b=JkNWPBYa3t9M5LuZj1NpRrQAdQ
	8r8aGU52Kv2DvOMXJE+rlWDwiJF/WpTVSs8ZlKoHDvTujup6yjmTFa7wbVFybaljmJl7kqN4aoO/o
	7QgdLc5dpfnByj9ByNAzzbbZvRE/oUWrOZY7E/XFNTQ5W51o0Pade8vWYmHgtGnfnbxfAeUFPKIjf
	UJRZiHp86EakpLrQioexE8KsaW1GigDpU17+L9OhMQZshfv/Y/m4oJabb4X143qWd7K/IDyrd7bj4
	3glm+ZSzHX8nYgqylEvCC9orSOlQ4MhefI0eLTel4vC+2XDmJ1wXD8Wt1CLqrWxfRD5qVY9w4OA5N
	bQYKLDRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6vG-00000001FdI-3HkI;
	Thu, 22 May 2025 14:29:26 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6jP-00000001EBM-17lR;
	Thu, 22 May 2025 14:17:11 +0000
Date: Thu, 22 May 2025 16:17:08 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme =?utf-8?B?ZtGW?= =?utf-8?Q?x?= for Linux 6.15
Message-ID: <aC8x5G4RUjgbAoAc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0:

  loop: don't require ->write_iter for writable files in loop_configure (2025-05-20 09:16:23 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-22

for you to fetch changes up to 49b9f86a594a5403641e6e60508788a7310fd293:

  nvme: avoid creating multipath sysfs group under namespace path devices (2025-05-21 14:55:46 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - do not create the newly added multipath sysfs group for
   non-multipath nodes (Nilay Shroff)

----------------------------------------------------------------
Nilay Shroff (1):
      nvme: avoid creating multipath sysfs group under namespace path devices

 drivers/nvme/host/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

