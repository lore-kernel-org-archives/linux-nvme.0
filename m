Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83955C3B186
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A143206DB
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTQ1kY+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A143206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1l7cQ/7OxxxhmbQhZJR+U4XkzOkJmk01fDis6MX9CGY=; b=hTQ1kY+Dy18ryE
	rjZsjccaviIytAXKpO1ExCoJpVGVE56eCZ3JZ9Izlyu/GA07R0Tdd/g3+7+j8xRdkLMxWWhWzNnas
	sf+mqvlrUJrkwBZJGpGBZpEVXDTaq2Uzgj0seeEmk46pthiHcBp4xaW8PTxrSvkcCC8+kDE3MWvzX
	VQXL8oT0x7mE+dKq1svcqTHNlR6U79aZ8wrTfJLPwUKg4f+FdvNseIMdZkRvtR8sC2WYamB2bci40
	i9f6pHCkSXwPtUjd2jE+7FwRQA5uKNSqzbn6Yrr6rfEaIJTjajf+B47KKXhcMb9hoXtVXh9s48MKx
	1GsRMPXANcOXDEL/vAJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1UrI-0002oL-IH; Tue, 11 Feb 2020 12:41:44 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1UrF-0002nA-H8
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 12:41:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 77CDEB1CD;
 Tue, 11 Feb 2020 12:41:38 +0000 (UTC)
Date: Tue, 11 Feb 2020 13:41:36 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Don't deter users from enabling hwmon support
Message-ID: <20200211134136.099ac9eb@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_044141_720038_6CA2A10B 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I see no good reason for the "If unsure, say N" advice in the
description of the NVME_HWMON configuration option. It is not
dangerous, it does not select any other option, and has a fairly low
overhead.

As the option is already not enabled by default, further suggesting
hesitant users to not enable it is not useful anyway. Unlike some
other options where the description alone may not be sufficient for
users to make a decision, NVME_HWMON is pretty simple to grasp in my
opinion, so just let the user do what they want.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/Kconfig |    2 --
 1 file changed, 2 deletions(-)

--- linux-5.5.orig/drivers/nvme/host/Kconfig	2020-01-27 01:23:03.000000000 +0100
+++ linux-5.5/drivers/nvme/host/Kconfig	2020-02-11 13:31:31.595715936 +0100
@@ -31,8 +31,6 @@ config NVME_HWMON
 	  a hardware monitoring device will be created for each NVMe drive
 	  in the system.
 
-	  If unsure, say N.
-
 config NVME_FABRICS
 	tristate
 


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
