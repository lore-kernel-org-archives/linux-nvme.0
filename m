Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B937AEEAA4E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Sep 2023 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mg1wc/0uNO0AfRPx3sddbOoF6ZcapYwIJbIi/hl+pRw=; b=sH8Bkshh6ZLJPohFplJ8T1z0UG
	RcfW53UoS83cy/xr9i1wWqDcg0kX3envz0vE/LOx87rHf68qfBJ920o8eLm3Zj13hisUvwRHfaA11
	R25+RKTBDaRKCA+6F76utAbcjN+5vlS0oGSVQgS7KorO5HZT4kyhPmRVy8eXzsOxC+B9P59/l2nPk
	rFt65wm9Wn7aGzXPeA3NJ3FZ6mhu/cDvluMFi/za29BEWn/qZAN9t1Pz/1cjB7bAPb9HkpXONC72D
	Cjymg6Gz6jQZzX5Hz8KduiYi48VIdxhmWPsLYDvcP/3IImn8fqwWTEErZluh1bBxiOvBuPK+w9Dba
	O1uxz5UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgo9a-008m8O-0r;
	Thu, 14 Sep 2023 15:21:14 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgo9U-008m7k-0v
	for linux-nvme@lists.infradead.org;
	Thu, 14 Sep 2023 15:21:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7D717B82899;
	Thu, 14 Sep 2023 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6972C433C7;
	Thu, 14 Sep 2023 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694704865;
	bh=QGHJ2MNASWncSpG/BYyl2uUv2mHWKg/N0FO6GxQIbhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV6B23whsnV+DoLjsUOgS5+7KaxKB643M5/We8Sha1Dshz1aABavs6gQdzm7pfC7U
	 SAwK/Y6ZBnaNTHiSA+CT2TEUgGChj/tVoTkUOvCud8ORvz7eksrBmUVv7GGi/cVAUD
	 5m6No5RLICrBZ4egNPdSMMOFf9uxYSAq9EBoYm7YkrCIdfgSNxMtUVGbWKfNoYIUaw
	 ov///X6EcBX5uT8EuzVdGyGRNIAFhj3MR/dgibx4c38Or73BuaC5IQ1u9nkSIBa7c1
	 j/H2kOkghuFMkQ2PdDRN1QABJ/IMy7QBXwCuREuz1LRXTxnz2QRuFeOhwZ5UPjSeeS
	 M1laz2o1+H4YQ==
Date: Thu, 14 Sep 2023 08:21:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	=?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Message-ID: <ZQMk38DogqopZLeo@kbusch-mbp>
References: <20230913202810.2631288-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913202810.2631288-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_082108_477489_3D5E144E 
X-CRM114-Status: GOOD (  15.04  )
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

On Wed, Sep 13, 2023 at 01:28:10PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some devices are reporting Controller Ready Modes Supported, but return
> 0 for CRTO. These devices require a much higher time to ready than that,
> so they are failing to initialize after the driver started preferring
> that value over CAP.TO.
> 
> The spec requires CAP.TO match the appropritate CRTO value, or be set to
> 0xff if CRTO is larger than that. This means that CAP.TO can be used to
> validate if CRTO is reliable, and provides an appropriate fallback for
> setting the timeout value if not. Use whichever is larger.

I need to send a pull request out today since we're quite a bit behind
as it is. I've applied this for nvme-6.6 now since it fixes a regression
that apparently quite a few people are encountering. If there are any
objections, please let me know by EOD and I'll remove it from the queue.

