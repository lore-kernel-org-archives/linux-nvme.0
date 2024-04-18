Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05236C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 01:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wa1DepT+IeFOlvfkPoz97kU/+5JWb4sHyxSDsDbAIPs=; b=XCxWi3QkQ4zgVRW0Co8CfrHphp
	/ReNIaD+st1D+jTgdu0RPvdI61NjfXP7wEhb2F9nC86C4bw4GtwpHvYkkpybVgaL1/IhNPvb/5rjG
	A/c6dhAgZnYEqqGu942fnd09jBEk+vu8xMcx2ZznGSRFQ/QA70RCVZhTvWnPXEjISZRisHq/LazUQ
	TAuKLwV872hzPGqvvSZTVlLjHw0e1e8URugZ4wA1RC55P4HAczefX7Y4D83V0nk5epyCCj0mRxFrC
	87u12+IIH+MFHrPEPFctPCeCeDhMpW1V8CyTygKap6sCp1sPCmLbn/2fup+96AsufewFEdFKVB7Bw
	ItMd5p7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxGNd-00000000XVp-3hpo;
	Thu, 18 Apr 2024 01:16:01 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxGNb-00000000XUU-1V9o
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 01:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713402960; x=1744938960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uFbfo87nO14001kmIG2rJyAQXlEfsQr2jrkvTkeyE/M=;
  b=jp/g5a7SRxFr+yw3b5H5YjnlGEdzQjfzN+wqEObI6yStzPJCqbdz3RuV
   QcFbmr36z8hXVCo+u/qWVNkqmy3FHJI2gTjkGYisEix1KdSVi+xs8bf03
   AYABSX5UdG7O/DQwDpWbyPfqhHG43lDTKIUHlpYGYaJosFqYCAzegDR62
   AGlo7xmz/WUAUkChixid6c4d6Vj5PCqqHYhU55DY7UgpG0odJnBSkuZtn
   FHrxplU2Ju/sZuB3tFvItKLsL3Q9tQX9yIpZeV5ji9Hhbnv5InXR8kgPN
   zOjLjgt5lKJUaOnJ7Hl4ht9+EOWoLki5zx1mMdoYM/EjA88oWDUB7+z+D
   A==;
X-CSE-ConnectionGUID: N+/55DOwT1quB+7TPRt9qg==
X-CSE-MsgGUID: hPQqxjL2TJq7oT1CuJ8R4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8799544"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="8799544"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:15:53 -0700
X-CSE-ConnectionGUID: Qg3sfDisSnqFwL5IYU/Blw==
X-CSE-MsgGUID: ay2i8yP0QI2Tkuy5KlkNFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27470822"
Received: from kglossop-mobl.amr.corp.intel.com (HELO [10.209.94.180]) ([10.209.94.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 18:15:52 -0700
Message-ID: <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
Date: Wed, 17 Apr 2024 18:15:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bagasdotme@gmail.com, regressions@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
 gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_181559_591440_5265288A 
X-CRM114-Status: GOOD (  20.97  )
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


On 4/15/24 9:32 PM, Kai-Heng Feng wrote:
> In addition to nearest upstream bridge, driver may want to know if the
> entire hierarchy can be powered off to perform different action.
>
> So walk higher up the hierarchy to find out if any device has valid
> _PR3.
>
> The user will be introduced in next patch.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---

Since it has been a while, I was not sure what this series is about.

IMO, it is better to include a cover letter with the summary of your
changes.


> v8:
>  - No change.
>
>  drivers/pci/pci.c   | 16 ++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..7a5662f116b8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
>  		acpi_has_method(adev->handle, "_PR3");
>  }
>  EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
> +bool pci_ancestor_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pdev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	while ((parent = pci_upstream_bridge(parent))) {
> +		if (pci_pr3_present(pdev))

I think it should be "parent" here?

> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
>  #endif
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..cd71ebfd0f89 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
>  bool pci_pr3_present(struct pci_dev *pdev);
> +bool pci_ancestor_pr3_present(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> +static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


