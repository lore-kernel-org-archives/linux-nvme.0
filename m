Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6722BE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWKZ7yU7lz3ojV6mlmNYCITfdB0jo1tGhiz+XfLBXW4=; b=sRdlhjCWe/+v71aPeciFA79ddj
	H8FDGq4HOhWKjhTyI8zaq6ylxPbRd4HWu9p2GHLE+8JiiyCEwYiE1p8U3QTkhrH2uuA+YCXG+nzHV
	qwMRRrFm7Q4lbkH84l+yUmDqZO+AzUiO3BTfdomlvPMaKZlB4Q3B2CRe643yOy3ghmmNIKIzu27Ta
	wSGw8XrE1gz8vYA9vlwp5ruDw7iEMvedUveG3fIUhKVnoFrkAAVauZ6EjJ4eJi1D9sMka5ubG2q1s
	HECjIo+Ta/ObkBPcI1CdiWKsBKaCweYN6TMSHhkgsXhtkuZTc90XlPPCiNeEdhM9vOP2d61utiiEk
	CL0wshwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNbD6-0000000EItc-0N3O;
	Tue, 17 Dec 2024 17:18:16 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNbCJ-0000000EInq-0Jte
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 17:17:28 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-218c80a97caso10946815ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734455846; x=1735060646; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EWKZ7yU7lz3ojV6mlmNYCITfdB0jo1tGhiz+XfLBXW4=;
        b=mjblwl/ykv2lGucb/7TsLU1UWRJhhWRH7gGhmNipQEGv0Pp8w0Qaok1bwff6+rSQS9
         SE07Kvma2bvjK83Z4XS2KWAPkf+ubJPhs3mtzTM/YLor6HV5vTaOWlutWhhxuirlm58Z
         5tZM/RjaXPNpZ+eunN9N8rE5Foemhg3gr7GBM6WWNoCnAh6iUcND8AZ91l2os4PNj3jw
         LEH6QJCWEITBFb7uYoRkLhnOuPYKDszjATrMcBzXMGpvVzJxHIq5L/0MDo7kif06MObM
         zZ9nDjbH3euZZmeOOf0H005zMg3RJqh3cu55XhBr+gzjerFKb8GjT8AwLjKXfzPH5nfl
         CXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455846; x=1735060646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWKZ7yU7lz3ojV6mlmNYCITfdB0jo1tGhiz+XfLBXW4=;
        b=qezm1Vd0M5tpHHXtrreHzgRIDHcvcENGBwVaX6hi8j4K6lsfaxKx2O8na8LcAg3Xsk
         LsuMS+g6nmSlRckmmHEKXRY/Eg1N2nSwxMzVyLmDYcUcsZd+yv6hJ3zUUKfoIzcVVbmm
         vQGAj2orsesad25/02jQeJEG5V93jywcdTdAHf6RJVJRpoJl5pc39O3JUlhogYzkW5Yo
         oN6TUJ4e0w+iQiiaAkzf/sdgsz6sypo6/OMN4ckwnC0J/rfcgEH40Q5+X8LL1LoqSSLP
         1TgrlNsQ8+4LdNKtjDtZ5SclrBXeO1kCZxXVN/nXKcHBl/qPcGgnXuVUyTG5t2IP2VH+
         V6cQ==
X-Gm-Message-State: AOJu0YxfzSCbbwc9J1VM6tc1Rlsk2jgjFqLpruxucXUzl/GgWKNuPU9E
	KWRNqrFOuLC9VWkrW04BfRuHGMDg1bHHWfP27oXv9+fATs7YN2eh8vR0xr23pg==
X-Gm-Gg: ASbGncsOscnt5Kw/qWhnCrEYjCzk727zw+DOnhtdolkWwqRga+pdGSTlk+s4ImfyA1H
	0NfVNOabot92WveIFLZECvMd2ZDCo3guRQ+KjkzrAu5f/kBgcLr3xEoi7X47llTqGFgytY7v0lR
	bOLL6ETB8pOH1Pfqa0QFi6xJkYbXFO7RpNSQ6vmmBU6s7wiajRX2PoDxkdsy6TU38nKBMjfM9bo
	X0Zn9H0KKFBuHUSRvA8tT2AZzQ8R57QuVoBjgN+uquIhzhXkUNLtz+9rNJcyBCeHYy7
