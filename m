Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD79C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:47:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F29613C3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F29613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d3zmM8jiSOKG7sABr6k/oiYmZC95dteWN686Rl57fKc=; b=YNWD3ERoLWDel7cYaaNwLjnVE5
	8zHE28QJDhbHWezMn37UO6l0+XOEiC0zhwdYqPkSPenl1p3sNowQKN8x24DJCT4gex2eWwh4pqxFl
	icsd2KlvpcTGj9+RN6H2d6acrQlLImMC4efqcbajg7qg63/I3Pf3dLZhIFpXCNSI0VuiMleV2aMow
	J47la12cZ3LGrAUD11aAxQB3pj/pg2NZaWDB3B6N96SjQResaxvTOHCwBwBG4fsi/NcYGdEKzJjLS
	JmEDYhSbM9+E5OjftGMOS1C2F9N/YjR6d76Lmp7NqBlWq6vYcoRQ2TGaofIOMN2w0cgwWLfHvcbn9
	MOvAnHVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWbAt-00C2iB-Lg; Wed, 14 Apr 2021 08:47:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWbAq-00C2he-4q
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 08:47:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=IqQeqnMwZkCz6ROcYSPqSmOvyvz4ksE1hWeO3/jPCDA=; b=fDh3u8wTzyVE59JhOnGBCbLuHH
 tHjzFi9QRVyveXrIrFZmJKQe24yWSlZ2fquR6kLOOLKtpv/6+CZYhMf4SUT9ZoNo+DAHQXXrybZfC
 n5HpblNbjayiDC5oX+mEDdBacueN+ym1e6zKuioVITp/s3YizBkLa9RU46eYx7qOXNKQyHI+QL7Bd
 3BwBYPu/EV7CG2GAWADlnH2wVHcpB6eNOfAVQmWOKVBya0OzeqZClatAWCnXLS/rUO44Jba6tNR+A
 jUsJsovlEujJckrBdgVxkJPHh94Af0GG1YsAzNP/uU3+FYZ7bWX5NVftYMlTHXWgU4AGjEGn+bwSo
 kYT8DziA==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWbAn-007cnc-MU
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 08:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618390015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IqQeqnMwZkCz6ROcYSPqSmOvyvz4ksE1hWeO3/jPCDA=;
 b=bv2iZngq+mlWs+NiLy4E3NmxGnk0yXsB+QxrlfezUKyJhiE2TGBElEWe6PJDggAjg+mv40
 K/Ly7uEYHsyKpeUEqvsagXI7cMbzVMANuNp3jkDXeRP9mQYODmEXzQnlk/QOegSK5NRL29
 NRbFLTnoeATaDBkOoqqL9kJKzu1JWxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-sEchaRntPIepxLMV18MAHw-1; Wed, 14 Apr 2021 04:46:54 -0400
X-MC-Unique: sEchaRntPIepxLMV18MAHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25F0106BC6A;
 Wed, 14 Apr 2021 08:46:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB2C051C5F;
 Wed, 14 Apr 2021 08:46:48 +0000 (UTC)
From: Gopal Tiwari <gtiwari@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Cc: gtiwari@redhat.com
Subject: [PATCH] Fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store
Date: Wed, 14 Apr 2021 14:16:45 +0530
Message-Id: <20210414084645.638150-1-gtiwari@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_014657_833939_A47FB978 
X-CRM114-Status: GOOD (  12.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Adding entry for dev_attr_fast_io_fail_tmo to avoid the kernel crash
while reading and writing the fast_io_fail_tmo.

Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d26eddf2bde4..dcf0228a6e09 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3821,6 +3821,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_reconnect_delay.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
+		return 0;
 
 	return a->mode;
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
