Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F7CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IpYVQSO5UdCqCoqYOxpi6ORmYFQVrCpaiDijXOrYYnc=; b=BKJjrKjYarhhNxZhiWAC8kZNcj
	xQOJEc9wSTF2OaRmBWSa16rIyk5LatnKgcCMV5Kum6WJpOJxvLDl3aC5+An6bO/TgTEGj6nOW/I/r
	bV69Y+ArEbp2ykMZnKBc9HbTXTvj9TjvKCN9X4UVVS/1RtNfVNfW3Ipmhizt5wreNu5kG/NTZJpbX
	jNUSSy4Vcu+peKS+ZBtdI+tpVY5ycFKJR2/X+inXCHNBUYDtOwiww2hwtGYBnZ2wWRFjfNzBYpoh9
	9ACnZAlC6LakB+Z7sI4/x4tx2nQRmiulPAPYKZ0cRyT/0I3MbMGnq+SsFEU5cIb9J5KjznTjWHj4a
	MVxNPZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJiX-00E4Bw-LF; Wed, 02 Nov 2022 19:48:05 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJiU-00E4AH-Qm
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 19:48:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 11FA0B82414;
	Wed,  2 Nov 2022 19:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F31CC433C1;
	Wed,  2 Nov 2022 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667418479;
	bh=/rDe3PR99y2t7nmWV3U14DOyLAk5MtHgzvA+OzyVqz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OquA22aqeZh663CEsNg81o/hefMC9y0PBbwLz963//KOOXNnI4bhfZT9zSB+XLpJf
	 zcGy0TvvReAhC+Q1jYESWUYuUsAig17c8++o87XWzScmKePG/a8PEUA61jpKpGirrR
	 U7jAEBxj1QRKJB0MEw9QBhCxVj/ufbf+tJs/UTODVVN2C5J+h403OxhGU9krThux1M
	 VzTiSTm8rX4XOCNmMlizARmBJ/I2EG1wUMwuITczQERkZyMzKIWSD7B1UyqjBr3kRQ
	 tkFWgBezbARTMaf4ERM49hDbSOaEe8Jf+El024kKa7GaoAI4ioK7cbbmGjfDHNVveF
	 udVUh5UnrqfEA==
Date: Wed, 2 Nov 2022 13:47:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Binarus <lists@binarus.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme-format: protection information enabled although metadata
 size is 0
Message-ID: <Y2LJbAd5hGkvF4Bz@kbusch-mbp.dhcp.thefacebook.com>
References: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
 <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
 <0865c0c4-1632-3a86-939b-feb2d2ce7f32@binarus.de>
 <Y2KT7ypZZdK4nlHq@kbusch-mbp.dhcp.thefacebook.com>
 <d75c7e0b-e8a5-5f01-05ae-3cd86b2d95bf@binarus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75c7e0b-e8a5-5f01-05ae-3cd86b2d95bf@binarus.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_124803_183200_23A6987C 
X-CRM114-Status: GOOD (  31.49  )
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

On Wed, Nov 02, 2022 at 08:32:19PM +0100, Binarus wrote:
> On 02.11.2022 16:59, Keith Busch wrote:
> > though, so I'll add that this particular model's does not work with the
> > Linux kernel's end-to-end protection. This device supports only the
> > "extended" metadata, not the "separate" that the Linux block stack
> > requires. You won't be able to use the generic block layer for IO with
> > protection information, but you should be able to use it in passthrough
> > modes. And if you are using the 8-byte format (LBAF 4, I believe), then
> > the driver will have the device strip/generate PI without the host ever
> > seeing it.
> 
> I have a vague notion of the metadata types, and have recognized something
> which worries me even more:
> 
> In the datasheet / manual for the P3700 from October 2015 (newest version I
> could find), in table 34 on page 38 which describes the Identify Namespace
> data structure, it clearly says that byte 27 will report value 0x3, which
> means that both metadata types (extended and separate) are supported. From
> the "Interpretation" column of the "MC" row:
> 
> "Indicated support for metadata transferred with the extended data LBA and
> in separate buffer - both are supported."
> 
> However, when I execute nvme id-ns /dev/nvme0n1 on the machine in question,
> it shows the value 0x1 for the MC, which means that it supports only the
> extended LBA metadata.
> 
> That means the either the datasheet / manual or nvme is wrong. I guess that
> the former is the case, and your statement supports that.

Your data sheet is wrong. This family of controllers never supported
anything but interleaved metadata.
 
> I had absolutely no clue that the standard Linux IO does not support
> extended LBA metadata, and thus does not support extended LBA PI. That's
> quite disappointing.

How could it be supported? The format requires data+metadata be
virtually contiguous, but that's impossible from the user app that only
provides the data.

The only option would be for the kernel to bounce it through a new
buffer, and that's more horrible than it sounds, not to mention a
complete disaster for memory reclaim. This was my last attempt at it:

  http://lists.infradead.org/pipermail/linux-nvme/2018-February/015844.html

> Currently, I don't know what the passthrough mode you
> have mentioned is, but I'll research it.

From user space, you'd have to use ioctl NVME_IOCTL_IO_CMD instead of
normal read/write.

> Perhaps I am using it already, because the SSD in question acts as a cache
> device in a ZFS pool. Since ZFS circumvents the normal I/O layer at some
> places, maybe it can use extended LBA PI.

Kernel space can also issue passthrough commands if they really really
want to via REQ_DRV_IN/OUT requests, but I seriously doubt that's
happening. That'd be quite fragile for an out-of-tree filesystem to
attempt.

