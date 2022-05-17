Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D64C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c37zykIbAvjFJYeekhN1tO9l8rsyfkhDhDABYYW7ubQ=; b=mXlhzlG5G8bba2BUScYSWpTCr3
	Gd3BzKgIRhaGvK7omr1E/bve6DMlGCgp6QLmBgZjxSHxiv4ECO7bIXZW3PC9JA4FewMFYZbSctJXM
	/xASv1KF7e7yMaAU8Qm2UHVjbAdmpnA3hdGNdeZ4OcJLuu2uBWfts4ev8mXHRO4xRSkufcf14/4yZ
	6v2URnTbju0G0a2PEZir7AM8lMEIXzjPAT/T7qlEBIyPZwHRxw8HlHirgQoESoFU9urid8Ilu45/v
	EPFQfKT4tGYWyHro9OI9EeIY6daraK3IUhk04ajPIiVNYbwsz44qjegErkUcOp7NkNtqIUKtXW9Wb
	/5M/dxwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqypA-00Ebei-Ka; Tue, 17 May 2022 15:09:24 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqyp8-00EbdG-3j
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 15:09:23 +0000
Received: by mail-pj1-x1035.google.com with SMTP id gg20so7584788pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=c37zykIbAvjFJYeekhN1tO9l8rsyfkhDhDABYYW7ubQ=;
 b=IyKFIEv664GQuHoUUrx8MniZCSQahLCVahex0zoQ5/eIc3vMbL1OFDDhDNKk1nYTxn
 swUcZfWl4f7dml8rPzm9rxDkHB2h/REMY9zKXWzgbt30Pn9TdQ1KvwE0MpnxhpWIQ0vC
 CZXwCKrOF3OJ/FGH4HVr3rOP8poNBCFgCok4/hef7l9NZz04lX7KEMEjtKQcM7ByFP4L
 LsM5wrJE6BVsKID61tcU/8ogohaf5IAPbnMb9dRSkXDgoFXl26LvfPoTsi8lsOd1gTB5
 bLAuCEPBZU9JFDjRnDlqDau87RI48xnsfZGr7EP7ghv54bBagq8QHmp26XUkKtAdqOpW
 B4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=c37zykIbAvjFJYeekhN1tO9l8rsyfkhDhDABYYW7ubQ=;
 b=QbMurQ8NevJ2N2SzZdpv3y2aQr/ht6MGGt41ETo/2rALrnhcksASyHbLo5UuAfvbFm
 E2rMCmkA8CFxCuwU5hh9XZHqaoXTfeoeqX//c36+MoDzVTS73yKsbP7KpEdrMFGC4l57
 HGfjjMMDgkTxJ7CGDIQPff8BIJUOxLwPUX/YVZ3LD+1pW6PVKT8Hv89Gj+kXHGT6KRfU
 dl+36zipvh1a0DOEvBn82ofgcXf6KLgsEmS1e3UqiMSwFIgBy43gmGbInb60f1J+Wn5U
 0/yzdsPpN6mVeGAHbSKQeTgq0ORDAoOKpUZqy6/EIKzj6B7DRiiIWiRGlxSATB6pixRX
 KcpQ==
X-Gm-Message-State: AOAM533qOly8+e5rcydOLL7gL0p07qvkIHlhD2SZEbg/XOZMdNJMggN9
 ZuNWLJcyMlnqdErWrIkMsqwXvVFlRjfT
X-Google-Smtp-Source: ABdhPJwXpnFf4RpEJB6ZM9C6d1HomdLU+ojRr/GSDmdjVh21K4qNzcEPWLJs85sZ4veBB/fpoL88ZA==
X-Received: by 2002:a17:90b:3a86:b0:1dc:2343:2429 with SMTP id
 om6-20020a17090b3a8600b001dc23432429mr25390497pjb.206.1652800158569; 
 Tue, 17 May 2022 08:09:18 -0700 (PDT)
Received: from thinkpad ([117.207.31.8]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c2cc00b0015e8d4eb1ebsm9230630pla.53.2022.05.17.08.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 08:09:18 -0700 (PDT)
Date: Tue, 17 May 2022 20:39:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
 bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_nitirawa@quicinc.com,
 vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220517150908.GA4528@thinkpad>
References: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
 <20220516201817.GA1047280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516201817.GA1047280@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_080922_220418_DCD6CCBE 
X-CRM114-Status: GOOD (  25.99  )
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

On Mon, May 16, 2022 at 03:18:17PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> > On some systems like Chromebooks based on Qcom chipsets, the OS may
> > powerdown all PCIe devices during system suspend for aggressive
> > powersaving. In that case, the PCI host controller drivers need to notify
> > the PCI device drivers that the power will be taken off during system
> > suspend so that the drivers can prepare the devices accordingly.
> 
> "The OS may powerdown all PCIe devices ..." makes it sound like this
> is an OS policy decision.  Where exactly (what function) is that?
> 
> Or if it's not an OS policy decision, but rather some property of the
> hardware, say that specifically.
> 

On SC7280, it is the Resource Power Manager(RPMh) that's powering the devices
down by cutting off the PCIe voltage domain. But the SC7280 RC driver itself
may put the PCIe devices into D3cold state during system suspend.
https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/

So to cover both cases (one is a hardware independent of SoC and another one is
the device driver), and to be generic, I've used the term "OS" after looking at
the previous flags.

Thanks,
Mani

> > One prime example is the PCI NVMe driver. This flag can be used by the
> > driver to shutdown the NVMe device during suspend and recover it during
> > resume.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  include/linux/pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 60adf42460ab..069caf1fe88d 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -578,6 +578,7 @@ struct pci_host_bridge {
> >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
> >  
> >  	/* Resource alignment requirements */
> >  	resource_size_t (*align_resource)(struct pci_dev *dev,
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

