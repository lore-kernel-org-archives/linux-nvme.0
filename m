Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B94BE77187
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Cg1zgsuxjgBjaw/sW0olfwRhMkQl1rQNt1Q6tfvwjE=; b=NJbyAZlDBuSusZZ3D+6YrlBMtC
	y1nVQMJTcOywQ8Ri+2wfYLxXMYoe21ewIfRYh7tupFeoPihFBOODePP0xrgZxcoG6NRzlNsQfoBj7
	756qCWJlKsD5wFjraXdMKFWaFwXL4OQ2Je5D9q11NStrP2ufgw3FK2ctsuuZsC9G5cKh05YX16TMY
	OPrAUMuer1bruDA3j0r/HhKTaM2TAioe3EzG77LvbmwMDxEFmmygShh/R1dTPRD1JV9HO8DOgh4TD
	nLBihGdx1Bh7oNe71JMWyyS0mrDFQ1q/NxZGPzFmz9OV8IECk+oYank/nLWoaTpijZ3bOGPgM3yat
	q9i/zZkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNyvj-0000000HSk2-2l5l;
	Wed, 18 Dec 2024 18:37:55 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNyvF-0000000HSgd-3pZc
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 18:37:27 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-728ec840a8aso28296b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734547045; x=1735151845; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Cg1zgsuxjgBjaw/sW0olfwRhMkQl1rQNt1Q6tfvwjE=;
        b=EKGSh3c2zBQiY0pM/4a2g314mLcNS+JGOtzaJsOpp4RGzLSwWrUUZYqdpsLX+eR3gQ
         WXcRckJv4iBaab/+fb9bI4cPQlfYAXOdAzNO2C8lPpc7zPd4d+nyA7Qu7LqKbZjAo8Zv
         7fhYn22L/f5YgopzIRjwx1cJAdBbSreFVmFJX230xlmgCNYft4a+dCfBvlpsargqH14T
         K2wJzsiRck3K0xI/eSHsl3C0sMxgeMSz2O/LFa+5JHubNo4tl7IqhwOOVfHrvZktNIp7
         NzLWMyMX0jlVbV7w6iUb6jfXPT2Th3TR5myHTBVclYmhhPGnNn91JwablulWUYrU9so+
         HI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547045; x=1735151845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cg1zgsuxjgBjaw/sW0olfwRhMkQl1rQNt1Q6tfvwjE=;
        b=FCSSRpDRhm1vNOsw+O+G/LOWqylSqx146WJOP4byZhq/O/01tt/YF4ODpIrunFKM4m
         bk2jn//nqbQnE35OS2XTBzoGMyum+ZeliNkc22pBs7BIxe0HhRX8QKco2YC6w/J5geDf
         IOliNap+Mh748Jgk6srOrCy1wTIP9fi2xcC53MgRE8X3eEq+0AzvixTWEl39kWOUk6Lo
         4wUaxygXqM2yz6rXXBGtguiVnBTs1WPoY6MNpsMNg6twvN6gWwBoHItsMKIsM3YErVrC
         6RGdK3AdooKc0U++wpFXyJCoQEDvw1/JR0HBebIOwphD12rl/re4+XYr+C+cMOmHfHLC
         KokA==
X-Forwarded-Encrypted: i=1; AJvYcCVWSwOa34JsTx671KLt6Y0XAa8GypJcS3rIQ/7bgkJpuCOvZsJhlDBt7yN5faoKGcgJfO2DylOAMGl1@lists.infradead.org
X-Gm-Message-State: AOJu0YyUqUmOJbkWoxQ+X5HSe2dWiJ8IYvXVsrXjdafOI5ZaVmsutceX
	lnvuVLi1eoqz9tS/aFyrZEWjJ+7fK8pxku8/CfGjSQYwsBoqqyX/ReBtLbvetmsPaE0VS8rNih0
	=
X-Gm-Gg: ASbGncsu2pJIXq1oIEA2DfbIzL9sqeEuGL1eJv9nSzV+nLlAbMuq/9MIbbW3UpjXIpj
	n7nWveAbpKWoBkuMFNqP0KBSGFi+Qwoe+lamms0XSVB8NxpNUfSCOuDbm591AP9CSVz4JgVvQav
	ZVlAgwcSXGPRrcvE4cUO/KX98u/bLA+0Uf1sHWfbr+3JmZ5ZhS3LH1htIkWczSJny4Lw1N1ko7g
	HnHMpLak8Ab0glwlNV7w0ZEYwJNh7pFDXfzqiVsy7qwQPhXToMfNaMWr4PHOJj+lM25
