Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08BF5A8BC
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 20:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=i+mf7RY3M1Tv6XHosizey/MtU12qh71eD/DgJazNOHg=; b=OJ421RCo2lmdrv
	sBMamqH33TMTq2LPjpxwOlQ8VD/PpqWCML2iSY1pVc5S8I8477JKlFxXMrzkqGIehabTmBxWOFu67
	eCXpGZEjT0lBu3MPTx8P/g5vHx/HCMhBdVx4cvlJ1tFb+gutviNKSFZj7wHjjUHKw0P9ZG3SZyiMn
	gFTbUDFbutyQ2MCoLPiWSyN41hDPbVktaCRzvn8JEY83oGMwc9ME4qHLUYmyQulizIWX/T1NVK50y
	khiZ+EAWS8BADRKzx69UP0xm5P995DI0iuP9hJZiyCzC8FoNXlcFRO0FXQscjH69wBQtdNTRD2KmP
	rXteocjlYLoJifCn9zyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEvYV-00000007eEV-1Vbv;
	Mon, 20 Apr 2026 20:49:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEvYT-00000007eEB-3H87
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 20:49:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1750443C9;
	Mon, 20 Apr 2026 20:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725BC19425;
	Mon, 20 Apr 2026 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776718156;
	bh=BJ8ETRCkjFk05mCQgMXRwxFn1FURg0WZX+lXBX3zkxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I18zC+fRDQLO7ho+L8/FKaP1A/3fjIfQJThI2m6aLx1InirpH6RQbLXCf27UnN6X1
	 Aboe0CptmgfoOwaaSfQmIl7kZvRIujOMFbNOzEhPZPKjSx3IspxAEv7FRQSRqhV/gd
	 8btdr69IeFYf2RL9+WpO1n1TvpSnrnyxfWMbJHyg9DX+cO3Eesr4iWzTYZCz2ybFl5
	 sY9F3R9LJKiFMl9XzT/qB2ONHLuumXdEFWH53LfL7vE9S4z7tfUddnFhuT4hjorxgq
	 9hzXBnxgxjbVYTxqdCLTa37VIYoO3bSbA58MJQft9yjSvnxhlZyY9ECXJ9Ucy+IDfS
	 3wEzMF1WLH+Qw==
Date: Mon, 20 Apr 2026 15:49:15 -0500
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
Message-ID: <20260420204915.GA231862@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zv3tl2cvlhpmwe5ikcszdneft4bjebqibrl6onbg7457vtzmmc@clh7nzgpeext>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_134917_912513_A137A3CC 
X-CRM114-Status: GOOD (  28.46  )
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

On Sat, Apr 18, 2026 at 11:09:11AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 17, 2026 at 05:26:15PM -0500, Bjorn Helgaas wrote:
> ...

> > Does L1.2 have to meet the advertised L1 Exit Latency?  I assume
> > maybe it does because I don't see an exception for L1.x or any
> > exit latencies advertised in the L1 PM Substates Capability.
> 
> As per my understanding, 'L1 Exit Latency' only covers ASPM L1
> state, not L1ss.  Because, 'L1 Exit Latency' field exists even
> before L1 PM Substates got introduced in r3.1. So it doesn't cover
> L1.2 exit latency.
> 
> > Regardless, I'd be kind of surprised if *any* system could meet an
> > L1.2 exit latency from a system suspend situation where PHY power
> > is removed.  On ACPI systems, the OS doesn't know how to remove
> > PHY power, so I don't think that situation can happen unless
> > firmware is involved in the suspend.
> 
> Yes, you are right. Even for systems turning off the PHY completely,
> they should have some mechanism to detect the CLKREQ# assert and
> turn ON the PHY within the expected time.

What would the expected time be?

> On our Qcom platforms, we do have some co-processors handling this
> even before the OS wakesup.  But support for that co-processor is
> currently not available in upstream and we don't know when it is
> going to be added. Until then, we only have one option to not put
> the link to L1ss during suspend and keep the devices into D3Cold to
> achieve the SoC low power state.
> 
> > Maybe that's part of why pm_suspend_via_firmware() exists.  What
> > if native host drivers just called pm_set_suspend_via_firmware()?
> > After all, if they support suspend, they're doing things that are
> > done by firmware on other systems.
> 
> No, that would be inappropriate. pm_set_suspend_via_firmware() is
> supposed to be called only when the firmware is invoked at the end
> of suspend. If OS handles everything and not the firmware, there is
> no need to invoke this API.

This is part of my issue with the "pm_suspend_via_firmware()" name --
it doesn't really matter whether the code is in the OS or in the
firmware.  What matters is what the code *does* or is *allowed* to do.
The native host bridge drivers do things that are done by firmware on
ACPI systems, so the "via_firmware" part is not as clear as it once
was.

