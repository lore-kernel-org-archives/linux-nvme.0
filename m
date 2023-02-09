Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E13C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTrSmS6CLmUYJ41jMvxZB1qw+/hHlSMu91EHIE3wSTI=; b=genmRSHR+b3s1e6Y4VC5RTkSMa
	ZByoJ3FZvWh64VtExX4eZpSNKp8gtlcwk1Zqck5VY3ejSP5Nj1UEq8acRXs5je8ia2o+rwE86NBoR
	f59D5DCI5vf6XrZGHs+1yw+PY44wphLbC8teGhyaKsHspiYmYEUcevVLR55JixUnGDmG5mItfQF2X
	DE5mPjtrMkS1HLaTZnjTtjPfJ+pv2PBuCrBiDvJZNy05bI+BusKZ4OxwJNvfNQki8/x/VPYwBUM2u
	zuUq4GNlhHRG5/amc9DdAHffPsZntRj7ew6T+Ht34y61g9pIL9faqpV+2NxtgQE5qaibRjdz7ULfS
	BuPPWBBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4vl-001Ehd-57; Thu, 09 Feb 2023 11:17:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4v2-001EGD-7f
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:16:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BF909B82107;
	Thu,  9 Feb 2023 11:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A36C433EF;
	Thu,  9 Feb 2023 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941405;
	bh=Rq4n8uSGL6HKdp05k/r4meCtbqJ+11BI6aGjnZHod8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaFT2laTsXTXrtPVxVJCIV09ua7kHT4HU2oaNDUGnPjB5BeNUDYJgRSDsNCE3om3Y
	 rM80GyW6VLe4Jkx53Qcx5wmgux2r7Bl+XCsd2Qz/S9OwNyrr3bWt03gyRB5uwz4WCf
	 37UX67FZ5FKHmkIFPWpYrplN+2abgdAMY4h+vt461rCrbaTkkl29T/b0tN3b0K2i5l
	 BmCAljedzKsP2k36dNpXilZl88MOeR1xuDxX5PE9XUBiV0iQJcVqRoNxkv9T/fFa5K
	 LsdYxvSyIugkf3ULwvCZJlCtnyrbjSwpL6sMdiz0ipUL0YjGv3gb8E+IIvqqLy2zeU
	 Ub8pPdRZJt1zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 28/38] nvme: clear the request_queue pointers on failure in nvme_alloc_io_tag_set
Date: Thu,  9 Feb 2023 06:14:47 -0500
Message-Id: <20230209111459.1891941-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111459.1891941-1-sashal@kernel.org>
References: <20230209111459.1891941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_031648_459795_5A6BFCCB 
X-CRM114-Status: GOOD (  11.11  )
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

[ Upstream commit 6fbf13c0e24fd86ab2e4477cd8484a485b687421 ]

In nvme_alloc_io_tag_set(), the connect_q pointer should be set to NULL
in case of error to avoid potential invalid pointer dereferences.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e189ce17deb3e..5acc9ae225df3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4933,6 +4933,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 out_free_tag_set:
 	blk_mq_free_tag_set(set);
+	ctrl->connect_q = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
-- 
2.39.0


