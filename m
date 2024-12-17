Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3E2E7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KTMt2S+urkIYn87qIOII4tAmscWY+RXwAsYODxpHnCQ=; b=W7KnqTojzf9vcvqWB246nRE0I9
	tXcd4T/EECRdZsqluuAaz26wFu+rFqexcg6Vh/pl2uGxay9VV/1gQ/1mCncfLwO+bTSdiKpiwY76a
	S7W5qNkRXlFtrh8hoisPRxeeqmIiRy/IThZDycN8qMZZ1BX02mzflEdnMYdEim4BHI51Dzkeyu24b
	eXES0OzG4+haiWFZzFdmqNWOV8qbtMT+mg8ws1X5ax3e3MS4S2utGXWm/UNhuLA885y9DGzfTq3kK
	PKPs7OEUmz7J+tfL1R7qJbARUpxKx+SCvfIbDnzzcSC/xdhrI4D9Y/TDh0oXerj5/mpHJWV8d49Xo
	+u0PbuSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQxt-0000000COTM-2baG;
	Tue, 17 Dec 2024 06:21:53 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNQxr-0000000COSr-06Lm
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 06:21:52 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-725ee27e905so6363851b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 22:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734416510; x=1735021310; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KTMt2S+urkIYn87qIOII4tAmscWY+RXwAsYODxpHnCQ=;
        b=lgiMWm35x7BOT1F4xN0u5F002V+NL3BZZKxM6OsM3yqNLEN9f1WhN62dgLdCCN9R5v
         mYYQdiV1z9wnZ41oESX1flwIj4J6dLCiGO+m6ORH47DsshBO4cxRqOhCTReX1oUPWR8E
         f6BYtq7GpYQeQ4QwcIsCJAKmxIjXDyY+yi/L+zuZm3HuSrAv8Oli66FDlfKPbvYvuwlD
         GQ8fE0lJ6dkskulg9HSj0xnxLMVGv8GH2pe3bCksiwpLN74h+cbvRJXvcVfWgsjfp20m
         ZfS05nW1dwFp+FyGhG+jH/cggct7lmA9Jtr5141BKQG5KckRYmrbfeQxAuvdCy5F5Bpw
         fvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734416510; x=1735021310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTMt2S+urkIYn87qIOII4tAmscWY+RXwAsYODxpHnCQ=;
        b=ODdpi6KgeXMd2FMwX7MbohWgAmyS5Gr192hyD8tVoipW3Ajr+Q+d3Up2bOR1RdPBy8
         vhNWZVlMwtkC1K7YI9nXW8cxo2DCkdrKvdaGzkjgOikZovBFxXMrrDBW7fqD4WSGUeEm
         4DVs85kntfY6Z8151NH3MbxBXusvZFUNKEdD6sxm5k+sr3O9oyJ0JM0YfCMvdfkCi/Yu
         8d6f44S4bF9XPMlEKAwkISswKaTIKqhRRwA5rpDXORfaogZNBSNTOMAYXIZK9xTvaQ/Y
         rG8sZjZ32CarjmTbgNudP8KKLaRHqmBv8OBnzO44lPJK5F9fnPtVNr2rd8KgjPXn5wrP
         b7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ghy7NucCvJbz+xB+zO7B3zPnznzTGs1hcbvxs8wDlqs4E7oadZ1F7KRHVqkqHlY4P2HBiySD+uZg@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf+WX0OPj8hrsgiKdKOkWuSxwBR69+9pQcHD7hggy2j9OF+JrR
	2mfXaWutaWAtioCJ0ekHKlOGXT9ygBLfyCiiQ/DSRrEPyvTHLPZoh/6yRqeAKQ==
X-Gm-Gg: ASbGncuJA3GXq/1v45nw7bv+uauRBaSScdmAAmyvwvYxz734mXZpeWSZalgx/Wr1mBf
	0gTkXC7g+O3C+tGo3S809Hn9JZM0TvtLt3hWFqOiPAM2aSd3JCCD9BEpmOf0mgcy4qjOPKljHxF
	QAaXHFj/i+omCG4dHCwq4C5qYA2fTj43dewB4IYjDp9s3G1Ks4c3oB33AdFwzPj2gKhEGEgGIz6
	TIgujMjSregXl9WxrU9yPlV6WZW1nPPwEFVK3XfnO/ueaxMbycf0qY42daexE3uWt8P
X-Google-Smtp-Source: AGHT+IHDN73kVjagfpHFEE7paMuJrna3XYZyYUYZnGRRnyEXV5MnD/5cAwnRlJHCCAF2jpNTULiJrQ==
X-Received: by 2002:a05:6a00:2341:b0:728:e1e3:3d88 with SMTP id d2e1a72fcca58-7290c15d7bfmr19910862b3a.7.1734416510163;
        Mon, 16 Dec 2024 22:21:50 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918af1040sm5835770b3a.83.2024.12.16.22.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:21:49 -0800 (PST)
Date: Tue, 17 Dec 2024 11:51:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241217062144.g7jjnkziuen3qsm6@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2ELpuC+ltp5wDay@vaman>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_222151_069432_1B48F739 
X-CRM114-Status: GOOD (  43.51  )
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

On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> On 16-12-24, 11:12, Damien Le Moal wrote:
> > On 2024/12/16 8:35, Vinod Koul wrote:
> > > Hi Niklas,
> > > 
> > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > >> Hello Vinod,
> > >>
> > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > >> could help make me slightly less confused :)
> > > 
> > > Sure thing!
> > > 
> > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > >>
> > >> I really wish that we would remove this mutex, to get better performance.
> > >>
> > >>
> > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > >> that dmaengine_prep_slave_single() (which will call
> > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > >> dma_async_tx_descriptor for each function call.
> > >>
> > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > >> the descriptor to the tail of a list.
> > >>
> > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > >> transfer of the next descriptor (using vchan_next_desc()).
> > >>
> > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > >> an incorrect address.
> > >>
> > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > >>
> > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > >>
> > >> So while this API is supposed to be async, to me it looks like it can only
> > >> be used in a synchronous manner... But that seems like a really weird design.
> > >>
> > >> Am I missing something obvious here?
> > > 
> > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > This API was designed for peripherals like i2c/spi etc where we have a
> > > hardware address to read/write to. So the dma_slave_config would pass on
> > > the transfer details for the peripheral like address, width of fifo,
> > > depth etc and these are setup config, so call once for a channel and then
> > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > 
> > > I suspect since you are passing an address which keep changing in the
> > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > as while preparing the descriptor driver would lookup what was setup for
> > > the configuration.
> > > 
> > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > destination, no need to lock the calls...
> > 
> > Vinod,
> > 
> > Thank you for the information. However, I think we can use this only if the DMA
> > controller driver implements the device_prep_dma_memcpy operation, no ?
> > In our case, the DWC EDMA driver does not seem to implement this.
> 
> It should be added in that case.
> 
> Before that, the bigger question is, should nvme be slave transfer or
> memcpy.. Was driver support the reason why the slave transfer was used here...?
> 
> As i said, slave is for peripherals which have a static fifo to
> send/receive data from, nvme sounds like a memory transfer to me, is
> that a right assumption?
> 

My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
are local addresses. And DMA_SLAVE is for transfer between remote and local
addresses. I haven't looked into the NVMe EPF driver yet, but it should do
the transfer between remote and local addresses. This is similar to MHI EPF
driver as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

