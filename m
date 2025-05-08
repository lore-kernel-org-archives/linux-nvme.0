Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F2C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/S8bsBFsJd1f+8AMacwJKEPEoO5+nh9xS2oe6NOb/M=; b=yFJ6bLjri/heSS94y98sCsHNI/
	9DoT3nhhCoLDgBEUxZa+XmnbVL2VpZKmo8z03un/nuHls7jpd3jZsn8BWsUTEZpt6tB8skc1tRsau
	/a2YmDU4OoIPScoGX82fFnKL7IG4ozyjUvMW5cCJAdM5jr0CrPVzsTvQvc4bvDcEPPAwDa0HYodhL
	YQW0PzR3XrvN5rd+V3Br8bo7m0X3jb2VTltIS7CHPzGs16iOTZ562Qo0RrxTDQuTwZ2cywb4i/68P
	6DtufoQfhbie8M/BPEfJfoPyRDEFsyFXgifGMgUSU1ZzhdZPGPB2j/UuuZrowdwguRJ7/8jm1zkz6
	+hqE+7xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAVE-00000001yKC-2c7O;
	Thu, 08 May 2025 23:18:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAVC-00000001yJs-3YiE
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:18:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0607F5C64CC;
	Thu,  8 May 2025 23:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204AAC4CEE7;
	Thu,  8 May 2025 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746286;
	bh=HPOiWwy8TnECT3jKd8m3qi9HRvby6HFw6q9Q0e4QsGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cAuvU6QG/+sX8ZwNZ2ttOsXSyYAnhP8mSWbVm78E1tc/3QEifoTr1D3wOB0wh8pKq
	 +hUJtqmj4Z2SVuEIqtDeaozi47fGW/888TTK2wcPxAnQaHEFw2zNyUEPDVKAsZ5dDS
	 e87ZGqigBJwh2CGhqKkNYXSh1PVdDS+3D/ZlvJEuSlNCQEDQ7KVSqEsaucLxr1SyQq
	 I2sHsTQ4xUfA+T9Aj9DAPhZe2mW/9bHlrG+ABCSWkhmC2kAubWm0EvaikvP5KcIwxj
	 OeTFaa7URvfTepYWyhulcymaG/OsPfWAVyNfHB43KdSzvEW0svGs/HzXPAlk3FEkHM
	 QYZrgP20Ismkw==
Message-ID: <e63e391d-44a6-4f46-9996-8d6abaa090fa@kernel.org>
Date: Fri, 9 May 2025 08:16:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20250508065745.389199-1-dlemoal@kernel.org>
 <20250508065745.389199-4-dlemoal@kernel.org> <aBysnmAu_ik89fse@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aBysnmAu_ik89fse@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_161806_933615_98E2DDFD 
X-CRM114-Status: UNSURE (   7.41  )
X-CRM114-Notice: Please train this message.
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

On 5/8/25 10:07 PM, Niklas Cassel wrote:
> Nit: since we no longer perform the NVMET_PCI_EPF_Q_IRQ_ENABLED check in
> nvmet_pci_epf_should_raise_irq(), should we rename the function to something
> else? nvmet_pci_epf_irq_allowed() ? Any ideas ?

nvmet_pci_epf_should_raise_irq() is still in charge of handling IRQ coalescing,
returning true if we should raise an IRQ and false if the IRQs are still being
coalesced. So the name as is still seems fine to me.

> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks.


-- 
Damien Le Moal
Western Digital Research

