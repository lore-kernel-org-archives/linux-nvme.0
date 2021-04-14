Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C27C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:40:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D32611EE
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D32611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CIK3cKjBI40/PKgN1FLEQOTNzaCKtiheP9oJ9IpJOY0=; b=Q0OMz5sWsbN9j5E+sc26JDTqY
	gCGc7XYlufF3xpFIF8HNdb+xHhxGU73cSt6l0mY6LbICJnePE3yJnSny6v49iEsbIqAPC1mPR5/kg
	ceY4fHQ9QtLh3QOZHc4H5uXRj3rByK4bt2w6/8cpBloNVK1aYJ8e0IHSC8qlMbbBW8D8fOBL1PbBY
	h6FyaemIBIziYKzx6st8mbee1naj2wpOMn5/hfM/eBl7EWZ1efU//4DgdiEwCmreppV7U/EEN33ju
	9r4C+Jg2roaDKEoGy3r4TndtHD9zLXE9q4WRpL99VkiIXV+ZUgVz3jmyR0bJjmqJXWrBeliygi1mM
	1adDlxrjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWZBe-00BhfA-I5; Wed, 14 Apr 2021 06:39:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZBa-00BheV-Df
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 06:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tsextURDuTNjnPmOoXQTMGEVT2vv2//1n7G4QAz/poM=; b=Y1ILXllXMYLuvvPK0gPhM+3pq8
 fbmKFEAq3F7PyoCmFobOYw5WZR3NEVGRrdLJsL0mlCDOhf3KTHbY6FgrRkUJ9m12gnz3+GDS/L+Sb
 MvsGOfdC724tb5wSPz1++fVryrI5ariOrDXBxPF/iArHS+UBMxH0MsTw7Vl4WmwSBJAJv4NP44Edj
 O324677oW6N5xZ7OtGS5PhvMfXHduj7DXGkYvlpb7D+ES/sYeZTzmQyBugyPaBR2ckfqwdOY6h+eS
 PWp6X/H+oXQMW3rCS1D6LyLB5YffEtEarUG/gXL+XjtG20mb4mKbmFOqVr4HwF/ZJhgrbaw0F5ix8
 Ph926t1g==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZBX-007X9Y-Qx
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 06:39:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C91D7613D4;
 Wed, 14 Apr 2021 06:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618382375;
 bh=GMFz/FIdj2tlORcbNu56F0SLGNpw8QFajqOz94BYLII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v6m8a7Cb8DYbT3ZWEtxfpdS1uzHpslejPe9BTKjXvjZbwPEvXF9pL0je+ydvqEeUw
 GWYjjJMkEMFh22Un76I8iKZpXQllnGlbOIHQG5/GEynrejKTa+cCnMhsJXFd7+D7De
 MuRL9afbH0AYt09iZo/+g7ZMggUZmm/dfQDDLNcI=
Date: Wed, 14 Apr 2021 08:39:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, hch@infradead.org,
 Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
 "# 5 . 11+" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <YHaOJDm3GCZ8baAV@kroah.com>
References: <1618381200-14856-1-git-send-email-Prike.Liang@amd.com>
 <1618381200-14856-2-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618381200-14856-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_233935_929413_B87A0D8E 
X-CRM114-Status: GOOD (  17.53  )
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

On Wed, Apr 14, 2021 at 02:20:00PM +0800, Prike Liang wrote:
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
> index 6bad4d4..5a9a192 100644
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
> +	if (rdev && (rdev->dev_flags & PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND))
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
> +
>  	adev = ACPI_COMPANION(&root->dev);
>  	if (!adev)
>  		return false;
> -- 
> 2.7.4
> 

This is still broken, why resend it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
