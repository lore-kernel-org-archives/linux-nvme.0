Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9925EC77B7A
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJEwtZjYg3L3DAGfeU8JmuIC1tNT6kPBfhOTvOpsldc=; b=qXLWStorvfYlOXfj5TcQ+esb9b
	oZ6X3WnTK9MeVFIJizaetD18skiOjS1JT/QYFDavxb0IzarnlpsAp9lf1A4Xr05HVMQAzUdlo8eM6
	YOIu7uxp1A+d0O4nooGCOT3a5IX8aELIV8bqQmbBwRcgbBvMQY56neNAYhisR3FNemWLbR+MvGrBC
	5IZ4aiyOpgW/LHAgDDHKparl2QB68AAuJaLRLxrrFaA8ssgAsZXMOgtump89Gf0zp3U6Lkatmsrhy
	eU6YQ5gtUccwKyva/XlK30Aqlbdco/PF4fxE8BknHDhuy/IOZ17+4UG21mMZQ5GVdiusQW5lL/G2W
	tC/I2F5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4loz-004N0x-2T;
	Thu, 01 Jun 2023 17:10:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4loy-004Mzz-0Z
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 17:10:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 48E7A64369;
	Thu,  1 Jun 2023 17:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2815CC433D2;
	Thu,  1 Jun 2023 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685639442;
	bh=zJEwtZjYg3L3DAGfeU8JmuIC1tNT6kPBfhOTvOpsldc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNXLQHjGcMa3jNdiI8FPWyFKqh2nIdM7WqohOvS8H7eLc8c8pvy2Hfyu19o1zcsHf
	 SZgoNdqb6RWFLIXkirzAXjZhvmMl9cXYfYTturP6dSp1+iqxZwbarJQpAwiexU9tuO
	 E6UxY8OySwND2DH7X5KGBXjBDf///hAREQlFyAYnxgsQRw+6zPEme09HZiAcDPQRvP
	 iNm34KsvKNUreCjpfaoorT8FfoZ7ICB+xf/rVaWYT6GznKmr5zzga3vUBxj0O6y1Aq
	 Mb95yRtGQ1hFLVn99wd0Nj69lSoQ4RK+7/1yaJ8zQ0ejoEfJHyrT5pgMYXRsBtKGH7
	 BI/BnxmqiiLCA==
Date: Thu, 1 Jun 2023 11:10:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Gomez <da.gomez@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHjRDxHDkCZViJ6Q@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
 <20230531130325.GE27468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531130325.GE27468@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_101044_274349_357ED5CD 
X-CRM114-Status: UNSURE (   8.67  )
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

Thanks, applied to 6.5 with the '1U' suggestion folded in.

