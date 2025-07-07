Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A12AC83F10
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaehXI4Yj+mX7Q/ewkFy7NXRCp+vOjHdcTDQWOXjBqg=; b=Fl+8/Q0JjEKnulj19AuHbsEJQ3
	8z4FVTkdA32cYLUK2rPcFkd8vytUJv6qUb9iHDB+u6fUKhm6NVQ9QvAeQ0cH3+QlNGP0b/YQIeJ0q
	PC0MqCktj6p/ZDyO39d7PDoo+h1N1zpWx4qVZSHdRZwUiGVknstDQNh1rePbIwFsw3UKuY0HzdnUV
	Dm6y6vf7VtvNEKVA0yaHqBTP8UTjvQ/59/AE2xUaeU1zOXQN0g8a3tjx0RNHUuE5KFToTKji6vSwg
	ujRBIJzGEGjAxCc0vGsngvHbEok8PV0UxVENDRQmX5JxNF9jGRKJEmVDtwVW+S/Z+u9LtB3yyFjxs
	J+RZy1Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYmzx-00000002jXF-1ihe;
	Mon, 07 Jul 2025 14:39:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYmlj-00000002glW-2BIA
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 14:24:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EC9BC43A74;
	Mon,  7 Jul 2025 14:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71860C4CEE3;
	Mon,  7 Jul 2025 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751898270;
	bh=Pe0Mos0PMM22VufbyPJTrr0R+UR662fysYzPLzi8JD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcOEGt7l2Mn3kkpMNxemia37CEyOQSsyo69Q/e4Y1jK2rJYfTyVqZhZlvZm3WLC7Y
	 G70jXepNmc3yY891EivmFRunF89p+VKzTq76zeggA+Y/Bb01Xp5DImfT/480ATs4Ok
	 8PdbyaseQhChfkk3D0dvCuskgz7+gCzBc12fDmMz4UDEQtBWHKd5z+UYye66OaJK4P
	 IAiVwm9EmLcqS+Se7HCUl7UlPciZCwzOUiRcdo9eep27CwGElkHleIljjNzFwRThe5
	 FJRPeEkR4YSLelgVJZgntfe2prfzJWY8XEk2DMnp8VZysyzBK5DCdKN+vTpQJz0tiQ
	 wH/86rjj8r7JQ==
Date: Mon, 7 Jul 2025 08:24:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGvYnMciN_IZC65Z@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141834.GA30198@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_072431_575903_6AAC2C3F 
X-CRM114-Status: GOOD (  15.47  )
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

On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> We could:
> 
>  I.	 revert the check and the subsequent fixup.  If you really want
>          to use the nvme atomics you already better pray a lot anyway
> 	 due to issue 1)
>  II.	 limit the check to multi-controller subsystems
>  III.	 don't allow atomics on controllers that only report AWUPF and
>  	 limit support to controllers that support that more sanely
> 	 defined NAWUPF
> 
> I guess for 6.16 we are limited to I. to bring us back to the previous
> state, but I have a really bad gut feeling about it given the really
> bad spec language and a lot of low quality NVMe implementations we're
> seeing these days.

I like option III. The controler scoped atomic size is broken for all
the reasons you mentioned, so I vote we not bother trying to make sense
of it.

