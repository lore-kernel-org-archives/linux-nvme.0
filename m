Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B92C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFGWb1We5U0CckrfixpOdyJGd1qe6B/djFaqHk+eUK0=; b=amPnyjzLYojGK9eMJznSfz6FnO
	CJVu09OI/luIJjlLWqnfRpyCTDXVKW/Kgp+X2SXQ7llERIrOA3zovFrEFIUGneFK8pbu1qOGRSPVZ
	WpDwxPcOkTE42vKuAbqbpVFWjRLHJwB1r2kz5TlMWZmPpbPMmKb+8vjfATViI0GxxCKIGQxnEInFx
	4SDImq6ncgfTugY0bmTaHil/+8YjPJJWY5DOpbbkg4Xp2yXySRLjoPxk1tLBXcpYfBJYjy7yse+jh
	rLoGidLS0wHPnJGeG7FbnIUShab1Ukk/BxlD3Wb5cHiH07INLNH3k9N5zUWRixYhr1qihipDJTBxZ
	vjLAkJhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqdT7-008wIt-53; Mon, 16 May 2022 16:21:13 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqdT4-008wIH-Mi
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 16:21:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 69EACCE16E4;
 Mon, 16 May 2022 16:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2535DC385AA;
 Mon, 16 May 2022 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652718066;
 bh=lvXF8B5cEFUP14fnSDwDUKarvgqBYRZjzjXhSBwkuQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FVk9TyGoySpfn0rv8yBCMn0zFvFpa7dWiSvgK7cYI5kZypMH3c+shdZoz7BwkaI7X
 lc8LQ3exuP6PGNHEAdsYUe91tkaRuPmxfTYzi6SOX+2+yN46HrKC4YhHqeuKpb+KkK
 GZGfL0dEZ5Vig0TLYdVcg0M2xWSltg33/YnZkubIGFwMMx21XZ5gyrPP0JSTc7V0bt
 cKxth8/E0z5FbB2H012Oq2wv7Qe+XneJyVdfXA1qN6Kk2MMkPe8MqyIdzqiQZVHag4
 j4I8rvVrNHFamFTq8ugxaQp8ERlA7fQ/nM6/AkQNgGFY3N+qYPLzliMuY3nbqg1off
 ExVv2+sau19Og==
Date: Mon, 16 May 2022 10:21:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <martin.wilck@suse.com>,
 Belanger Martin <Martin.Belanger@dell.com>,
 James Smart <jsmart2021@gmail.com>, Hanumanthu H <hanumanthuh@micron.com>
Subject: Re: nvme-cli license clarification
Message-ID: <YoJ574Sr5oOLSM8T@kbusch-mbp.dhcp.thefacebook.com>
References: <20220516161608.of4tklsysuvgbtie@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516161608.of4tklsysuvgbtie@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_092110_959857_1D57B9A5 
X-CRM114-Status: GOOD (  12.37  )
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

On Mon, May 16, 2022 at 06:16:08PM +0200, Daniel Wagner wrote:
> 2. nvme.h
> 
>    The situation here is a bit simpler as Keith is 'owning' most
>    of the lines (monolithic and master branch are almost identically)
> 
>    Copyright (c) 2011-2014, Intel Corporation
> 
>     104 Keith Busch
>      26 Hannes Reinecke
>       6 Steven Seungcheol Lee
>       3 Sagi Grimberg
>       3 Christoph Hellwig
>       2 Scott Bauer
>       2 Minwoo Im
>       2 Martin Wilck
>       2 Daniel Wagner
>       1 Warner Losh
>       1 Tomasz Zawadzki
>       1 Ming Lin
>       1 Max Gurtovoy
>       1 Martin Belanger
>       1 Jeffrey Lien
>       1 James Smart
>       1 Brandon Paupore
> 
>   I suppose someone from Intel needs to signed of the 'or any later
>   version' thing. Keith do you happen to have a contact for this?

I am not sure of who would be interested at Intel in this anymore. This was
initially just a copy of the Linux kernel's header, though, and diverged
significantly from there, but I guess we'd need to inherit the original's
GPLv2 only license?

