Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BA6C5478C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+ofg/rehaEDzJM1n8JLME6IkdcQpYCzMXmkjEJpC5E=; b=GpAoxlabuQ0G/Aa863zWvGjamJ
	EObatB28V+3/+ypfNfoNXTTxzmppc7w35hsRolKt343MgF5fIsT8AjqDFjRcS9C5QdcPZUb6Rrbwy
	s4pzt8+RE2+JBphGSkYJQiVQqa6+L3A2gy00gliiS3G+JNgOTtD3xtWtAXZRRrd+7fcVDFVXAvIr/
	BkPLFOA6mjZmc+zQiCWEVMkpUZgNQrYDh3yagK+jBywJed6FBUo6eBEOkj7/SmblHxPqtfsi9GS8v
	o4yHwQ07HAnOSuip59/dlVtvWc/NTtH/Y/rv+hoJGlH3FmCnmFymWn9u5NqZHM/8kwW5LE29nizDM
	cOe/PI4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg14D-0000000HZec-0sXF;
	Fri, 01 Mar 2024 11:28:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg14A-0000000HZaF-3gSK
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 11:28:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 60F4060FFA;
	Fri,  1 Mar 2024 11:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF7FC433C7;
	Fri,  1 Mar 2024 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292518;
	bh=v5H4lAgRiBMfkPUqc3PvqzSEFetlwVRrv5vScRRvdDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWAQVVtYyh/FFsc33URWOlKqGW0CIYj1lcIawZVZ7zNlCY2E9btsQiWFh4088nKmI
	 XJeVZXXno3I00x7wEwNshBUYRdCLZfDmOM/P5wtYtKlAHFySAa/44PGEvmqFBJUaWC
	 OUyfMeEvGdC1n6qygONWVN0JiMHIOkvUFXgb2+c7d1o9MrtqY1izQr+7D+8ttrTDVg
	 A+BKTiCDAIDkklBsYC8D4RIOmww+jnfksc8yPBPJWbN9U6GTiRd6y6vQYaE57CkIQi
	 KQZxL3eTx9KK/z1lTzCeBr+YCy87dZJbZqiNzLknAMQhq1IRmrNTB1FpbEuT4hgfid
	 41K74kPvbPIXw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] nvmet-loop: do not call nvme_ctrl_put() after nvme_ctrl_uninit()
Date: Fri,  1 Mar 2024 12:28:23 +0100
Message-Id: <20240301112823.132570-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301112823.132570-1-hare@kernel.org>
References: <20240301112823.132570-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_032839_094320_491DDB9E 
X-CRM114-Status: GOOD (  10.19  )
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

nvme_ctrl_uninit() already calls nvme_ctrl_put(), doing it twice
will cause an UAF.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f1d5eee3daec..82db181f0168 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -615,7 +615,6 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	kfree(ctrl->queues);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
 out:
 	if (ret > 0)
 		ret = -EIO;
-- 
2.35.3


