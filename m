Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31173C0219D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 00:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xphMH0mOxVBpFy3EXFJJuaVRrUFVEK+9Q0QfUj+nKys=; b=AHJYcGtB7DqIcjXfVdNlsWGAfL
	SLTp/1KZLcuNwNKa0U0T351LxW99a9ya5AxPE3vaRsWaQUCHupckPqJGHWobv/1jjNoI/Ua9lJXXC
	68zUmACqn7HXQOcOqf04SelST1AwYrM8AkSAUuXTjS97q7pUPdQsYIh4hP70xBa9x1IuT6vSH6nvX
	ji0m6u7yheqd0m/xTIiafrfR6U9rjQyoDFP+XKenvSpCO7B+X/Z4pso6rQwbpULXyC4ZsoWJVH+TV
	WfbNDUDa2D/FfzQ/rY43ujUxjV/6Zxyo6XHyhSkxyE/QdZEs8VuJHshL5aBwQTAvblR468/YI6etJ
	gtHeK/aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thHfz-0000000FqBr-3Eu8;
	Mon, 10 Feb 2025 00:29:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thHft-0000000FqAO-2BYp
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 00:29:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9B217A4048C;
	Mon, 10 Feb 2025 00:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684AEC4CEDD;
	Mon, 10 Feb 2025 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739147359;
	bh=5wdK4NiaNjaX8g9gHZvb6d/cbM/HpFa6Ef8K3xlP9+8=;
	h=From:To:Subject:Date:From;
	b=m8RGVmGluUKL+cfzf8U2p/4q+UCMJoR8brOt/DD/ovZEM1Kb52SxizQxlvRrI/4uq
	 67EZaOpVuA4Q1jHZRv4Q11FTTEvUErme6jLAWTFGjvs1CkxrLZDQNpSndPN6ivcB4d
	 NFUCpORBfemFFiWg0KjnGQUrgZuELVuP2gko6sCd2MmqiWHskqg2MV2zGJd8L1duLq
	 m3iXz3TGcBC9C3aYoFDrPaYb7bCzp5feHVygC3ruYQefd0wVj2JC0WfgUWKFHr9D+P
	 6h98HE88mVAUSJYkxkSSM4bHw0Im58jMChrqb9jLWTHgURoBtlInN+w+CUvb3xyVcA
	 i4Q7M4guLYW7w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/3] pci-epf and tcp fixes
Date: Mon, 10 Feb 2025 09:28:12 +0900
Message-ID: <20250210002815.1744205-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_162921_619996_CE02FC1C 
X-CRM114-Status: UNSURE (   8.63  )
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

All,

3 patches in this series to fix a couple of issues with the PCI endpoint
function target driver and a trivial fix for a compilation warning with
the tcp fabrics host driver.

Damien Le Moal (3):
  nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
  nvmet: pci-epf: Do not uselessly write the CSTS register
  nvme: tcp: Fix compilation warning with W=1

 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/pci-epf.c | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.48.1


