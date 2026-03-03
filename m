Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D5EDA694
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okOmVOs5aH1AVuel2k4pgEAgov5NX9I7QzjXcxQ4ZJ8=; b=OvlN6fTj/7TCPGokBW9u9Q7YAW
	IeUAXCtfSDkfeL79BcBo0QzrXXoMdtVvZsfkNxXQ0Z8XcXiVajzzRS4Gtc8kERanoc1GsRilcuI5z
	9XleMLwBsW96ATxIlyUgfXISK+MhVmPvNsocAvcZ3sK3S978Qnf3PqzZUmsxtiMrubEMETyYmvGcl
	adQZF8bVSufS1hvTtPXIXKLDFF1GUqG05ub3Lc4BKy9FD9FYMoEUtep/WMEKPrwMGipmp73dMdULX
	AwD2lI4nrSCjfufrdtbyY9i/YTAy6A0/WAfQKyUk3LAUjK1Tk2+6u8Fw5RvcW4njeZ435ImCgG2Wn
	HWuYPo3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSb4-0000000FYnw-0fo1;
	Tue, 03 Mar 2026 16:27:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxSb1-0000000FYnM-1LNl
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 16:27:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BC1C844062;
	Tue,  3 Mar 2026 16:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464ACC19422;
	Tue,  3 Mar 2026 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555262;
	bh=02WuwVzfcqREGKNcO4A+gehHauWokgchNs/BbMoEVRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGwJT3ccRPvCctpnE4DzTVD9FcqQmUNlycHUD0v6oE4FbMMKWy2q5rt9sKy0wKWn5
	 XWyuo0Xe6aDRAWyTuIbehuzELvMVCVofjpVhED//48OHcWjhILi9DMBEPdLcSDWDCb
	 d6+pNTKHz74ebyHUBnyikOrKlOvq9eJMLEd2RoXhwffxanj1dl2oO3XrEEp8Rb1vtM
	 RKec0J64+9GRrl2bq6SfYqks3UlK1VN+5ZOBcRiq8EY9e1sIuv/vYBSCpXXDm7s652
	 zmoURwTNwBIhEAEjysccLZK+I/09A5pk+DOppSF/yM+gXjuPFM62kyd9DKC/NLqvSw
	 jwVKBkkp/E0PQ==
Date: Tue, 3 Mar 2026 21:57:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, krishna.chundru@oss.qualcomm.com, 
	manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <km5stwtgzyshi5ogd2ke7qjj35nakwo6ztho5ju6y4ds32epln@fqqebty3v6me>
References: <e44c330b-778b-4fa1-b678-fa909cc05b03@nvidia.com>
 <bf37b6a5-268d-4c07-a536-a826b3d5953b@nvidia.com>
 <unc5zefwndgcv7wufaezz3gkg3qtaymkjlmymhyqdqwzn3wybl@ow2rhbyt772h>
 <f9ac8c8f-8959-416b-ba90-14f0886c5bc0@nvidia.com>
 <a5m4pqtiaxsq5lmq64roro633ganbeq7mypa5ojuuqy4npkvok@wcogdbzaq6xe>
 <7157c68e-97f3-43b0-bfb5-e271a8f2a4b8@nvidia.com>
 <cf1e685a-a1cb-45ec-bdc3-1ef1a3d1044e@nvidia.com>
 <e0a0dc6d-fff0-41ec-92eb-7f2dbefa967b@nvidia.com>
 <vpwe273ehsbsyjpysyky4ypgnawosjehen34rr2n5bpoaqjsyg@3uylwh3oyyqc>
 <cfbbe3f0-f958-4cf2-aaa0-afca52cc5d5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfbbe3f0-f958-4cf2-aaa0-afca52cc5d5e@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_082743_398474_36232F5C 
X-CRM114-Status: GOOD (  24.78  )
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

On Thu, Feb 26, 2026 at 04:55:34PM +0000, Jon Hunter wrote:
> 
> On 26/02/2026 11:08, Manivannan Sadhasivam wrote:
> 
> ...
> 
> > Since we know that ASPM is the issue on your platform and the failure also
> > confirms that ASPM was never enabled before, I'd suggest disabling ASPM for the
> > Root Port as a workaround:
> > 
> > ```
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 06571d806ab3..f504b4ffbcb6 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -2499,6 +2499,13 @@ module_platform_driver(tegra_pcie_dw_driver);
> >   MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);
> > +static void tegra_pcie_quirk_disable_aspm(struct pci_dev *dev)
> > +{
> > +       pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L1 |
> > +                                 PCI_EXP_LNKCAP_ASPM_L0S);
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, tegra_pcie_quirk_disable_aspm);
> > +
> >   MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> >   MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
> >   MODULE_LICENSE("GPL v2");
> > ```
> > 
> > You can use specific Root Port IDs or PCI_ANY_ID depending on the impact. We can
> > also work on fixing the actual issue parallelly.
> 
> Thanks. By default we are building the PCIe driver for Tegra as a module and
> so I am not sure we can use DECLARE_PCI_FIXUP_EARLY() right?
> 

Ah, yes. We cannot use any of these DECLARE_PCI_FIXUP*() in a module anyway :/

> I was just thinking that in pcie_aspm_override_default_link_state() we just
> need a callback to specify the default ASPM override state?
> 

That looks like a dirty hack. Moreover, your platform works perfectly fine with
ASPM. So you should not be turning it off due to one driver behaving
erratically.

As I mentioned in [1], you should try to advertise the
PM_SUSPEND_FLAG_FW_SUSPEND flag for the platform as per [2].

FYI, this is a known issue that is plauging us for so long.
PM_SUSPEND_FLAG_FW_SUSPEND is the cleanest solution we came up with. But
unfortunately, we cannot use it across all of our Qcom SoCs due to firmware not
advertising S2RAM in some of them.

- Mani

[1] https://lore.kernel.org/linux-pci/kkly3z4durpagtenadvmzdpojlctachgfgi2fdapt6zthdl2gx@n2qhmlud2zb7/
[2] https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்

