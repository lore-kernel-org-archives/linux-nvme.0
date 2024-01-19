Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EACC4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iu6wa/rK4pWrBKLxOWNu0O90Wa8WyeV3+r+u3h8jh4k=; b=N5f8LO+Bs29S/flqLkP8pZ8wEq
	SDBeXrMGsIDMMqgGFLjllkDGtZsi5jTIru9ZiAwxv8FFjGU14MtVRAlHDYh/QfsMGg21biL739BEq
	BNedU9DUhwCJwPKGxKSFuq9buDj1Bc3L/PO3MCZE6Uk5+LDhdGjlMbyVbPuGfheLSo67EEDEA89TQ
	4R4qKcVoZdIddV/nWcimW3vmMlcV7qxKY6K1hhF8zQ+VahlrjJagQpI4IcylAVxYJtr93OQI0TAHu
	oCtfk3YitCwCgBWWxDBSkT0ASLf+nQueHbH8NQSETxeV/33zbMiY7GKpEuHuZJwY4PWPrECuOOt7i
	a1Ukosdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwVJ-006fcL-1R;
	Fri, 19 Jan 2024 21:34:21 +0000
Received: from out-175.mta1.migadu.com ([2001:41d0:203:375::af])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQwVG-006fay-0O
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 21:34:20 +0000
Date: Fri, 19 Jan 2024 16:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705700048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu6wa/rK4pWrBKLxOWNu0O90Wa8WyeV3+r+u3h8jh4k=;
	b=IinR596wBybdI8NlUso85eN36G5vxLDEN+nkOaSfk4qtH3lYVBNeHWFqDfJ060ngmZLmC2
	1LS3qYu9ZxicNGWxq7KD4toKh81g09CHcN22PHP0eVr91BbL0mJX0qhIfPBUA0/OvlU7Gh
	IE9FY0LhRnaAdoYHCHbWdBalam2ATsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mia Kanashi <chad@redpilled.dev>, linux-bcachefs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME
 with BCACHEFS
Message-ID: <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
 <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_133418_318883_A7E13D24 
X-CRM114-Status: GOOD (  33.62  )
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

On Fri, Jan 19, 2024 at 02:22:04PM -0700, Jens Axboe wrote:
> On 1/19/24 5:25 AM, Mia Kanashi wrote:
> > This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
> > 
> > Transferring large amounts of files to the bcachefs from the btrfs
> > causes I/O timeouts and freezes the whole system. This doesn't seem to
> > be related to the btrfs, but rather to the heavy I/O on the drive, as
> > it happens without btrfs being mounted. Transferring the files to the
> > HDD, and then from it to the bcachefs on the NVME sometimes doesn't
> > make the problem occur. The problem only happens on the bcachefs, not
> > on btrfs or ext4. It doesn't happen on the HDD, I can't test with
> > other NVME drives sadly. The behaviour when it is frozen is like this:
> > all drive accesses can't process, when not cached in ram, so every app
> > that is loaded in the ram, continues to function, but at the moment it
> > tries to access the drive it freezes, until the drive is reset and
> > those abort status messages appear in the dmesg, after that system is
> > unfrozen for a moment, if you keep copying the files then the problem
> > reoccurs once again.
> > 
> > This drive is known to have problems with the power management in the
> > past:
> > https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
> > But those problems where since fixed with kernel workarounds /
> > firmware updates. This issue is may be related, perhaps bcachefs does
> > something different from the other filesystems, and workarounds don't
> > apply, which causes the bug to occur only on it. It may be a problem
> > in the nvme subsystem, or just some edge case in the bcachefs too, who
> > knows. I tried to disable ASPM and setting latency to 0 like was
> > suggested, it didn't fix the problem, so I don't know. If this is
> > indeed related to that specific drive it would be hard to reproduce.
> 
> From a quick look, looks like a broken drive/firmware. It is suspicious
> that all failed IO is 256 blocks. You could try and limit the transfer
> size and see if that helps:
> 
> # echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb
> 
> Or maybe the transfer size is just a red herring, who knows. The error
> code seems wonky:

Does nvme have a blacklist/quirks mechanism, if that ends up resolving
it?

