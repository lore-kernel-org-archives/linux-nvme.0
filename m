Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE77BE7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UmEAZYbazaiq3UiSAj8WEGOhMeHyFr9+mT0GtYV2jKE=; b=LqxRJSCkrBbRRTNu+X6+Y0XhXi
	Hs9qtcT+1t4VR21dqqlgAO012+sMntdDevllaz2vNIWAFOwNbTWZXMclSH4KPCFJu7x7E4Lfkz3eN
	BVAau5Y3uiQDMB/mh8mqLg03ybCmZaZN+un9SszdHlGjpl02zIuKlMLeidFjOa5S6mloO2fOI85jE
	wNfGU1gJ6f+xBwILPaOsuYYSKch40lpqDQjIyWHF6ZJL1+AwZAJNeptP//o+3vfsRi3PBiNTjjdv0
	lO4Mqx5LVxV+ZCph2BLgIZYrPmkG+dUAFRfJb0mZLUvQ9zqdTqezgNF1qEm+xWindbqgYQaJejUJl
	dx92jzbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tML4m-00000005lgi-0LRK;
	Sat, 14 Dec 2024 05:52:28 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tML4j-00000005lgJ-3kQd
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 05:52:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0675CA40226;
	Sat, 14 Dec 2024 05:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D4C4CED1;
	Sat, 14 Dec 2024 05:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734155543;
	bh=OYdXiKe7Rzv6Q1F23Q/vI3qVefJed3FVeqzukNlTszE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fUyDQssXl9ayZejEHkN2jjg0LvC3RlA46SNqZElFYERNdBsOF6xlaw0dCzFab39Ba
	 /0yGP1cV5eeZUrXpAAvIiEC7GtBYpLgg6QJgbOsnl6k5j8EQD898289ck3qeqV52bk
	 ObCdwHD+hlQ7QuOfyLUtWcY0fgsodPmkvmeTbAOA7cZktj9YXfQwZPOUNtOrbTJmNM
	 frGjIoNa2zJ3DgZtD+R0lNjmHAbAtqBzc2eADdWqbCqDoKtJG1O27YEXm8Uib5u6Sv
	 czuxUymesXYENnX3uMLj341w1pOtQm9Mmt+BROoJi0zIjTXG5j7b3Jj1UnvZZhUWDb
	 crYB301Cq9YTQ==
Message-ID: <09563385-63a4-478d-80ed-81a5ca74d557@kernel.org>
Date: Sat, 14 Dec 2024 14:52:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212185527.GA3356063@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241212185527.GA3356063@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_215226_000429_7E6E6CD5 
X-CRM114-Status: GOOD (  10.31  )
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

On 12/13/24 03:55, Bjorn Helgaas wrote:
> On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> 
>>    This ensure correct operation if, for instance, the host reboots
>>    causing the PCI link to be temporarily down.
> 
> s/ensure/ensures/
> 
>> The configuration of a NVMe PCI endpoint controller is done using
>> configfgs. First the NVMe PCI target controller configuration must be
>> done to set up a subsystem and a port with the "pci" addr_trtype
>> attribute. The subsystem can be setup using a file or block device
>> backed namespace or using a passthrough NVMe device. After this, the
>> PCI endpoint can be configured and bound to the PCI endpoint controller
>> to start the NVMe endpoint controller.
> 
> s/addr_trtype/addr_type/ ?

Nope, addr_trtype is correct. "address transport type" is the meaning for an
nvme target port.

> s/configfgs/configfs/

Good catch. Thanks.


-- 
Damien Le Moal
Western Digital Research

