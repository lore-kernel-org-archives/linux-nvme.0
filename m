Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC52C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 03:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQOnFhbhv1e/uN7cYsRlf+5EuFtyZnDVpn11d4YqSTM=; b=YvM1Y34VVYKcWv8UEKOqy70j/b
	NJP//WNNL779ABqoYj42Ygpa3KzN6xSbrZQf8SrrkQmYQvW3+P0prmfAqSsMMlL212ZRwTOAYBJ22
	C45iQfDrbiBpC1EpfuH02p82EkVXSDkBtazBBGWKxcHhZB+4zopyPHfbGdQtzXzQAVZPrW06pLn1b
	5ZjztwLKJxLh3bipWmJE9oziG9P2vRoWIOjDywfK4A303ps2xJ42n9G7dxOQtfaassZmpMJkln914
	5TSHGBI7uTIZ6DPU0XrPp4cnhgX0sCgJfcC5B7VRSltvzUD+Oa9ytRe1LyFGTfFnxDmt4WTptNbWy
	RYLo2rYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC9OQ-0000000A5pC-3mve;
	Tue, 06 May 2025 03:54:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4wk-00000008yKS-2eJh
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 23:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A665144857;
	Mon,  5 May 2025 23:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C799C4CEEE;
	Mon,  5 May 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486602;
	bh=/A2lNNDhMc5Fco9orW1zjWE7iSjabScTNUs6YZMsbcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcTZsKUiEAJ2VcHMcG+Igda5Mg/8P47PCr6DZhaBgjvYlDDfGi95984Wcr5/g6N9i
	 D3UABN5gQ0kyTwAJ3m1rva5ZLHMFig7savcRjqhpr5yqCCwgYNnKwf/UZYNNE3WPBe
	 yXfuT/ChfLrCq9Q4Z0KbvwYtjP1qpVruLZa3E+bG01onSo02OhPcQNjk50yeaGGvoP
	 zL2iHkftp8zm3y+wSVUtMLD2ebyWLHCoWSdtnipvLbSdNEe8rsPLb/G+HRIfInrWQF
	 TuaOlJPe+StLT5c/eZ/wfaLHIF3jFeL16dxfFcWKtX3aba/jlgaSPHVzjhjEgSQktY
	 Q3RZ66RsrXysg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 112/212] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 19:04:44 -0400
Message-Id: <20250505230624.2692522-112-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_161002_691353_E7E9CB92 
X-CRM114-Status: GOOD (  14.07  )
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

From: Xinyu Zhang <xizhang@purestorage.com>

[ Upstream commit 99fde895ff56ac2241e7b7b4566731d72f2fdaa7 ]

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.

We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.

With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20250227223916.143006-4-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index acf73a91e87e7..0d84acbdbf6b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -541,7 +541,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, ioucmd, vec);
-- 
2.39.5


