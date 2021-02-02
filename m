Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:26:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435BB64E2A
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 00:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435BB64E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jhp/pWFHYmk/uXJ+MpVvBIqaYz18Iy9wLRiPIwA+F2Q=; b=nQButfSlvoQnvbUWqyJlAxu8l
	NfbMr2/Qasywq4QuoVHEqcN9+uLZ0Ne6cp27z6eh8wSm4T8hPEofdhaTbaK9G72nFhhLoOyyzslue
	VkwUTCn6mdnhLbOnLAr4y3g1XI2zds2GJ0DsKEiYPtHSvS57Yn25PZzGDR0B4m55rm5NOgkQ6greK
	6Y0NrW3VNbVnb+ku5AKXUNXlEcCU1GEm9XT41Z9uVTMvcVGQ5vkCuLEiXYsWgmJ9fh6eGNtZ4GJLQ
	c+95zE8gLep+Gb5XmQQlfcCkFMEZyTStyk8PG6zxNSkqLiD28n9heJkoJlx34DZrHB6aGOUz7MiBj
	90Z4hCSHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6jWI-000732-Kb; Tue, 02 Feb 2021 00:26:14 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6jWE-00072Y-L4
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 00:26:12 +0000
Received: by mail-ot1-x334.google.com with SMTP id h14so18232121otr.4
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
 b=tCDZIyKRfYkflVO/mtEEY/OhC27bA9kqcX/5z+t4BtDBqfjp5sZ49VjvxVeoplOarj
 AHmY7N+os6HUVETD7QEgDovkqXB9vRw9mosvTMB0EzWzWlaO05AsR204OzZKZglBwYiX
 pHQBMKa7/HwClvsBCbv5i43x7LoXh+9DL2zfBgKB+ONF2UqWACyeWSzlt2oyy3ElQkYU
 jU42fR2o3wK8iolXAqeuVQN1utwYgYnSs8VYPrrMqiVJVYcqHdUGJWMc9C9X41IuMgq9
 H5UcsTgNmbqCwr1LI57T+EnrptCtYRBZDYWAvgWbsMxvK6h1QSipoNDTD9tPto4A4sar
 N7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
 b=D9KHT8K3K1F1wLzH6TaPbGZSoTkae59VtF+aRBCXNc7ZM1//sbtplUr8SGN+yZzYM0
 xlgJ9TgBHWZNLvYPlXBDkOX85NmbO7a1vbUkr7oq8wjwlXtjiQeKMxyVmNRvIK8iBBBp
 4oOMU0w3PQhKO0ofEbuEbee6gr7enj/Z+MXATeTCae1My0hCpDJ5nRkbM8E08CKE3o3h
 N8/qqsu4MRI6wjg4v9HJp2DpagiA1YS4lpJ7dIAJFF7sGEk95aJZCFiiLMD1CMIQaweg
 jIiENAEl8VWT/DkRlcD5h4MuP5zJHkhEu5gzpyR/cbXlHhw+5UTr/JOobvCh0RsC0QkU
 bGHw==
X-Gm-Message-State: AOAM530XSRp9DqoygbZHRa+6wVdm6SBce/66EvIbjdMxEwv9BQXujuQX
 fBqe7jgtHXqytAyqbQHXeB4UiZlJbALawyX7v3ka9Q==
X-Google-Smtp-Source: ABdhPJyFgXBxhpe6iO2OHTC17kqmn9HUrbruwF7fouFTXMMPS3G9sjeY2vc7eAvB7AwHVf2zMFQpAJVvevVDT4EA30k=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr13319071otn.205.1612225568439; 
 Mon, 01 Feb 2021 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
In-Reply-To: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 1 Feb 2021 16:25:55 -0800
Message-ID: <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_192610_746474_0C68EBDE 
X-CRM114-Status: GOOD (  21.90  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 Erdem Aktas <erdemaktas@google.com>, dan.j.williams@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?

I agree that setting it once is the right way of doing it.

So I have changed the patch to enable the mask once in nvme_probe.

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..4ce78373f98d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2630,6 +2630,9 @@ static void nvme_reset_work(struct work_struct *work)
         */
        dma_set_max_seg_size(dev->dev, 0xffffffff);

+       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+               dev_warn(dev->dev, "dma_set_min_align_mask failed to
set offset\n");
+
        mutex_unlock(&dev->shutdown_lock);

        /*

However on boot of the system, the following error happens occasionally.
The error seems related to Journal service. Whenever "Stopping Journal
Service..."
appears, the boot succeeds. Otherwise boot fails with the following message.

----------------------------log start here--------------------------
[  OK  ] Started Journal Service.
[   10.774545] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Load/Save Random Seed...
         Starting Create Static [   10.804340] systemd-journald[780]:
Received request to flush runtime journal from PID 1
Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
         Starting File System Check on /dev/disk/by-uuid/7281-17FC...
[  OK  ] Started File System Check on /dev/disk/by-uuid/7281-17FC.
         Mounting /boot/efi...
[  OK  ] Mounted /boo[   11.203461] systemd[1]: segfault at 2e0 ip
000055b08607cc24 sp 00007ffe13809090 error 4 in
systemd[55b086000000+140000]
t/efi.
[   11.216088] Code: 02 c7 44 24 10 fe ff ff ff 49 89 e4 89 06 48 8d
6c 24 08 48 8d 5c 24 10 48 c7 44 24 18 00 00 00 00 eb 10 0f 1f 00 48
8b 3c 24 <44> 39 b7 e0 02 00 00 74 3b 49 8b 7d 00 4c 89 e1 48 89 ea 48
89 de
---------------log ends here-----------

> Based on the Keith's comment it needs to be completely avoided in hot path.
>
> Did you get a chance to bisect the problem in the rc6 ? We need to know the
> root cause otherwise it might happen again after we add this patch.

I am now trying to bisect the problem.
I am not sure how the mapping offset could have caused the error.
Any suggestions are appreciated.

--
Jianxiong Gao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
