Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187FC25B0E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Aug 2022 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMrBRbqajbGOGSs9g4v31y8q/r6yg2Cye5dypuSITWk=; b=Y7+P/djDhxwIsqBYKlbWsKZbds
	k3M7RlnGGld9xYh4KZDKb/KveZA0n6hW1Mp8cCWklqFnrm6RW5VMNZ7bPHW0HV5iyNn6yXzlFlQMB
	OP95+miQceWeGJdbEkUSxAyzexsWOtP06qtAY7A58USM0Bkcp/AGCUsqtsad2ohYnUpwwtrShooZ0
	CAvcHtKvJ99FAajLYnd0eoAc2M4g8esDieFSd/u1odYQ67b2gaAV4YJ0YJefBuwmhH+V0ZzB/7wUP
	yuVZ7UkikDDoZTsD/0wV4Hr4m5cFL+Af2jWBJbbO5EaY17G5syyefoFGrSH6jLOCHTOYyh1PM22+P
	VpDiHHKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMVvU-0096IF-4f; Fri, 12 Aug 2022 14:46:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMVvR-0096GB-Dp
	for linux-nvme@lists.infradead.org; Fri, 12 Aug 2022 14:46:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C387160F35;
	Fri, 12 Aug 2022 14:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3C8C433C1;
	Fri, 12 Aug 2022 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660315571;
	bh=FxO/yW3Nx2HCJZJI9Sleiv/E+ewt+zmSSMLBLRLSXrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aY4pUhGf9MDhT9vOxAcAqLnnniw2c6dCUZc0k62Kpg371nNgYxAUURZO/xPZk3E8X
	 BeM3XaCJw4nfFUxRL1Lya1oN78/WqNbdui5jucJZg8GlEGbTu4nnxXoOSTdGEkJLvr
	 kZiUvqIrAYswjNgfq1GEw3sa76vXUbvFz3EFl/WZHmDdbPNUljAGvOCjVTxrJmqEyU
	 flq7c/cZ5TyxB4yA2rXO5KkjBMuNcHWpgh9IGIZ0qKys1+7PONzARqzp9hDkn2wwjk
	 m/00leRWbAiB/BZHEX5qK1FGQP2L6q3kn3WzYeCbPDyWAgcADI/WRnh3hC5QD1IZtC
	 NHRJKkq0bE0Xw==
Date: Fri, 12 Aug 2022 08:46:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: do not update kato from a dsm io command
Message-ID: <YvZnsGYHVdqFw4Pq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220811192608.3387239-1-kbusch@fb.com>
 <YvVgIzRXRv6EKk98@kbusch-mbp.dhcp.thefacebook.com>
 <20220812053329.GA24588@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812053329.GA24588@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_074613_522451_F6F7F5FA 
X-CRM114-Status: GOOD (  12.60  )
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

On Fri, Aug 12, 2022 at 07:33:30AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 11, 2022 at 02:01:39PM -0600, Keith Busch wrote:
> > Actually please disregard this. We don't reach the effects_end on io commands
> > as it is already.
> 
> I thought we do, what prevents them from ending up there?

It's pretty subtle: the driver always returns '0' for IO commands, and the
passthrough end handling isn't called in that case. We're not expecting IO
commands to have effects that need special handling.

