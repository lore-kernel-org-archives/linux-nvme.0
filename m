Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB22E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfSiMFXIPJuQ0g2tsiyiLPd4E6hT3VfWC73zAi4cQoY=; b=HcNM8aCYuLFIffNvOrWi6X2Ak1
	ZvWNxrbz6+zBL3lcTBjiZbT2iGFJ1HrTr3+V4yoMkNiqDUda8JH5wc2JacDuttgXIf0G0cxpqE4ZO
	GEquEAAYNBTHXoesXJIKVHu3ndqV1AwtQsYpdLY7BZ51X+4bpzwwrUra5/7Eg1ZZw6a6jfSLzi0Xo
	wiFzMIaHIeeNuNqXdb8vNTYMyVxf8YTg/eZ07YgebRfq0SbmvBO049qFPVsfNAt2u9TVLHswCSjed
	oI5QvMGIfA4XwRdIgEee4FMHQPFNqgz/v3OULkXJh125zdRheN6dbCq16ubTWTfVUu0WsimLwF5T4
	f7xJz41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNayW-0000000EGng-2wKW;
	Tue, 17 Dec 2024 17:03:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNayT-0000000EGlv-3wVQ
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 17:03:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4551C5C4E71;
	Tue, 17 Dec 2024 17:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D745C4CED3;
	Tue, 17 Dec 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454989;
	bh=sSpqoEK8CNyCR1Nyjvil2/UizEqb+1z512pRABGm/q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KAepieqIUtb0+e9bJ7xjMnIpJq53p6XBWEOMKHzNGfGwZmzX80VicOjFt7JpjFEJ+
	 aqVcFemBbj+LvlY5s3J3VYmMF4yEpZigXlnIWCQ8P57qQ8xl2OHIp2bLWujjzgphz2
	 lgdF/EjPYNukLrGfSKO9mXSdhXcqnFsMH7NlJPE6nQ+MTI1ZeW4VyNLWZXsfdHy4vx
	 d/VgWpzhSy11vjVhlSjxEuQmccYuXUrxlk87rvxVcb5YJ9dgH92ldu63Z1jNLbTfF9
	 IJM8lelLGWkOkLwGZeRGNweL4OyiRL/cpwwgPyVwkXyqG/yzmAX3ARxnTStHKWHu8l
	 MTun5qIMz07ng==
Message-ID: <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>
Date: Tue, 17 Dec 2024 09:03:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
 <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
 <20241217164149.vuqwtthlykn7bobj@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217164149.vuqwtthlykn7bobj@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_090310_066023_8F6D174E 
X-CRM114-Status: GOOD (  22.22  )
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

On 2024/12/17 8:41, Manivannan Sadhasivam wrote:
>>>> +	/* Create the target controller. */
>>>> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
>>>> +	if (ret) {
>>>> +		dev_err(&epf->dev,
>>>> +			"Create NVMe PCI target controller failed\n");
>>>
>>> Failed to create NVMe PCI target controller
>>
>> How is that better ?
>>
> 
> It is common for the error messages to start with 'Failed to...'. Also 'Create
> NVMe PCI target controller failed' doesn't sound correct to me. But I am not a
> native english speaker, so my views could be wrong.

I do not think this is true for all subsystems. But sure, I can change the message.

>>> Why these are coming from somewhere else and not configured within the EPF
>>> driver?
>>
>> They are set through the nvme target configfs. So there is no need to have these
>> again setup through the epf configfs. We just grab the values set for the NVME
>> target subsystem config.
>>
> 
> But in documentation you were configuring the vendor_id twice:
> 
> 	# echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
> 	...
>         # echo 0x1b96 > nvmepf.0/vendorid
> 
> And that's what confused me. You need to get rid of the second command and add a
> note that the vendor_id used in target configfs will be reused.

vendor_id != subsys_vendor_id :) These are 2 different fields. subsys_vendor_id
is reported by the identify controller command and is also present in the PCI
config space. vendor_id is not reported by the identify controller command and
present only in the PCI config space.

For the config example, I simply used the same values for both fields, but they
can be different. NVMe PCIe specs are a bit of a mess around these IDs...

>>>> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
>>>> +{
>>>> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
>>>> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
>>>> +
>>>> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
>>>
>>> These prints are supposed to come from the controller drivers. So no need to
>>> have them here also.
>>
>> Nope, the controller driver does not print anything. At least the DWC driver
>> does not print anything.
>>
> 
> Which DWC driver? pcie-dw-rockchip? But other drivers like pcie-qcom-ep have
> these prints already. And this EPF driver is not tied to a single controller
> driver. As said earlier, these prints are supposed to be added to the controller
> drivers.

The DWC driver for the rk2588 (drivers/pci/controllers/dwc/*) is missing this
message.


-- 
Damien Le Moal
Western Digital Research

