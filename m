Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4875AD111A8
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9eGE6EKz24C+DQ/SaMTDwnGe0jrgOz1z3E9DUmUtjrk=; b=bkNT1YPdWOtTSDolMb45zNsBOx
	BCQK/OxAxONtQgERsQXUmgorlqzirpP2DDcl7cPGxvDA6R8n+Z33JZgFL2nI/zFZWiJAn+Ff4ZfHv
	+rpWiVXpmNlSvrODjrhn7JevanTSgZdj41t/+UBF1IPaLMAvxU5tCniYwAi/8RiLzR0Cpy3pxVcmZ
	x/SwVrC3sov6fpK/QK7zEKnP/9kLl09hz+oeRMKrWhIBV8AIh6zO5h9OeFeQD5u7yKTIhCHivHYwl
	hQpHcIHbfm7i3kIMg8geNs4zs7HYuWbzlMA1HNs1TlZXQKIUdDb07i5ssFSsAGGyGpCDytSXI63sb
	t+7LQWgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKR-0000000GsNW-2xRc;
	Thu, 27 Nov 2025 15:54:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKN-0000000GsKn-3LvB
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 15:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764258879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGE6EKz24C+DQ/SaMTDwnGe0jrgOz1z3E9DUmUtjrk=;
	b=IgQJUk9ad7nI4TTBJDQEJ84A4lk+Vy40IkvSvAZTu/Z66UQYBNWdI9CNDk0X0wxYGqqwah
	oMIU3/2e5AhCUZy5LhEpXI30ncd0yUvDY/PZeBfOixlHflgwCR0bQhkYjdpje+UF9fRXVx
	TkSChMHbFOqkz/ksjw5PJ2UCxeP/aXk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-8uz7N-XOMO2lb15TkskJNA-1; Thu,
 27 Nov 2025 10:54:32 -0500
X-MC-Unique: 8uz7N-XOMO2lb15TkskJNA-1
X-Mimecast-MFC-AGG-ID: 8uz7N-XOMO2lb15TkskJNA_1764258870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87040180049F;
	Thu, 27 Nov 2025 15:54:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FAAB19560B0;
	Thu, 27 Nov 2025 15:54:29 +0000 (UTC)
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
Subject: [PATCH v2 1/4] scsi: sd: reject invalid pr_read_keys() num_keys values
Date: Thu, 27 Nov 2025 10:54:21 -0500
Message-ID: <20251127155424.617569-2-stefanha@redhat.com>
In-Reply-To: <20251127155424.617569-1-stefanha@redhat.com>
References: <20251127155424.617569-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_075439_911624_0BF02D83 
X-CRM114-Status: GOOD (  13.61  )
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
index 0252d3f6bed17..e436ed977cdb4 100644
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
+	if (num_keys > (USHRT_MAX / 8) - 1)
+		return -EINVAL;
+
+	data_len = num_keys * 8 + 8;
 	data = kzalloc(data_len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.52.0


