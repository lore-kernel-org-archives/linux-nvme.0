Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26214C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOOVllnv/xhIxYO3kYM0wSDy+V/x9nOUIUz9IG1QhXo=; b=vqZ8KQfuXjsc/DvsdNrk6TEZkf
	dg9T9yK/O6o2RfPCCDv1wf4xDFGshH7h3W+2bp5mSjEXMwQnhuB5Nw/9jh8xxlfy2PooI4BLwWd7r
	tUnh8CqxtfEl57Mk5as4V5lbcv8yaPYyJya6SldQcCTyCMbbuvbmMYLAXIK4n9FHHMDGlZMJyWQWl
	Pe6T3F3gtAPzRnCrdD7TqAc76e3pnUgEg0fOP0X36cxx8b2DmDwoV0t5U6sirYF4WoqK4NOGyYuGM
	4WXfWcxs4za8tjJe+LHeRRF6l2vBUHl6ZkWE1Y57REdV3yJQs0dVPRdx+nUhF0zQrdxsE3nmSLugw
	30cSnJnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4Ul-005hwd-24; Tue, 30 Nov 2021 14:52:35 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4RN-005gG0-8z
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:49:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EB1E6B81A2C;
 Tue, 30 Nov 2021 14:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9B9C53FCF;
 Tue, 30 Nov 2021 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283742;
 bh=Ku7nmQKR6nKu9eyH26k6lOkXuHGUGiDdtGKdJXVxUuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=otMl+3ySrYcRYTFd0nyWylUWGcXICbxodHn9CZd7pZdGMd0TLY9QQhfumzl3v6UGI
 /cd/OKfrSHNbLRAI1C+Sw1xdzP0TeDTcEia3z5oqgs0IfoXf9hwg12NDcVa2EdV4TY
 ik5/CT2SOf3sUw37tTmt1pCqRYoBTKKl4BKTidVTBDd7bjA1JP6Z8+M5vldIoL/ox2
 gjpfWkb8c9TZwLoh0BLalEXqKY0r11NaBveGTPz4NC8zF+Ljtz6PbSIB93o+zI1rPS
 P0d7Gg9QBZ3RGXIIns4tpPeFZQGhZ5CONxVKyawsd4BRG3dta/St7mOyRHl/dkhzhj
 /Pahn0nYq9s6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 46/68] nvme-fabrics: ignore invalid
 fast_io_fail_tmo values
Date: Tue, 30 Nov 2021 09:46:42 -0500
Message-Id: <20211130144707.944580-46-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_064905_495861_B302476F 
X-CRM114-Status: GOOD (  11.72  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 8e8aaf512a91ae44d40647a88b51326c7b0a70a8 ]

Valid fast_io_fail_tmo values are integers >= 0 or -1 (disabled).
Prevent userspace from setting arbitrary negative values.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567f..fb5cc5d14899d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -697,6 +697,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			if (token >= 0)
 				pr_warn("I/O fail on reconnect controller after %d sec\n",
 					token);
+			else
+				token = -1;
+
 			opts->fast_io_fail_tmo = token;
 			break;
 		case NVMF_OPT_HOSTNQN:
-- 
2.33.0


