Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A7BE77187
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0R8lNcGDVTUJ4XfKojA76WW7sklYWQ1x2c4qmRXJLs=; b=SlPjckAGCFUawPOhxlM6dar4Wz
	E0W7O/EadhVrccZmFDaX3tcbKoebHz/zpzsjKL40uooZpND9fajiwQhew3q7v22735FAaK6Rsc7ov
	tRZlJz9hUN5znRc2ZhhIne8BB4Mo8JcqiyADu95u/2q1s2NHWEydHUWUneXH1l9t3hWC8Hg/lpE/c
	R+lhQ2LsWIEtYBE94cnv6ZZvDHxH8TK9A8jCnLF1vFHh3n3BJQVwXtfhWc2dAossYJ691dEi7Y9hM
	al5ngsJ+xKN66mhANAejywPNHdzXcmqvNR483WQgC7cjFNIqhjBixrqcRVP1TzQQzcVyageB9K1RV
	hpsnx6mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNafp-0000000EEjZ-0VAU;
	Tue, 17 Dec 2024 16:43:53 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNadz-0000000EEQC-0wG4
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 16:42:00 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7242f559a9fso7091701b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734453718; x=1735058518; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0R8lNcGDVTUJ4XfKojA76WW7sklYWQ1x2c4qmRXJLs=;
        b=YCcYdZQE2pqGNe8XmTWKGmfy9/iZdYg6xOZQOPTa+jQhzPNEpuC4lfvRspBWZfvPu8
         QpCQkd2oA9eN8KZkIAcBkWnX4QRkEfxRLkbp6DlTYR41hfbGSPN7Z1z1aS7ZyL7JJh7O
         SdHqqNoVYF8xJYNr6qVzw0KROElork3R+4aOW9GBp7wijSXoxiVC58pkx50BZ6OG8f7L
         3c6o32MeonGV1Au3IRSEo+m1xUQgFvHZqRBHCQEGxIPkfWpAzPYkIpBsyMKLNdC8wMqG
         X4hmRcOx3GI5h5nr6ZoisDk0FkH6aUKXdHEPRYnvCv0wADZfsJ3MmbjD3j5FaKje8CDk
         RDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453718; x=1735058518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0R8lNcGDVTUJ4XfKojA76WW7sklYWQ1x2c4qmRXJLs=;
        b=F5aoN9HRrsHFm/rqZKhCVvIdJ2wSEEkepQwIsQ88Lqh8olSBuyY5CQkbeKnmo0LRwo
         eezXVQnVFRRRPnS4tdybNVwg/JsX+ZnImNCamn8XOk3WElRovE6GScHtgliRMo1B7ew+
         64uweTFQw63MN2GF657mD3xLN9xFDkob5TfEFGYem/YfVIZa/v3iDAxCVEMM7DHZZs2l
         LNK8pGcvPWMRCiib/qDUm+TFj2KJQbk5O+o1nwfQ99zm1oMczI+rNNhVe0UmBhvnvzRY
         OU2fPjHLCYmRGuSRvMXl2ga/z9McOBjylYQkf41cEIDE3+VAAhGqyRD0cewWvPYr7+9/
         9S4g==
X-Gm-Message-State: AOJu0YynqsyfBBbaCsWq+fIYZOR03s0TOaal8WIH6+t4eNNn6kh16DXQ
	PHDxKSr69qg3erPh222ccxpK9aDumR9Xu4pUXxFi05aNyXeLQ3r7RV7ArpSdCw==
X-Gm-Gg: ASbGncutkHc0oU5Q7dcJnDSICZyGVbOjUboWosFlj7PDct1JPuiAgwhejaT4JEPgMdn
	C2jhVA38+yq1NKt3OtBfXX0L6atLyi5OyXd/PzWoPuaUlGI7+JCziIsSukM1ZjanFNYHTf7SU33
	Uf7kU7UpWiakt5slx7fcnz6/EQ4XZvj9PpgaO2k3cewoQes9Jc8xwWulHBFYqgo/UWtB9GZ4tXX
	zm0ZD7n6Qpp1ZkBylN0x88cJbGFgyvkLXIZWilZAbjfm9Py9HpOpXljjTy0ug/28mCe
