Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D9C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97437613C0
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 08:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97437613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aSveUulbH0UskVD61uj68PVgO2FPOO/20eLO+FPdAxk=; b=H8G6BJDbBiIA6ROz+Ysg3+xPp
	NO4piLvtk+BJ9KhnHB0zhvstUYPhctBQdvKhwNMmnQxi9tTCT/e1hxHjad56ncFqyXUd4Wi90AHg7
	3vjswggCbOICMT8HCRk97prK7SdtUUkHUhX/8KivbHMJF2UXSvvQfETdQp19tB7BtlZ1VoJvWeZJT
	2N4PU9PynAW/0Wj6P/sAV6XWrwh5sTLXwxgoBWat/UtnBoT0owlxZYdcYsrRtxU84PZRAVTIyJpFQ
	Y+f+av6JgnAVSqbryNjetSMVczNYq5ilq8GpcRlbed0s1n4RRZ2McgT3Dszzulr2SdqzUncbo0z0d
	d/7dl7N6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWb5D-00C1I0-QG; Wed, 14 Apr 2021 08:41:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWb3n-00C0gU-PC
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 08:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=iRH6pJIu32mTMXY9a0gZ3GF2z2Z+9T+IFO5Kn2o6tIc=; b=lijbAY2mAS+43im2u17efKaGBB
 kwYocqOF6gHr03i/qNU4ghCT6tbNzMdRClTROD9PIGAn8Pw/XA4bdn0/PRKwCajT0CpOo4SeMNaIj
 bhk0yeVfRxZoKkGcwOAcYcKdOIBiEKj1w03BUWftbhe/fv3XSEaWG9z8GpEFeJdcd9Yase2MUaxUN
 Wsblvgow6wFbrVh+iBKuE7HY2xpXWnDQGIshTKWzmgZSww4ItLiDXlwJzwhScbx5Xn/PeYJfkzJA0
 DLtfTqg7Bq+1FzyI+Uic3Nluxh3bQM0mh0tp6BrhqbSJQgdCkAkBb3CVHL2Nyz6ykqyv4uaPRs4hM
 eGoW6HLA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWb3l-007cQk-3d
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 08:39:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A731613C0;
 Wed, 14 Apr 2021 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618389580;
 bh=WMtLxo60w5WDzrUzRDusq2qVRFIKBXxizv1BbQ/sfAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f6eqSsVDq9ctfDPCbxq4fUW7D1NIUZNPXMUYWtGfY+1+Xc1V3WhUq1mASOkkfAHnh
 96TGjuWxhSmPUh3HSDZkoaMGqeox9SbTu9/Ug4sKxobQ3Sv4a8LAvJ42JoqlAasasJ
 ESjlh04DAlI+AetAks/XYuQkQZ5DrPqwzb5UGXqM=
Date: Wed, 14 Apr 2021 10:39:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, hch@infradead.org,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <YHaqSga3rUif10gu@kroah.com>
References: <1618388281-15629-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618388281-15629-1-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_013941_215142_6444BA90 
X-CRM114-Status: GOOD (  27.79  )
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

On Wed, Apr 14, 2021 at 04:18:00PM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power setting to resume from RTD3 for s2idle.
> 
> In this preparation patch add a PCIe quirk for the AMD.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: <stable@vger.kernel.org> # 5.11+
> ---
>  drivers/pci/quirks.c | 10 ++++++++++
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
