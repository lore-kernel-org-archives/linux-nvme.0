Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAD1C3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 22:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X11KdZycco3RW/kmTzYI2J/sL8E0OjWYVL9EAifO5hs=; b=TGcZFE2/vmqnkJWgrBgueOhIMa
	Q7sPuwk9t/PfreJ7qTTgnJLDjdFKpZB3FF7frIAcB9vA6tK5kYD9lxwSnzuz35/fp3PRar7Efagbo
	uh6tIwWzXbDZVBNeRNPZZgqbaEkorIYEZwCmhCylhP6o80zQiU1J7DpXIXE0Nt4AunVPZNbP7/BQp
	NVKmOgMitc/yFdA2BDTlCQIvxckOB0216dTZsKBnGWec1hNalcTzJD1lCP9+BYzVWliEuc4TbDKWe
	96C5EYO40ByCHNQGc+snwdC/7AJWvn3EEfMWkhwFIcQkj6pKU9OBd3eoq3n9BajdvZHl9vZwXq2uC
	E8f0UhxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG3ao-00000004kkf-2rBo;
	Fri, 16 May 2025 22:31:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG3am-00000004kkG-07hn
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 22:31:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A8364484C;
	Fri, 16 May 2025 22:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D998C4CEE4;
	Fri, 16 May 2025 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747434707;
	bh=j1TzjQ6x1h5RRusIRAxCzoJzqDcMuofCLRpeIjOayrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+EbV0zePfMiLNAhwB0s7/x9bwNJR2vcrhn/I2aT7tJGVpWA6MVSE//HZBr0jeZjj
	 +A6ef6qY2CX0FVj4alj5UydwsenwRG5VTQ9TYeri39YfxkoOOvwKB3IHItpRTey4nG
	 huoxrqqAN5fApQCaTdcBLIUMJvOiYdplK1yiPhORKSa2fmU+2DK1TOZ21taEtOIfPT
	 HoElvP4nY0OPDIxcI4lI75L7eJI7mjUjmGbq8KZOYSaXt8inHEvE5c4JcYavj0u/J2
	 8QmoV3MUhv3CU3P9RlUMcT6ZDtUyI8NSRueNwFLhy9y2n10iIWinhJ/jQnSKWHJdh1
	 iV+6WyOUmGIZQ==
Date: Fri, 16 May 2025 15:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, Boris Pismenny
 <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <20250516153145.602fc02d@kernel.org>
In-Reply-To: <2537c2gzk6x.fsf@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<20250430085741.5108-2-aaptel@nvidia.com>
	<CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
	<2537c2gzk6x.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_153148_097048_CADA03C7 
X-CRM114-Status: UNSURE (   8.38  )
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

On Fri, 16 May 2025 17:47:34 +0300 Aurelien Aptel wrote:
> The offload works by calling the iter copy functions while skipping the
> memcpy (see patch 3).  We think the unreadable bit is getting close to
> what we want if it wasn't for the skb_datagram_iter() check. Maybe the
> bit could be unset at a later stage but it's not clear where.

Getting rid of the hack in iov_iter may be for the best, actually.
It's pretty ugly.