X-Google-Smtp-Source: AGHT+IEMEAcDgUV7e6hsk7BzgNDNAC7F0wt1POGME+x9pD5sGqSeoRWWGI8Iqmk3UKm4KQEdAaAymw==
X-Received: by 2002:a05:6a00:4b53:b0:727:4e5e:881c with SMTP id d2e1a72fcca58-7290c1b489fmr21712153b3a.15.1734453717869;
        Tue, 17 Dec 2024 08:41:57 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b79096sm7138399b3a.100.2024.12.17.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:41:57 -0800 (PST)
Date: Tue, 17 Dec 2024 22:11:49 +0530
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
Message-ID: <20241217164149.vuqwtthlykn7bobj@thinkpad>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
 <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_084159_283712_4645C23D 
X-CRM114-Status: GOOD (  60.31  )
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

On Tue, Dec 17, 2024 at 06:35:33AM -0800, Damien Le Moal wrote:
> On 2024/12/17 0:53, Manivannan Sadhasivam wrote:
> > [...]
> > 
> >> +/*
> >> + * PCI EPF driver private data.
> >> + */
> >> +struct nvmet_pciep_epf {
> > 
> > nvmet_pci_epf?
> > 
> >> +	struct pci_epf			*epf;
> >> +
> >> +	const struct pci_epc_features	*epc_features;
> >> +
> >> +	void				*reg_bar;
> >> +	size_t				msix_table_offset;
> >> +
> >> +	unsigned int			irq_type;
> >> +	unsigned int			nr_vectors;
> >> +
> >> +	struct nvmet_pciep_ctrl		ctrl;
> >> +
> >> +	struct dma_chan			*dma_tx_chan;
> >> +	struct mutex			dma_tx_lock;
> >> +	struct dma_chan			*dma_rx_chan;
> >> +	struct mutex			dma_rx_lock;
> >> +
> >> +	struct mutex			mmio_lock;
> >> +
> >> +	/* PCI endpoint function configfs attributes */
> >> +	struct config_group		group;
> >> +	bool				dma_enable;
> >> +	__le16				portid;
> >> +	char				subsysnqn[NVMF_NQN_SIZE];
> >> +	unsigned int			mdts_kb;
> >> +};
> >> +
> >> +static inline u32 nvmet_pciep_bar_read32(struct nvmet_pciep_ctrl *ctrl, u32 off)
> >> +{
> >> +	__le32 *bar_reg = ctrl->bar + off;
> >> +
> >> +	return le32_to_cpu(READ_ONCE(*bar_reg));
> > 
> > Looks like you can use readl/writel variants here. Any reason to not use them?
> 
> A bar memory comes from dma_alloc_coherent(), which is a "void *" pointer and
> *not* iomem. So using readl/writel for accessing that memory seems awefully
> wrong to me.
> 

'iomem' is just a token that is used by sparse tool to verify correctness of
MMIO address handling. I know that the memory here is returned by
dma_alloc_coherent() and is not exactly a MMIO. But since you are using
READ_ONCE() and le32_to_cpu() on these addresses, I thought about suggesting
readl/writel that does exactly the same internally. If you do not need ordering,
then you can use relaxed variants as well.

> >> +static bool nvmet_pciep_epf_init_dma(struct nvmet_pciep_epf *nvme_epf)
> >> +{
> >> +	struct pci_epf *epf = nvme_epf->epf;
> >> +	struct device *dev = &epf->dev;
> >> +	struct nvmet_pciep_epf_dma_filter filter;
> >> +	struct dma_chan *chan;
> >> +	dma_cap_mask_t mask;
> >> +
> >> +	mutex_init(&nvme_epf->dma_rx_lock);
> >> +	mutex_init(&nvme_epf->dma_tx_lock);
> >> +
> >> +	dma_cap_zero(mask);
> >> +	dma_cap_set(DMA_SLAVE, mask);
> >> +
> >> +	filter.dev = epf->epc->dev.parent;
> >> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> >> +
> >> +	chan = dma_request_channel(mask, nvmet_pciep_epf_dma_filter, &filter);
> >> +	if (!chan)
> >> +		return false;
> > 
> > You should also destroy mutexes in error path.
> 
> Good catch. Will add that.
> 
> [...]
> 
> >> +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> >> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> >> +{
> >> +	struct pci_epf *epf = nvme_epf->epf;
> >> +	struct dma_async_tx_descriptor *desc;
> >> +	struct dma_slave_config sconf = {};
> >> +	struct device *dev = &epf->dev;
> >> +	struct device *dma_dev;
> >> +	struct dma_chan *chan;
> >> +	dma_cookie_t cookie;
> >> +	dma_addr_t dma_addr;
> >> +	struct mutex *lock;
> >> +	int ret;
> >> +
> >> +	switch (dir) {
> >> +	case DMA_FROM_DEVICE:
> >> +		lock = &nvme_epf->dma_rx_lock;
> >> +		chan = nvme_epf->dma_rx_chan;
> >> +		sconf.direction = DMA_DEV_TO_MEM;
> >> +		sconf.src_addr = seg->pci_addr;
> >> +		break;
> >> +	case DMA_TO_DEVICE:
> >> +		lock = &nvme_epf->dma_tx_lock;
> >> +		chan = nvme_epf->dma_tx_chan;
> >> +		sconf.direction = DMA_MEM_TO_DEV;
> >> +		sconf.dst_addr = seg->pci_addr;
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	mutex_lock(lock);
> >> +
> >> +	dma_dev = dmaengine_get_dma_device(chan);
> >> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> >> +	ret = dma_mapping_error(dma_dev, dma_addr);
> >> +	if (ret)
> >> +		goto unlock;
> >> +
> >> +	ret = dmaengine_slave_config(chan, &sconf);
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to configure DMA channel\n");
> >> +		goto unmap;
> >> +	}
> >> +
> >> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> >> +					   sconf.direction, DMA_CTRL_ACK);
> >> +	if (!desc) {
> >> +		dev_err(dev, "Failed to prepare DMA\n");
> >> +		ret = -EIO;
> >> +		goto unmap;
> >> +	}
> >> +
> >> +	cookie = dmaengine_submit(desc);
> >> +	ret = dma_submit_error(cookie);
> >> +	if (ret) {
> >> +		dev_err(dev, "DMA submit failed %d\n", ret);
> >> +		goto unmap;
> >> +	}
> >> +
> >> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> > 
> > Why do you need to do sync tranfer all the time? This defeats the purpose of
> > using DMA.
> 
> You may be getting confused about the meaning of sync here. This simply means
> "spin wait for the completion of the transfer". I initially was using the
> completion callback like in pci-epf-tets and othe EPF drivers doing DMA, but
> that causes a context switch for every transfer, even small ones, which really
> hurts performance. Switching to using dma_sync_wait() avoids this context switch
> while achieving what we need, which is to wait for the end of the transfer. I
> nearly doubled the max IOPS for small IOs with this.
> 
> Note that we cannot easily do asynchronous DMA transfers with the current DMA
> slave API, unless we create some special work item responsible for DMA transfers.
> 

Right, async transfer requires some changes as well.

> I did not try to micro optimize this driver too much for this first drop. Any
> improvement around how data transfers are done can come later. The preformance I
> am getting with this code is decent enough as it is.
> 

That's fine with me to do it later. But if you do it, then you'll get way better
performance.

> [...]
> 
> >> +static inline int nvmet_pciep_epf_transfer(struct nvmet_pciep_epf *nvme_epf,
> > 
> > No need to add 'inline' keyword in .c files.
> 
> Yes there is. Because that funtion is tiny and I really want it to be forced to
> be inlined.
> 

You cannot force the compiler to inline to your function using 'inline' keyword.
It just acts as a hint to the compiler and the compiler may or may not inline
it depending on its own logic. You can leave the inline keyword and let compiler
inline it when needed.

> [...]
> 
> >> +invalid_offset:
> >> +	dev_err(ctrl->dev, "PRPs list invalid offset\n");
> >> +	kfree(prps);
> >> +	iod->status = NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
> >> +	return -EINVAL;
> >> +
> >> +invalid_field:
> >> +	dev_err(ctrl->dev, "PRPs list invalid field\n");
> >> +	kfree(prps);
> >> +	iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> >> +	return -EINVAL;
> >> +
> >> +internal:
> >> +	dev_err(ctrl->dev, "PRPs list internal error\n");
> >> +	kfree(prps);
> >> +	iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
> >> +	return -EINVAL;
> > 
> > Can't you organize the labels in such a way that there is only one return path?
> > Current code makes it difficult to read and also would confuse the static
> > checkers.
> 
> I do not see how this is difficult to read... But sure, I can try to simplify this.
> 

Maybe my mind is too much used to single return in error path ;)

> 
> > [...]
> > 
> >> +static void nvmet_pciep_init_bar(struct nvmet_pciep_ctrl *ctrl)
> >> +{
> >> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
> >> +
> >> +	ctrl->bar = ctrl->nvme_epf->reg_bar;
> >> +
> >> +	/* Copy the target controller capabilities as a base */
> >> +	ctrl->cap = tctrl->cap;
> >> +
> >> +	/* Contiguous Queues Required (CQR) */
> >> +	ctrl->cap |= 0x1ULL << 16;
> >> +
> >> +	/* Set Doorbell stride to 4B (DSTRB) */
> >> +	ctrl->cap &= ~GENMASK(35, 32);
> >> +
> >> +	/* Clear NVM Subsystem Reset Supported (NSSRS) */
> >> +	ctrl->cap &= ~(0x1ULL << 36);
> >> +
> >> +	/* Clear Boot Partition Support (BPS) */
> >> +	ctrl->cap &= ~(0x1ULL << 45);
> >> +
> >> +	/* Clear Persistent Memory Region Supported (PMRS) */
> >> +	ctrl->cap &= ~(0x1ULL << 56);
> >> +
> >> +	/* Clear Controller Memory Buffer Supported (CMBS) */
> >> +	ctrl->cap &= ~(0x1ULL << 57);
> > 
> > Can you use macros for these?
> 
> I could. But that would mean defining *all* bits of the cap register, which is a
> lot... The NVMe code does not have all these defined now. That is a cleanup that
> can come later I think.
> 

No not needed to define all the caps, but just the ones you are using.

> [...]
> 
> >> +	if (epc_features->msix_capable) {
> >> +		size_t pba_size;
> >> +
> >> +		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
> >> +		nvme_epf->msix_table_offset = reg_size;
> >> +		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
> >> +
> >> +		reg_size += msix_table_size + pba_size;
> >> +	}
> >> +
> >> +	reg_bar_size = ALIGN(reg_size, max(epc_features->align, 4096));
> > 
> > From where does this 4k alignment comes from? NVMe spec? If so, is it OK to use
> > fixed_size BAR?
> 
> NVMe BAR cannot be fixed size as its size depends on the number of queue pairs
> the controller can support. Will check if the 4K alignment is mandated by the
> specs. But it sure does not hurt...
> 

My question was more about if the 4K alignment is enforced by the spec, then you
are ignoring alignment for fixed size BAR by using its fixed size:

reg_bar_size = epc_features->bar[BAR_0].fixed_size;

> [...]
> 
> >> +	/* Create the target controller. */
> >> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
> >> +	if (ret) {
> >> +		dev_err(&epf->dev,
> >> +			"Create NVMe PCI target controller failed\n");
> > 
> > Failed to create NVMe PCI target controller
> 
> How is that better ?
> 

It is common for the error messages to start with 'Failed to...'. Also 'Create
NVMe PCI target controller failed' doesn't sound correct to me. But I am not a
native english speaker, so my views could be wrong.

> > 
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (epf->vfunc_no <= 1) {
> > 
> > Are you really supporting virtual functions? If supported, 'vfunc_no < 1' is not
> > possible.
> 
> NVMe does support virtual functions and nothing in the configuration path
> prevents the user from setting one such function. So yes, this is supposed to
> work if the endpoint controller supports it. Though I must say that I have not
> tried/tested yet.
> 

If virtual functions are supported, then 'epf->vfunc_no < 1' is invalid:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/endpoint/pci-epf-core.c#n79

If virtual functions are not tested, then I'd suggest dropping the check for it.

> > 
> >> +		/* Set device ID, class, etc */
> >> +		epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
> >> +		epf->header->subsys_vendor_id =
> >> +			ctrl->tctrl->subsys->subsys_vendor_id;
> > 
> > Why these are coming from somewhere else and not configured within the EPF
> > driver?
> 
> They are set through the nvme target configfs. So there is no need to have these
> again setup through the epf configfs. We just grab the values set for the NVME
> target subsystem config.
> 

But in documentation you were configuring the vendor_id twice:

	# echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
	...
        # echo 0x1b96 > nvmepf.0/vendorid

And that's what confused me. You need to get rid of the second command and add a
note that the vendor_id used in target configfs will be reused.

> >> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
> >> +{
> >> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
> >> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
> >> +
> >> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
> > 
> > These prints are supposed to come from the controller drivers. So no need to
> > have them here also.
> 
> Nope, the controller driver does not print anything. At least the DWC driver
> does not print anything.
> 

Which DWC driver? pcie-dw-rockchip? But other drivers like pcie-qcom-ep have
these prints already. And this EPF driver is not tied to a single controller
driver. As said earlier, these prints are supposed to be added to the controller
drivers.

> >> +static ssize_t nvmet_pciep_epf_dma_enable_store(struct config_item *item,
> >> +					     const char *page, size_t len)
> >> +{
> >> +	struct config_group *group = to_config_group(item);
> >> +	struct nvmet_pciep_epf *nvme_epf = to_nvme_epf(group);
> >> +	int ret;
> >> +
> >> +	if (nvme_epf->ctrl.tctrl)
> >> +		return -EBUSY;
> >> +
> >> +	ret = kstrtobool(page, &nvme_epf->dma_enable);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return len;
> >> +}
> >> +
> >> +CONFIGFS_ATTR(nvmet_pciep_epf_, dma_enable);
> > 
> > What is the use of making this option user configurable? It is purely a hardware
> > capability and I don't think users would want to have their NVMe device working
> > without DMA voluntarily.
> 
> If you feel strongly about it, I can drop this. But it is useful for debugging
> purpose to check that the DMA API is being used and working correctly.
> 

But if you enable DMA by default, that would test the DMA APIs all the time. I
don't see a necessity to allow users to disable DMA.

> >> +static int __init nvmet_pciep_init_module(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = pci_epf_register_driver(&nvmet_pciep_epf_driver);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = nvmet_register_transport(&nvmet_pciep_fabrics_ops);
> > 
> > What is the need to register the transport so early? You should consider moving
> > the registration to bind() so that the transport can be removed once the driver
> > is unbind with the controller.
> 
> This registration is needed to enable the configfs configuration of the nvme
> target subsystem and port. Withoutn this, setting a port transporet type to
> "pci" would fail to find the pci transport implemented here and the
> configuration would fail. This configuration of the nvme target susbsystem and
> port must come before configuring the EPF and binding it.
> 

Ok, fair enough.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

