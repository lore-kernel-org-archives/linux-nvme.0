Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85631C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 06:30:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF1F610E6
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 06:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF1F610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n8lUh7sVQlPBDtx4FBN6PZLVvITJwekKLEW/BuBqD6Q=; b=luXeOdqbFEgggxWnOt1UMwfYi
	eCQlPxDo3L1MfEgX5BKq8+iWVvV4PCrmEb/ni0E+LbVuTrOw98CmBzCWdCgee6rBWw0ivqxYbRqxv
	DMZ5jgLR+nIZh1F7jjVtDsGL55buAHiQ/QjHHxrSPbKOay4cw16ZL4YF3M4OOgWrOEBhVuKWGJjs4
	cM5zl5C/sRIC1WWzFvl2qBFWywuPxGx2H0GmD5kt7iOEfWgjE+s/W6bNlKFNCRbefsw+ElkC5zKnM
	p7IoZr1/hrsSDY+SSYY7ePPqVxi5VCFPF4+MR5V6qNmMWZbp+vF9chyF9p+lEYsnFsLQ5F1DZyeH1
	gsNLUv00g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWvVk-00F45w-Eg; Thu, 15 Apr 2021 06:29:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWvVh-00F45F-Im
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 06:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yUEZwpdxlFaE9CI0PT/BREQNG8IOFe+2labMEDUeBGw=; b=YeMu3piE7mSz+8BP6+NaBJD1Ru
 4fvYNGcDQ3FdFOYKpIls/RbG0Sc9aWIU6NFinc9B8h2CJPLd0xEA/TLypQiMdrZD/YyUcMbTUzkVl
 gCescQWOFCB/3V3XW4G0kuv/X+MprNouu3f7iP76bm4M0lxlXZNDPdCFjuSloSZQQlPozoldqUDfP
 P7KXmuYWI5tcAX+2+8BiP+2tg2H2bYYXSidjbxIBbv6lXVgIJtxPV/16RRxgHtxzAqdV1WjPNwwr0
 0pcXAnrOZS/67UMBDCo+k38/Iy3n94tzNwHTlOPwewjfd7vfgMMoPHr+J5Xw16sLiNFN4POxQkj7P
 fSEwaE8g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWvVf-008JTH-2k
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 06:29:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5077E610E6;
 Thu, 15 Apr 2021 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618468190;
 bh=3A32B+gZv0zuuoI1QYyb0Ju4ttAEz+Z30b2UWx7sLHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nW1eT1knhuE/j19o/RX8RbKIQAuTcJITT3YC+TQYH7wPW4NVdXjqm6y3Yur6nVD+9
 CI5aVlJVTlIf45+GMecqzz9vQLlwe5CIboaakLZLHjfFmlHuSc/7GizkoDCzHfhV0S
 AYplWgCetgpmGSuI62CCjf53b84cpbmbfnNw+EfQ=
Date: Thu, 15 Apr 2021 08:29:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 hch@infradead.org, stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <YHfdWYY3QSjIM2lT@kroah.com>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <1618458725-17164-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618458725-17164-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_232951_171955_7385DD41 
X-CRM114-Status: GOOD (  21.00  )
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

On Thu, Apr 15, 2021 at 11:52:05AM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need
> PCIe power setting to resume from RTD3 for s2idle.
> 
> Update the nvme_acpi_storage_d3() _with previously added quirk.
> 
> Cc: <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

You don't sign off and review a patch.  And you do not put a blank line
between them, this should all be one chunk of text.



> ---
> Changes in v2:
> Fix the patch format and check chip root complex DID instead of PCIe RP
> to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> 
> Changes in v3:
> According to Christoph Hellwig do NVME PCIe related identify opt better
> in PCIe quirk driver rather than in NVME module.
> 
> Changes in v4:
> Split the fix to PCIe and NVMe part and then call the pci_dev_put() put
> the device reference count and finally refine the commit info.
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6bad4d4..ce9f42b 100644
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
> @@ -2845,6 +2846,12 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>  	if (!root)
>  		return false;
>  
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));

Please look at the root bus for the specific device, do not assume that
you are only on this specific bus.

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
