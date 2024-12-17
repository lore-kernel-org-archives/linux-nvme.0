Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6B0E7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6acbz+sYik7awbI0rOlFvmPprgMME8EdhtYEszk268=; b=aWlo7Iz8H7eLDAfZdZIOfoFgU/
	+5UqMCAp97ZzkM9+pA8zAH8i8wXdbUoSdPYMIc1E6LxYunw58iNVJhfUHC922CwHjH6LKloanr/d6
	Df9CMa6wvZ8N4nqELoyADuh7jVVbgm3xVlmkOlbVjsxSFantVy8ZZMkfOOxMjgH1cg4OdLyHKpfL7
	k9CcW0UtLFDInapLphh68SCV9T3xZJFIoZdyNw5eJ2D97wjZ+pDibRiNjQ5VWdjtfu010FBgX7up7
	Jnb7SLL49kP7zo+i2GeOccpMQmhLkmG/RnGFvTnupgnWH6CH8gLOcIph4k48/Mk+UPF/NDs5ITQMp
	shzuJdvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTiH-0000000CsLc-25FL;
	Tue, 17 Dec 2024 09:17:57 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTST-0000000CoyK-007t
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 09:01:38 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so4403720a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734426096; x=1735030896; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d6acbz+sYik7awbI0rOlFvmPprgMME8EdhtYEszk268=;
        b=Xx4pfPwLuv+hyF+C+xiNaX/CptgT2PpmaDV/MpWd5g2LA26g28TYHH1HhzFmNZJGD4
         9ywRhcIbVKmznv2wv/Tik7+euViIqRuxnz3K5HAgWL111AESbd3pSkjVh/APBdvYuFwx
         TgX6bFi5w2shurEHzSg98zCAjf9rX//dEIEmMRpwOb95m3rGIvXxiAURmUU78hPuNF3E
         RdRtQGljMOBIUstHYPfCi4fTmKCpclVVaqZwlIFRvHzYf6CWyp7iUSVnFSfqoeiBea/Q
         tFCRojVg44fPo+2CTGy8BdT7OqrUc7kPzW9wy5wPiT2ShM5qvLhpTNTOVY2NqKPIiFg3
         GDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426096; x=1735030896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6acbz+sYik7awbI0rOlFvmPprgMME8EdhtYEszk268=;
        b=VerylVI8XJbaF0E8V+TX6mNViuuZa5VyXYt9hJAb58TwpApCOeuJKuXDwJqa3YBv33
         tHN/IDMvZy7MD+Qi1T924Mf03oP6f7hPwDarlfyABHJuVKaiIxLWwypKup4CuCdpAEQo
         9HQz4oCQpyGkt7Neg9XRlYNn01EJq3jHOjyJnv/93rlboEOQek3CO19L1+ET8eHVDlW+
         FGLNUgl9zS11GNfIR4kVu7FQ9toEZRDLfhXHVbiBqSnkKCJURWkhPcfrQJjo2gWegVYj
         j74O/PpNOFZ33lOUqs705x7QA5RSzu/8rfdcivCVsEUqQFMTNro4RGAUrKQCs9tcvbVB
         Z8lA==
X-Forwarded-Encrypted: i=1; AJvYcCUue9Uwkb7UiiakD/h9Npuz9AWe6kS0xCz1SPctZEPcVktheg9XqtqsO0RdW5e6n0aj7P1uCI2YLOol@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2a+b1jlNaqjnM8Fc+qKSRLCiR5PoD2HcDua2udPwMz43kMJsA
	XQYGDNE5MQ2EpLu2hvY6dII6jDH6JAHQ2yYN77kuPXI921i+FpUPbfxVWvgt7w==
X-Gm-Gg: ASbGncsMr8vdS+Tcib7r0HzytLJ45amaxmn8oiMVOymhpUCg4u7NGJHMaAp1KI69X58
	c7nPtksIdtPkvQwvZUJd/s1w1JvdtwuY5A7f3/h234AQwbhoNPC3ChBtP3zgxLlzIPo27IQt+Ra
	tZx5PRJ+UkVCcYwP5PkSQ5bPer1qadEyUgbnxB/uPBhTsTlNcYmZwSojhhQEWuleS1M+AOiNdJt
	C2j+O5lCAAVa6VHODURNhbL6vix3Oq+WMATCdLt0PvaxlUuww/1XKXNtSGfIaMccQ12
X-Google-Smtp-Source: AGHT+IErZlHdFPBSG0pEQN7o8tLqL6wo5ZhyFFqcvV3YUSnBr/tQiyUamgeW4V2OWCLXqq//eYe8bg==
X-Received: by 2002:a17:90b:4d05:b0:2ee:b26c:1099 with SMTP id 98e67ed59e1d1-2f2902ae9damr19245070a91.34.1734426096276;
        Tue, 17 Dec 2024 01:01:36 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1e6dsm9426193a91.39.2024.12.17.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:01:35 -0800 (PST)
Date: Tue, 17 Dec 2024 14:31:29 +0530
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
Message-ID: <20241217090129.6dodrgi4tn7l3cod@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217062144.g7jjnkziuen3qsm6@thinkpad>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_010137_042141_6F7E4C02 
X-CRM114-Status: GOOD (  48.82  )
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

On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > Hi Niklas,
> > > > 
> > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > >> Hello Vinod,
> > > >>
> > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > >> could help make me slightly less confused :)
> > > > 
> > > > Sure thing!
> > > > 
> > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > >>
> > > >> I really wish that we would remove this mutex, to get better performance.
> > > >>
> > > >>
> > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > >> that dmaengine_prep_slave_single() (which will call
> > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > >> dma_async_tx_descriptor for each function call.
> > > >>
> > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > >> the descriptor to the tail of a list.
> > > >>
> > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > >>
> > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > >> an incorrect address.
> > > >>
> > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > >>
> > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > >>
> > > >> So while this API is supposed to be async, to me it looks like it can only
> > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > >>
> > > >> Am I missing something obvious here?
> > > > 
> > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > the transfer details for the peripheral like address, width of fifo,
> > > > depth etc and these are setup config, so call once for a channel and then
> > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > 
> > > > I suspect since you are passing an address which keep changing in the
> > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > as while preparing the descriptor driver would lookup what was setup for
> > > > the configuration.
> > > > 
> > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > destination, no need to lock the calls...
> > > 
> > > Vinod,
> > > 
> > > Thank you for the information. However, I think we can use this only if the DMA
> > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > In our case, the DWC EDMA driver does not seem to implement this.
> > 
> > It should be added in that case.
> > 
> > Before that, the bigger question is, should nvme be slave transfer or
> > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > 
> > As i said, slave is for peripherals which have a static fifo to
> > send/receive data from, nvme sounds like a memory transfer to me, is
> > that a right assumption?
> > 
> 
> My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> are local addresses. And DMA_SLAVE is for transfer between remote and local
> addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> the transfer between remote and local addresses. This is similar to MHI EPF
> driver as well.
> 

I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
implementation is supposed to be used by clients with fixed FIFO. That's why
'struct dma_slave_config' has options to configure maxburst, addr_width,
port_window_size etc... So these are not applicable for our usecase where we
would be just carrying out transfer between remote and local DDR.

So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
in client drivers.

@Niklas: Since you asked this question, are you volunteering to implement
prep_memcpy() in dw-edma driver? ;)

If not, I will work with Qcom to make it happen.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

