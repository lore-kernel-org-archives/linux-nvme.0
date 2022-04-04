Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6D8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YEyQI4TqBbQpq/rvSylrlYacC0Q527NLgouBZ97n9E=; b=GyzUaOtQKbbRpcW3K5RQQL+8Qt
	PgAUrz7HP6grt08jotk314D4TDFDQW/G7BTd1iGRMJCkza6mWOKOeRbL9SDvG/U7TdyOdWEGJoua2
	XFuQ5Ysr0ql3gZHxvHZVhiunAfaks8VQxB2YSeYJdZZT0d3nOeKx/PW+l0xel9VqlivxFbteLWBEm
	+kYpzDYEkmEj4FNeR7ZBYq29vwI2YFD+/cHrYwqnP6y2L6huz8X3vpmM+iMi9OhQA4f4/1WfPEGoV
	tmBzT61yDbtW5IS7VAZzSOEK3PiBdHyWjdGasospMTn8PuKuF+f9cVSonl11w4WWSWB4JFbWOvNQ0
	EHY8aUSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbTLA-00GMji-Sc; Mon, 04 Apr 2022 20:30:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbTL7-00GMiB-5J
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 20:30:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6521160E7F;
 Mon,  4 Apr 2022 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9198EC2BBE4;
 Mon,  4 Apr 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649104215;
 bh=6FKVb30OG/E/J0J6IhpJSZnH/s/9A54rDm03hL8Jwjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XZa0XbXlqr0h+hmdy0Lw/XKbrGGO8Gfz/elUrW6OVzrTiYwHb8RMeC9pMy8rLdH+c
 GGFyE2gbEhKwUoFm5luz+cAEs+OhPI9/PfNytD47M89nTSDXufyObPum9kdmJIQgtS
 z4xKoS4S3svaIIC6G071zX+hyind9lSldwyg2TefIxifUiNB3kis3iTWMLVEJNACpI
 eAj/8b8jvNGvrXPs5TX9mbDNdokB8Y+Wn7OH5P4wW2MPtvZAznjjWL5/Y9vDj+g2Hs
 Au9EUrFZfzCjLnnM3W0VrVXqcfNKqWI4seJCDdGNdlaMdOGjE86P2qfJvRFtzn3my3
 ecPUIflStEW2A==
Date: Mon, 4 Apr 2022 14:30:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <YktVVG+WSXzYWjGR@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <4A24C337-5EF9-4C3A-A112-BA75934AC78B@oracle.com>
 <Ykskv/gp2s6PWiHp@kbusch-mbp.dhcp.thefacebook.com>
 <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a97859a-9b9c-da39-3dca-76811f67b4a6@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_133017_277748_5AC208FE 
X-CRM114-Status: GOOD (  20.52  )
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

On Mon, Apr 04, 2022 at 01:34:38PM -0600, Jonathan Derrick wrote:
> 
> 
> On 4/4/2022 11:02 AM, Keith Busch wrote:
> > On Mon, Apr 04, 2022 at 04:39:06PM +0000, Alan Adamson wrote:
> > > 
> > > [   97.083215] nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
> > > 
> > > An error from the device (status=2/Invalid Field) when an Identify (0x6) command was issued. Prior to the patch,
> > > the nvme driver didn’t display the error.
> > And it's harmless. The driver is querying an optional identification and it's
> > okay if the device doesn't support it, but the driver doesn't know if the
> > device supports until it tries it.
> I've had to field bug reports like this before, where it says error in dmesg
> but is actually harmless.

Even before the kernel message was added, some implementations trigger error
log events, which alerts smartd. :(
 
> Maybe we could suppress the error and add a harmless print?
> Eg, nvme0: blah blah command set not supported

The new print in the completion handler is pretty generic. I don't think it can
readily tell the difference from a harmless error. Maybe pr_err is too high?

Or maybe since enough people have been concerned about *this* specific
identify, maybe it should be restricted to 2.0 devices where it's mandatory. I
was reluctant to do that at first since the initial device I tested was 1.4,
but it was a prototype and we should be fine without the non-mdts limits
anyway.

