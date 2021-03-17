Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01620C4332B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ED164FE4
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ED164FE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wYrq77giIf4I9gC5fDAPFvRKLhSDmy6xjAurUPQOjyU=; b=N+xgFMNaKY5UVFKtGU/Ha9K0g
	eMRpPi/MULKBPCLFr8rQ4J3n0gS0YVoE+N37hEPt9n3suyqo3U2zHltlc+Ltgl6GvKlHeRsAN0fmI
	vrldczKfzj7G8xK0CuxAx/CYx0TP/U/CWcraZUGgtx/ko+GRPwEIonj5ZTlVXsuMyBSMW4fyi13tq
	v7z+FMcYR3EYsKzLSBla5FwEIs17tJd+GJoHMdpxTBX97XxoSbpG/Os9anJ7BLeGFqROVud8fvmdu
	pife+Bcg4B8Pr68M10Ndfer24PnmONuZJxLsSqXqgkpv3mAvsl/EaAA7WDEOruRZjFw7UZOE2mZ+N
	jnmC22/2g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKVv-0027TU-DL; Wed, 17 Mar 2021 00:58:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKUO-0026hJ-PF
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:56:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACADB64F9C;
 Wed, 17 Mar 2021 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942603;
 bh=aozgTVH3HTG6JxHeF/viQWKnhix4qY/2AgcsbmddK/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LAHObZRKVGTpvU5FE2qYTC09101MeOX9bNyzwF9YTCilMSR+3T8aPiVzfvRFNBW+O
 B1TvflOetf12ecnB8SjARhp6OlktlsaUEx7qgotpF+5PGSvk7nJ8gCvHs1AJyrnEcL
 FE8R611vLKeka+Esv/7Iuzl5TvUtGqwfi3v1JI0MAqo7K0naMIAgfiZSaArg8iWSDx
 V8ttJWwmv+48e2v7CSPkUIEpt8ZWKlQyGoGCPab386PdxBtL4Leir/ovhzTGf1iGnL
 /nndC+n6AFQwUwDEbY686i5EfnNClrfcGATqaYfDbo+74p1NUndXUuAVw3mckNalE4
 xFQdL/x+Uj9vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lv Yunlong <lyl2019@mail.ustc.edu.cn>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 54/61] nvme-rdma: Fix a use after free in
 nvmet_rdma_write_data_done
Date: Tue, 16 Mar 2021 20:55:28 -0400
Message-Id: <20210317005536.724046-54-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005647_875301_380E1D25 
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