X-Google-Smtp-Source: AGHT+IHw0j4waZkD5AOaUOZbUb/afL8zOjtN94gaSgY9b1aG30bn7rZvne7ekkCLaJV9utR7RGn4Ig==
X-Received: by 2002:a17:902:e88e:b0:216:386e:dd8 with SMTP id d9443c01a7336-218d4f76563mr4328115ad.17.1734455845878;
        Tue, 17 Dec 2024 09:17:25 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5011bsm61959185ad.152.2024.12.17.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:17:25 -0800 (PST)
Date: Tue, 17 Dec 2024 22:47:15 +0530
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
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241217171715.wqawrrk3c7bdmxtn@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
 <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
 <20241217164149.vuqwtthlykn7bobj@thinkpad>
 <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_091727_113634_7920607C 
X-CRM114-Status: GOOD (  33.21  )
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

On Tue, Dec 17, 2024 at 09:03:08AM -0800, Damien Le Moal wrote:
> On 2024/12/17 8:41, Manivannan Sadhasivam wrote:
> >>>> +	/* Create the target controller. */
> >>>> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
> >>>> +	if (ret) {
> >>>> +		dev_err(&epf->dev,
> >>>> +			"Create NVMe PCI target controller failed\n");
> >>>
> >>> Failed to create NVMe PCI target controller
> >>
> >> How is that better ?
> >>
> > 
> > It is common for the error messages to start with 'Failed to...'. Also 'Create
> > NVMe PCI target controller failed' doesn't sound correct to me. But I am not a
> > native english speaker, so my views could be wrong.
> 
> I do not think this is true for all subsystems. But sure, I can change the message.
> 
> >>> Why these are coming from somewhere else and not configured within the EPF
> >>> driver?
> >>
> >> They are set through the nvme target configfs. So there is no need to have these
> >> again setup through the epf configfs. We just grab the values set for the NVME
> >> target subsystem config.
> >>
> > 
> > But in documentation you were configuring the vendor_id twice:
> > 
> > 	# echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
> > 	...
> >         # echo 0x1b96 > nvmepf.0/vendorid
> > 
> > And that's what confused me. You need to get rid of the second command and add a
> > note that the vendor_id used in target configfs will be reused.
> 
> vendor_id != subsys_vendor_id :) These are 2 different fields. subsys_vendor_id
> is reported by the identify controller command and is also present in the PCI
> config space. vendor_id is not reported by the identify controller command and
> present only in the PCI config space.
> 

I know the difference between vendor_id and subsys_vendor_id :) But as I quoted,
you are using the same vendor id value in 2 places. One in nvmet configfs and
another in epf configfs. But internally, you just reuse the nvmet configfs value
in epf. And this is not evident in the documentation.

> For the config example, I simply used the same values for both fields, but they
> can be different. NVMe PCIe specs are a bit of a mess around these IDs...
> 
> >>>> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
> >>>> +{
> >>>> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> >>>> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> >>>> +
> >>>> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
> >>>
> >>> These prints are supposed to come from the controller drivers. So no need to
> >>> have them here also.
> >>
> >> Nope, the controller driver does not print anything. At least the DWC driver
> >> does not print anything.
> >>
> > 
> > Which DWC driver? pcie-dw-rockchip? But other drivers like pcie-qcom-ep have
> > these prints already. And this EPF driver is not tied to a single controller
> > driver. As said earlier, these prints are supposed to be added to the controller
> > drivers.
> 
> The DWC driver for the rk2588 (drivers/pci/controllers/dwc/*) is missing this
> message.
> 

Yeah, maybe you should add it later.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

