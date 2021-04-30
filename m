Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2015C43462
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 17:51:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A91161207
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A91161207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=WX8zO+725XptYBsdY2YSg5NFQL6BwM9MdtSvu+sfdvM=; b=L8Xr3djiE1vRZ31RFNhKqN5WM
	cITLEkMYY8+qBCfck9aCzb2uiRmp+dDdj0ea9qt0+yF6D2hF+wRJxGnGO/jNDnMbX5WfNQxGnpG81
	fQwIK2Xk/148f+znrTDcet0biHDWQ+JJ7+mm7dmLnBx4886iVTcjO8Ql0wo5fa1PyQtPBI8VGJuAv
	o4bcuuo33bbS46zQyT7TdpkfA/nlo5e1/Ydx+CPvE7iBr1EJaadX4GIxGcNnET35IO48QIe0MN1xO
	xhf+44vkAfZ0Qqe51M5fUpRqoOnGCIfDIhIA03eurAT0WQiY/qaY8Pl7hSQSkh7nUrCqidQ0UC5RY
	p4XegO4dw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcXI0-008Jgv-RX; Fri, 30 Apr 2021 17:50:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcXHz-008Jgj-7I
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 17:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=k2WmWIxggLQrp/zSkBexaOynDWmd8xm3t91nPuEo+nw=; b=wqgFwNJ4t/4b83NbGpaWHdi/i+
 d8SMuHIiHyRokXQ4DVQFoCmOHta1e3dGOYftNqrTTVvuQFDQevx8Ur3gf14wu/DxZKCZ4uY5OCCzV
 0IB/LcHs2vnTrN+YR1ePtBFuCJI5kQFIWfIrxUkyMnreGhnZA9usQ0lVBTk1e48/1xuTT5NIJLRTc
 bM33ybnautnjracoapNS0BewfUKcFsuGZ6gCKaMWVhxuTS3SSNSz2JoNh9KS/ckmh6BZ4k86StvA0
 OYoTgXC1BX30THY0wV9Oy0hZFkzz5llyf6mYGgyojIlV9Wjf8FgIT7tZOJyJt/bG9ARY7iBKhGnlD
 52uwpocQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcXHw-001ZGA-Dm
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 17:50:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CB061186;
 Fri, 30 Apr 2021 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619805051;
 bh=dsUAq9OHe+LM0RLcK+sEicotIP9gabDGvl8bPpPeIlM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=OzW4mTmJO77VGepm6/NAttAoxNHkTLpoVZixQpfcdMsdPP3azlHoo/EJvoUvoneZW
 /L5lVdGwtqPwY/J1mbp2FIF2QKF9Okvz+MfGJrcLm2ChPGzy+CiofIJdQfyPM9cRSX
 pnyudU0UVYLnDk6cN+bUDEU1WIRnxN7CZ2FwAdtK4GFNrI6IAwQ30E/eawC3EX71UW
 Z1ObRB3JqfMsktdGY5l6g9itAreyqG/KRPg/ibf9lKwa+AzwUMqxhPs9cbxWjNce0z
 H1rQy1kFCv7csLxG+xb1LQwAPLEDlcEruu+6BwEG7ht8FNADa9n1LF1EzKzkg1eFEO
 w2Rj32v92NXhg==
Date: Fri, 30 Apr 2021 12:50:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 gregkh@linuxfoundation.org, hch@infradead.org,
 stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210430175049.GA664888@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_105052_561284_021447AF 
X-CRM114-Status: GOOD (  28.39  )
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

[+cc linux-pci, Rafael, thread at
https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/#t]

On Thu, Apr 15, 2021 at 11:52:04AM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power setting to resume from RTD3 for s2idle.
> 
> In this preparation patch add a PCIe quirk for the AMD.

This needs to be cc'd to linux-pci (I did it for you this time).

Sorry, I can't make any sense out of the commit log.  Is this a Root
Port defect or an NVMe device defect?

Patch 2/2 only uses PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND in the nvme
driver, so AFAICT there is no reason for the PCI core to keep track of
the flag for you.

I see below that Christoph suggests it needs to be in the PCI core,
but the reason needs to be explained in the commit log.

I have not acked this patch.  Please don't merge it before clearing
these things up.

> Cc: <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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
> drivers/pci/quirks.c | 10 ++++++++++
>  include/linux/pci.h  |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3..f95c8b2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -312,6 +312,16 @@ static void quirk_nopciamd(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
>  
> +static void quirk_amd_nvme_fixup(struct pci_dev *dev)
> +{
> +	struct pci_dev *rdev;
> +
> +	dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
> +	pci_info(dev, "AMD simple suspend opt enabled\n");
> +
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1630, quirk_amd_nvme_fixup);
> +
>  /* Triton requires workarounds to be used by the drivers */
>  static void quirk_triton(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 53f4904..a6e1b1b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -227,6 +227,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	/* AMD simple suspend opt quirk */
> +	PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND = (__force pci_dev_flags_t) (1 << 12),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
