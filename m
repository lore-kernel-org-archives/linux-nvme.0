Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60096CD3424
	for <linux-nvme@archiver.kernel.org>; Sun,  3 May 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mzaWqHq7+PTBz7tIumUUKb9qiEb96ClwN+6v3qJcSgs=; b=DDc/i2EM0Vt2/ACCBaymRN7xtn
	nD1qm62hfuQroHRD24S9/GAzEL4G4qLO1ENjGZGt86xLj9zP5a/11OzdsO2VaJzIxCLrKFvHxsQBu
	Rfu8zrlcH6+xtptVZd+ocjfQtraHfsBzaXgYEiCfqZVcdzeIvoTEurGVrj1CygrgtCvsSgcFRbtL9
	SkHUtHEdRgitPSyKeryLsetAcrxCmez19OlD5aoSMmcLFUuPU8Pb+qp6BYZfQg7Fs7xBMAdu3ziB6
	I3oWvBxSRV2oZJaYanODytng/q0eOLZmpIoH1c+vtP6wBccg5PwjeNjMb3WiJBGX3g0Po0KFEioJt
	RvyU974Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJd28-0000000BdaY-2f2l;
	Sun, 03 May 2026 20:03:20 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJd25-0000000BdZx-2S2n
	for linux-nvme@lists.infradead.org;
	Sun, 03 May 2026 20:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1777838581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GxGxr9OhVOb/5NWs4nGOD3+qy3bRaE9+X7htV7HkvxTRAaxyiQuOdpzAsYJ2NNqVDu
    vukRn0czcY7avjMqYPGlYRtPv2mxOtar1ZMu2a4+oHoiT1+qL9Nin712YeKZpvFGGdjP
    bpjJrrxkwUiHIeeRCAS2I+EJUhXAwZUD5iY1/ozzp7GQT6BYK3vh52sMsiwAwHSVBWzI
    d/WSpld2pMydBBh4g7URj/UikZUEjDxHswceudZbKrvCPW7fTEmz/y7+7cAUvyBo3efx
    GKXOAV1U/mwUNp0eAOZdAtIx6Zd7b8hCaWWUEJmJb1QNQ6hGXve1bJQORiWy6hD2VT7N
    zW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777838581;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mzaWqHq7+PTBz7tIumUUKb9qiEb96ClwN+6v3qJcSgs=;
    b=HoowDOWmmvncs+L/BYRiqd/sF6D2R10Zm1sGBZ3O8hwpi6hhRSqmjZEAInIQ3CYdlP
    u7tZMKnbTTNUK8GVa/mEGdrRgAgKAC7Un5rlJlLuYn6/2V8fB9kSJnswFCoGnhn8pICA
    kqr/diRKYEJ1yJfll2pPVdYAgD/9+UTZ8DUnT0zAv0tIETF4oE04ZEvqNGTUUCBx5Uij
    kaIEqmJuqA/a98FEuc90Wm/FrSGswfmwlzeOUYOVOeXnybxzqvB19rOpUcnzAdRmoVgU
    cpTlzS3PcXp4JPUzJtDZlaELmTBeuPPD7StqAIiXVDApKbz2TtvuLha6p7ymnpkgx8AC
    Oeng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777838581;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mzaWqHq7+PTBz7tIumUUKb9qiEb96ClwN+6v3qJcSgs=;
    b=nGg20asYnfAUcJibRU0aZl4mNlX4+HlS+8Q5j/s+7mpC/PZzS9eSBDPRlCTv3ehMa4
    gWL/DDIRroEEX4CdDKxw/3T9t4KDVu6xNq8DdN18pjx/baDewPv69yNsT0mqR7E+b4i9
    wyCVQ0VywVDUyNiO0pPBK0YnZ1n7jh1ElTQjaY96FvfFsEuBYe1cuLuupBpcSZnBUSNn
    QqWI7pomfXB8xqQyZddQg9R9ey7fJw1QuP6KQy0kVGdH6NppEbyws+ANBGvIGIkGc7mV
    tCQHbdd3kZZgoP0BAIgR4y/FoUfZdj0qMrIbnW0dQYE8Q9VOZQNMCryLXeMh5x5owjt8
    E7lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777838581;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mzaWqHq7+PTBz7tIumUUKb9qiEb96ClwN+6v3qJcSgs=;
    b=ONtYeu8Lqhv72SO9PX8dgTZ24EEtza6ZVUrYKuIytBq3HFEFB5+NrxjYOEDsSsXlqJ
    qtOJXsSve3hzq/QhIgCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2JeaOom9QllqptkjU05r"
Received: from Munilab01-lab..
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id z79345243K304GW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 3 May 2026 22:03:00 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH] nvme: skip I/O Command Set specific Identify Controller on pre-2.0 devices
Date: Sun,  3 May 2026 22:02:43 +0200
Message-Id: <20260503200243.2968366-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260503_130317_921210_A72D3471 
X-CRM114-Status: GOOD (  11.52  )
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

From: Bean Huo <beanhuo@micron.com>

The I/O Command Set specific Identify Controller (CNS 06h) is only
defined in NVMe 2.0 and later. Pre-2.0 controllers return an Invalid
Field error for this command, which shows up as noise in the NVMe
error log visible via nvme-cli. Avoid sending a command that is
guaranteed to fail by checking the controller version upfront.

Note that the analogous CNS 05h (I/O Command Set specific Identify
Namespace) is intentionally not gated on version, as commit 823340b7e877
("nvme: always issue I/O Command Set specific Identify Namespace")
allows pre-2.0 controllers to optionally implement it with graceful
error handling.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..71eeab8f661a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3400,7 +3400,13 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
+	/*
+	 * I/O Command Set specific Identify Controller (CNS 06h) is only
+	 * defined in NVMe 2.0 and later. Sending it to pre-2.0 controllers
+	 * results in an Invalid Field error from the device.
+	 */
 	if (!nvme_is_io_ctrl(ctrl) ||
+	    ctrl->vs < NVME_VS(2, 0, 0) ||
 	    !nvme_id_cns_ok(ctrl, NVME_ID_CNS_CS_CTRL) ||
 	    test_bit(NVME_CTRL_SKIP_ID_CNS_CS, &ctrl->flags))
 		return 0;
-- 
2.34.1


