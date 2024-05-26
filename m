Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C25C25B75
	for <linux-nvme@archiver.kernel.org>; Sun, 26 May 2024 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+17iG9k8Ji8nV5b1c3/MrdKr5n745GwHR75IDIw30Lw=; b=ZD7XxhEAxvMA9mxHL0BfKF7COt
	eQARxsVJV8wufXsRVo8eGGpWgLkS37yOFkWeLSi1rwi0p4uXkjfpJbIcvuxDcINXuf+460RkIYdEX
	EWp04P1FeMWRZ/OHMuHm9Sw+3XWUjtFLMopDoSNg5Ut/Gxm8LH8HUk/HV+vQkwBPYU+Y8eaWvvTK+
	dxVfxVP7cfLds9aDuYTGoWJ7i+zIpL1rt9lZWEN9ZSxYui+PMLNblcmtAECRbL32sOISSloUFeZsB
	M9eL5CBpv+Vz/d+ywcAIMmlGi7LRL47RIBJ5b/tIRlHNFJAnKEIUYuE4V9B0NNMYea7hT39FYqRbB
	dHq4bGMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9Hx-0000000CMGj-2IYf;
	Sun, 26 May 2024 08:31:33 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9Hv-0000000CMGD-0fZC
	for linux-nvme@lists.infradead.org;
	Sun, 26 May 2024 08:31:32 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-356aa8a7e1aso59764f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 May 2024 01:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716712287; x=1717317087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+17iG9k8Ji8nV5b1c3/MrdKr5n745GwHR75IDIw30Lw=;
        b=IB42evT3sg5U9ivU3f5fIjcMye5SOFg+DknoTvWOMZncJBpGGUfcPrdW3TpIACgnTT
         uG00SELhXXrXoF5IuDvxF0W47GJSM+CqfTzWDYZygJtrxXHNVvpnL+qWSflZLzulCAeE
         X59GRyQhYYwfjhjnyLXV0/HKayEA0dncY+f+vYgMqavBcrgeqkm+EUQYiGR3YN2T41C6
         t8+snhyUyMcsNgDEmm6Zf7OHm8WXGZAAwBbnHs0rgddbO3ySr6PTHTf6Ssf4/LbKXf7D
         /2byAvOAiExjKv5XXdYfkczFmqSq+9NzCG1HFhUv73BaAXKFYM4qilrkOzkwBLx3Xrvf
         5/QA==
X-Gm-Message-State: AOJu0YwT8d96tk7WlsqdFyIBazHNErqNXWJyjLD43cFSpaisNpieLOdy
	Nh2MxfNr8Ie0hTZ2tE/QLnAZiAbdZAOn5dretNNvrRM8kx/Gw+nh
X-Google-Smtp-Source: AGHT+IGBl24/zJIt1XOiLIQp8BuVpC6U/VdkD9h+2ata0au7V1dw9ahjNHoYOyP7C4O4Rl3mj7Ig9g==
X-Received: by 2002:adf:f9ce:0:b0:356:7963:fe9e with SMTP id ffacd0b85a97d-3567963ffb8mr2638360f8f.6.1716712287414;
        Sun, 26 May 2024 01:31:27 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0909a7sm5907880f8f.55.2024.05.26.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 01:31:27 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-rdma@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Oren Duer <ooren@nvidia.com>
Subject: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq attached qp
Date: Sun, 26 May 2024 11:31:25 +0300
Message-Id: <20240526083125.1454440-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_013131_226271_7327735C 
X-CRM114-Status: GOOD (  16.30  )
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

ib_drain_qp does not do drain a shared recv queue (because it is
shared). However in the absence of any guarantees that the recv
completions were consumed, the ulp can reference these completions
after draining the qp and freeing its associated resources, which
is a uaf [1].

We cannot drain a srq like a normal rq, however in ib_drain_qp
once the qp moved to error state, we reap the recv_cq once in
order to prevent consumption of recv completions after the drain.

[1]:
--
[199856.569999] Unable to handle kernel paging request at virtual address 002248778adfd6d0
<....>
[199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
<....>
[199856.827281] Call trace:
[199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
[199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
[199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
[199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
[199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
[199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
[199856.860587]  process_one_work+0x1ec/0x4a0
[199856.864694]  worker_thread+0x48/0x490
[199856.868453]  kthread+0x158/0x160
[199856.871779]  ret_from_fork+0x10/0x18
--

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Note this patch is not yet tested, but sending it for visibility and
early feedback. While nothing prevents ib_drain_cq to process a cq
directly (even if it has another context) I am not convinced if all
the upper layers don't have any assumptions about a single context
consuming the cq, even if it is while it is drained. It is also
possible to to add ib_reap_cq that fences the cq poll context before
reaping the cq, but this may have other side-effects.

This crash was seen in the wild, and not easy to reproduce. I suspect
that moving the nvmet_wq to be unbound expedited the teardown process
exposing a possible uaf for srq attached qps (which nvmet-rdma has a
mode of using).


 drivers/infiniband/core/verbs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..580e9019e96a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2962,6 +2962,17 @@ void ib_drain_qp(struct ib_qp *qp)
 	ib_drain_sq(qp);
 	if (!qp->srq)
 		ib_drain_rq(qp);
+	else {
+		/*
+		 * We cannot drain a srq, however the qp is in error state,
+		 * and will not generate new recv completions, hence it should
+		 * be enough to reap the recv cq to cleanup any recv completions
+		 * that may have placed before we drained. Without this nothing
+		 * guarantees that the ulp will free resources and only then
+		 * consume the recv completion.
+		 */
+		ib_process_cq_direct(qp->recv_cq, -1);
+	}
 }
 EXPORT_SYMBOL(ib_drain_qp);
 
-- 
2.40.1


