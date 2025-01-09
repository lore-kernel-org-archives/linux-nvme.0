Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDDFE77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=skGmqXhr7D7GHFSBn1n1jBSZ/OstthGpQL9ynguv1XM=; b=c5q/iSYnIRIS8+NPM2TUM5qKPT
	DdeXeHsIyFZWmxpZrFtXJruMojSgGZ9sl5LIoB42QDNZeTRKOrQlcE+0iturGnzRbUdbmaqtrdNFz
	9Y0KfNL7nu1wvPTjdPe/fgnqzaPqZlDo+WWm2qVf3PXMj7Pj3cOJ5C/52bemmiKzVTYfcASKSy6Zy
	YA3svbAZxNF0x/4NOYdrvyetWh0Pasu8wun5gfN7hA6pnpVYdsFl5LdFXqpIiGLtlWqUTn0/+lAh2
	//A7XDpxetmxTyQ9HcIM+a8+oOVbx2mcmhQI5DwO6Lg0WWEkNCG5zaj15af0TEkmEtjw1SJgeVDtx
	Kk4zL5iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscu-0000000C1nW-3FUj;
	Thu, 09 Jan 2025 13:31:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscs-0000000C1lS-23Jy
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 13:31:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 34E78A41CAD;
	Thu,  9 Jan 2025 13:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DCCC4CED2;
	Thu,  9 Jan 2025 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736429465;
	bh=nIScwi2DSPh0GvWAvF2mKHT9Nt5wUZKyiIzlhzVSW4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GPfLd0KSyXPP1kHLy8IabfOv4yfiatJSpxe8jGY8lOKORHtVPEvW/nSWWzf+gOJIj
	 AJehwktHVNsNZk/Hpff24v/vRdmA2nYG/fLeSTuqA6YaYDKU/V2fjMB5l79wNvhhpE
	 wLDCpE+L/DlI/ioi/zc4JL+PLXYyOHIMi3xD/YHT525YTvbB4/QEp83+UwPpxM3Kcq
	 sghV7I2w2ruuxRe3VaoRbxaK/8PY0QWpIb1YwNzdbteNtOGykWQp0s1zJNFNiY1sq1
	 1Dkz1U9qW8wiRHCFT1IZ584qvx6I2defb2NOTovikfN0dI5B2vBr4ucRgw74QpgV4A
	 2FFZckyXoJnRw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 09 Jan 2025 14:30:48 +0100
Subject: [PATCH v4 2/3] nvme: handle connectivity loss in
 nvme_set_queue_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-nvme-fc-handle-com-lost-v4-2-fe5cae17b492@kernel.org>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_053106_615053_0D45E6EA 
X-CRM114-Status: GOOD (  16.09  )
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

When the set feature attempts fails with any NVME status code set in
nvme_set_queue_count, the function still report success. Though the
numbers of queues set to 0. This is done to support controllers in
degraded state (the admin queue is still up and running but no IO
queues).

Though there is an exception. When nvme_set_features reports an host
path error, nvme_set_queue_count should propagate this error as the
connectivity is lost, which means also the admin queue is not working
anymore.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b72b0e06801490f2c14e7fa09a45a870045a221d..a08ff8b362d0b7bd1a8a343e26d564b089c6bad3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1695,7 +1695,13 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*

-- 
2.47.1


