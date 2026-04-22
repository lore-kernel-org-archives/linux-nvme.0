Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E33BFAD3E1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 23:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=eg7tq/GDt7HVvWP6sp7BJW32O6FfoKvqzokLWLMDic0=; b=0exhATGGgToASN
	FNVhfaixv7ayp9kZ07nhUw+NceYWhjHuMnzer0S2YbMSFOB9z72Fm1ZZBDa7GJJHcWXMmW+XuB3LQ
	SjJGrJftG/kEvzI1staJtzxK8CxhWCoQhkBFtpv1G6zUUbi5GJygxiaZnsXYfjWHTUTySrIRNRn7P
	GzKSUB+QbTq8LyZK/6z8/YD+j4Yyq7w2o/IAXAT59h2x31BhkXg/tWRk9IWCj2RHsNN9eDceH5VCP
	dD6Fqx1bNmyyB5JOYvGt4fMESrMUCIlpO/67DiP9ejOg+XAazVRgoMYsJc26vVdbFu1rTsXsM2PwJ
	cnTWg6zWrD2w6M2FBm7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFhKD-0000000Ar63-3JeJ;
	Wed, 22 Apr 2026 23:49:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFhKA-0000000Ar5H-2PHq
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 23:49:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 70ED04198A;
	Wed, 22 Apr 2026 23:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23934C19425;
	Wed, 22 Apr 2026 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776901780;
	bh=MKSrCh2S3mr55uyV/Z12S+XkTvz5MBWMuSM4wQ/Job8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WpbcaguohQuyurO8P9qtHx431iyqolN/sDurNKWaVcGWhWbZj/2Lc6Pv4nPkXoNon
	 AAE4IFmzh7tEK57XXFytVmCX4oVXszIKIsHRfbJ1Ei4SqPhvIdQ+lSzJgZ+wQstkDb
	 Qn5JiTXlcsFMNCN23gl6SFSmA+GRSGt3L88n4Uh0+tP5SkQszctAMq57O0E0XKOp+J
	 cxuFjkKosm8JZwkQqJUXjWTrfuk+8VEqOEUUZmrNEyJcdDnKc/oNTl4T3ufrpn1+mz
	 o4f3ipYA3UdzUWGTadg3O6uumqQYyjH8gMW6HsmnXR99yaBV4uXT1HzKPFYKFeUm55
	 3s2CzP2xqxfBw==
Date: Wed, 22 Apr 2026 18:49:38 -0500
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
Message-ID: <20260422234938.GA416865@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkejoqdchyv55efsyl7o6b3ewiwaj5kbc2hgltxt5vwqdvt5yf@cxvwcjo5zcrp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_164942_675250_8D0BFB62 
X-CRM114-Status: GOOD (  29.87  )
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

On Tue, Apr 21, 2026 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 20, 2026 at 03:49:15PM -0500, Bjorn Helgaas wrote:
> > On Sat, Apr 18, 2026 at 11:09:11AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Apr 17, 2026 at 05:26:15PM -0500, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > Does L1.2 have to meet the advertised L1 Exit Latency?  I assume
> > > > maybe it does because I don't see an exception for L1.x or any
> > > > exit latencies advertised in the L1 PM Substates Capability.
> > > 
> > > As per my understanding, 'L1 Exit Latency' only covers ASPM L1
> > > state, not L1ss.  Because, 'L1 Exit Latency' field exists even
> > > before L1 PM Substates got introduced in r3.1. So it doesn't cover
> > > L1.2 exit latency.

FWIW, this FAQ from https://pcisig.com/faq?keys=3.0 confirms your
understanding:

  Section 7.8.6 - Is the L1 Exit Latency in the Link Capabilities
  register only the ASPM L1.0 exit latency or does it include the
  added ASPM L1.2 to ASPM L1.0 latency?

    The ASPM L1 Exit Latency in the Link Capabilities register
    indicates the L1/L1.0 to L0 latency, and does not include added
    latency due to Clock Power Management, L1.1 or L1.2.

> > > > Regardless, I'd be kind of surprised if *any* system could meet an
> > > > L1.2 exit latency from a system suspend situation where PHY power
> > > > is removed.  On ACPI systems, the OS doesn't know how to remove
> > > > PHY power, so I don't think that situation can happen unless
> > > > firmware is involved in the suspend.
> > > 
> > > Yes, you are right. Even for systems turning off the PHY completely,
> > > they should have some mechanism to detect the CLKREQ# assert and
> > > turn ON the PHY within the expected time.
> > 
> > What would the expected time be?
> 
> That's mostly L10_REFCLK_ON + T_COMMONMODE. But nevertheless, the
> system wakeup and controller driver resume() time would be far
> greater than it.

This patch sets "pp->bridge->broken_l1ss_resume = true".  I'm trying
to understand how we know to set this.  There might be other platforms
that need to do this but I don't know how to identify them.

This comment:

  + * Some host bridges power off the PHY to enter deep low-power modes
  + * during system suspend. Exiting L1 PM Substates from this condition
  + * violates strict timing requirements and results in Link Down (LDn).
  + * On such platforms, the endpoint must be prepared for context loss.

suggests that the L1.2 exit takes too long and results in the link
going down, which is essentially a reset for the downstream device,
which would destroy the context.

Is there some spec language that determines how long the Downstream
Port waits for the L1.2 exit before it gives up and decides the link
is down?

