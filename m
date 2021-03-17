Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2456C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:02:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6A264F97
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6A264F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wYrq77giIf4I9gC5fDAPFvRKLhSDmy6xjAurUPQOjyU=; b=CSLR3oBTXCjRuu/mlvqqJyZ2R
	cyYSctGDsWAarZ3/lYpSE4Z2fONWo4Dg6uwRAKyXl2dwDr5kcKQTl4VYcg258iUhh44K0D9I15cAZ
	hhPZKrqtKzf80620aY0JhnRikkFj4hMZO8HseJI+IFeggqsggkUflSH5mrMkhitvirsDPYVPF41GI
	wnFSn848E1UKrmOZCoEbW6ZxadO/EP0GGFe0djCGx25C6BRZN5PDO0lDKYPv3vyML+hEBMW4xcdVu
	zva+Rf+Cv8zHB/mzslE4HBVPDfAB/x1DjcwhA6MBvsTDUfZT3VivQHXLZWHD1c/zSAJuASurIYCI1
	9omdPRo7Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKa1-0028t9-Ne; Wed, 17 Mar 2021 01:02:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKVX-0027JA-7c
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:57:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 799D664FA8;
 Wed, 17 Mar 2021 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942673;
 bh=aozgTVH3HTG6JxHeF/viQWKnhix4qY/2AgcsbmddK/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q4HJg7iW3pV+MJeviHUGd9RXP2IXoXlvSkhBuaU7fnVaebIiwE/IJi/KXKswU3779
 F+BDAfhs3cjTxC+eRryE89XKcu4BolEmo0JG5EIyG4udY46sB+6YKI3ro4LIt/lTvS
 CxVCtqOnvTe8VEUiQDe5xJ2Wgohcz0xyqx9PN3ld4S90I6P4n3NRg2VVajbExuSenz
 ZBGSym99daVnqGl/FZ08/DHKDrqOeNJGzqNb5VLJHBf6zYCXc2O3Lb6VMzjPCdrGJf
 cQCo3Coov9zo6MMSedUwQq6s4hagRY155XKHOPfFgMySsGLFmoomiJkpiYQNt6eKZ/
 qIPIgaVMHKq0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lv Yunlong <lyl2019@mail.ustc.edu.cn>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 48/54] nvme-rdma: Fix a use after free in
 nvmet_rdma_write_data_done
Date: Tue, 16 Mar 2021 20:56:47 -0400
Message-Id: <20210317005654.724862-48-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005654.724862-1-sashal@kernel.org>
References: <20210317005654.724862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005755_885193_711A8B8E 
X-CRM114-Status: UNSURE (   9.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

[ Upstream commit abec6561fc4e0fbb19591a0b35676d8c783b5493 ]

In nvmet_rdma_write_data_done, rsp is recoverd by wc->wr_cqe and freed by
nvmet_rdma_release_rsp(). But after that, pr_info() used the freed
chunk's member object and could leak the freed chunk address with
wc->wr_cqe by computing the offset.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/rdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 06b6b742bb21..6c1f3ab7649c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -802,9 +802,8 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvmet_req_uninit(&rsp->req);
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
-			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
-				wc->wr_cqe, ib_wc_status_msg(wc->status),
-				wc->status);
+			pr_info("RDMA WRITE for CQE failed with status %s (%d).\n",
+				ib_wc_status_msg(wc->status), wc->status);
 			nvmet_rdma_error_comp(queue);
 		}
 		return;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
