Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4161BF43698
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+TDFG3nfJA8n0TH8rf/gvjeJ8FWKug17bdRwNZTOlg=; b=wj3ajAAIN0O51A8wwkZM3Fp9PJ
	OKuBWrzxMhoszuHfHbzExY3hBEmR5njuhl5ltVr1OHRy/rpI2sZFI07XmLNYKYFoP4WXbuDiN3YYg
	UIKGlGPVUPZ9dkzvU3JrSKYh8ed4QrZd702oBgKiCUPo/8Lr0AbCkQHWaDk5Uh4Adq0vxbhl4JOy1
	gVKdvn7KRcq2TZAN9QK1ouBKsluUEiZRfkpHFUw7NCqyXj5mQH4hVk2qJa3MJ0f51MEMJY/+2tRA+
	bZzVlE3bVe7fIEkaGRCoivfnYHuP7hic6BlximhBAX9o+8EOg9rg0keoQsObljkpbxruUzZ9r5ijm
	D8RBtimQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDhyI-000000041FA-30LH;
	Fri, 17 Apr 2026 12:06:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDhyG-000000041En-2Dy1
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 12:06:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1EE543DA4;
	Fri, 17 Apr 2026 12:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E74EC19425;
	Fri, 17 Apr 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776427611;
	bh=gX5slQsvRLsEFrAM+WwAVauNcHLIRbuo2mgnsXramdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEFL5pS+fJg+7QEkYJ06Vt7vuF/zJVS4dPQHL96T74FZtEHS8RZoSdJmaqJ6Zn8U8
	 CnWb74b7vhNdd+0AoxJHIJMfsXAsdTIKoftNCUD3ls10XYEYpXFtbHbhj1t/Grj9+M
	 LqjIBvHhbt/Te4blDWcIyUcE7j3nzAVCN88jmOPXDu6tPWtT1y1ePfnsMlWbkcXH0p
	 7Q0K0ufSFEsoGLgPmhkdTn3WP7Hn1CkNt3rgjt19CcZXziP2t9ZkWI/T47PEIPfccU
	 NfrBHyGMoVSAmxzdhziW1r1Irq2/lxEmDi1K9Zm5fjkI3I4ltClz617KPLyAO4hUa4
	 JXhW6vAccvXIA==
Date: Fri, 17 Apr 2026 17:36:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
Message-ID: <vji2jty2pqerse6g66pavrt7e7oq3bax4m6sobp5wxew6xwv6d@r5lbv35klz6b>
References: <20260414-l1ss-fix-v1-3-adbb4555b5ab@oss.qualcomm.com>
 <20260416192000.GA21992@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416192000.GA21992@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_050652_618134_45E3B04D 
X-CRM114-Status: GOOD (  40.72  )
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

On Thu, Apr 16, 2026 at 02:20:00PM -0500, Bjorn Helgaas wrote:
> [+cc Rafael]
> 
> On Tue, Apr 14, 2026 at 09:29:41PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Qcom PCIe RCs can successfully exit from L1ss during OS runtime. However,
> > during system suspend, the Qcom PCIe RC driver may remove all resource
> > votes and turns off the PHY to maximize power savings.
> > 
> > Consequently, when the host is in system suspend with the link in L1ss and
> > the endpoint asserts CLKREQ#, the OS must first wake up and the RC driver
> > must restore the PHY and enable the refclk. This recovery process causes
> > the strict L1ss exit latency time to be exceeded. (If the RC driver were to
> > retain all votes during suspend, L1ss exit would succeed without issue, but
> > at the expense of higher power consumption).
> 
> I don't think the link can be in L1.x if the PHY is turned off, can
> it?  I assume if the PHY is off, the link would be in L2 (if aux power
> is available) or L3.
> 

As per the spec, if the link is in L1.2, the entire analog circuitry of the PHY
can be powered off and that's what I meant here. The LTSSM state would be
preserved by the MAC layer, whose context is always retained.

The only problem is that, CLKREQ# is routed to an Always-on-Domain (AON) inside
the SoC. So when the endpoint asserts CLKREQ#, AON wakes up the SoC and later
the PCIe controller driver turns ON the PHY. But by that time, the L1ss exit
latency would've elapsed, causing LDn.

> L2 and L3 both correspond to the downstream device being in D3cold
> (PCIe r7.0, sec 5.3.2), so I assume this is a reset as far as the
> device is concerned, and we need all the delays associated with reset
> and the D3cold -> D0 transition.
> 
> > This latency violation leads to an L1ss exit timeout, followed by a Link
> > Down (LDn) condition during resume. This LDn can crash the OS if the
> > endpoint hosts the RootFS, and for other types of devices, it may result in
> > a full device reset/recovery.
> 
> What does "L1SS exit timeout" mean in PCIe terms?  Is there some event
> (Message, interrupt, etc) that is triggered by the timeout?
> 

By 'L1ss exit timeout' I meant the failure to move to L0 state post L1.2 exit.
During L1.2 exit, the endpoint expects the refclk and common mode voltage to be
restored within the negotiated time. Per spec, r7.0, sec 5.5.3.3.1, Exit from
L1.2:

```
Next state is L1.0 after waiting for TPOWER_ON

* Common mode is permitted to be established passively during L1.0, and actively
during Recovery. In order to ensure common mode has been established, the
Downstream Port must maintain a timer, and the Downstream Port must continue to
send TS1 training sequences until a minimum of TCOMMONMODE has elapsed since the
Downstream Port has started transmitting TS1 training sequences and has detected
electrical idle exit on any Lane of the configured Link.
```

So if this condition is not satisfied, then the link would move to the LDn
state and that's the only event triggered to the OS.

> > So to ensure that the client drivers can properly handle this scenario, let
> > them know about this platform limitation by setting the
> > 'pci_host_bridge::broken_l1ss_resume' flag.
> 
> I don't see how this means L1SS is broken.  If the device is
> effectively reset, of course we can't go from L1.x to L0 because we
> didn't start from L1.x.
> 

From the OS perspective, the link would still be in L1ss and not expected to
move to L2/L3 during suspend/resume, since that transition is controlled by the
OS itself. But when the OS resumes, the link would go to LDn state and it can
only be brought back to L0, after a complete reset.

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 67a16af69ddc..01afffd384f2 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1363,6 +1363,17 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> >  
> > +	/*
> > +	 * During system suspend, the Qcom RC driver may turn off the PHY and
> > +	 * remove votes to save power. If the endpoint asserts CLKREQ# to
> > +	 * exit L1ss, the time required to wake the system and restore the
> > +	 * PHY/refclk exceeds the strict L1ss exit timing, resulting in Link
> > +	 * Down (LDn). Set this flag to indicate this limitation to client
> > +	 * drivers so that they will avoid relying on L1ss during system
> > +	 * suspend.
> > +	 */
> > +	pp->bridge->broken_l1ss_resume = true;
> > +
> >  	if (pcie->cfg->ops->host_post_init)
> >  		pcie->cfg->ops->host_post_init(pcie);
> >  }
> > 
> > -- 
> > 2.51.0
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

