Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9BFC0340
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQmmBo9xLNOKO8C0J9UpZRkB0rwSWQj/DC4pB2tx2Ag=; b=sFlXjKx3pGvjrwk68/aWq1t2jz
	P22T3+kv2ZUL3g6T8jNzofajcDv09Lu2CrGSL+DJQbk/23hHMbvqptRFltT7DscsvPt+rU4OF+hXT
	CP1WrkKCwcQCfUvCOyzS+r9BsLcjH7oawdBcvwf9aHWVtks7u8617//Pxbc8BaoWHqNOnvucfpDzi
	ORFigwq4r+B0nimrpJOM4DNVTj6KMhchqdwGJIe4gHmwVyjBPUA/PMSrUqjTSlNbsVcG+V9h4Q8GZ
	3Xd2bCEWHbso+xJWRUsPC/SlCwcSU33L2/dBlPdfKbwduWPzS0SGKkfNJrTf/V3yHvHrQnb/cWH+F
	T9GEtexg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFvmT-0000000Brfe-0RVh;
	Thu, 23 Apr 2026 15:15:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFvmS-0000000BrfS-1VU1
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 15:15:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 69E436014C;
	Thu, 23 Apr 2026 15:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7700EC2BCAF;
	Thu, 23 Apr 2026 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776957351;
	bh=oTqmn846eDcPC24miKu77LDWVbxha/8Sm/ChagtCJQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozdPHSNwwS+Qj7yZnttq+jJAL8YEIfTguuS/p1JGVEk1aeJOKb2+AXsxTGKTvst7u
	 Rj2vnFjITKXV7jty01dmvewi9Umeic+hyQfHBhrAObX+n7nXSnssl4vzdSTvKkspYU
	 y9GyeEjEj4Qpj51X5awiIumPfMCm7u+WSk7Phyqv7PQaYXquWVtVyw2GJ4rYtN0RYX
	 SCtR08dlfMJgPB5m5dutcaJZ2s+qwB7tvAI0dxyEUzQtaMYPSGngzwJEVMgf80A5tn
	 4tS0GeZkR5dkI81b9I8QrOeyn9AYOxbNbpDn8wvJ2vtpKKD4Il6o2HLdjwAGKi3TX+
	 /QDJlG8jSIjHA==
Date: Thu, 23 Apr 2026 20:45:42 +0530
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
Message-ID: <sssgkayhnxjbgav3jfkroyk4usez7rjbktjlurubovhq5bvf2m@aupvtrjxiuu4>
References: <bkejoqdchyv55efsyl7o6b3ewiwaj5kbc2hgltxt5vwqdvt5yf@cxvwcjo5zcrp>
 <20260422234938.GA416865@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422234938.GA416865@bhelgaas>
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

On Wed, Apr 22, 2026 at 06:49:38PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 21, 2026 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 20, 2026 at 03:49:15PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Apr 18, 2026 at 11:09:11AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 17, 2026 at 05:26:15PM -0500, Bjorn Helgaas wrote:
> > > > ...
> > > 
> > > > > Does L1.2 have to meet the advertised L1 Exit Latency?  I assume
> > > > > maybe it does because I don't see an exception for L1.x or any
> > > > > exit latencies advertised in the L1 PM Substates Capability.
> > > > 
> > > > As per my understanding, 'L1 Exit Latency' only covers ASPM L1
> > > > state, not L1ss.  Because, 'L1 Exit Latency' field exists even
> > > > before L1 PM Substates got introduced in r3.1. So it doesn't cover
> > > > L1.2 exit latency.
> 
> FWIW, this FAQ from https://pcisig.com/faq?keys=3.0 confirms your
> understanding:
> 
>   Section 7.8.6 - Is the L1 Exit Latency in the Link Capabilities
>   register only the ASPM L1.0 exit latency or does it include the
>   added ASPM L1.2 to ASPM L1.0 latency?
> 
>     The ASPM L1 Exit Latency in the Link Capabilities register
>     indicates the L1/L1.0 to L0 latency, and does not include added
>     latency due to Clock Power Management, L1.1 or L1.2.
> 

Thanks for cross checking.

> > > > > Regardless, I'd be kind of surprised if *any* system could meet an
> > > > > L1.2 exit latency from a system suspend situation where PHY power
> > > > > is removed.  On ACPI systems, the OS doesn't know how to remove
> > > > > PHY power, so I don't think that situation can happen unless
> > > > > firmware is involved in the suspend.
> > > > 
> > > > Yes, you are right. Even for systems turning off the PHY completely,
> > > > they should have some mechanism to detect the CLKREQ# assert and
> > > > turn ON the PHY within the expected time.
> > > 
> > > What would the expected time be?
> > 
> > That's mostly L10_REFCLK_ON + T_COMMONMODE. But nevertheless, the
> > system wakeup and controller driver resume() time would be far
> > greater than it.
> 
> This patch sets "pp->bridge->broken_l1ss_resume = true".  I'm trying
> to understand how we know to set this.  There might be other platforms
> that need to do this but I don't know how to identify them.
>

As I said earlier, if the other platforms do not have any hardware mechanism to
detect CLKREQ# assert and enable refclk/establish common mode voltage, then they
would also suffer from the same issue. But it is not possible to identify them
only by looking at the host controller driver. Because, even if the controller
driver power off the PHY, some other hardware entity could be handling CLKREQ#
and taking care of refclk/common mode voltage.

So this flag should only be set when the host controller driver is solely
responsible for controlling refclk.
 
> This comment:
> 
>   + * Some host bridges power off the PHY to enter deep low-power modes
>   + * during system suspend. Exiting L1 PM Substates from this condition
>   + * violates strict timing requirements and results in Link Down (LDn).
>   + * On such platforms, the endpoint must be prepared for context loss.
> 
> suggests that the L1.2 exit takes too long and results in the link
> going down, which is essentially a reset for the downstream device,
> which would destroy the context.
> 
> Is there some spec language that determines how long the Downstream
> Port waits for the L1.2 exit before it gives up and decides the link
> is down?

Spec r7.0, sec 5.5.3.3.1 defines the timing requirements for refclk restoration
and common mode recovery. But it doesn't specify what happens when these timing
requirements are not satisfied by the downstream port and this could be the
implementation behavior. On the Qcom platforms, we are seeing endpoints giving
up and moving to LDn if they didn't receive refclk within L10_REFCLK_ON.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

