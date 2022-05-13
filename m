Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C3AC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9d9jSv8aXSc5IXWAhJugycMg+hbBQWZtppCgCde5Yo=; b=gERyaJhB6pys/+JnO/0g03r/Yt
	BigTFM+uf7k2+VKa3gbBy+gJSEQbSq8XZESAbkIjRfK3r1Q9ZyjcKPorPZgLoVWdcd7/4Lo0pQkJi
	XUoOpa+/ZuCikAGSeIx/khyKCx5qBFk0Fl22Eqpru6Igwkr2mhyUiOpIVdkAH33Ky/flcwKaGg6Tj
	10qX+Y4TXDtL98lT7F2tub4BwSApWtmekNXi9xz8VRhF5olV6NMt5oNc2e0MKJ5z97CD+GTyWJieD
	n5EI/0OAWIa8jkWtsvhEIyV3+Auy4CblaVM50f+evsXOcJPyBV2H7F9H6LGxE1s8bGSAPyEALrRdD
	j4UUKr0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npKbL-00E8xx-H8; Fri, 13 May 2022 02:00:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npKbJ-00E8xQ-8K
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 02:00:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA1CF620BA;
 Fri, 13 May 2022 02:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BEDC385B8;
 Fri, 13 May 2022 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652407215;
 bh=On5YitkVUshII7124UCUvMfb8ONsaO3VZAiiiXu9yZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZarSMHQ3CfmHbvpwzCxOjhNOjkOJPptdH7Pb029333lazxnQ3wPokIM3DDCXny9zs
 oyNqo2BSeRmaPjyA+RbyXQ9qvhUi7pIZCtGXVGKt1SOS7yb/kz7WK6RY5doJGFUbmf
 TyFe/nLCEBWt1U2HOOEGzUssrHF+0efnkO5BWKjYZUAWokDZArzevRk5zbzIa5ukJQ
 hAvjDVTuxw87Jdn88s2x3GntfACPlSo+UzracMHB/6y9ig+m4nIw0mv0hb/QGasIEU
 8CgTQekqYVep9AE9M2DOLRYc/pkXs+5kyKqBUZKVtHGb/Yq/03URajoRfx9PzFYG6d
 HkW2NGW4Du6bg==
Date: Thu, 12 May 2022 20:00:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Roese <sr@denx.de>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Message-ID: <Yn27q2sh6FiOFEDb@kbusch-mbp.dhcp.thefacebook.com>
References: <20220506101534.1728011-1-sr@denx.de>
 <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
 <Yn0anJBHcSd1K2tM@kbusch-mbp.dhcp.thefacebook.com>
 <60ba95d4-ca30-546f-b179-52cd5be7e82f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ba95d4-ca30-546f-b179-52cd5be7e82f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_190017_374923_820602E3 
X-CRM114-Status: GOOD (  20.74  )
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

On Fri, May 13, 2022 at 04:07:18AM +0300, Max Gurtovoy wrote:
> On 5/12/2022 5:33 PM, Keith Busch wrote:
> > It might happen if the device requires a Subsystem Reset to activate the new
> > firmware.
> 
> but isn't the reset something that the admin should do ?
> 
> some power-cycle or cold-reboot or other reset.
> 
> In the reported case the device resets itself. I'm not sure it's expected.

I'm not familiar with this device or the procedure used to update the firmware,
but I'm aware many vendors still provide their firmware bundled within their
own tooling, so simply running that utility could do all sorts of things
including a device link reset.

If the device is resetting itself without a user or driver app initiating it,
though, that would be bad behavior outside the spec. But if this harmless patch
improves interop regardless of device behavior, then it should be okay to
include.

> BTW, for sure the fix is good for the hot unplug case but FW reset shouldn't
> cause this scenario IMO.

Yeah, the patch is fine as far as I'm concerned, though it is impossible to
prevent all register reads executing concurrently with any random link-down
event. The commit log indicates reading registers during such an event causes a
kernel crash, so a more complete fix probably needs to come from the platform
level.

