Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935C2C27C6E
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lHmWRpgq12tfe4dSoLspKBSiOYOLeC37DT6FtJrSrZE=; b=3hvGd2d9r1aNvHTkFGP05CNW50
	AVRCyM2aQm9R2AfAHudP6+4dKMCeNIQmlaxXUvGE5W6fPCECTGmDkDcjtgiI4nJRv52x4wNlX54a+
	iF2750kGksnSFMxqR/sy6V8fkYeny/htD9h47DZUyoEkoCMvZZIcCSPa/X5jdApiyv4QFp59UGFLk
	AgirGysRwhRVkNakwQGKPE05Wz22heFfQhbbcpfoa54YM3VUXwiDAymXxxHiVct7aO9HHLQPyDCeM
	HEUaQLodMdOWjNPpDIn+6YJOMMZDlZSE71nmxtb8lkMZ5rufgGB67S0XhzURHD3YKZuR+ki5HNE0F
	5CnHkewA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mH-00000009e2J-1oyd;
	Mon, 17 Jun 2024 07:27:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mF-00000009e0r-0Wxd
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 07:27:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 167F9CE0F15;
	Mon, 17 Jun 2024 07:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D3DC2BD10;
	Mon, 17 Jun 2024 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718609259;
	bh=iObgXdZG+1UZidxB+IijwCrFvSRy+iTi88D1m9/FC58=;
	h=From:To:Cc:Subject:Date:From;
	b=cDZ516t9tsk6OiHNNY2NUSPOMKBbtZqSa1AUBKdKhh1+nWZvZnFqmYjqiDpbrLFAx
	 RPZaT8+ZLQY1wImwSgER6PBwnmMdxpxHAhRTbWlsf8gnpx0qHnv5f17bMi1s2aEZGV
	 /W7FQuFekG1TuCjV0TwsDtV+a8zAQVOQp0WxAgSxFaBzitZtQoLT187B9rXeSqNaAA
	 lkzrR6v5iwGGhTlgO7HphP5RY4HIdYdVpVouZJRR3ME0WJOQDtOX+HAsjBtUEhJn2B
	 RYhZEWai1s5t+LYaG2C0Un5tW1Q5/nvB36L3kaDh2qttQtGB8N9xtLDebmpTCAxxPl
	 LA8qA5Ib5N8kA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/3] nvmet: fixup nvmetcli save/restore
Date: Mon, 17 Jun 2024 09:27:25 +0200
Message-Id: <20240617072728.134728-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_002743_363549_74FB3D93 
X-CRM114-Status: UNSURE (   7.85  )
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

I noticed that there are some small issues during nvmetcli
save and restore. This patchset fixes them up.

Hannes Reinecke (3):
  nvmet: do not return 'reserved' for empty TSAS values
  nvme: fixup comment for nvme RDMA Provider Type
  nvmet: make 'tsas' attribute idempotent for RDMA

 drivers/nvme/target/configfs.c | 41 +++++++++++++++++++++++++---------
 include/linux/nvme.h           |  6 +++--
 2 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.35.3


