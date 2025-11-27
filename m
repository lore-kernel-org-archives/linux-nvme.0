Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03536CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4yiEqdjZP2pjR5NE43rCMghlmUF6oy2t/sXcmabl5AU=; b=kHeRKrSNFNDdrvEBTBoQas0wmv
	RiOt687goT3kxaMYlFOOEtCrlxetiG+I9Mk7pqnlU8rrYSr5ADxkL0pIj0ale3CWPLFk339itHTDL
	fVLlOAaOAGbvVjfxDTQ0/7H43lxJ4Cf9Df2Tr6JAYZ9QAm6MQK2Z3J7n0OguxLq+0wLf76kub07NP
	5G8Edce5UZkmY+v/QPp10wFvjhxO50smceJLg9ownMDFgCuZvfK8FRtF2levwVryAPDlV0HsqkCnG
	OXm1UNqVEfs4naG6FL3nvd0HgdDXfPj6eP+OQI0YM3A9OGr0+jaJNjEyRr0EortDBG0V72AqXRMs5
	R4mK+TuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKP-0000000GsMP-1Rs2;
	Thu, 27 Nov 2025 15:54:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKM-0000000GsKK-3Xez
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 15:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764258877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yiEqdjZP2pjR5NE43rCMghlmUF6oy2t/sXcmabl5AU=;
	b=IvMp4LmgCcjAlttqU11/M2z9SxnXiwk6+hiH5BS11TIV69WFHMfTW0UQCEsx5dEHf+Y/Qy
	e4RCFKEdBaX2BNAuK/o2B6dCgHr2uXMTmqiqqnuempzPe4ntiKAyGlljCsUHAAmOPsAhnQ
	yhJcxPvfCbJLh3iNFv8PVh4lfu9mwEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-TZXPpSsGNVuPgZswTFV2mw-1; Thu,
 27 Nov 2025 10:54:35 -0500
X-MC-Unique: TZXPpSsGNVuPgZswTFV2mw-1
X-Mimecast-MFC-AGG-ID: TZXPpSsGNVuPgZswTFV2mw_1764258873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D98D180034D;
	Thu, 27 Nov 2025 15:54:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D126180047F;
	Thu, 27 Nov 2025 15:54:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/4] nvme: reject invalid pr_read_keys() num_keys values
Date: Thu, 27 Nov 2025 10:54:22 -0500
Message-ID: <20251127155424.617569-3-stefanha@redhat.com>
In-Reply-To: <20251127155424.617569-1-stefanha@redhat.com>
References: <20251127155424.617569-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_075438_951353_4D91C53E 
X-CRM114-Status: GOOD (  12.93  )
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
 drivers/nvme/host/pr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b139..156a2ae1fac2e 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -233,6 +233,10 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	int ret, i;
 	bool eds;
 
+	/* Check that keys fit into u32 rse_len */
+	if (num_keys > (U32_MAX - sizeof(*rse)) / sizeof(rse->regctl_eds[0]))
+		return -EINVAL;
+
 	/*
 	 * Assume we are using 128-bit host IDs and allocate a buffer large
 	 * enough to get enough keys to fill the return keys buffer.
-- 
2.52.0


