Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CACFC4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fc2EyzO7BPPPf5BE59eBOQEfLrVQtLjD8n1LUwv+7mM=; b=sqkamfCG6C7kkrenOL1G98LsZQ
	+C4DlwMDJOjh6BkU0itZlyQswjRqb5dD9nQYVP23INhChhlzWnNTCQ5XnM1R29oSO4HhA78DxpRCP
	AQSYzenH+0AW8/PHWEWFx3lEm0ivFPcWU2EEJm61JkhHm7qsav+eks3yery1W+wWwIR+3nsCUJZqa
	JZyAI5ANkHcItvPW6Obbcgq0xFso/eqtFKMDvXmRRLMTvrOc766AdMAoSFKG4xkvPewGeId/uDX/4
	k3wEAAns77gCzYJQuQzzJ7ztH2wbdHqBemMFIzoMXQ/MggofBKTIeQ5QXJNd2PjgE3kJEtPhAUWCL
	6J+erEjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEm0-002F0b-2Q;
	Sun, 29 Oct 2023 23:00:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxElx-002EzH-2v
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 23:00:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0641660EDE;
	Sun, 29 Oct 2023 23:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15529C116B9;
	Sun, 29 Oct 2023 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620444;
	bh=H6PU+qPOGDb+0My74bBCeQDqCXkrfPF8NgoiYUtkxUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C31wEaJTHlQfPJ2i7ms4VFhxmTfCumgUVO1BJeGFhHgLfc6yEIJI17QSPf+NdxYE8
	 dnTf/X8iYcFpoK13+AcO98Deyaa6wMXpga22a+IO84TzM63rA1pff2Q8yJxflxX2mV
	 7lWlt9nvfwSPIizzwoTFjeTXiJJL1O3PdxmwlWO3OaGMMkhm38DSWFxf/n+rN+2Gm6
	 vGGDz06xepwWnIRA9lXxc+dYEHuagEDOHv2n2QxKg8F8/yZan28uXrbYh4oTM/2KvM
	 sCk+u7ZjsHe8wb0dUOEjmJZymv3JCpk8H+R6H8ozJlUMg9CSnBHCHoc8OUXbze9DBA
	 lOX85HR0CnRPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	welsh@cassens.com,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 16/16] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date: Sun, 29 Oct 2023 19:00:02 -0400
Message-ID: <20231029230014.792490-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_160045_983729_D0493A41 
X-CRM114-Status: GOOD (  10.04  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c67ebd4eac38..970a1b374a669 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,7 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0


