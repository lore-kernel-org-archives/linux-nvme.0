Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A387C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:34:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAF6611AD
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAF6611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=mNeWZqckHSIKc+lxzJdJniJHVyRUukLUMbWOzkyUCV0=; b=QasKIZwlgJpsJSG5PS30jGdyZ
	r/DhX//bVnmrinHZPvjEi9ZmkH0ZzJsJegk7kSGc2FKlupcyiSHLmL0Pb9KW3cpxNo9HBjQ2d6vNL
	B0xH9KJZEaU5mZvVBKjLFFtqeZBKWjVwuTLv70EK2CPhoX5BO6DwfNjE2TUca4/guxNVvoHDltHYO
	j42+FFE/rBpzX5UFj4j0HkD3Pw+a8iK3b1SKWozgztDPs5JmRIWQbYEGqeeYSPMt640OKEeHObwbs
	tttJ5kPAGlEulgHKyQ/G5yhICTcY4028wPQli8cQWdwvEXrgKuPwmaMR7TS3yzbETbTTp5JWXoKDR
	ITLWLkGMg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljTpR-0059xt-3I; Wed, 19 May 2021 21:34:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTpO-0059xL-I1
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 21:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:References;
 bh=UxkekoyQDN2hbeSTk0hHRzJaUo6EqvvlFbEJLiHSEO8=; b=ka7WNxNRQRxYYxJahGqYVliQzC
 CEW90IWz9BsXFduCDMbbi7/9xoTuYCdjMG/0wvNE9/OEAGcyF0C3y2F+jXdutK1FWn1vmgeoedI3j
 S9mQB/MnKEKnjK2Fmk5Erry5U+//kjr1AWgXiV8Ahrhyo2j2RD8HDdcuZ+88j4DTf+qp/W1iesPn6
 m1RoFvAf/Y0+TpZLkU2CJatmns9Xx7QaWuon+/sFg+Mr4DOT6pz7AisiuSmWmlQ1dU7NJuw691ctv
 x1HHmPPuzOr77eBKnz5FYROBxtXninqSAdYynxaQYsMdv/jZxSQvkrsTJ6bBHq7vguTYtMShlP5H9
 7XkTODgA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTpL-00Fnmk-PX
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 21:34:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC8D061074;
 Wed, 19 May 2021 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621460041;
 bh=P4pBbb+gpfVC0LaXhR2HVFGTt4ylPWLlXS4sxpNN6/4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=pDctJk6zxPhASM4cufXgw00O0lh5OH4gCGCZiBDQbLlk9kurV3jpn+J/CAfwJv9yO
 DR34pZ3hhPPdiikP0zSP66uVuPqp89zCyMI18IIZOOXKFx61AzJqDoGPXtkyz4X4km
 5YfWBSfXOKytwRKJM87Nw7J7I6dYzDeIcXNv5PYP6CzZyaVm3P2RGodD1Gdyd6zzEj
 M+QRTWuORa1yKAcBW8chBJX83pFGbC1sEMF8NQ85ENKkHF3Nzii5oRdh2W+c8/05Rh
 DvNLYZ+iGsqinFVGBfZ8AqaoH3X4PHjvYG/BL2Up+aP46o9NMFdELMWxaOVxvtelTB
 B1eLXR6HLxCBg==
Date: Wed, 19 May 2021 16:33:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-pci@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Alexander.Deucher@amd.com, stable@vger.kernel.org,
 Shyam-sundar.S-k@amd.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210519213359.GA256663@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621304675-17874-2-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_143403_897927_5E0AF123 
X-CRM114-Status: GOOD (  34.16  )
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

[+cc Rafael (probably nothing of interest to you), linux-pm]

On Tue, May 18, 2021 at 10:24:34AM +0800, Prike Liang wrote:
> In the NVMe controller default suspend-resume seems only save/restore the
> NVMe link state by APST opt and the NVMe remains in D0 during this time.
> Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
> and then will lost the NVMe power context during s2idle resume.Finally,
> the NVMe command queue request will be processed abnormally and result
> in access timeout.This issue can be settled by using PCIe power set with
> simple suspend-resume process path instead of APST get/set opt.

I can't parse the paragraph above, sorry.  I'm sure this means
something to NVMe developers, but since you're adding this to the PCI
core, not the NVMe core, it needs to be intelligible to ordinary PCI
folks.

For example, since you only use this flag in the NVMe driver, you
should explain why the PCI core needs to keep track of the flag for
you.  Normally I would assume the driver could figure this out in its
.probe() function.

Quirks are usually used to work around a defect in a device.  What's
the defect in this case?  Ideally we can point to a section of the
PCIe spec with a requirement that the device violates.

What does "opt" mean?

What is SMU firmware?  Why is it relevant?

Is this a problem only with s2idle?  Why or why not?

The quirk applies to [1022:1630].  An lspci I found on the web says
this is a "00:00.0 Host bridge: AMD Renoir Root Complex" device.  So
it looks like this will result in PCI_BUS_FLAGS_DISABLE_ON_S2I being
set for every PCI bus in the entire system.  But the description talks
about an issue specifically with NVMe.

Is there a defect in this AMD PCIe controller that affects all
devices?

> In this patch prepare a PCIe RC bus flag to identify the platform whether
> need the quirk.
> 
> Cc: <stable@vger.kernel.org> # 5.10+
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> [ck: split patches for nvme and pcie]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Acked-by: Keith Busch <kbusch@kernel.org>
> ---
> Changes in v2:
> Fix the patch format and check chip root complex DID instead of PCIe RP
> to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> 
> Changes in v3:
> According to Christoph Hellwig do NVME PCIe related identify opt better in
> PCIe quirk driver rather than in NVME module.
> 
> Changes in v4:
> Split the fix to PCIe and NVMe part and then call the pci_dev_put() put
> the device reference count and finally refine the commit info.
> 
> Changes in v5:
> According to Christoph Hellwig and Keith Busch better use a passthrough device(bus)
> gloable flag to identify the NVMe shutdown opt rather than look up the device BDF.
> ---
>  drivers/pci/probe.c  | 5 ++++-
>  drivers/pci/quirks.c | 7 +++++++
>  include/linux/pci.h  | 2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15a..34ba691e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
>  	INIT_LIST_HEAD(&b->resources);
>  	b->max_bus_speed = PCI_SPEED_UNKNOWN;
>  	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
> +	if (parent) {
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	if (parent)
>  		b->domain_nr = parent->domain_nr;
>  #endif
> +		if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
> +			b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> +	}
>  	return b;
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3..7c4bb8e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
>  
> +static void quirk_amd_s2i_fixup(struct pci_dev *dev)
> +{
> +	dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
> +	pci_info(dev, "AMD simple suspend opt enabled\n");
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630, quirk_amd_s2i_fixup);
> +
>  /* Triton requires workarounds to be used by the drivers */
>  static void quirk_triton(struct pci_dev *dev)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 53f4904..dc65219 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -240,6 +240,8 @@ enum pci_bus_flags {
>  	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
>  	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
>  	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
> +	/* Driver must pci_disable_device() for suspend-to-idle */
> +	PCI_BUS_FLAGS_DISABLE_ON_S2I	= (__force pci_bus_flags_t) 16,
>  };
>  
>  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> -- 
> 2.7.4
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
