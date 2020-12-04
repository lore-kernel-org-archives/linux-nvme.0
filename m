Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46CBC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 16:19:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA9B224BE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 16:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA9B224BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bS63+7OrdDxm01fp6I+qkxoAPcjCSF7pQLr8mJ/0jpU=; b=KQhPjUFgo+bUatQtH8DF6Ri9EU
	FOaRl+48xf8DVwWSaUx96ku3+L1aWSasvkqNY/yT3aGkSooG0aqteszj3c8Fccipe54tJJUm7VosK
	qboURN4XYf5sSCzInoxLa+TRrH0F1BnH2eN446sCD4XrtrEf8n8Cr6Bu+6damdZVayJ0vJEhAeusC
	7lS3nA4WGuyg78LcvOdnKMJxCurGncZKXojTwsHfTuXu0X3o8VQ9lJHQ0G82BwysQQm+DJcsVftjB
	cURD/xx/k1XOWhJjFWbAIkVZ3qLTAxo2W5r2gOFVPqpkmjXhM/9sKLTYfBQmv8IFOEPyNySZg+QlB
	P/QiNK1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klDna-000483-5G; Fri, 04 Dec 2020 16:19:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klDnW-000473-Mh
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 16:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607098742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aF6cgk6RXMYjIwhM09tLVmYwY5LnMXNwRL9Ca5SKEFg=;
 b=Ed3fgqhxApHJ+eQGs+8wwxHkGxHsVmXsi23se/Mev8TGNQ1bvrgUpS0XgYCmHMp77JZlMv
 mFMufcKmWTYg8jjzIWF/47bt000k+FIu+30aAIIAy8+2DezwSufnT0VgWPiLT5jcAtf7r0
 QpRVBiWPlQfW0wboTv5Cxn+a8TR+DVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-g9JHHuegPuuT1G3x_dy_Kg-1; Fri, 04 Dec 2020 11:17:08 -0500
X-MC-Unique: g9JHHuegPuuT1G3x_dy_Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BABF1926DBD;
 Fri,  4 Dec 2020 16:17:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7F192999B;
 Fri,  4 Dec 2020 16:17:01 +0000 (UTC)
From: Gopal Tiwari <gtiwari@redhat.com>
To: hch@lst.de,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Date: Fri,  4 Dec 2020 21:46:57 +0530
Message-Id: <20201204161657.16421-1-gtiwari@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201204_111906_817150_24FAF854 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: gtiwari@redhat.com, dmilburn@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A system with more than one of these SSDs will only have one usable.
Hence failed to detect nvme devices due to duplicate cntlid.

[    6.274554] nvme nvme1: Duplicate cntlid 33 with nvme0, rejecting
[    6.274566] nvme nvme1: Removing after probe failure status: -22

After adding to the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk resolves the issue.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..143f16a9f8d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3201,7 +3201,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
-		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.21.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
