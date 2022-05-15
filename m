Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53E4C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 15 May 2022 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HC7/2sqGC6cIMVnKeclc4BbPMqO5VHG/vb+bpAG/pUE=; b=hL5dJkY4R7cq9hKdHgNoDnVXu5
	aWPCd0KYruMXpq0Xr0om8+f/0YIt2jUcdtXJEXQiXAcZYytSxtlI8lya3kCLFccis9U50m0XpWzXw
	zPjTCXfRELeC8aVEAasH2c2RnlzjipW5Jfbx9aR9rIYrcHX4sCwmyCG+FFVVvd8OhOIqAtlx7kmL/
	6J9+XSoPJ3H65AMOwL/BDK4U+4jgyYv+K3W0R9h6t/vYrukheTtLU3JGOjdusBkUvxmzOeQ0XMUaC
	wiRjqaurAr/mGHANF8Idxqcb0o+24yMfV4q6ZXA+uCgxmQa2Lk/GRJ64YYJMhYU7X9GrEfVSg4wE1
	t4RXaiNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqKAV-004pg7-Gh; Sun, 15 May 2022 19:44:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqKAR-004pfD-Ou
 for linux-nvme@lists.infradead.org; Sun, 15 May 2022 19:44:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB4E36113E;
 Sun, 15 May 2022 19:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01167C385B8;
 Sun, 15 May 2022 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652643876;
 bh=zDXCb/nw5fBTnejIBBj5bo6ZvLBQt916vTb3hwiwvKU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sFFlfB5dNLvvdBzm/lxSicx+Bd5u0oYNRUC4I1kyIBI2mrS+vM3/vuwqUZEPA5i9O
 qEaJtnZzF/hL14Wmhi0riAeADMAJGrbNRGG/Kfw0PERBWuDb3he6KYSCkPvb8cLZ8N
 dlOFoR4xMUUlmlfLAsyXs8zGIUHpYJHB4imcJ6nl8293oamI3hfUPwl2lLdrJmxDrN
 CP8S4/9Xn7OG5mVEvE5XY+/MEXcx1EP4mSG62tHWgpoKyVZC3ge55YRuet0a6KTqF6
 bxeRBKeSZg3CN4ZOekYHCoo+ejjiegTE+lHNSFR3t6Qgt26dqNC7dYpNzfHpAITZeX
 dCAg/IKGRuqOg==
Date: Sun, 15 May 2022 13:44:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marcos Scriven <marcos@scriven.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: My Western Digital SN850 appears to suffer from deep power state
 issues - considering submitting quirk patch.
Message-ID: <YoFYIJ3/yEK1RGTK@kbusch-mbp>
References: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea81a6a-b510-40d2-9b32-036f263f75f3@www.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220515_124439_930752_3E240418 
X-CRM114-Status: GOOD (  36.94  )
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

On Sun, May 15, 2022 at 05:00:44PM +0100, Marcos Scriven wrote:
> Hi all
> 
> I've been experiencing issues with my system freezing, and traced it down to the nvme controller resetting:
> 
> [268690.209099] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> [268690.289109] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [268690.289234] nvme nvme0: Removing after probe failure status: -19
> [268690.313116] nvme0n1: detected capacity change from 1953525168 to 0
> [268690.313116] blk_update_request: I/O error, dev nvme0n1, sector 119170336 op 0x1:(WRITE) flags 0x800 phys_seg 14 prio class 0
> [268690.313117] blk_update_request: I/O error, dev nvme0n1, sector 293367304 op 0x1:(WRITE) flags 0x8800 phys_seg 5 prio class 0
> [268690.313118] blk_update_request: I/O error, dev nvme0n1, sector 1886015680 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> 
> Only a reboot resolves this.
> 
> The vendor/product id:
> 
> 01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Black SN850 [15b7:5011] (rev 01)
> 
> This is installed in a desktop machine (the details of which I can give if relevant). I only mention this as the power profile is much less frugal than a laptop.

Some of the behavior you're describing has been isolated to specific
drive+platform combinations in the past, but let's hear your results from the
follow up experiements before considering if we need to introduce a dmi
type quirk.
 
> Anyway, with all that background, I'm happy to try NVME_QUIRK_NO_DEEPEST_PS for 15b7:5011 locally, and submit here if it works.

I think that's worth trying. Alternatively, you could just mess with the
module's param 'nvme_core.default_ps_max_latency_us' value and see if only the
deepest states or if any low power state is problematic.
 
> However, the main problem is how to reproduce this issue reliably/deterministically, in order to be confident in the patch. It can happen with in minutes or days at the moment.
>
> So, my questions:
> 
> 1) How can I reproduce the issue deterministically?

Unfortunately I really don't know. I have no hands-on experience with these
kinds of systems.

> 2) Are there any other causes of this I'd need to rule out? E.g BIOS, PSU, broken drive rather than a power state quirk.

PCIe ASPM has occasionally be a problem, so you could try disabling that too
(pcie_aspm=off).
 
> I also have a couple of more fundamental questions, the answer to which is probably way beyond my understanding:
> 
> 3) Why are so many drives needing this qurik in Linux? Could it be that Windows also avoids these power states?

Many client vendors don't prioritize Linux for their IOP testing, so we tend to
be the last to find out about issues.

> 4) I looked at the code around the message, and it seems to be this is about an attempt to reset the controller, rather than just accept it's timed out an operation. Is that correct? And if so, could there be a problem with the way resetting is working - or is it again a quirk with these NVMEs?

We used to have a health check thread periodically query the link status and
preemptively initiate a reset if it detects a problem outside any IO context.
That query defeated desired low power settings so we removed it. Now we only
check the link status if an IO times out, which is why the resetting message
appears in that context.

I don't think there's any particular issue with the way the driver reacts to
the condition. When you see an all f's reponse, that really indicates the link
is inaccessible. There's nothing we can do at the nvme driver level to
communicate with the device downstream that link, so no operations will ever
succeed. Once we're in this state, the nvme reset operation is almost certainly
doomed to fail since we can't communicate with the end device.

There might be additional things we could do at the PCIe level, like a slot
reset on the downstream port, but I haven't seen evidence that type of
escalation improves anything so far. It might be worth a shot, though.

> 5) On that note, some Googling yielded this patch, that I think was rejected
> https://patchwork.kernel.org/project/linux-block/patch/20180516040313.13596-12-ming.lei@redhat.com/.
> I'm unclear on the details, but felt it might be relevant.

That just changes the context where actual reset happens, but still uses the
same trigger to initiate the reset. I don't think that would help in your
situation since the link was down before an IO timed out.

