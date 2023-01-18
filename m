Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E95C004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 04:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ds+9FmGDgQcCbq75JbRt2YdfxENnCmQ15fS5LueX4I=; b=n3paqGjohPRmFZlX6UjMvtEilg
	LvlNpx9h1ri1y6epnGQMYZ2xdzWUnPxthBMNlcJ6pI2yYWUZaMlEyGAPgaLUXHHiUMvl8ibkZWiJI
	6u9xd5BGq44zLRyPXqDvoyQ9u20l4MlH8UiKupfHsIWB8VoADP2oxPw1rs72wIJKVMwKcD5uQ6b0F
	LfhtcgHfG+As99846brmoSg/f+5dS/WoTGgQ7gVphOE7SGhZ72bs2FQlW2AGv2x/dD6Y/QIiuH81b
	1UvFB1U5izOt1pSoZLrjvtd7pE03W7g+fA4+eyl5mKaR6sfD1x0o2W/c2exkQpvd96VjvJPYew4Ki
	idIfrapQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHztE-00Gr9t-GB; Wed, 18 Jan 2023 04:17:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHztB-00Gr9C-H1
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 04:17:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9076160E;
	Wed, 18 Jan 2023 04:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC96C433EF;
	Wed, 18 Jan 2023 04:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674015448;
	bh=mT2FPPtzp7PINgPtB7zdvXfPGfCFTcpMzIEVwBGXBq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrY2mfxs0YdjoAI82ox0vEsIMbXdNsF15A7M1xkOFwvZMOo+O6kl0xlaMPWnVzAZI
	 gvYhcuHvlC2nos1AtuDkGr7pLHi6eHdoSckkJKDTr3l0sOKcyy8fE3FaGGAI+DSxDn
	 d+u7oB8SessmF6J0K8FIcnsxRq0tp1dtdKs6+b0EKOToNb7Iim+RGvs5LO4KAn5yLo
	 sWL/oYnhokJHVHkx22nDuPuvrTCONZ0kPLKpApxUS465d6kofxxfek4Z7X8AJDocWa
	 BPTPYolb70V2nluDktP5WEFMJhbAgTaaTdNYJb1E+CQYLQJwiSTDpghpXD0im88GbB
	 tbnXwXOjjd14A==
Date: Tue, 17 Jan 2023 21:17:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8dy1Qv3Z/9LDjUs@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8AG21o/9/3eUMIg@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_201729_641121_E9E56E3B 
X-CRM114-Status: GOOD (  11.74  )
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

On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
> Hi all (linux-nvme, qemu-devel, maintainers),
> 
> On QEMU riscv64, which does not use MSI/MSI-X and thus relies on
> pin-based interrupts, I'm seeing occasional completion timeouts, i.e.
> 
>   nvme nvme0: I/O 333 QID 1 timeout, completion polled

I finally got a riscv setup recreating this, and I am not sure how
you're getting a "completion polled" here. I find that the polling from
here progresses the request state to IDLE, so the timeout handler moves
on to aborting because it's expecting COMPLETED. The driver should not
be doing that, so I'll fix that up while also investigating why the
interrupt isn't retriggering as expected.

