Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC610CD4F54
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OQ1Fw3LDkzrbN0yVIGv1Dqhnh6+h8zc9ZIloINx7Ai4=; b=KK+oqBDc/M8c1TKPB2uIr5I7nj
	/YL5hRmjbIfKyP4KYX2euDqqqedQ/VQN6/blflIVxKJz5ZdBn2aQn8HJ/VxQSwvlpKR0GkwKjloes
	+WuDpga2qKyBCOoEBIjh+felUiL7h7ZvakEyi/bcZymfKibowNGE3fK+BiI0gNGAhBx+8JQAhafyi
	uywoAbP1gjsSwlAHJa3MUkJK1+zuGLYH+lG0Z7cTB9mCLc7OGUG+8vLu0te2Dmwg9iNbaR0Nbc5kB
	+L3HG3Qdxv5yxb0uqAGFcEDagY+dlT2stL8ZDODl0yS02OcVUYAm0i81IbLKDazzHT7NfLz8QCYeI
	PwVBS8YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDfW-00000000HcM-3h3I;
	Tue, 19 May 2026 06:11:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDfV-00000000Hc5-2st7
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:11:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2749D60052;
	Tue, 19 May 2026 06:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C8C2BCB3;
	Tue, 19 May 2026 06:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171064;
	bh=AEi2nVmhI7gdfoRwA3I1eNTxCjd+JXAAmeYjgjfRdpU=;
	h=From:To:Cc:Subject:Date:From;
	b=sKC5uNBN+oe4eyeNeJCj18JnuSadl8rxMSHNPs/5cIA8QcxIbicOHFbamlh8+Jfvj
	 qqpMDgKNQIRVPpJsn8UESazNDsIAB6gtkFZtbm+lNSe9Eif55KtgCcb8WdoEVjwH+5
	 Q4hwbo1TxhRnjViPcDmmm8rql2E4zkorHrSSINdXejvD+0QJMi18kG6vWUUkbDzowx
	 GvGN4yw/aEpVrcm6VOzlUyREwDbpQDaung/TyrYBal8FUls5eQNnxXtYFUjJ2F7Ybu
	 jUIWrvn6IZqsSoAAjL5VocIFuBT55Wi0dR7fJdzi7a84YP6PoHYn/mAH850tgVeT5I
	 AnagzsgaOdlfA==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet-tcp: two small fixes
Date: Tue, 19 May 2026 14:10:19 +0800
Message-ID: <cover.1779170418.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

During the development of NVMe over MPTCP, two small issues were found
in the nvmet-tcp driver. Fix them first.

Geliang Tang (2):
  nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
  nvmet-tcp: remove duplicate cancel_work_sync in release_queue_work

 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0


