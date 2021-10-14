Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:45:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89C161156
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B89C161156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NgYvhR7S4KVA7iiVrv/0A5E92bPDV+lv8gwWp02SxFs=; b=HFmva2n1wb5NbCqEucxE4T6S/Q
	lvL8AZ+2f9zf0hvyjWpbXcJRxrRBd1+Yg/Da4wSNurMRGBVv2hRnH6az++8vVg3NlSvZ/JP1JRXmD
	FrKMrzDFfzJw94BZlUDe87z92aVJrP2cpiKquHln8rNBXqdBNgFJufFOPBLym+4LXz9w6Ua73LfeE
	abssG/K1IZZqbqT1eji7ya+YRv/TxUj65Lfg0M0aiZB2kftkPhrDsFdZtYDJ6swX924ngTE8+D4W9
	5Hwljaxtxk9BV5Fk5lTCpCn9TCOX7L6kW3G6rxkhsLp7HKUpzcO+0n9xiOCuKV980G34Vt1AdW+dr
	XvD3hmXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb3ra-003smU-Gk; Thu, 14 Oct 2021 16:45:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb3rX-003sl2-GW
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 16:45:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8213F611AE;
 Thu, 14 Oct 2021 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634229947;
 bh=W5mcPjtUtIxcpw9d6WI4dn3rRVR7x8jLMZWRdSTwqeM=;
 h=From:To:Cc:Subject:Date:From;
 b=DTCfpII0hKuB+hZNXTIqHsh3kFJ59ABBNW1vwJjesxGqp3gjFn35KbabcpMHtmabj
 6R3Bp2mbMhoVrMybUFIRG2bqVx9xdh9n3Vl6ThGQwsOYD4/GX8NiI3Vs5YuB7oicao
 J5chZ7N9T1CGiKVKv9w/jVm2XNvPhwk33vPOCHetPB5760HInXxVk+tEzabuBm3xjt
 GwJK/vM2FCMfsqYlamcEgoe3cxoR2Lad6aFwFLv3UJ5fJiE7knOUhX3IkXSJvC9wfE
 oABVGpRkVaoBSLbRnrbw9nkE19jA3P+OBC8wXyTEHqz3x6p4Sw4lricJOfJ8GA1uq2
 O6iZWYknSFKjw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: John Levon <levon@movementarian.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] nvme shadow doorbel buf fixes
Date: Thu, 14 Oct 2021 09:45:41 -0700
Message-Id: <20211014164543.1821327-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_094547_585041_AA56FFC1 
X-CRM114-Status: UNSURE (   4.06  )
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

This is v2 from an older patch series posted here:

  https://lore.kernel.org/linux-nvme/20200427235243.2268765-1-kbusch@kernel.org/

Changes since v1:

  Added comments explaining patch 1

  Dropped patch 3 for now, which was just a performance optimization

  Merged up for current master

Keith Busch (2):
  nvme-pci: clear shadow doorbell memory on resets
  nvme-pci: remove cached shadow doorbell offsets

 drivers/nvme/host/pci.c | 109 ++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 60 deletions(-)

-- 
2.25.4


