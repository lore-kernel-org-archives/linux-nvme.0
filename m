Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EF9E7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmxHeHKigs+48dEYo5SejUJ5WLXMuH9N7v3NLc8KkRI=; b=x2rQtCpRzRZ6/cUSnke4qZnBXC
	6g55gC/kAnKx49Irh/RVtIEMjkRixqP9C+v4IGkpicw31OhS2EwYxzxIIGx7Y/pfWoDrO1cIWzAVd
	yo3lcI9q8u5dEEC8IHXa0ePdVZk9RmSmnnPwAFRn9zF840RBKPgbLG9L0cTi/r0x59T/Tsae1wRjp
	hOnrt3cCwbxaRVlJSmS88uJvdPVi3ecR5jYyedr+mcdKIuoXafAJL5Pzb5tNBGZhB15T93BpGZCvm
	w0ZLyHmi8IZCDywEErd73DbK5hLBBg337Rq2djri2xXOQJ8JlokmigbXdj5zXrRVZ9ToqkR0iZHSz
	jKNulsnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZHi-00000004Q8b-46Hj;
	Fri, 20 Dec 2024 09:27:02 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZHS-00000004Q7A-41ze
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:26:48 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21675fd60feso19642695ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 01:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734686806; x=1735291606; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmxHeHKigs+48dEYo5SejUJ5WLXMuH9N7v3NLc8KkRI=;
        b=mAn3Zg7SK2rjzrVqRfozO8zXYIrQ2F1pUMH8OgvdYzpTp8nbRpxKJy3XhePO2k4Djq
         8TJshUR+//+5yM8aUrlmFntP78F/+rYdUqx58FO2sTyRF5Twu76chVCA9Ows74FJUZ2Z
         suOyGXY9KzscjadKVpGwEuZtbvB8P9h3Ko5suX0fNzg7dKLilOyl5pvaigYa7fxYjixE
         Z+GyoYKMQFRTJjYjb38F4vMiriMo4evN6C94Y+FcYOMU27CV3LHg5XxIeP1KhsI/c+pw
         I2SDgp1aakimWhZMVea59RIEQ+jTKnL8q+hjQfYXNuKlrZGBcQkx2bFpT5Ao7be4yyJg
         XiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686806; x=1735291606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmxHeHKigs+48dEYo5SejUJ5WLXMuH9N7v3NLc8KkRI=;
        b=sSZHQyL9jFuWpOcQkVndJdYBnf/bogxmhvi8f6eIg55TZdfidvvZgYg8XmXEyI3TOx
         3UcpIYhQwtzSKHZSIrJQ+1ia+2oxoCD7gC7XDVc63zMa2YBQ45ebIV7cUi6v4NzjEVpE
         OB2iYKVdloiBjW3y80A9e2FNFTVlCKG/iNIssrizsMl2LEmnCW+JUuN1KcefNUlHRPPt
         C9RyPFOgH9VnhEwd0yMjhyBBNALkKJZhmO691/bAMLyXZwIEVo5WM1Qj71D6g9Dx6HCO
         +8U2rk912IUaKmK0i2w+ykMqabpZPgyWoS4NDAvfrmgmcTj8DMlsIsHL6wOrxAK37CuF
         nNCA==
X-Gm-Message-State: AOJu0YyLTY4hkMyY4CRmeeVFSmVx8aFePO47Gjfp+grfJrHWMWAuRwzH
	XO4eAwcja2FEcu9XrwnhMHc6FfCnos5v44J8v74V8Ej2nvlc9rNNHsPqCWm6+g==
X-Gm-Gg: ASbGncupxswgwd6uI/p4y4HdG7N30InLC4vhjM/ddAHnc+vY4CniXEJgnp+Ia9iUOH+
	snYfCc2vbj6dEQYty4a62LF6Bnixf35ZGmRdH0Gt/rP2GRJU+8TaZUak3/mt1Ry5UFI1be/p+MX
	D+gf1k1h7Gu8qxZ8KLEgSWF2PeHQWbqLx5KUCE4JLxc7LTz0w/j5NO8X0w49/vSGs7SYDADDZtH
	M1y6FyhUlwi9ZakmSNjVbsDf+9v30RQFQhCv6hItFDe2RNDYpZ1ldo0GcyP0/IhrrXR
X-Google-Smtp-Source: AGHT+IF8/6j5SpRZ5xVNPlCRjshyB1U8Ts28bQ7c35ZQ6MdzVSGq78q4eM7ndU4QIokwR30a8J1I+Q==
X-Received: by 2002:a17:903:990:b0:215:b45a:6a5e with SMTP id d9443c01a7336-219e6e9fdcdmr31864135ad.18.1734686806100;
        Fri, 20 Dec 2024 01:26:46 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb4csm25019475ad.77.2024.12.20.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:26:45 -0800 (PST)
Date: Fri, 20 Dec 2024 14:56:39 +0530
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
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <20241220092639.jho2tbdcxarlzpmr@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
 <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_012647_057129_F4333805 
X-CRM114-Status: GOOD (  28.79  )
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

On Fri, Dec 20, 2024 at 05:59:05PM +0900, Damien Le Moal wrote:

[...]

> >> +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
> >> +{
> >> +	struct pci_epf *epf = nvme_epf->epf;
> >> +
> >> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> >> +			  &epf->bar[BAR_0]);
> >> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> >> +	nvme_epf->reg_bar = NULL;
> > 
> > Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
> > nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
> > dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
> > epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
> > the EPF for platforms requiring refclk from host).
> > 
> > So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
> > separate helper nvmet_pci_epf_free_bar() and call that only from
> > nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
> 
> I do not get PERST# on the RK3588... So I never noticed this.
> Does this work for you ?
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 8db084f1b20b..4d2a66668e73 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2170,14 +2170,23 @@ static int nvmet_pci_epf_configure_bar(struct
> nvmet_pci_epf *nvme_epf)
>         return 0;
>  }
> 
> +static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
> +{
> +       struct pci_epf *epf = nvme_epf->epf;
> +
> +       if (!nvme_epf->reg_bar)
> +               return;
> +
> +       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> +       nvme_epf->reg_bar = NULL;
> +}
> +
>  static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>  {
>         struct pci_epf *epf = nvme_epf->epf;
> 
>         pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>                           &epf->bar[BAR_0]);
> -       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> -       nvme_epf->reg_bar = NULL;
>  }
> 
>  static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
> @@ -2319,8 +2328,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
> 
>         nvmet_pci_epf_deinit_dma(nvme_epf);
>         nvmet_pci_epf_clear_bar(nvme_epf);
> -
> -       mutex_destroy(&nvme_epf->mmio_lock);
>  }
> 
>  static int nvmet_pci_epf_link_up(struct pci_epf *epf)
> @@ -2390,8 +2397,9 @@ static void nvmet_pci_epf_unbind(struct pci_epf *epf)
>         if (epc->init_complete) {
>                 nvmet_pci_epf_deinit_dma(nvme_epf);
>                 nvmet_pci_epf_clear_bar(nvme_epf);
> -               mutex_destroy(&nvme_epf->mmio_lock);
>         }
> +
> +       nvmet_pci_epf_free_bar(nvme_epf);
>  }
> 
>  static struct pci_epf_header nvme_epf_pci_header = {
> 
> > With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
> > setup.
> 
> With the above, does it work for you ?
> 

Yes, it does!

One more suggestion. Since you correctly removed mutex_destroy() from deinit()
and unbind(), you should also switch to devm_mutex_init() in probe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

