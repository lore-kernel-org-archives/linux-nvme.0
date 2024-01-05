Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA09C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qey7+/Metc7y9NM7Oohh9zmN0tveATjj7VtIkKLd/jk=; b=G4EB+DCC7E79C5wHDuzjxyD2Da
	jD1tFqA7PppUh+3Ut4yTpdTbUPVABix3UMpYU696Is+VnTRgRxqgWNHcmPYxzQpg+gR9gyQkBkNhh
	g2JL39C0j3A1GnOzVNOIEeWI4e3LhzA7xaLIbgT7t7QIAPKhlWKOICzM00lsb9ueafcoXzmPfuF+K
	53nuGjApXfb6Tx8yh+1h86IWUQImHasZaKu7xeAqlDxJxq+VPuSleIZWvxOc7GzGZU6qrhyiE6vZr
	SMLO5Jr2NBmeuSu6e2UGYHwoq9vgTMXpAYyV17M86APG0nPlqoFAQhcfj0SAsX9VEq60XULwPCEXJ
	ViOrgZEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqkp-000BZf-09;
	Fri, 05 Jan 2024 20:25:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqkm-000BYt-1n
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 20:25:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 538C561BCE;
	Fri,  5 Jan 2024 20:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7112CC433C8;
	Fri,  5 Jan 2024 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486315;
	bh=bAZttlTQMZlhQC6CNZBZC3zQ6+w00XhSfvWG1FFDVUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUV3A2sx8AH0megKnsNxucQs1h21xGk3A/pWRHNqKOhLfNWoSIL/yUIqaMY01VE2p
	 vvv5DSmr64xBG+1mvJFzxMBCPMNMmEABKKeCpD5IBykBYa9hvo6s+08dvPJQZp1u4h
	 gI+wqSrdug2BY75/P3vkQKM29PLAX4ElpZup9+3hUk88/hjtfr2rwHqSil7LmVXSBe
	 TiM1E6xf7ebVNZKumSOF/WJYvXbjijsASAlBt8amZpIvW20qj/Epu+XPh7XhTq7Wod
	 iejiRK7EqwaR9aD+CLJZqm1trUGc+pM/GZv+R04cPx0aIggY1wlAp1UCR3eGIPKkFj
	 G6iFNZhJNBX1w==
Date: Fri, 5 Jan 2024 13:25:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: trace: avoid memcpy overflow warning
Message-ID: <ZZhlqHLfB3o1Pzuc@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <20240103155702.4045835-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103155702.4045835-2-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_122516_640051_7FCEBBA5 
X-CRM114-Status: GOOD (  13.47  )
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

On Wed, Jan 03, 2024 at 04:56:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch introduced a struct_group() in nvme_common_command to help
> stringop fortification figure out the length of the fields, but one function
> is not currently using them:
> 
> In file included from drivers/nvme/target/core.c:7:
> In file included from include/linux/string.h:254:
> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
>                         ^
> 
> Change this one to use the correct field name to avoid the warning.
> 
> Fixes: 5c629dc9609dc ("nvme: use struct group for generic command dwords")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied to nvme-6.8 with Christoph's line-wrap suggestion.

