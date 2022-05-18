Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C5FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 03:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMTtZkU4nCZ91NEzU4LZyarDEe9CrBJP6c+5gci4GhU=; b=xhJR+2hsq4UmcZbHv5XZSsScbi
	NFv5+PXC1fkfJ3qrXZjABSbuYeY6CeA+2of+QBvSjL6aZUMkkp3ixqj4aTkiN4LmOtDuyhmgeiUfE
	KbqIP4bHjXUQ5+Mv+X9T/BbHQLuxPqiRa85jt1wWBELh68+kdtrpGlUS+nzsTKH3lt2zxuiOkwYRr
	uKczS08yobVETgu/aVi482sSR8F5MOV9S45zy17x6h/AvLTiYeRtCIdqPC/tfN3/qRfU7CnAR0Bn4
	bm5FELbQhfjOc+oPJFhgaSu8oA2nrX5meKzxrfIBngQX6FHcxQVyrYUWTmHDFwkEl+sfIQ5zdru44
	fparOq4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrAqP-00Gy8H-Rn; Wed, 18 May 2022 03:59:29 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrAqM-00Gy7k-Sk
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 03:59:28 +0000
Received: by mail-pl1-x630.google.com with SMTP id c2so636549plh.2
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=oMTtZkU4nCZ91NEzU4LZyarDEe9CrBJP6c+5gci4GhU=;
 b=hF2SJNQuyAPX27K3O9IKX/L7RDe9giGyYcZXLKfxFWF8u2tDkNwctNMV0RTCXeqRtY
 Z/h56M6pzUGxi0REj9rAvd+5EJwbbTuTDWrXHJHFAHMuLiUAg2edghW6NutRy2mfL/Jm
 GMPvVsvejGx11NLjXPDbv0od0DV06IaVgfKqzMldePlFVBPRgeTw+s3gy6CS6Q6xrJze
 6igJeBRbf8skF17n1cjJu1pjR5o3rBESjG0GklU0cXmf8msxavMpTLRNixhQLL59apY2
 lP+0Sw+pVuMPOZDXlWhb4y+h+vBrYz5EEnJNZwavhIqx6Af8rBeeMJdmBg6IXNl3Q/9S
 PC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oMTtZkU4nCZ91NEzU4LZyarDEe9CrBJP6c+5gci4GhU=;
 b=g9sS1JMxDPzKgd3q0IUUYsKAy85c7Af7A1j6uK3LcQY5Ah+bfbNZ5Q4do6wPjXI8sp
 GixO4hESoMGszmO9EM7lnqSbj0JMmR24bP1pPyoQyYt2q0RgSg2CjQh0MMDrqZR/5EEO
 8wSea70aIHO7sryfZCm2gQWeoRlSaqn0+MolUEsAI7kBKTeR8RU9NyEWjBkd/yu3Vp5K
 QsdOCCr+dDao0NZuZnKIUE+UPIIf/ylNGo2yfhyUAmOvM0FDa+cG9p3YvcMscS0o/k9i
 /2Hx6hrDnIvjY2vYLTmxyU1tQrUE+DzEG+59Jtqhts6PD8yzIHDiWfc0Ncm/nz/H3ehF
 Yblw==
X-Gm-Message-State: AOAM532OwSVHaR6Ca/5ulwLM1Lva+GibUdfJnLBoDMv3AkZBH+x8JEiC
 Cfn0zmV+erK9A5Zp2ecgQfIm
X-Google-Smtp-Source: ABdhPJzXyPrirmGjfB9wAO7hUPPrBdR7ojzbTs2rrQl2LhF5QrddfhsS+8ZM5ow+o6gPFsXwn0NTUA==
X-Received: by 2002:a17:90a:f3d5:b0:1df:2191:5ad2 with SMTP id
 ha21-20020a17090af3d500b001df21915ad2mr20245819pjb.136.1652846365631; 
 Tue, 17 May 2022 20:59:25 -0700 (PDT)
Received: from thinkpad ([117.207.31.8]) by smtp.gmail.com with ESMTPSA id
 g8-20020a170902d5c800b0015e8d4eb225sm413568plh.111.2022.05.17.20.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 20:59:25 -0700 (PDT)
Date: Wed, 18 May 2022 09:29:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Jens Axboe <axboe@fb.com>,
 Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
 quic_krichai@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
 Vidya Sagar <vidyas@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220518035915.GB4791@thinkpad>
References: <20220517150908.GA4528@thinkpad>
 <20220517172423.GA1083672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517172423.GA1083672@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_205926_971234_543FFFFD 
X-CRM114-Status: GOOD (  37.68  )
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

On Tue, May 17, 2022 at 12:24:23PM -0500, Bjorn Helgaas wrote:
> On Tue, May 17, 2022 at 08:39:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, May 16, 2022 at 03:18:17PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> > > > On some systems like Chromebooks based on Qcom chipsets, the OS may
> > > > powerdown all PCIe devices during system suspend for aggressive
> > > > powersaving. In that case, the PCI host controller drivers need to notify
> > > > the PCI device drivers that the power will be taken off during system
> > > > suspend so that the drivers can prepare the devices accordingly.
> > > 
> > > "The OS may powerdown all PCIe devices ..." makes it sound like this
> > > is an OS policy decision.  Where exactly (what function) is that?
> > > 
> > > Or if it's not an OS policy decision, but rather some property of the
> > > hardware, say that specifically.
> > 
> > On SC7280, it is the Resource Power Manager(RPMh) that's powering
> > the devices down by cutting off the PCIe voltage domain. But the
> > SC7280 RC driver itself may put the PCIe devices into D3cold state
> > during system suspend.
> > https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/
> > 
> > So to cover both cases (one is a hardware independent of SoC and
> > another one is the device driver), and to be generic, I've used the
> > term "OS" after looking at the previous flags.
> 
> This sort of device-specific behavior definitely needs a pointer to an
> example.  Otherwise it seems like it could be generic PCIe behavior
> that should be documented in the PCIe base spec.
> 

Okay.

> > > > One prime example is the PCI NVMe driver. This flag can be used by the
> > > > driver to shutdown the NVMe device during suspend and recover it during
> > > > resume.
> 
> Apparently nvme is broken, or at least sub-optimal, without this flag.

Yes, broken on SC7280 or any other SoCs that turn off power.

> What other drivers will be similarly affected?
> 

I don't have a list but the drivers that don't expect the device to be turned
off or reset during suspend may experience this issue. Right now, we have only
identified the issue with NVMe because that's what used on Chromebooks.

But in the coming days, we may need to fix some of the drivers also.

Thanks,
Mani

> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  include/linux/pci.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index 60adf42460ab..069caf1fe88d 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -578,6 +578,7 @@ struct pci_host_bridge {
> > > >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> > > >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> > > >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > > > +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
> > > >  
> > > >  	/* Resource alignment requirements */
> > > >  	resource_size_t (*align_resource)(struct pci_dev *dev,

-- 
மணிவண்ணன் சதாசிவம்

