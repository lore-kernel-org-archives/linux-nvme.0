Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E1FC982D0
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=286m7qqU+1+My40bWAQal2p0ydHLws71vmZkeNKrn+E=; b=MUm8JrPxC6bMRaxAAwgOJGJeNo
	QqxTHmWgHQcWOo2xVQQH0ksVQX5EHRWIxBByyssik+POBWHNHwoR8gJKigaV2ms4cL36dX4t+zqCq
	ajrCme1gUoqxELuQo/V+lmjeZ01VwDqYfQlQjcJn1SqXpzFUbxwGjUpJZ7F3FVubA+l1645716uDj
	fcNQYI49tCcLfYUpIfG5Knli39wbTaEeBJPPW+vDznrRT69HVvv6pZBEjxlswpd3QGQVoycCBd2jj
	5pl2iBhv1PJsetXTGm4VZs5bk8JGqtoreZvSo9hEtRV05F0ZvLRvhy9uP8SpfnU2HVqIV8/aQXUV3
	VhgJy51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I8v-0000000CN6e-2Frg;
	Thu, 17 Sep 2026 19:51:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7I8t-0000000CN6D-3wUT
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 19:51:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 11DCD601EF;
	Thu, 17 Sep 2026 19:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0306D1F000FF;
	Thu, 17 Sep 2026 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789674694;
	bh=286m7qqU+1+My40bWAQal2p0ydHLws71vmZkeNKrn+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gB9PTePXbF3dauZ1CP3Ma7tHqUqd5YHVsVecXPlfNJ+NUCfHThYFSDLNzMr4GjILJ
	 3qHuCDIMjzIq1xBGE7WugEHUGgsTY6tq/n5mzrD9U8XDFkOfzyNvsxrrONnPUv/nrM
	 aBQh2VZzECZ0r394i/BXUwUcjcusRsxGgM6kP+25IowEDpZ82CjD3ODQS2g8QPuFBu
	 x190+xbzPh6rGFMk9MT4pz5LPAyE4NnYwXkw4vuLCComMUx0KvaS1+mNz11WyCnTuX
	 /PvalH5Vgv6+eLGaRf+ptzbFQK6VyTjvMOYz6i8kuZhTA5tK0LpJcwRSSAlODPHD36
	 ZYuQkFxd+1oGQ==
Date: Thu, 17 Sep 2026 13:51:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
Message-ID: <aqxExPzdo2VMII7Q@kbusch-mbp>
References: <20260916114533.237863-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916114533.237863-1-arnd@kernel.org>
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

On Wed, Sep 16, 2026 at 01:44:51PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing a string variable into dev_set_name() causes a warning
> when building with -Wformat-security enabled:
> 
> drivers/nvme/host/core.c: In function 'nvme_cdev_add':
> drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
>  3911 |         ret = dev_set_name(cdev_device, name);
> 
> Remove the temporary strings and let dev_set_name() do the
> same thing internally.

Thanks, applied to nvme-7.3.

