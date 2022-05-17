Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6930C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=3MSbKn8LsKhFlVC3mSScicjcOfY7V1ma6YdneTKkK8k=; b=QgUatxxQLonudo
	F/oS16cLTAHK4xeeFywSoV6mdGrLEqqMK6mBte/tLhNutBzTyFwH/NurM9diH1BpokNcbE0iuAaKz
	dJAllxmzMGmMiIoG7On1nDtOxx4GcSNnPEbpeLIGp0C86PzQ9F1na0ww/OowzgnqnobyuvkCKrTKq
	LV5m96WxEb+zkf1SR62YX0XxJ038MtyvqO6J93ABT/Ewiy7Mhc8EhE3XZnajmPdf7iqdzT+K9jsWW
	ZMazMUE/6lnrBt53imvatnyNZwuR2dbEWQGCmEjjnsupCKsR+V37zaBoC1/cPhOCtj1edYO+IS0O7
	KdI0CDg+5xhInEoXRLPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr0vv-00F2qd-VR; Tue, 17 May 2022 17:24:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr0vs-00F2pl-8G
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 17:24:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id ADDF5B81B0D;
 Tue, 17 May 2022 17:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A4EC385B8;
 Tue, 17 May 2022 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652808265;
 bh=mL+KtsPPjaEbR2Y51As6zVyBznRSejv6V79j/n2+j1k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=CpWruRzecxaSahxwxwCcvv6XRIcM5qxZVm9o6TOLb4n5Jg0KydISdkpUiKtbfNNL1
 jMrQEeQqpEawYSrNJ/QKKv9n+23WCKw6Ft/TB88q7fT5gxeMUtgSz0TV27Gg8N+kPx
 jmDH+6o4QXPXvbjI5LJ/Hp4ADBZn3SHdvcHbpacGqqtB/QOx/HtIvIgn1LC1beSN2l
 ZZVwqOO8s2I0DU7JTqYMPiwUEThHfZUCS9mPBJ9HjRHNpEHfrYpUrGm0+8TNxyeoW2
 1WmH5UPddzomHugwOa1h2Tbl5kjQNPLfR/u2a2yTcmR407H06I7bVYgo/UFjmZLC2V
 a7WX3mftvA+Vg==
Date: Tue, 17 May 2022 12:24:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20220517172423.GA1083672@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517150908.GA4528@thinkpad>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_102428_622806_A33AD978 
X-CRM114-Status: GOOD (  32.64  )
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

On Tue, May 17, 2022 at 08:39:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 16, 2022 at 03:18:17PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 13, 2022 at 04:30:25PM +0530, Manivannan Sadhasivam wrote:
> > > On some systems like Chromebooks based on Qcom chipsets, the OS may
> > > powerdown all PCIe devices during system suspend for aggressive
> > > powersaving. In that case, the PCI host controller drivers need to notify
> > > the PCI device drivers that the power will be taken off during system
> > > suspend so that the drivers can prepare the devices accordingly.
> > 
> > "The OS may powerdown all PCIe devices ..." makes it sound like this
> > is an OS policy decision.  Where exactly (what function) is that?
> > 
> > Or if it's not an OS policy decision, but rather some property of the
> > hardware, say that specifically.
> 
> On SC7280, it is the Resource Power Manager(RPMh) that's powering
> the devices down by cutting off the PCIe voltage domain. But the
> SC7280 RC driver itself may put the PCIe devices into D3cold state
> during system suspend.
> https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/
> 
> So to cover both cases (one is a hardware independent of SoC and
> another one is the device driver), and to be generic, I've used the
> term "OS" after looking at the previous flags.

This sort of device-specific behavior definitely needs a pointer to an
example.  Otherwise it seems like it could be generic PCIe behavior
that should be documented in the PCIe base spec.

> > > One prime example is the PCI NVMe driver. This flag can be used by the
> > > driver to shutdown the NVMe device during suspend and recover it during
> > > resume.

Apparently nvme is broken, or at least sub-optimal, without this flag.
What other drivers will be similarly affected?

> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  include/linux/pci.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 60adf42460ab..069caf1fe88d 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -578,6 +578,7 @@ struct pci_host_bridge {
> > >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> > >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> > >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > > +	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
> > >  
> > >  	/* Resource alignment requirements */
> > >  	resource_size_t (*align_resource)(struct pci_dev *dev,

