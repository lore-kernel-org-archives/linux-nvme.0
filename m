Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9EC27C40
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 02:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Z/Rk23XOaIsbchFZPked/PQ2R+6guYd7Mbfpmk4g3A=; b=aZgDawPrimH4W/9BmuASU4CKZl
	smYQNlYRgfR4nlcgHEuhMml600jKKkqDB6h2ccpPB6Mw8fuYir93uZskRSs7ESeGyBnwE8kMow2GM
	TUSBxcaSkFrTaYDJYW10mw53JoqUP65Eik5925YGUuvT4z8vFyZaRlgoqEHsKQzh41eX2VTVJi8Nh
	R3NTJsyHEL0mzKSlcbkthWtZduWFLOnwC0M2LxiqWaw52HiqDciLNTsYXxFQrskSORFUWfqk5DLLq
	o81d2AA54aqLPfVlH2ZaSku4+i/OE4tFQLmmJGWfg5wJKF6KjzQIRidgHvLx0t/bsXl6uEAbzLOaF
	dyXfydRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYzg7-001vlG-1N;
	Thu, 24 Aug 2023 02:02:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYzg5-001vku-03
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 02:02:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE2B63698;
	Thu, 24 Aug 2023 02:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80A4C433C7;
	Thu, 24 Aug 2023 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692842547;
	bh=+Z/Rk23XOaIsbchFZPked/PQ2R+6guYd7Mbfpmk4g3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f6DEGgjRetnBO6vyBltoJoIIJJijcXA1iWN2FlrXw9NX9FfD+ZWHM77NrHcCG7/ng
	 oFKWDkdhvC/EzP7FzZMJqVm/ZnTSTKf7H1uMkChLgd4EXVenmvNA9CUNlYqxUzc+uo
	 4PPtuHl5eqUKbtU5VrrjsyCdSl+xVtWW1b9d7Mtfz+g3kzRdLIBsZOACHxeVPLIUqs
	 +WwhXtW7tY4ONROyGnlGBVFTL6L41IAcw1tuz53g5XWGdg8jzioArkfC/W08HnrXnd
	 YhmxsQYH14z6oHAsQjn3wxXmsSYEqesH1XnHjhO7z6xPZ1tywxpy76DY4BrEq99Qkx
	 IZp1fmWdA0NNw==
Date: Wed, 23 Aug 2023 19:02:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v13 00/24] nvme-tcp receive offloads
Message-ID: <20230823190225.5688f1ad@kernel.org>
In-Reply-To: <20230822150425.3390-1-aaptel@nvidia.com>
References: <20230822150425.3390-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_190229_121528_6420C394 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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

On Tue, 22 Aug 2023 15:04:01 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> This submission was rebased on top of net-next, and on top of
> the NVMe-TCP TLS implementation v10.
> https://lore.kernel.org/all/20230816120608.37135-1-hare@suse.de/

Please post as RFC if there are dependencies, we can't apply this,
anyway.

More importantly it took so long to revise this series we had made
significant progress with the netlink infra. I think you should move
out from ethtool into a dedicated family, in a similar fashion to:

https://github.com/kuba-moo/linux/tree/psp

