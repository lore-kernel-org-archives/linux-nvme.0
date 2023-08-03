Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55516C04A6A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=opb3EWEg9MtbrkVHf+1QQhsgcMs2w8JS9edEjhNPcJE=; b=ovtYMqmyaugai2OmQy/xtjc5AH
	hVfpF37DxDNCQyDHgBeynW+JXgedb9RS6HZExe8sGyRtY4rqzQ0pRYE6iM6stK6NGlUb0n4KgWS6c
	ZtiuPN1q10ivvtgD3jtSmEmRYyj2FgTutYMiYirxVcAr+RTiyIlV8RdgfgAKINpKRmsRtIb/T1EVY
	USlrUb4UrSwfwvQV+ViNA+G1FbwDocqtythXyfLA8gsE/E+6cBWs8pXEeaLkrQ8euTQyxShCsTiwa
	u47zuwqzqRqUOqPGj7Wps5Z/Krb+MwA0deYkFSi+ZNLh/48iDTcib0LkNrWtBLYZiwLN/RcKWYzXo
	jmCf2Y5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRXzO-008kUZ-1h;
	Thu, 03 Aug 2023 13:03:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRXzK-008kRG-2d
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 13:03:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D85A361D9B;
	Thu,  3 Aug 2023 13:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65916C433CB;
	Thu,  3 Aug 2023 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067813;
	bh=9Q9y+Y2QzfJdoochpxIlRw8fhM/lfnNz9Cq2beWflSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQgBuT1DPs2ZhqfHz11XVlQVgtgZYOO2SvR6J/Yx7D/mB4eH/wHd4EZRRLV7YXVJV
	 YUeS/1MzNrrI+oAaDb5GTHC+dpv2AEYNCYdNZcNxqpVnxzqK0p2MXVUpCZdx0Vtcfl
	 xynyCNJScw3T6fDa0v43F8YeTiwLKPMlUr9rJtrhALInxWgcs04clR+RjKv95b/3s8
	 hLVhurE/xnYJetvBbq3eYmLGPZH2w3UuRFwWGzvUZoKpwqSEJ0rRIgbv/fn3kUzDxB
	 54RIG8Oi13BR0dMkOiLLqQZ37Uxkx3f5H6P/k27DT2s5lMJfU32RKtwUFmYj5QQ9FP
	 is1p4oZ7c2uxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pankaj Raghav <p.raghav@samsung.com>,
	Clemens Springsguth <cspringsguth@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 7/7] nvme: add BOGUS_NID quirk for Samsung SM953
Date: Thu,  3 Aug 2023 09:03:20 -0400
Message-Id: <20230803130321.641516-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_060334_934319_E9E9DE47 
X-CRM114-Status: GOOD (  11.50  )
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

From: Pankaj Raghav <p.raghav@samsung.com>

[ Upstream commit e5bb0988a5b622f58cc53dbdc044562229284d23 ]

Add the quirk as SM953 is reporting bogus namespace ID.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217593
Reported-by: Clemens Springsguth <cspringsguth@gmail.com>
Tested-by: Clemens Springsguth <cspringsguth@gmail.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf37..8cef5805bfb2f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
-- 
2.40.1


