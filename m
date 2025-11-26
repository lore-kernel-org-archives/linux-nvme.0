Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5BED10F58
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8ULdLo4b3ORYhVubgD3gy7oPbpY6qArrsrgQiRkmsY=; b=mXWAvbbRqasLyhoQA7W0COsJAV
	ieMNRv5nfxtjmmenMRBaMSOhSLnQ/aaJLY5UQ7j1XXitaoKUdorYaa4OOXwFDq3YRWFWzngaxwOBS
	8iFZtRH3Ri7s3JQQwgm+ovmvbzYohPo+YmzR8GBZEvyUdMfumUVUjB/locNs3DcFCKt+ucmCcKoOn
	E3dsZzm4UENqpfW1zftmPEzfp6pCYoS3N2pN6wPrezjgs6Tc5aGXsJnl0SrtIyooItaLDZ9uYF3dm
	rthUOZ8dsAbXRejFpC+jhT3x4t2SQ+MmOfekORt5nZq/zIG5OUhgje13eLcTiQpDlOuiPuyaT7Gyu
	HUagm5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWZ-0000000FJgI-1ask;
	Wed, 26 Nov 2025 16:37:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOIWV-0000000FJfG-24H1
	for linux-nvme@bombadil.infradead.org;
	Wed, 26 Nov 2025 16:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=n8ULdLo4b3ORYhVubgD3gy7oPbpY6qArrsrgQiRkmsY=; b=UyLa5RW61cyCJwtQAzBNqDqZ2H
	PEjJs2v0TvVqydP1KFPtFmNuWERyw+l0t39tIwYVC9p0SouvjiFRHyB0hCCD9u8+1+Dl33kIzpOsi
	B/wLoYLzPXUPDgG5KTcEaWKSD5xH0yZfo5QnUCuVigWq97apaSOWpZEKAyBDzf3MfJP5paVXL+AID
	Tehy+1nE1DFa4TxbgglHuC1vgh1jPWXa7yVaHEhVYNQ6MQL9tI5wk5mvqf0fjkFHT2if8Ncxn0qqR
	VaAEooQ1PfgUY4XAlFQ129yh3NI0lvRRPSkRrHZr3/ZZaKDTrOoak379XVpoAqHMUh0zueCLSok5+
	+vvJjkJQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOHes-00000008PVM-0myl
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 15:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764175059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8ULdLo4b3ORYhVubgD3gy7oPbpY6qArrsrgQiRkmsY=;
	b=CLmbl6UrASLAhTsXHdjSkCV47OLZ4bQdHK/HvubvVMcoZaXirgFBa1XgGpb+h+U6mnidNb
	D7HXYBn9YfriK3TDR3xG9YvrCoV2RBglmwT2QFUJJw50aOmrjVFyF7kou1BUynZHftRADH
	AeokGGcVvclrB0MXRJBELy490+yT0Vc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764175059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8ULdLo4b3ORYhVubgD3gy7oPbpY6qArrsrgQiRkmsY=;
	b=CLmbl6UrASLAhTsXHdjSkCV47OLZ4bQdHK/HvubvVMcoZaXirgFBa1XgGpb+h+U6mnidNb
	D7HXYBn9YfriK3TDR3xG9YvrCoV2RBglmwT2QFUJJw50aOmrjVFyF7kou1BUynZHftRADH
	AeokGGcVvclrB0MXRJBELy490+yT0Vc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-9p40aK1TNFeth8KEkFpF8g-1; Wed,
 26 Nov 2025 11:36:09 -0500
X-MC-Unique: 9p40aK1TNFeth8KEkFpF8g-1
X-Mimecast-MFC-AGG-ID: 9p40aK1TNFeth8KEkFpF8g_1764174967
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33FAA1800451;
	Wed, 26 Nov 2025 16:36:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C4A319560A2;
	Wed, 26 Nov 2025 16:36:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/4] scsi: sd: reject invalid pr_read_keys() num_keys values
Date: Wed, 26 Nov 2025 11:35:57 -0500
Message-ID: <20251126163600.583036-2-stefanha@redhat.com>
In-Reply-To: <20251126163600.583036-1-stefanha@redhat.com>
References: <20251126163600.583036-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_154218_449702_E58862FA 
X-CRM114-Status: GOOD (  13.82  )
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

The pr_read_keys() interface has a u32 num_keys parameter. The SCSI
PERSISTENT RESERVE IN command has a maximum READ KEYS service action
size of 65536 bytes. Reject num_keys values that are too large to fit
into the SCSI command.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/scsi/sd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0252d3f6bed17..d65646f35f453 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1974,9 +1974,18 @@ static int sd_pr_read_keys(struct block_device *bdev, struct pr_keys *keys_info)
 {
 	int result, i, data_offset, num_copy_keys;
 	u32 num_keys = keys_info->num_keys;
-	int data_len = num_keys * 8 + 8;
+	int data_len;
 	u8 *data;
 
+	/*
+	 * Each reservation key takes 8 bytes and there is an 8-byte header
+	 * before the reservation key list. The total size must fit into the
+	 * 16-bit ALLOCATION LENGTH field.
+	 */
+	if (num_keys > (65536 - 8) / 8)
+		return -EINVAL;
+
+	data_len = num_keys * 8 + 8;
 	data = kzalloc(data_len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.52.0


