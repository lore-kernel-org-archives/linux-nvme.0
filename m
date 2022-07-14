Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A3EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 04:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xeb59IxFfYoszyxhu/nC8IimB5YJWBZ1AEnrzd177E4=; b=qXmfDBmeI8bx8gCjiVHASP/5Xy
	ywUDNMAEW7Ff7VNLmFjuVamPEjvv5brnBJuwGCaqulIDp7ElcfkbYfLh3xih5pv69QT0Xbuzb5uOs
	nADlmXALHIhOmmwYmV5IdzeV7x/eDniej2Eer3qlkG8+aGa7i+0zF0y8iT0ghX+pm3EgRbZhemawx
	RtQYUEvQvnn+w7lcIOdOB5IETt+hZ1xK7GhZEXaTbWNZk8TKBkYtbtx6QApYXFc/K2A+oSj2tA+Vc
	kthzQ8N40FCgn7mjEaq55DGIzXuaDjZ3lFt3yRFKhxBg3Wmy7PZSk5U11fVseOul/toTSv0SQyZGG
	nBgYLmgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqwv-00AsBp-EU; Thu, 14 Jul 2022 04:59:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqwZ-00Arxx-Cy
	for linux-nvme@bombadil.infradead.org; Thu, 14 Jul 2022 04:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Xeb59IxFfYoszyxhu/nC8IimB5YJWBZ1AEnrzd177E4=; b=fDQHrRFCAqxLU/nOP/aoWQkIwa
	af2/eN5o6nEF93p001R7K4QqNpsVmeYAFjFMkN6+fpaRl6202rxUZd410n582+zUZnMh0UvyGzMDo
	l6VT0JioZ3bHcPpwd8nTJXa+sf98gcdh4HsN63nzhWdZtYJNRueTQTu7nYDtPWzpn3Uyd7laOKcop
	aw0s1XzCa6QLmS7PZ5mA9whIzygr6IfocLI4Wh8kcOOu32mOa26JMk+0IFMvz0mLQ2zNur1y0dvkb
	xQsI3jSgDK/AlL+c9mgRWjLlhKSgA9TglZO1rH0QAyiwELt580Vyiii5KCdGbulV292iHL75rEo3D
	0xrWsbsQ==;
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqQ2-003kGi-1n
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 04:25:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D564AB8237A;
	Thu, 14 Jul 2022 04:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7773FC341CD;
	Thu, 14 Jul 2022 04:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657772737;
	bh=BmG0AIFw+eljF42VL9fIOkV9TDiDb49cHlNYb29j45k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAS7pkcIdMqgr6ECWGRJxbQE8E2Q5wEtMqr+KLT3PZJXqRtuzdb4VALna0alJR1Xx
	 Z0G8Pmb6SKbQVm3PzFBqRbGIzJ9tSMlSMfuMiPv4RJdWiK/lT+yev5aIwKgnBuXHxl
	 CpHnvpJF5I+L9zEfYvNhHwKvLu1514LgkG9FQSakcn/cpBvep2etyzv/T3KjyJTZFn
	 rHMXB1skNhbbv1/KBaoxLzLbJQVB2AWZZ6hh+v8DBvL+V/zbXLt96xb58LMUZIaj6R
	 x59gwO1NbceBVg7A2vfIWI/PYYOwcFYXRM1wMwu4iIKymG4TUsKoHF5eMPI0fJ/5KN
	 /iaXzBfybFmLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Chris Egolf <cegolf@ugholf.net>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 27/28] nvme-pci: phison e16 has bogus namespace ids
Date: Thu, 14 Jul 2022 00:24:28 -0400
Message-Id: <20220714042429.281816-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042429.281816-1-sashal@kernel.org>
References: <20220714042429.281816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_052542_826824_AC1FA41F 
X-CRM114-Status: GOOD (  12.31  )
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

[ Upstream commit 73029c9b23cf1213e5f54c2b59efce08665199e7 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Reported-by: Chris Egolf <cegolf@ugholf.net>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c3db9f12dac3..d820131d39b2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3337,7 +3337,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.35.1


