Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF608C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:35:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D1020781
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DnkQiefL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8Y1tdpX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcR6UPQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D1020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:Subject:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=3YFPaaV/7S9tq/p1YpxOIrk4a3FMC1aYtQ3WIL9tjxA=; b=DnkQiefL6DxNSW6wOQqImRsdt
	Zn0683LUUZ7Frh8kbqOdF+tE05RxKsELkTsKIhmW+6iimFEbgatDWbY//YuoIji/Blwm4smS8iErK
	AGWDytDNPS9UTZSwXJGb5t13TI43eqIgWmr0dnxzWzvKS54cgWlttHi0ZD4hxFJfrsy7Ns0fkj79N
	GZ82SBUk8Iyda4tBitiuV4HJ1Xra4Yt+n3zJLzPRXTya9/oJuNM1B5QIR9/jPWGQ2Us10g6jVAC1q
	uDPk8/4DPacWNTICEihOX5eAB0MMabPxvUGBITRNt/mbXB+DrwQ/veFLbaXkLm8jdj9LyJvZXg7Pz
	GzppP8GFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomdp-0006WX-KJ; Fri, 26 Jun 2020 11:35:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolKH-0004OP-It
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:References;
 bh=q40jBAvsV1oaaCm4vYZZ5nkc32wKhHJcoXU07lnlTtY=; b=S8Y1tdpXBgKbACixfaIDr0qtJo
 QPAaKAtkvIwKaEB+xM9GLw1msYFO2bGoRuvtiF42chaPuJ9oIj9l7IuFngo3Vegm/kiND7vW2SnEL
 2TAYjkiz5OpZVQv5BSx1vDlzhvmwdsjIpBe20/4tPE1iyK/qYcKomTj/MicTimJeTDQFkFL6dSW93
 9lHpL4PWIERUnevVzKBj+pfAJhuS/SV7ExwvYlKJSvdNSZfbuF8ePu2A+jlixHFM5CVt6htLlG0iQ
 MxB07wL4B56cu8sqaNkE3969vAcPcOkA3VC39rpiXw1gIeXVvhL9jzoBziNx978ybJnJpvCOAHoi8
 k6yBGqSw==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joViE-000213-Ky
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 17:31:01 +0000
Received: from localhost (mobile-166-170-222-206.mycingular.net
 [166.170.222.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2D0320789;
 Thu, 25 Jun 2020 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593106255;
 bh=FwCQ696O7Br9AROnL6MUzsJIYGTIRPIdruuU47avOfY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=VcR6UPQLooXvts5AMZD1x7Qy6i3ZI74p0iNvVpd12tmDSmSQ7d1+khqitauC42+as
 fL/B9TaT3Ea4Mzg8BtsqeXk86xor0VZGaXUdnT1M/6KjNXZ5e/c1PRIPWmqMbLR+VY
 Ls07poO3E+Yr065NFY9vxfsjXA1nyn/pwH3UN8Xg=
Date: Thu, 25 Jun 2020 12:30:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200625173053.GA2694537@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200625_183059_125563_D7332637 
X-CRM114-Status: GOOD (  49.23  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, shyjumon.n@intel.com,
 Keith Busch <kbusch@kernel.org>, "David E. Box" <david.e.box@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 25, 2020 at 01:30:53PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 11:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > > StorageD3Enable is a boolean property that indicates that the
> > > platform wants to use D3 for PCIe storage drives during
> > > suspend-to-idle. It is a BIOS work around that is currently in
> > > use on shipping systems like some Intel Comet Lake platforms. It
> > > is meant to change default driver policy for suspend that may
> > > cause higher power consumption.

> > > +/**
> > > + * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
> > > + * @pdev: PCI device to check
> > > + *
> > > + * Returns true if the ACPI companion device contains the "StorageD3Enable"
> > > + * _DSD property and the value is 1. This indicates that the root port is
> > > + * used by a storage device and the platform is requesting D3 for the
> > > + * device during suspend to idle in order to support platform pm.
> > > + */
> > > +bool pci_acpi_storage_d3(struct pci_dev *dev)
> > > +{
> > > +     const struct fwnode_handle *fwnode;
> > > +     struct acpi_device *adev;
> > > +     struct pci_dev *root;
> > > +     acpi_handle handle;
> > > +     acpi_status status;
> > > +     bool ret = false;
> > > +     u8 val;
> > > +
> > > +     /*
> > > +      * Look for _DSD property specifying that the storage device on
> > > +      * the port must use D3 to support deep platform power savings during
> > > +      * suspend-to-idle
> > > +      */
> > > +     root = pci_find_pcie_root_port(dev);
> >
> > I think this would need to be updated to apply to v5.8-rc1 after
> > 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> > pci_find_pcie_root_port()").
> >
> > https://git.kernel.org/linus/6ae72bfa656e
> >
> > > +     if (!root)
> > > +             return false;
> > > +
> > > +     adev = ACPI_COMPANION(&root->dev);
> > > +     if (!adev) {
> > > +             /*
> > > +              * It is possible that the ACPI companion is not yet bound
> > > +              * for the root port so look it up manually here.
> > > +              */
> > > +             if (!adev && !pci_dev_is_added(root))
> > > +                     adev = acpi_pci_find_companion(&root->dev);
> >
> > I see that you copied this "ACPI companion not yet bound" thing from
> > acpi_pci_bridge_d3().  But it's ugly.
> >
> > Isn't there a way we can bind the ACPI companion during normal PCI
> > enumeration so we don't need this exception case?
> >
> > I really do not like the idea of putting this code in the PCI core
> > because AFAICT the PCI core can do nothing with this information.
> >
> > If we could make sure during enumeration that the root port always has
> > an ACPI companion, this code could go to the nvme driver itself.  And
> > we could also clean up the ugliness in acpi_pci_bridge_d3().
> >
> > Rafael, is that possible?  I don't really know how the companion
> > device gets set.
> 
> That's a bit convoluted.
> 
> device_add() calls device_platform_notify(), before calling bus_add_device().
> 
> device_platform_notify() calls acpi_platform_notify() which invokes
> acpi_device_notify() that looks for the companion via
> type->find_companion() which for PCI points to
> acpi_pci_find_companion().  If found, the companion is attached to the
> dev structure as a physical_node, via acpi_bind_one().
> 
> So by the time bus_probe_device() runs, the companion should be there
> already - if it is there at all.
> 
> The parent ACPI companion should be present when the child is probing
> too, as per the above.
> 
> > Maybe this is could be done somewhere around pci_device_add()?
> 
> It is done in there.
> 
> It is not necessary to call acpi_pci_find_companion() from
> pci_acpi_storage_d3() as long as that function is required to be
> called by the target device's driver probe or later.

OK, great.  IIUC, that means this function doesn't need to be in
drivers/pci and it could be moved to the NVMe code.

> Ths acpi_pci_bridge_d3() case is different, though, AFAICS, because it
> is invoked in the pci_pm_init() path, via pci_bridge_d3_possible(),
> and that gets called from pci_device_add() *before* calling
> device_add().
> 
> Mika, is that why acpi_pci_find_companion() gets called from
> acpi_pci_bridge_d3()?

Is pdev->bridge_d3 really needed before pci_device_add()?  It would be
really nice if there were a way to get rid of that manual lookup of
the companion device in acpi_pci_bridge_d3().

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
