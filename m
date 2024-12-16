Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F91E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAtuvi55oQf1RxS61n33V8zyvt2qXg0Myja8haj4+0Y=; b=Q4GtGzv7sE8OuQ58iR7qV6niLv
	9eeKbSIQC97jD//V3vEaUHmBsR+17gO5f2TIa7xIm/NEVrF7IC+mmWoJJrevpDsb0/HO2rqIYWqTv
	kLgptLkcSPqyG1dJJI07jQLIjg5ZzaINQ045FzN12p51WtO6XKfISD41capImsRMKhMdUmf4G+nCq
	BFCSop3JFqSau3VJ7n/pF+YPdUZJ4A1/MPC5Wk25r6Zp6LcQJEAGSVRe6D6JnoTQ0mX8T7PFqi+Yw
	wipt0iOI7iXdlk0KY2z4zCo80/cMJOyyv5A+4gBJehN5w81ameZ+0/FODWcHtJUDjmm4ySYtWDtiM
	CE5uWhOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGVo-0000000B3XL-2M5V;
	Mon, 16 Dec 2024 19:12:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNGVm-0000000B3Ww-14ar
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 19:12:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96C935C5E19;
	Mon, 16 Dec 2024 19:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193A2C4CED0;
	Mon, 16 Dec 2024 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734376329;
	bh=CRPNOBDFPXTDmLQ7rQq8Yr9i6kXX7bwuxyIFMN6UNDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gG4DWPdXt6xxx39D5Fqty82LhGJJBP1+6OW4q8HR2s15ad93XA4gNA9IBH7sDtt5E
	 DBPDVTQlk6VCUmz5+Ra5GoFfsrrWNpaAVOsYxh42ddaHY3i02LXHKWrPzjb9TKoafH
	 E+uC/7aVt1AVo1MXyrlKDKhCu50FBFWinCyTIwWQwkYY14IwmLB18EGEzD+B9ytm57
	 dCyVYvCLgfrCPJTmKo4W/QP+nwW+exqdL/CJMYAZO/19HZFKV7XwQzFtasaS5QUdKb
	 Bro0CTX/M3XZLdkgSYVAU16nHErZ01ACLFlSJFV6Y0HmnfrTR9iQ60cCXAPEj0STZM
	 zGIL++6kM1SKg==
Message-ID: <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
Date: Mon, 16 Dec 2024 11:12:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Vinod Koul <vkoul@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org> <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z2BW4CjdE1p50AhC@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_111210_390057_54BD8AF5 
X-CRM114-Status: GOOD (  27.37  )
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

On 2024/12/16 8:35, Vinod Koul wrote:
> Hi Niklas,
> 
> On 13-12-24, 17:59, Niklas Cassel wrote:
>> Hello Vinod,
>>
>> I am a bit confused about the usage of the dmaengine API, and I hope that you
>> could help make me slightly less confused :)
> 
> Sure thing!
> 
>> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
>> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
>> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
>>
>> I really wish that we would remove this mutex, to get better performance.
>>
>>
>> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
>> that dmaengine_prep_slave_single() (which will call
>> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
>> dma_async_tx_descriptor for each function call.
>>
>> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
>> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
>> the descriptor to the tail of a list.
>>
>> I can also see that dw_edma_done_interrupt() will automatically start the
>> transfer of the next descriptor (using vchan_next_desc()).
>>
>> So this looks like it is supposed to be asynchronous... however, if we simply
>> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
>> an incorrect address.
>>
>> It looks like this is because dmaengine_prep_slave_single() really requires
>> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
>> in the sconf that we are supplying to dmaengine_slave_config().)
>>
>> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
>>
>> So while this API is supposed to be async, to me it looks like it can only
>> be used in a synchronous manner... But that seems like a really weird design.
>>
>> Am I missing something obvious here?
> 
> Yes, I feel nvme being treated as slave transfer, which it might not be.
> This API was designed for peripherals like i2c/spi etc where we have a
> hardware address to read/write to. So the dma_slave_config would pass on
> the transfer details for the peripheral like address, width of fifo,
> depth etc and these are setup config, so call once for a channel and then
> prepare the descriptor, submit... and repeat of prepare and submit ...
> 
> I suspect since you are passing an address which keep changing in the
> dma_slave_config, you need to guard that and prep_slave_single() call,
> as while preparing the descriptor driver would lookup what was setup for
> the configuration.
> 
> I suggest then use the prep_memcpy() API instead and pass on source and
> destination, no need to lock the calls...

Vinod,

Thank you for the information. However, I think we can use this only if the DMA
controller driver implements the device_prep_dma_memcpy operation, no ?
In our case, the DWC EDMA driver does not seem to implement this.


-- 
Damien Le Moal
Western Digital Research

