Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE92EC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:34:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C5461244
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5461244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0KO93Hbjg+WLl4zI8oDmIiLUqdwlqoLoosmbyO3w1Ro=; b=TGscuHGbE4UuAELSgUhyZxLFy
	j6r03JGYcapf2uCUaIVJ/M1vUH7g/caYen7mJTnYmXeKpyXypUgvdpmkoP8oywr7RlbKM5SdHiSb1
	ZiJa5Q3JX6qC5EPWGDY20rOc1YEfwLKQscwStWicRJpPIxrInZ8MDpBxeaxLXaHcRMXlPy3yjhCIi
	Hen8tmliFBRBjNkhqb6MnXM+E3FNSaftQ23MKlsCOGf9UwaFiewuyLniebpyyM66dFeYoHcrpohWx
	M7gRr/w9O8Q3N5KJcnczpO9Dk1yLE6eQcQ8XHexbUsPpaOc/UtAI7MNAiN+P3OcyZ4W9tb9LMGSCy
	OkfHoqcQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWYAc-00BXoV-Gx; Wed, 14 Apr 2021 05:34:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYAH-00BXlG-U7
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 05:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3W5Wyxt59GnMWI2uhZpNojuXYxhz7SWzHjKUf43I7NI=; b=HxCFJ01vjWjXFsLL1OWyFvMHpR
 +KtZk80DQtH6bzE3pdTfMqjVbZj5PYapRs8jtvS3IPyq5AozMTm22g77E1FBhLWt2j5FDhOhwoVnP
 DILiNoucz2ocsdLeCKMMI1qK65R+a0tBeUo/j6FiPzmOQmGnrxAHwtOkwkbQh10yEdIblrFQkYNTo
 CmYV7++ey1aPV+xXwyFT1oBfbN7eYMTvrlG1/ooPmmSeJ9/AFlyqC3U3rGuvb8Tr3bDnCYTIgzNKb
 S0lQ45PGWUg+uebiDcEJ7x3nuPIHXbbSN8xVELI8lfv5MxiNS1iwpFbCLcfBDh5n8MswK1pu6YQvF
 GJEW9fSQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYAF-007Uyy-Ff
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 05:34:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C66661244;
 Wed, 14 Apr 2021 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618378450;
 bh=yfGHiPPoMi92sXuj46ELTK/wlCe18PL65yehcTi8xng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jnm9GfiKZyeTLf10xt14iYqCD9O0SdUeCXGJwX7vjO9f7PHuc9bquhwOLCDfjH8Md
 RiZsoQykix2Yh+Z9ANiNQxVI3NEgty4R4UuRTDrG88v9Zz5mwDEJ1QrDVJJSYzikDa
 GGtSdJqbgZCjxQ3dsxRIH0KYQbUC2Kj141lgX5Jg=
Date: Wed, 14 Apr 2021 07:34:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, hch@infradead.org,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <YHZ+0M9OW7dpiBKC@kroah.com>
References: <1618366694-14092-1-git-send-email-Prike.Liang@amd.com>
 <1618366694-14092-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618366694-14092-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_223411_572755_5F9F87C1 
X-CRM114-Status: GOOD (  17.45  )
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

On Wed, Apr 14, 2021 at 10:18:14AM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need
> PCIe power setting to resume from RTD3 for s2idle.
> 
> Update the nvme_acpi_storage_d3() _with previously added quirk.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: <stable@vger.kernel.org> # 5.11+
> ---
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6bad4d4..dd46d9e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev;
>  	struct pci_dev *root;
> +	struct pci_dev *rdev;
>  	acpi_handle handle;
>  	acpi_status status;
>  	u8 val;
> @@ -2845,6 +2846,10 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  	if (!root)
>  		return false;
>  
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (rdev->dev_flags & PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND)
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
> +

You just leaked a reference count :(

And what if rdev is NULL?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
