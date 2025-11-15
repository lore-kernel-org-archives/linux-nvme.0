Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E22CEB2C6
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ful7OavqXs4vEo8C3CT1+yRrnGUYUw71eREHASlP94g=; b=hz/RpWcqsLVqH7a2SVKdrrZuB7
	1EsTpAIq0qSjmznL7YiXibk0SpUtML1COdSKlTq2f9rWu7WM2M5Xl3hBSNcasMCnDvArFu0nU3rj9
	CXqM8W0uYyO4piaaxmhOQuafSce8KX2Bn2qzjRoUGJ37e84jJb86VH6gwZmw18uKqbrW14YnoJYSR
	V1zlBgbQYVYEZVVuGZXqpboFx3HCbidz/FJJAZ9DbLSocA/zsDUcL5m68AZt2KCZgpiYAQiIE6L7g
	qTB9JymSMC37bH5OAOg5wbB8L//Puf7trP+MzmXNF2qrEooHg4lqnMYySLuPm18tXRUlB8Fx9MC56
	X0ppRA8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKJ3E-0000000Duia-42FA;
	Sat, 15 Nov 2025 16:23:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKJ3A-0000000DuiS-1WZX
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 16:22:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6651E60008;
	Sat, 15 Nov 2025 16:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA96C116D0;
	Sat, 15 Nov 2025 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763223775;
	bh=dkf+PPZ9lvXL5kEc6dGDQYL+MKICC5QBe4nJe2bEqDk=;
	h=From:To:Cc:Subject:Date:From;
	b=O5wG0rSWt91XzQaEbMhM/t8nd9pBoUJ+ph6daIuK7cmHYOux8HGw+taxO5cQgVbAo
	 iHMe7Ggi1y5j0xG6X8GLskNweg4z0Kq45Mrahj7NDJQ3N2whucLl7/sydbazesGhB9
	 6TVI/hR6nichbr7lCc3uLqS7uFQPRC2rP3vaJGnovUQL08v6ZdC5GccobsliM/io2G
	 xoMMl1RfdrktcSfPI8WL6MmkmVlMAg8Lv6+Vb3Uwyd2Y88t3ggGlzB8/+MlsvtSwFj
	 4f8sTMf8TYf0jzEG+auT9xK0yzxX9sSu/moi9vRx6kqOt0+W/oRu/k6lw+UnppaNh7
	 jXNScmpIhIYpQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] block: Generalize physical entry definition
Date: Sat, 15 Nov 2025 18:22:44 +0200
Message-ID: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251030-nvme-phys-types-988893249454
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: quoted-printable
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

The block layer code is declared "struct phys_vec" entry which describes=0D
contiguous chunk of physical memory. That definition is useful for all=0D
possible users of DMA physical address-based API.=0D
=0D
This series changes NVMe code to support larger chunks of memory by changin=
g=0D
length field from u32 to be size_t, which will be u64 on 64-bits platforms,=
=0D
and promotes "struct phys_vec" to general place.=0D
=0D
---=0D
Leon Romanovsky (2):=0D
      nvme-pci: Use size_t for length fields to handle larger sizes=0D
      types: move phys_vec definition to common header=0D
=0D
 block/blk-mq-dma.c      | 17 ++++++++---------=0D
 drivers/nvme/host/pci.c |  4 ++--=0D
 include/linux/types.h   |  5 +++++=0D
 3 files changed, 15 insertions(+), 11 deletions(-)=0D
---=0D
base-commit: 79bd8c9814a273fa7ba43399e1c07adec3fc95db=0D
change-id: 20251030-nvme-phys-types-988893249454=0D

