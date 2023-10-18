Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E60ECDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BglcM4atM+2rf5B/mp1sHG8DqPMTxuGyhRalY9Zn6Us=; b=00J5f+tBePG+6/ZeF6lNKdFJgg
	T7GpKf1gr7B1nFeOF72iZuKShlPKRl9jf8oI/xOAaY32HO4w1JFTs2bcY1+ARUnElXpT7djbBkEy8
	JWzEcAnipY5B9TDwUN9AM25x74LDX7vNUGppIbokr5B+QERPFOZqhdEfnk/RH3/NigbsJZNFYzGfj
	e5viZBNARLGyfGmYL1pNmVse21xFin6oAH/iXOvIUWQfS9COZghv6tC83IYFdmflixws1lzPtOSxW
	mBbpo1+l1uUDLJPVWZvAh9dvu1Bsjhu6UqIU0TJL2HajNTR7ZIackUcGWLq89padKOK+L9RHB87dN
	E6XGMs8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtE3g-00FjF5-2i;
	Wed, 18 Oct 2023 21:26:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtE3d-00FjEf-2i
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 21:26:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6662B61596;
	Wed, 18 Oct 2023 21:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E310C433C8;
	Wed, 18 Oct 2023 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697664384;
	bh=BglcM4atM+2rf5B/mp1sHG8DqPMTxuGyhRalY9Zn6Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4w2CGYYg9TGEuwZbCTuExyWqr1UZrosAv2oZcC+oL3cS3Wxsf6lKkyfXS1R/8+9w
	 veQYYuO9q97Kaa/7arcQ+uU2sUPXwVwcT/jZp56PMauBCzhA5dznT0OQr2WKB0fQlc
	 VVwqnaU/l9zn5yKDrxCM+FN0FCh9vERfox1hFSvp90s3zM84gAwkykTGhmR2UUOoq7
	 PnFaQ+m3/nZVURYdP3feVau5Znjc7hm2LYbyrmbO4TIuzI4r3vvtFJCGZljDyH/Frr
	 cSN2AQHvlPWSYizCnYMNXmcQe5ZRG1zaXr+m8K64iMzimysodmqHcZqJn+1YGjPV60
	 1v/0S7ygKTgAg==
Date: Wed, 18 Oct 2023 15:26:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTBNfDzxD3D8loMm@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_142626_036564_16667910 
X-CRM114-Status: UNSURE (   5.55  )
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

On further consideration and some offline chats, I believe this large
change is a bit too late for 6.6. I think this should wait for 6.7 (and
stable), hopefully preserving non-root access in some sane capacity.
It's backed out now, and current nvme-6.6 PR does not include this
patch.

