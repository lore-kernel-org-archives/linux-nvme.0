Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D4C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E23yl+qQFnpOivuPaQprafpmWeK0mhzdqcO5OEI2CfE=; b=jYwqSEnUskJDishQr4AfyD4yku
	EJaGpbxSb+sX2nyXi2VhhZ5I6LPN5ma9/lbuYGBUZrzhKVisPfBLx3spPtWSFHwMDvSZgbctAoga7
	bg6nQ4V6B8y47/kZq2P3uv6W5GlgRKxSB/PSnQSxpQI+wepcWJP1a++VrAfu2u42mOxkllDw+3lZ7
	3KBaD0x8BeykdKsiX1X9ik67Bmoz4UvUxIquGYDwrymbuRu4Bl/rWbqJl98X/uu2lynjCr1O51e64
	2KnltnZwvqGubN+lgr3xZT25MnHb7lVlJZNWUrnRTWrw6o426ytFNHiMmCMtgK9keUtKtMvroDvn/
	3wiCqwBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0NqR-001qXL-1x;
	Tue, 07 Nov 2023 15:18:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0NqO-001qWX-2T
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 15:18:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0CC6F61230;
	Tue,  7 Nov 2023 15:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC31C433C7;
	Tue,  7 Nov 2023 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699370299;
	bh=SVeQJeuz3QQq6STDyr8bhtFexA212lGhkT189HxwcLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSS1tUGkfnmzV1jEgzVgPkIHONCucdCBnSSEyPiHpXSsuib3EWLYbAFRPGh1M9bN0
	 3FkoPCQFlHRo521nGue9lQbqTs1IZiFSwTIqAyzA51m7XyTK+6XOv4uleu7647Slb9
	 zV/t5F1vcuaH/bvD44oecqJqCKzqihevjd+8W6VUbXG5mcHJESHprMu1A+EV9wIfT1
	 72MJhYqfkI9EgG1tWi4GaTbOPGauXDY9GTHR6Bp4H6cFpIvjM4ZPD/zS+pth1YifoO
	 kwACMsvc4i3nvscOmpMdDjoF9tuUVp3ofz1NT12HKcmoW6uIkx/re40zvBUbGJ/fAp
	 1SWwnMnt+W1rA==
Date: Tue, 7 Nov 2023 08:18:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Message-ID: <ZUpVOYvgmFzXEK0y@kbusch-mbp.dhcp.thefacebook.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
 <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
 <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd07dbc043e38a7a4dcaee0b6d2835ec@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_071820_849529_6A01A14D 
X-CRM114-Status: GOOD (  11.84  )
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

On Tue, Nov 07, 2023 at 08:31:37AM -0600, Wen Xiong wrote:
> 
> > To check exactly which id is problematic something like in [1] can be
> > used, totally untested ...
> > 
> Steps:
> # nvme detach-ns /dev/nvme0 --namespace-id=1 --controllers=0x81
> # nvme delete-ns /dev/nvme0 --namespace-id=1
> # nvme create-ns /dev/nvme0 --nsze=562805846 --ncap=562805846 --flbas=0
> -dps=0 -nmic=1
> # nvme attach-ns /dev/nvme0 -n 1  --controller=0x81
> 
> Below is linux log with your patch:
> 
> [  149.570987] nvme nvme0: rescanning namespaces.

Are you running these commands in quick succession? There should be a
"rescanning namespaces" message right after the 'detach-ns' command, and
before subsequent 'attach-ns' command. It looks here that the rescan
didn't run until after the 'attach-ns' occured. Instead of tearing down
the original, the driver just sees the namespace it previously knew
about has changed unexpectedly; the processing for the namespace removal
didn't happen prior to the attach-ns command.

> [  149.578714] nguid mismatch
> [  149.578719] nvme nvme0: identifiers changed for nsid 1
> [  149.582291] block nvme0n1: no usable path - requeuing I/O
> [  149.722140] block nvme0n1: no available path - failing I/O
> [  149.722157] block nvme0n1: no available path - failing I/O

If you drop all open references to /dev/nvme0n1, then the handle should
get deleted, and a manual rescan after that should get your new
namespace visible.

