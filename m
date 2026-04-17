Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3557EF99C6B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=+lwGJ+GXOWE5MgS094XRlbgHkR1fylmtk6R7EJm5diY=; b=0Gu7Lb6RWJ2+zR
	ttXkIIHDkXjw9tEQbLZ5U+gy5zodlj0LuDvThj6MXuvrwyhtg0jgU5TFh5BX4BcFT4OxIB/DlX8F0
	G2oO2Ys++l9rRqHPmrLG58KpVOuWRgQE62sJE96SMpwO+BzrO5HJPNsU0zt/21atRccqkCcv5CkCQ
	EntIUXSURry3ICk+oeDj9TXwAStSzKMIzfZ6BnhdvbKvAr/RxqIoQ/3FGPo0PjpXNfYN1kxw3WwHR
	qMueyypRZIjZgfVo3EVkqxfKw6VcpqlpsubQ0UOYGuuaxkdSI8mYcJFiDCFKNPyJFPJ4Or9wAqZAf
	8mtZwcN9umTgycaNkXHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrdn-00000004WU6-1RUj;
	Fri, 17 Apr 2026 22:26:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrdi-00000004WTn-0kZa
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 22:26:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DB3560052;
	Fri, 17 Apr 2026 22:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67A0C19425;
	Fri, 17 Apr 2026 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776464777;
	bh=ldDrCZLNDA6+Ze7JqHXF2mgFMD1/O2u3aOg33Abpsds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k56JV38kBfvzqBIsN8JWl0Oujn12TZ287FU/V6ljKbTCA3FwTXkCcL5lEOyQu9Csg
	 5XRwUUwXmSBrZsAU7UqtNJbFHgfcr4QePzpqz5ifIEgc3MW0Q6PhGH3Kh5bHTGTZHV
	 FSzjtKEkUXiNFDZ+4ROvgL6eUv3l/d/dxwFNaIeZDUZZegGDxOh6k9yhkj++tdO+hh
	 2oWSEgXOrBGlBoatS6GYN1fxHBxyCReEpvSnRBNmjG9thinHga388zSjN4n3sgXq0h
	 tVBT4yHApURwjzkixaE9kJ/k4TTbHZDtR9v9uOFCKke4JGdVgWNq7HyERrbClt4wRb
	 5YdzUqPFtBFfg==
Date: Fri, 17 Apr 2026 17:26:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
Message-ID: <20260417222615.GA97425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vji2jty2pqerse6g66pavrt7e7oq3bax4m6sobp5wxew6xwv6d@r5lbv35klz6b>
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

On Fri, Apr 17, 2026 at 05:36:42PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 16, 2026 at 02:20:00PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 14, 2026 at 09:29:41PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Qcom PCIe RCs can successfully exit from L1ss during OS runtime.
> > > However, during system suspend, the Qcom PCIe RC driver may
> > > remove all resource votes and turns off the PHY to maximize
> > > power savings.
> > > 
> > > Consequently, when the host is in system suspend with the link
> > > in L1ss and the endpoint asserts CLKREQ#, the OS must first wake
> > > up and the RC driver must restore the PHY and enable the refclk.
> > > This recovery process causes the strict L1ss exit latency time
> > > to be exceeded. (If the RC driver were to retain all votes
> > > during suspend, L1ss exit would succeed without issue, but at
> > > the expense of higher power consumption).
> > 
> > I don't think the link can be in L1.x if the PHY is turned off,
> > can it?  I assume if the PHY is off, the link would be in L2 (if
> > aux power is available) or L3.
> 
> As per the spec, if the link is in L1.2, the entire analog circuitry
> of the PHY can be powered off and that's what I meant here. The
> LTSSM state would be preserved by the MAC layer, whose context is
> always retained.
> 
> The only problem is that, CLKREQ# is routed to an Always-on-Domain
> (AON) inside the SoC. So when the endpoint asserts CLKREQ#, AON
> wakes up the SoC and later the PCIe controller driver turns ON the
> PHY. But by that time, the L1ss exit latency would've elapsed,
> causing LDn.
> 
> > L2 and L3 both correspond to the downstream device being in D3cold
> > (PCIe r7.0, sec 5.3.2), so I assume this is a reset as far as the
> > device is concerned, and we need all the delays associated with
> > reset and the D3cold -> D0 transition.
> > 
> > > This latency violation leads to an L1ss exit timeout, followed
> > > by a Link Down (LDn) condition during resume. This LDn can crash
> > > the OS if the endpoint hosts the RootFS, and for other types of
> > > devices, it may result in a full device reset/recovery.
> > 
> > What does "L1SS exit timeout" mean in PCIe terms?  Is there some
> > event (Message, interrupt, etc) that is triggered by the timeout?
> 
> By 'L1ss exit timeout' I meant the failure to move to L0 state post
> L1.2 exit.  During L1.2 exit, the endpoint expects the refclk and
> common mode voltage to be restored within the negotiated time. Per
> spec, r7.0, sec 5.5.3.3.1, Exit from L1.2:
> 
> ```
> Next state is L1.0 after waiting for TPOWER_ON
> 
> * Common mode is permitted to be established passively during L1.0,
> and actively during Recovery. In order to ensure common mode has
> been established, the Downstream Port must maintain a timer, and the
> Downstream Port must continue to send TS1 training sequences until a
> minimum of TCOMMONMODE has elapsed since the Downstream Port has
> started transmitting TS1 training sequences and has detected
> electrical idle exit on any Lane of the configured Link.
> ```
> 
> So if this condition is not satisfied, then the link would move to
> the LDn state and that's the only event triggered to the OS.
> 
> > > So to ensure that the client drivers can properly handle this
> > > scenario, let them know about this platform limitation by
> > > setting the 'pci_host_bridge::broken_l1ss_resume' flag.
> > 
> > I don't see how this means L1SS is broken.  If the device is
> > effectively reset, of course we can't go from L1.x to L0 because
> > we didn't start from L1.x.
> 
> From the OS perspective, the link would still be in L1ss and not
> expected to move to L2/L3 during suspend/resume, since that
> transition is controlled by the OS itself. But when the OS resumes,
> the link would go to LDn state and it can only be brought back to
> L0, after a complete reset.

Thanks for the background.  It would help a lot if I had more of a
hardware background!

Does L1.2 have to meet the advertised L1 Exit Latency?  I assume maybe
it does because I don't see an exception for L1.x or any exit
latencies advertised in the L1 PM Substates Capability.

Regardless, I'd be kind of surprised if *any* system could meet an
L1.2 exit latency from a system suspend situation where PHY power is
removed.  On ACPI systems, the OS doesn't know how to remove PHY
power, so I don't think that situation can happen unless firmware
is involved in the suspend.

Maybe that's part of why pm_suspend_via_firmware() exists.  What if
native host drivers just called pm_set_suspend_via_firmware()?  After
all, if they support suspend, they're doing things that are done by
firmware on other systems.

