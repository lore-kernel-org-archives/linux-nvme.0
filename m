Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD4C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:01:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2880064EB4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 05:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2880064EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lCQlx7pEy+L+30O1CCgf8ceyzN2UqU7W36P6bCcGkgs=; b=r0xqfzr/fYlaD32ORfJslU1GQH
	4E2mMJqioJ0Q76+Hpcb5UPxZtpLMyG8qXkz2yoLV9ZOBPFygDYqZQjgN6oW6Tz4AVtzG2F1F6HYg+
	qHQynVIy39ltMkCi2Nr3LQaYzXHb/EKNim70RYJqW2d+Og50zopxZV3BrmNr0y9EhwbukGDFf5sAW
	s9iuJChmRTDTVNc7AcUn768ceIwUhsJzh7+lCaOxV4FOo166g8KaSckQsmHPR1+QZ+AuMZAF4vHJU
	M7TPPJAiL+Ib/HYfHeW3Myiu/atvVy89ljjnPWvRYlfzqhSU9pM/eBqK0ZLRe6IUtwzIv1yOpFbCA
	fXztTOww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9L97-00018j-DV; Tue, 09 Feb 2021 05:01:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9L94-00017t-K8
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 05:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612846861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tNmTyLNbvDOn8cqS5mZYP8FHj2Rw2BtFiKmSIyYGuhQ=;
 b=fVUXZVRexbuqzoP8GnwOx/igwad4VA/yzDqYxV5wQ9rvd8/6dviVmK927rwWdHU6/tX6tB
 JJkGsg8n3a/BGKTF8pfaZM3pEMy8v0z2w4SkER0hAipgfYo/kCwqGp9dH5EVn+nsS+KSh7
 sgC6tOBGADdfzmPSS8q5c2LOc0sCjwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-o9Mo9zJ9N8SOLdLJvBtbog-1; Mon, 08 Feb 2021 23:59:11 -0500
X-MC-Unique: o9Mo9zJ9N8SOLdLJvBtbog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AD2107ACC7;
 Tue,  9 Feb 2021 04:59:10 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE5619C71;
 Tue,  9 Feb 2021 04:59:07 +0000 (UTC)
From: Gopal Tiwari <gtiwari@redhat.com>
To: hch@lst.de,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: prevent SK Hynix PE8000 from using Write Zeroes
 command
Date: Tue,  9 Feb 2021 10:29:02 +0530
Message-Id: <20210209045902.72345-1-gtiwari@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_000102_801449_602C98D9 
X-CRM114-Status: GOOD (  13.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: gtiwari@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For SK Hynix PE8000 WriteZerocommands exceed typical I/O MDTS
(Maximum Data Transfer Size) supported by the hardware. Which
intern fail and generate following erros :

nvme nvme0: I/O 0 QID 96 timeout, aborting
nvme nvme0: Abort status: 0x371
nvme nvme0: Shutdown timeout set to 15 seconds
nvme nvme0: 128/0/0 default/read/poll queues
nvme nvme0: I/O 0 QID 96 timeout, disable controller
nvme nvme0: I/O 0 QID 0 timeout, disable controller
nvme nvme0: Device shutdown incomplete; abort shutdown
nvme nvme0: failed to mark controller live state
nvme nvme0: Removing after probe failure status: -19

Firmware unable to complete any outstanding commands
due to lack of resources, therefore placing NVMe drive
in a condition that is unable to further process WriteZerocommands.

fixing by disabling Write zeroes.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4dcdf0..aca67728700e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3257,6 +3257,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1c5c, 0x2839),  /* SK Hynix PE8000 U.3 NVMe storage */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
