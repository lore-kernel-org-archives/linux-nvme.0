Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90750C3ABBF
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 00:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXLnSYBHBGQ8AfNxRKaQDWuFTkVqHSBwm3cNLJU97iU=; b=IoA5xpoXPqg0AN8qyYR0akJlFf
	h6n/0H3O5ehqcdhOTxSBaT2tx2Fv7stIFQC9OxS+QekWdo5M29kfhQGnEX3hZDWrnebwLtZOPoSNh
	KAHQY3GtS/785QMHKa7ZxLM/Iq52myiAvhs5y8d/cldo7ams5J7O0z9rP8G72NucTFSYSprDouudJ
	Fxe8ih1VCsLHmYheEAenmC6wU066ZYzST6Wg1sN+bXXWQy48X44E4EcGVhTcq6OoS5ZWk2HepvCAf
	S9GhJlR0C9Md2yKH96MS9StDONZIEsE2zIhGb5S2to9UzjvIiroc3Ptl+5ErW8DopziGyC3IxrXTM
	qtjCFNHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC6Rq-00000009MSi-3jLm;
	Tue, 06 May 2025 00:46:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4GE-00000008kw8-2fVG
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 22:26:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 410A9629C6;
	Mon,  5 May 2025 22:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC929C4CEEF;
	Mon,  5 May 2025 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483965;
	bh=G+46tQlxluCP6eWe/CdD8mmIezTjRDbXVZi4O5UPoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvWj18zUAJYf3ApV3bp5Ecr4At8c/66hQNsZnAR8/7mJ1iT5k7QjAyfAndECCkLNW
	 7HhjEHO+C0iM95IIcXg53tVfPqDD9TcYJy8RRT8yn4Ins+92vThJ+IfSuVL0TfW/v/
	 HZDx+UYGF1SOFHsDnvahDaI524mTp/TwJzphpx+HPEX4LtG5nyNeel13JYTJhVuAzu
	 TYVPzuZjRgmBddPeDVDNy13Og2zCbha3uxCnwvAocoom5LwvNSXfp6US0T0K1i4yUl
	 X8z8z/qJqg+M+z9qv47dFcsdEf5tnqisfD1tlzoXjudFKAlDF3gcmRvb1N+kJf4u6z
	 8ABH01B8GOkWg==
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
Subject: [PATCH AUTOSEL 6.14 295/642] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:08:31 -0400
Message-Id: <20250505221419.2672473-295-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit
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
index fed6b29098ad3..11509ffd28fb5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -514,7 +514,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec);
-- 
2.39.5


