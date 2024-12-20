Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E8AE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5boJminZgitxq3r5NaydDCyPtGRydqEl633WaiR2zg=; b=X55u24ntwwRtB+pv8Kzh/wtG0x
	hhhRNwyaTqxoyDSZA/Yj5Mh/n0QYZJKTY0NByzsDa6L5ryC2SpCrwhRBnbYz+gQ1E0qyoLgZfU0/z
	lIRmiHpHXvQfseJrMlW0dkCX/2i8+kUNIWRGfC6bhRHSkFXag6g2ebptv1eY+3zWDtf3FV+tr5Qu4
	qprmhTLqhscB8pzL0ZctrywGcEyT1Z0OlVcm4UyAxr7ZFnfYcqknqKd+OZVMlc6eun8zP3U2QmXJV
	GOt+cB+MRLuCB6mgrOozsGfeZ9WsHkn+D1TX3lraAgnQwJtCRjnfWKpa1wBS2v2LAZ2ttEvcnhAnw
	I98WGv9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOY9e-00000004FTd-1Uec;
	Fri, 20 Dec 2024 08:14:38 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOY9c-00000004FTB-1Dig
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 08:14:37 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-852fff91550so427115a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734682475; x=1735287275; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5boJminZgitxq3r5NaydDCyPtGRydqEl633WaiR2zg=;
        b=n+9SJ/rJT1JcPAMyQojfL5nbnPHfZth2n3iKK/BgoFC/bbfM7j7wPgYAmjVz26ZqyX
         45L0T9q+2M3NqDNVkBvpPB+ZDvYUQGqfCk2YP7h5aUtiIDPjc6g9fNZZambrtm2H6umY
         wUtKpY2FOA0AImOYX5pDmTSOujX4wxAVQOAXWQUxqo+WkWYEBcfhRyQg/T6jO/dOf8cJ
         AVlh+BmiH/UNPbjLRnOIo+44eC1E9tfWYC9VibAZ2D/sdUANhCSOPdQX30EzgymT7TdG
         ROc2V/4GT+PhEZdpLia2DpmLl3mZxdxa9RPb76RFjuV/YIQeV6UzJdZzV0nuqjQkUaBw
         XnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682475; x=1735287275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5boJminZgitxq3r5NaydDCyPtGRydqEl633WaiR2zg=;
        b=iX9DWA+oRfrbRXyrwImCCGjV+xpQcYtcUjm3xKUTODCl5XUTvm2DTZO0GqnWHwiToq
         stn+d1FNAJvLY5egQlfRaJBSkqJJwde+97nC/08/ohgVxBeJ+pPhA+h1o95PvPDMID6g
         rX7XVHiU0/ypFdiVQMiEEMTzt4hpb1k3XAm1ymYaXU8DouqNXWoGGiKAU6VNEln/9dkn
         jU45nmuN1D1AJQkmH3ruIt+WsU26qWvKg/Y8fltnzR/FsQR+xWHRd+5I8N3OXCoT0iDr
         /c4IHEATZgpm0NcGtXmjjPzSdlrLBMTbrbiLJgKYaww28DTNDJiuqx0hAZOr3XhKUrFi
         7naw==
X-Gm-Message-State: AOJu0YzEIVot1tgEySc6kaUTN3Sac7KWVD7s43epT7pw11T9Mm4+yW2J
	6jFKYg/CBSb1xOhLOz11im19Mh3bVfY9aZS/quhWlwlma6fNSVozpZuWEpv6H5zDExDfaL0YWEg
	=
X-Gm-Gg: ASbGncv78ZODYh8XAVgKN20+7kQ4XW5X9WRqq5tiIgceffi/EEt+hVVsPaHhGHF30F0
	LoFKvaNRkCiDTu0dyqyP0xg8yc6iRDzR76qW+SpPWtyRBzoq+WILcpKFcc80jQawDlaaBKwbmam
	a2HziLu4q0XkYGzQtwYAwlE7pNUKKF1vYJ06dQlTyWaD6H0CdxGU6jjg0h5nLHbbmbeK2jik4Iq
	srutudQRAqmR0rqjYNzzcCrPfr76VzTsrHfykiq6eeK9c7Jnaw5DMEiMNv1fAgN3s1S
X-Google-Smtp-Source: AGHT+IHOl61JImRQqmKCDrXFRMLTrXVw/zhuZfo68uKgYeo2DlE/cbas/GF5RcYOFesppKrRBmopqA==
X-Received: by 2002:a17:90b:514d:b0:2ee:dd79:e046 with SMTP id 98e67ed59e1d1-2f452e2e49dmr3073613a91.13.1734682475386;
        Fri, 20 Dec 2024 00:14:35 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd54sm5070410a91.41.2024.12.20.00.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:14:34 -0800 (PST)
Date: Fri, 20 Dec 2024 13:44:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220035441.600193-19-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_001436_337643_08E3CBEA 
X-CRM114-Status: GOOD (  24.13  )
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

On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
> Add a documentation file
> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> endpoint target driver. This provides an overview of the driver
> requirements, capabilities and limitations. A user guide describing how
> to setup a NVMe PCI endpoint device using this driver is also provided.
> 
> This document is made accessible also from the PCI endpoint
> documentation using a link. Furthermore, since the existing nvme
> documentation was not accessible from the top documentation index, an
> index file is added to Documentation/nvme and this index listed as
> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> API index.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Small nit below.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-nvme-function.rst        |  13 +
>  Documentation/nvme/index.rst                  |  12 +
>  .../nvme/nvme-pci-endpoint-target.rst         | 368 ++++++++++++++++++
>  Documentation/subsystem-apis.rst              |   1 +
>  5 files changed, 395 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
>  create mode 100644 Documentation/nvme/index.rst
>  create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 4d2333e7ae06..dd1f62e731c9 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -15,6 +15,7 @@ PCI Endpoint Framework
>     pci-ntb-howto
>     pci-vntb-function
>     pci-vntb-howto
> +   pci-nvme-function
>  
>     function/binding/pci-test
>     function/binding/pci-ntb
> diff --git a/Documentation/PCI/endpoint/pci-nvme-function.rst b/Documentation/PCI/endpoint/pci-nvme-function.rst
> new file mode 100644
> index 000000000000..df57b8e7d066
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-nvme-function.rst
> @@ -0,0 +1,13 @@

[...]

> +Configure the function using any device ID (the vendor ID for the device will
> +be automatically set to the same value as the NVMe target subsystem vendor
> +ID)::
> +
> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
> +        # echo 0xBEEF > nvmepf.0/deviceid

It'd be good to mention that the vendor id set with nvmet configfs will be
reused here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

