Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069B6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 May 2022 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MiZ+0IvW8jjjxvu1Bkq9ZIWIVqKUJacSyRxJpKCYH18=; b=WiK/2HwMPLQzjM/jsa2T1kRmOn
	P8Oj+Eo0TNWWLc/o0Xt8cGkZqAaNqyfr9uL/NOYkz7QCOr+6JfHvQ+fj8Ava27j6Rg6j/vhVa9d0l
	Pd+hVctvx/XqgBhp5dEVSomjNJ4Yt85Fs3PM/zqNiyqnKzF/ihJS5D43l/+5PApN7JO9U8v8aJF5o
	0JS1nT+LGTammfWBOM3xJ48HnXZt0YT3aadEv5Wvg4zYITY2ZWbx7WpMD1VU2m5NCJsajRboCFbnt
	iQn/vdljvoA+IdjnQlFOd+ZsP3/uVEP8X+Kdf7qn69KqDfalacNHSjFhbLGMrg586AIWt0UVNS+A4
	iGLio6Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuKfq-00FxJ2-8j; Thu, 26 May 2022 21:05:38 +0000
Received: from mail-oa1-f51.google.com ([209.85.160.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuKPs-00Fqqv-IT
	for linux-nvme@lists.infradead.org; Thu, 26 May 2022 20:49:09 +0000
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3596271fac.9
        for <linux-nvme@lists.infradead.org>; Thu, 26 May 2022 13:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MiZ+0IvW8jjjxvu1Bkq9ZIWIVqKUJacSyRxJpKCYH18=;
        b=MAzPg2cqWorgwVMnMm8HddQWozKyklDhQk4wZGpTHSBOBLzQLDTmj1Iqm9uGjbfr6v
         sbxH+DAEw5kgeqA6wnbh5pME6mmaadxboTaisDwgFjmctGYO30QzNMvAtQ6DQc4f6+Ei
         v5Fy27lAiWF0DvzyTETYY69t4aMHpBPXcMQOezhnVv7LKDeXb3o2CDNfjETY4w1BedXt
         p1sIaZ4mt35c8TvKTAldsMb6bqS0elYWvTmlIh61BHDXuO3ZePebBrnDkXAGs0avqYmM
         gPvpQsaqpg5AbuYSPmw7ewr3ZNOwQbHCSQGmHOKXGj3pksh21vmCiaaDRN6pIJbZLo7U
         7AkA==
X-Gm-Message-State: AOAM533oaqnYXXyQHzg5o3STj6e+v2sS5Lp7jADYenhJT4tgPppiMhvc
	I8ZoUX9wlypbaTbwuhesQFLNsrweXQ==
X-Google-Smtp-Source: ABdhPJwzclLUkR3PCJ6MEvx5J/Soe/zca3RJeZCRBhWGgy4tEyDUtmeTjwbPMaDrqR8MEXweQCsEeQ==
X-Received: by 2002:a05:6870:7084:b0:ed:d709:34be with SMTP id v4-20020a056870708400b000edd70934bemr2229680oae.4.1653598120077;
        Thu, 26 May 2022 13:48:40 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-37.sw.biz.rr.com. [192.154.179.37])
        by smtp.gmail.com with ESMTPSA id y17-20020a4ae711000000b0035eb4e5a6d2sm1036427oou.40.2022.05.26.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:48:39 -0700 (PDT)
Received: (nullmailer pid 238876 invoked by uid 1000);
	Thu, 26 May 2022 20:48:37 -0000
Date: Thu, 26 May 2022 15:48:37 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com, quic_vbadigan@quicinc.com, quic_krichai@quicinc.com, quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about
 powerdown during suspend
Message-ID: <20220526204837.GJ54904-robh@kernel.org>
References: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
 <20220516201817.GA1047280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516201817.GA1047280@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_134908_644291_A8225586 
X-CRM114-Status: GOOD (  24.66  )
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

Why does this apply to the whole host bridge? What if you have multiple 
devices and some are powered off and others aren't?

Rob