X-Google-Smtp-Source: AGHT+IGEK6/dK1naAm83SqXg1kfGUqMxn3XUnbRqdCz+y153a8bvEV+YxxmTbEC8bJadRQNfsU/W8g==
X-Received: by 2002:a05:6a21:394a:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e5b47fe155mr7211113637.12.1734547044958;
        Wed, 18 Dec 2024 10:37:24 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3ded0sm7822826a12.83.2024.12.18.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:37:24 -0800 (PST)
Date: Thu, 19 Dec 2024 00:07:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241218183717.3kxevwjia4mqc6ov@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
 <20241217090129.6dodrgi4tn7l3cod@thinkpad>
 <Z2Gf9lv6hLROjM8e@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2Gf9lv6hLROjM8e@ryzen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_103725_979761_A3C61D1A 
X-CRM114-Status: GOOD (  54.41  )
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

On Tue, Dec 17, 2024 at 04:59:50PM +0100, Niklas Cassel wrote:
> On Tue, Dec 17, 2024 at 02:31:29PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > > > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > > > Hi Niklas,
> > > > > > 
> > > > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > > > >> Hello Vinod,
> > > > > >>
> > > > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > > > >> could help make me slightly less confused :)
> > > > > > 
> > > > > > Sure thing!
> > > > > > 
> > > > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > > > >>
> > > > > >> I really wish that we would remove this mutex, to get better performance.
> > > > > >>
> > > > > >>
> > > > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > > > >> that dmaengine_prep_slave_single() (which will call
> > > > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > > > >> dma_async_tx_descriptor for each function call.
> > > > > >>
> > > > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > > > >> the descriptor to the tail of a list.
> > > > > >>
> > > > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > > > >>
> > > > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > > > >> an incorrect address.
> > > > > >>
> > > > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > > > >>
> > > > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > > > >>
> > > > > >> So while this API is supposed to be async, to me it looks like it can only
> > > > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > > > >>
> > > > > >> Am I missing something obvious here?
> > > > > > 
> > > > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > > > the transfer details for the peripheral like address, width of fifo,
> > > > > > depth etc and these are setup config, so call once for a channel and then
> > > > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > > > 
> > > > > > I suspect since you are passing an address which keep changing in the
> > > > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > > > as while preparing the descriptor driver would lookup what was setup for
> > > > > > the configuration.
> > > > > > 
> > > > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > > > destination, no need to lock the calls...
> > > > > 
> > > > > Vinod,
> > > > > 
> > > > > Thank you for the information. However, I think we can use this only if the DMA
> > > > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > > > In our case, the DWC EDMA driver does not seem to implement this.
> > > > 
> > > > It should be added in that case.
> > > > 
> > > > Before that, the bigger question is, should nvme be slave transfer or
> > > > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > > > 
> > > > As i said, slave is for peripherals which have a static fifo to
> > > > send/receive data from, nvme sounds like a memory transfer to me, is
> > > > that a right assumption?
> > > > 
> > > 
> > > My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> > > are local addresses. And DMA_SLAVE is for transfer between remote and local
> > > addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> > > the transfer between remote and local addresses. This is similar to MHI EPF
> > > driver as well.
> > > 
> > 
> > I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
> > implementation is supposed to be used by clients with fixed FIFO. That's why
> > 'struct dma_slave_config' has options to configure maxburst, addr_width,
> > port_window_size etc... So these are not applicable for our usecase where we
> > would be just carrying out transfer between remote and local DDR.
> > 
> > So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
> > in client drivers.
> > 
> > @Niklas: Since you asked this question, are you volunteering to implement
> > prep_memcpy() in dw-edma driver? ;)
> 
> I did implement something that seems to be working.
> 
> It would be nice if you could help testing it using your MHI EPF driver.
> (You need to convert it to use _prep_memcpy() in order to be able to test.)
> 

Sure, will do it tomorrow and let you know. Thanks for sending the patches
quickly :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

