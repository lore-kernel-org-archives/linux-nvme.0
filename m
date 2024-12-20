Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D109E7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiti6fdINijFLp4DXmew4d/6ZEhorO/X5227JNzX8w0=; b=kLnHHm3t0gad2KdD3eFBVtIb6V
	dHMZu3cNi3eNU7Q7gEy52O2chQTFqSyR8RgRI45Yqsj8WrCdPHTMY9URGhPt4P77nfp0j3rBsDA6q
	nqhjYumeNI+gKjYQ7xCT9nb4HyzVwE+CIi5vd3R+RKsZRT8qrot38Qla4Ru6J4D7ed/MNJWjxmkLj
	Lrgyv7//yZX/2ayOUsjkoZnUR+DXNtq4Jmd+9mGV5UPh9FzVaSnFzjylY43w7nkpVSyBO1YVoYyg3
	G/uzw27h/+LOKxGDss6fQ8q4/xPNUzXaUS17ldugr+KaU5fHrhtFT9gTMPMKinhEMzZJpYSWaP9gr
	tcirVUmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZPV-00000004RNg-0d3F;
	Fri, 20 Dec 2024 09:35:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZPS-00000004RNI-1bZy
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 418A6A402AF;
	Fri, 20 Dec 2024 09:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC1C4CECD;
	Fri, 20 Dec 2024 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734687301;
	bh=6aHlxxEE5s0daOuuf5+/ndwzU60spUvmAxdJU2cLcuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXNQJ80b24OZ+voeUJWCUWbNLBLyGYhcTOvSAiSvh9nC5N++hvW/9X6UTiHVeCszU
	 iTlUwlAapQoZzW/8xtDWmZ71cHwmjLGsmA6qf3cfQdWdlJ4HM2l8qZ2GR8E2lpcarA
	 I60lJVQv//mUQEPXdnPMVMwcHV3tjSIHrLVh5peihUkRwS6dnkJcJtSqO4f5JrdKOV
	 eAXFLBFAx+2KSCOwXjtm+ELYXioP21/DCDKdWlJeIhnxyeXUCmrNiC6Em0Vro7p5AD
	 5+67rS8L01LMuiph3jlT5GOOEB0Crg0qnLNpXl4/2fm0yrAFuAaNh5++rCokedVmmL
	 Jl08CxjPAJ2NA==
Message-ID: <80f3782b-c444-48ec-9276-cbfc9dae6a61@kernel.org>
Date: Fri, 20 Dec 2024 18:34:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
 <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
 <20241220092639.jho2tbdcxarlzpmr@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241220092639.jho2tbdcxarlzpmr@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_013502_556408_0686D37B 
X-CRM114-Status: GOOD (  18.80  )
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

On 12/20/24 18:26, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 05:59:05PM +0900, Damien Le Moal wrote:
> 
> [...]
> 
>>>> +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>>>> +{
>>>> +	struct pci_epf *epf = nvme_epf->epf;
>>>> +
>>>> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>>>> +			  &epf->bar[BAR_0]);
>>>> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>>>> +	nvme_epf->reg_bar = NULL;
>>>
>>> Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
>>> nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
>>> dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
>>> epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
>>> the EPF for platforms requiring refclk from host).
>>>
>>> So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
>>> separate helper nvmet_pci_epf_free_bar() and call that only from
>>> nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
>>
>> I do not get PERST# on the RK3588... So I never noticed this.
>> Does this work for you ?
>>
>> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
>> index 8db084f1b20b..4d2a66668e73 100644
>> --- a/drivers/nvme/target/pci-epf.c
>> +++ b/drivers/nvme/target/pci-epf.c
>> @@ -2170,14 +2170,23 @@ static int nvmet_pci_epf_configure_bar(struct
>> nvmet_pci_epf *nvme_epf)
>>         return 0;
>>  }
>>
>> +static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +       struct pci_epf *epf = nvme_epf->epf;
>> +
>> +       if (!nvme_epf->reg_bar)
>> +               return;
>> +
>> +       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>> +       nvme_epf->reg_bar = NULL;
>> +}
>> +
>>  static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>>  {
>>         struct pci_epf *epf = nvme_epf->epf;
>>
>>         pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>>                           &epf->bar[BAR_0]);
>> -       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>> -       nvme_epf->reg_bar = NULL;
>>  }
>>
>>  static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
>> @@ -2319,8 +2328,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
>>
>>         nvmet_pci_epf_deinit_dma(nvme_epf);
>>         nvmet_pci_epf_clear_bar(nvme_epf);
>> -
>> -       mutex_destroy(&nvme_epf->mmio_lock);
>>  }
>>
>>  static int nvmet_pci_epf_link_up(struct pci_epf *epf)
>> @@ -2390,8 +2397,9 @@ static void nvmet_pci_epf_unbind(struct pci_epf *epf)
>>         if (epc->init_complete) {
>>                 nvmet_pci_epf_deinit_dma(nvme_epf);
>>                 nvmet_pci_epf_clear_bar(nvme_epf);
>> -               mutex_destroy(&nvme_epf->mmio_lock);
>>         }
>> +
>> +       nvmet_pci_epf_free_bar(nvme_epf);
>>  }
>>
>>  static struct pci_epf_header nvme_epf_pci_header = {
>>
>>> With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
>>> setup.
>>
>> With the above, does it work for you ?
>>
> 
> Yes, it does!
> 
> One more suggestion. Since you correctly removed mutex_destroy() from deinit()
> and unbind(), you should also switch to devm_mutex_init() in probe().

Ah! Yes. Will do.

-- 
Damien Le Moal
Western Digital Research

