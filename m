Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D4D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMFwoOksHHE5cqY2VlDWWpug5apQFnrEoUUMM1BHdZM=; b=QbQkmPPZWoa7g34UcUtdyePUj/
	7o+ZFEWid6NOsfNKsslejnjxq7l3W7bOlWLCP36cSBmv9oLxn1FcN1y9n+gaCBb02LSfn1/qEs1Rk
	oqIdlmj0Ta62BYgov0rKRTtD5iX3RzrPu0Xf3ber1ZeAKL6XnJ8tppFFqXDng3otxHnCA20PdFBzx
	uaOH8Xa76QGJfgn4NTDjs8UdEdVogSpg6iYkmWSoaO9NvyW/iY3oulffF3TfddG9oEbREV5V1F2fq
	BBMGSTH4ZiZo8ORDzMkA4CDXfhxSoqyxQpgSyQcoHN1pkRgidQd08rvJxsPkj72j6sowrNGQeYE3Z
	JFJ7XrcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgW-00000004Y3b-1Z0h;
	Mon, 01 Dec 2025 21:43:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgO-00000004Y1n-2qgW
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 21:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764625423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMFwoOksHHE5cqY2VlDWWpug5apQFnrEoUUMM1BHdZM=;
	b=L3Mu695HBDQ20f3Js4KFvkh+m6wXXX8G7bOspqBbtD/p9Q9vQ3DV85XhPGNmYBfKdkrIiJ
	e36aCYVvBrUC+DN2l89Fvk8RUiHaQaWrkxTZEfEzetM/i3lQk/wBA3VUCPS852pFtU+7qP
	znzKfVayKLe4rqEYBk0XVV+KA/kevB0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-l0f1X0LbMJCJ0PRFNBW5jQ-1; Mon,
 01 Dec 2025 16:43:39 -0500
X-MC-Unique: l0f1X0LbMJCJ0PRFNBW5jQ-1
X-Mimecast-MFC-AGG-ID: l0f1X0LbMJCJ0PRFNBW5jQ_1764625417
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25C4F1800343;
	Mon,  1 Dec 2025 21:43:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E79A19560A7;
	Mon,  1 Dec 2025 21:43:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Mike Christie <michael.christie@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-nvme@lists.infradead.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 2/4] nvme: reject invalid pr_read_keys() num_keys values
Date: Mon,  1 Dec 2025 16:43:27 -0500
Message-ID: <20251201214329.933945-3-stefanha@redhat.com>
In-Reply-To: <20251201214329.933945-1-stefanha@redhat.com>
References: <20251201214329.933945-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_134344_790336_C9E58C93 
X-CRM114-Status: GOOD (  13.83  )
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

The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
Reservation Report command has a u32 maximum length. Reject num_keys
values that are too large to fit.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/nvme/host/pr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b139..ad2ecc2f49a97 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -228,7 +228,8 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 static int nvme_pr_read_keys(struct block_device *bdev,
 		struct pr_keys *keys_info)
 {
-	u32 rse_len, num_keys = keys_info->num_keys;
+	size_t rse_len;
+	u32 num_keys = keys_info->num_keys;
 	struct nvme_reservation_status_ext *rse;
 	int ret, i;
 	bool eds;
@@ -238,6 +239,9 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	 * enough to get enough keys to fill the return keys buffer.
 	 */
 	rse_len = struct_size(rse, regctl_eds, num_keys);
+	if (rse_len > U32_MAX)
+		return -EINVAL;
+
 	rse = kzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
-- 
2.52.0


