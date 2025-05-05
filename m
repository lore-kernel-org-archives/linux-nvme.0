Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E38C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGD5aHrF2mqvNygfBW0WZUtC/EyA4OEBwNv6ILdKObk=; b=cIJSiBnSpfIFfNbc1ofr+Krp3v
	a0LMxT4y27JilkXMx7VQ51MosPLS2xdk2k93Fv9dvFlGSJkUC0tB4kKIFJiulzftSrImkYDXtmk5j
	iMOpgqnjrNx2Kfbj3C4yZuWo+hLr/GMg3/lMkCV7zhMgufpNPd3xsKWietH6Qx8Uop0ZMJ8cJg1Z7
	KWrbgt8RzQPT3LiJ0z2a1jdvYSqzuQKf9NIuHN9sH0nJlUfOWCcrcyA6LRg91KiQCDO+JL0eVw+HQ
	Di9IYptVRFmo/rdUcpPTUFRBRQa8sUvRp4zExMym4H4sSBisnrnvyvVF3LYOPNcz0YzcBQjdXqY8E
	uu2Vew/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC7RD-00000009b9h-4Ak5;
	Tue, 06 May 2025 01:49:39 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4av-00000008rYc-1fU3
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 22:47:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0938FA4CF97;
	Mon,  5 May 2025 22:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343F6C4CEEE;
	Mon,  5 May 2025 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485248;
	bh=z5aUk+dG5NqmZKV1Bu57nkbRphmoPenBEhGi2559TMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLsi7L4rnu6v99iTg+sNCd8fcenGnZ2GjzD1M83bpvww0H72D5YMktN2+6d/H9wK2
	 ZzBoDiy/EWHQROfA1AChXfSc7+JfXRkatccYo2K7nWY3+DavCpNs53+4NBToo/LIk3
	 2a0vOmeiqttz/uG2X/BrIFr2KyXgLwthgfOagLXymJbD4Ln/vIFLo0NWtCw9r7c7i3
	 dPHOK5wlD9iOVTTn5/yuHoiS57jayi/jqT8kjetEXi8Z48ZQ5KSE5L++1iCGtQbL+i
	 OvzJ2ByOEBJXznlWH/ofnvSoRLGoWJDn2GvOrKUhYBNPq/gKp1hDZwsykZzP1QUp6X
	 56iNK/MIEyT0w==
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
Subject: [PATCH AUTOSEL 6.12 234/486] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:35:10 -0400
Message-Id: <20250505223922.2682012-234-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_154729_505111_D7F89AA3 
X-CRM114-Status: GOOD (  14.16  )
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
index a1b3c538a4bd2..d128e6cf6f1b0 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -515,7 +515,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, ioucmd, vec);
-- 
2.39.5


