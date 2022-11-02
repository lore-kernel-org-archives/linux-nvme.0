Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005A0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qiAEgC29CJ5rMCE0kGqMWjm89+dEV7ZMU8j6RRKF9qE=; b=EguboxMA8HArWzy7mtyvz8EjiI
	8Z+zj0iENqEca+xdiKNMmPNfwwyx0ZHlA5eZT97MVyzSa7ZgHYYGyxGWrpnlySpQpBATCY/pSeZHR
	S6DEwVYH0eWEibpT2B/yJ2ma1YtJL+RyipJCPsSnfX5qcu28lKt7gVcv5PpGytP11EZfRXAC9h7Qo
	wdSCwXxeIjE+Eb3h/rNAZQlUBFMslwBTt6tiMJxrgNI+l/8dB6dy6iKw6/+dyXV35j5SgIkC0maOz
	G8Fa3/i/klL4YN0jIinOFNxPwUyFmBUBsrlyghr82BmWzjmUJKkS20tmYXREIAASKOJgvHDI9rR98
	0IP1biCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqG9e-00BwnQ-JK; Wed, 02 Nov 2022 15:59:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqG9b-00BwlW-M7
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 15:59:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C8D5D611A3;
	Wed,  2 Nov 2022 15:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B51C433C1;
	Wed,  2 Nov 2022 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667404786;
	bh=WDPoWFLX4iJC87RUDqcrEmrG3vpc9K/sjbr0H/KZ15s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdR5gDUJOKxsOBNyradTox/FcZcBdYrymC/RZAKgW845TQedYumsO9EK9TwE4fnWF
	 rQJQnUFgDamwyJiGbf21wGKdEdSAv024mHg5+4oSoXqUvUn80tXtMZ8lVYYobsPRdM
	 icvN4nuy/AJ97nVdxYSwjD1qbhAC4HomLOCqFYviD35owLSWeJWLPbBwym+S6ydxR5
	 L4vOeYbv2QNvRH7X/9E4cCChYjL1Jn4vHtsg5VllvvMOkQyw4xZPNprSqnrCJkHL+4
	 g2kNOciGgXQkPBg68FHt/YANrXpaA/cAHrTflcgBeFpZ8QTKoQ9zDKXPOEGjbpRDWK
	 U91SBgrxwg3jA==
Date: Wed, 2 Nov 2022 09:59:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Binarus <lists@binarus.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme-format: protection information enabled although metadata
 size is 0
Message-ID: <Y2KT7ypZZdK4nlHq@kbusch-mbp.dhcp.thefacebook.com>
References: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
 <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
 <0865c0c4-1632-3a86-939b-feb2d2ce7f32@binarus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0865c0c4-1632-3a86-939b-feb2d2ce7f32@binarus.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_085947_799994_CAB21CEC 
X-CRM114-Status: GOOD (  25.91  )
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

On Wed, Nov 02, 2022 at 04:42:21PM +0100, Binarus wrote:
> On 02.11.2022 16:34, Keith Busch wrote:
> > On Mon, Oct 31, 2022 at 10:27:34AM +0100, Binarus wrote:
> > > On a machine with Debian Bullseye and nvme-cli 1.12, I have formatted an
> > > Intel DC P3700 the following way:
> > > 
> > >    nvme format /dev/nvme0 -l 3 -i 1 -f
> > 
> > You correctly surmised that the device is behaving out-of-compliance
> > with the specification. The device should have returned an "Invalid
> > Format" error since, as you found, this is the error to return when
> > "enabling protection information when there are not sufficient metadata
> > resources".
> > 
> > You're unlikely to find a fix for this EOL device, though. It's just a
> > firmware bug that you should avoid.
> 
> Thank you very much for confirming that this is a bug. May I steal your time again and ask what you would do in that situation? Throw away the device because we can't trust it, or format it with 8 bytes of metadata and hope that the PI works correctly then?

I think that's going too far. To the best of my knowledge, the device
works fine. You just hit an untested parameter combo. The device may
report you requested PI, but without metadata, it's going to behave the
same as a non-PI 4k format. If you supply valid paramters for pi
formats, then the device will correctly honor that.

I'm not sure if you're familiar with the different nvme metadata types
though, so I'll add that this particular model's does not work with the
Linux kernel's end-to-end protection. This device supports only the
"extended" metadata, not the "separate" that the Linux block stack
requires. You won't be able to use the generic block layer for IO with
protection information, but you should be able to use it in passthrough
modes. And if you are using the 8-byte format (LBAF 4, I believe), then
the driver will have the device strip/generate PI without the host ever
seeing it.

