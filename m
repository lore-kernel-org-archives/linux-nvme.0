Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A8C3601E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdw+cJFgyoJF3TmGc7q3BNdXNBoRe+ac+3oI1D9P5a0=; b=rqiYlsVi9CRisLdsBftKyUQnrU
	LXZr6zdSCu/kdASw/RTXF1rL9jpOwMfXIR+Jji0tNihehSL9xhFHjzZ3gl8YWIYxVEUS62YScakJU
	vy+D0eMMQ4mcCrh0xd60syj6MGbml0/TqbAgfao91lDmBEn/0WfScZhLvvq8fShQIEpk9tA/cFyz4
	V5QusOpoKVBzMYsot0+BRwy3VzCGouH8plkhvXcs2L52J/02NfnONg43AY/C5X8cOXfVaON21GgD3
	ZumtkMSH5xKpPbs0nEZEFMw/Ip2rCmcW/BuzWebyPGvwh4yqt9pizf43wrBdWIBHQoL9rsVIDda47
	o0XNGAGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32KJ-0000000C8Nl-1aMa;
	Fri, 11 Apr 2025 00:32:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u32KG-0000000C8N0-2v9i
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 00:32:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5B96E5C58B8;
	Fri, 11 Apr 2025 00:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D974C4CEDD;
	Fri, 11 Apr 2025 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744331575;
	bh=i9dlpXBOKa04as+3l4cJLENr+xOFpg+4vIrge4l8Xrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IKwAmpLI+AwVre4aoeDZtLsQk3jePmaMtF7iI0vj7/70QkESGbhe8iCyv+SX/Tb3w
	 oFJzca61rEAe9g0dN0Iuyo6KyoBolaWE/LkFZP6AJLMlIyd86sjaKSgExhVIAvbU7f
	 zjNQ4lrGNlnSozetkU0e5HTHyogJELYcwphKVoZjGKSwT+1G/F1TFjFd3nNnGNm05V
	 BZnCD8pSeGkGunvPonUuLRii93xzLWD9CnpHvE28k/EXJ4Nq4AptCPD1vYpMyCE0gN
	 CJ8vgUhBNsii/kPf9E1pDrxaPeeKrYpO2mEbKEhqgrsV0OhQCWhNPhhpQxqNpSg+wy
	 1lNQvTQ1HPwlw==
Message-ID: <e1337822-e0d4-43b6-8fdf-8df521f23cae@kernel.org>
Date: Fri, 11 Apr 2025 09:32:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the
 controller
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-3-dlemoal@kernel.org> <Z_eCmfXXjmarMnQl@kbusch-mbp>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z_eCmfXXjmarMnQl@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_173256_780186_C4606BB4 
X-CRM114-Status: GOOD (  20.20  )
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

On 4/10/25 17:34, Keith Busch wrote:
> On Tue, Apr 08, 2025 at 11:47:32AM +0900, Damien Le Moal wrote:
>> @@ -1895,6 +1912,11 @@ static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>>  	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
>>  
>>  	ctrl->csts &= ~NVME_CSTS_RDY;
>> +	if (shutdown) {
>> +		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
>> +		ctrl->cc &= ~NVME_CC_ENABLE;
>> +		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
>> +	}
>>  }
> 
> I think this is probably okay, but I don't know if it's necessary to be
> messing with CC.EN that the host didn't request. The qemu emulated nvme
> doesn't do this, at least. But it looks like that would all work out in
> the end anyway, so again, I think it's fine.

Maybe qemu clears/resets all the registers of the BAR when it does a shutdown ?
I did not check the code. But here, if we do not clear EN, *and* the host does
not first disable the controller before trying to re-enable it (like the linux
host pci driver does), after the shutdown, we fail to detect that the host set
EN again since we can only detect that by polling and comparing to the previous
value.

I also thought about using ctrl->enabled for determining what needs to be done,
but then again, if we do not clear EN from the register, the next CC poll loop
will see EN set and think that it is the host trying to re-enable the controller
and we will re-enable right away.

I think that clearing EN is not necessary with qemu because there is no polling,
since (I think) that qemu nvme driver will be looking at CC.EN only and only
when the guest touches it (as that will trigger a guest exit into the
hypervisor). So the qemu nvme driver always sees the newest value of CC, not the
old one like we do with the endpoint.


-- 
Damien Le Moal
Western Digital Research

