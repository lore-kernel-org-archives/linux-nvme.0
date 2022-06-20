Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91994C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVBB91Q21dmlELD+CGqOWdd8NHbp9ekIt+W7tA2FCWc=; b=Usu/UpKOXzcZIXbyjAB2GFQjEk
	kjwgULud1vtYg892s5C64W6Lsnlna12FAYqRPDKxw80EqBXaVZGdnWsWQ2bnmx/VbpChNs1dzrPnm
	YRjYOq1+jxOLP7AtLka9HpGcwtjB0PhOj7QCTqJDb3WWmarrwu/9eeK8LkpcQ0NdYP1hE9VtX7WLQ
	f6sdc83YIvYdPd8XQwsP1aUubq4RFBg2+dru9hkwiTLenk7LZ48mB2j8xeC6eHiZ5YxgB4kFe4O4/
	vrQNxEBJ47gYErip0yY5EXe09HAHWfVgjLV7GD84OpZxJJbkoSjom00cNU9uUhI2EXV0C71+Ha9kq
	XDnwK/Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o38DQ-00Fz23-K6; Mon, 20 Jun 2022 03:36:40 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o38DN-00Fz1e-Ab
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 03:36:38 +0000
Received: by mail-pg1-x532.google.com with SMTP id g186so9156320pgc.1
        for <linux-nvme@lists.infradead.org>; Sun, 19 Jun 2022 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVBB91Q21dmlELD+CGqOWdd8NHbp9ekIt+W7tA2FCWc=;
        b=Cn12uO6fPiT9mRwhoBioM6FCV4ohhDwf11PplmQu/2/BJlCsd7FMG+4+kUOjONmK6t
         88LXAclOy5moz2epcADuTzxYn15D5fVJtzZVJfbMEUkO4GUtysUFQ78KXNEXFQlqduF4
         mcwBqohfszErnFvtJbEFFOmi6gzxKdGv2+YciQHV/5j86ndLKT9tuvItg56/w1VvrnUr
         FND8hjF0xjViSh6z2iuMrjZFF4j5Jb2lR5T7F8h9lcjETTnggB+ARiNVuS8G7L1V3SH8
         XycIDOW1sz0P2Pi8/CKwrcLc7KVQLRqaXDTcamdJ1pMVkoxRugUSBeNyb3OWVjtqU5Tj
         wl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVBB91Q21dmlELD+CGqOWdd8NHbp9ekIt+W7tA2FCWc=;
        b=iDn3hnIOP93IacfwRJ8+xaN7Wj2nhrASUqK0BehhGkbw2fzUDPUiDyBzviLfeQADjQ
         7olRvNMA5WOI8HIuFZn+TbdE8qal5JICO+YFbXgWGm0iLahiS3MTXhKMK9s0UaLxEjyz
         +NgGhLnvu6yLt5eObVJl0vMdzCGe0cLgK3U9KzCTl1+KQRk6cINJVqk8+h6k9kny1AVt
         llSJF91+Li9Peo1EHRV0N9c0TS/nrUKHvyh31PnEPltajDBFTKJSnVD59HLPHDb5gvjO
         26arMh7Ab6A/1AU9XnZR2sjGyw+aASnG1UfoBGKn9CyEWJfm/NJ2VOMzaUEbojJDynMz
         Cibg==
X-Gm-Message-State: AJIora9S/y023xxKHk2Ma9PuMqfmvX1T4UGENCzXdpscXTJcajeCgu+N
	SNAUgM8AwEy6GBDI3tPbnR8=
X-Google-Smtp-Source: AGRyM1uOIK9MNhVOsVmDd3c5AKncc6wQPn/MuKhHQiSXwwK5WMNZg8ssYDvuST87F1ADc4lUHx7Ugw==
X-Received: by 2002:a05:6a00:16c6:b0:522:7ed2:4ff0 with SMTP id l6-20020a056a0016c600b005227ed24ff0mr22497415pfc.9.1655696195314;
        Sun, 19 Jun 2022 20:36:35 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id n18-20020a639712000000b0040cb1f55391sm1315243pge.2.2022.06.19.20.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 20:36:34 -0700 (PDT)
From: onenowy <onenowy@gmail.com>
To: hch@lst.de
Cc: Jason@zx2c4.com,
	abhijeet.rao@intel.com,
	alan.adamson@oracle.com,
	axboe@fb.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	monish.kumar.r@intel.com,
	pankydev8@gmail.com,
	sagi@grimberg.me,
	yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed during blktests]
Date: Mon, 20 Jun 2022 12:36:27 +0900
Message-Id: <20220620033627.8728-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615113106.GA10697@lst.de>
References: <20220615113106.GA10697@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_203637_406058_0D0F134A 
X-CRM114-Status: GOOD (  12.30  )
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

> I don't think we can wait for 5.20 - the "offending" commit is in
> 5.19-rc and -stable.  So I'll plan to prepare a patch based on the model
> number for now, still hoping we can come up with something better
> eventually.

Hi ,
Some samsung SSD for OEM also have the identical PCI-ids and are affected by this quirk.
But they have different subsystem-ids.

For example,

model number: MZQLB1T9HAJR-00V3 for lenovo
vendor: 144d
device: a808
subvendor: 1d49
subdevice: 403b

model number: MZVLB256HBHQ-00000
vendor: 144d
device: a808
subvendor: 144d
subdevice: a801

Addtition of subsystem-ids of X5 to pci_device_id(as below) may solve this problem.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17aeb7d5c48522..92fd3b1d88fc95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3475,7 +3475,7 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+	{ PCI_DEVICE_SUB(0x144d, 0xa808, {X5 subvendor?}, {X5 subdevice?}),   /* Samsung X5 */
 		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
 				NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },


But I don't know X5's subsystem ids, Can someone provide subsystem-ids of X5?

