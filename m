Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AAEC44507
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SY+YyJkbi1gEkE//gLhZ4wGARXCzfj2FI0PbhlEsEJs=; b=3xgxjrQt7oaKLvabbOHRT3FLQg
	/FulAeqeHUMo4ImV+GIgBj0gDNDyIq7syYo4slcaE3/HUeUpkSlWiBGusHxdKcvX+zR6/R0xVjsik
	uAQWX60rwQ/UZf3SEOBgR+OKA8YSnclNDz0frj2xpx88WxpmoDu0ScFVvSNlf5L5Wjk0GkN8XHJrH
	mg+ldKdMWDZKVnga7syMg4qP+f73/AxIDnWXMGemE9z3xkZ0z10EewDXbjIvUD2ug9HZyrlGhl8Yh
	NCZ6f4h7XUu/0KGLOv7kqCxXxej66TPgbHmmL1fL2EaIUZjMzB2BVHW6tPd1tMa6OhK+NQ9ZS3n4j
	6d8i5HNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk8QK-0000000G38j-3tqn;
	Wed, 15 Jul 2026 22:49:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk8QI-0000000G38b-3nNL
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 22:49:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0961940486;
	Wed, 15 Jul 2026 22:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952DE1F000E9;
	Wed, 15 Jul 2026 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784155788;
	bh=SY+YyJkbi1gEkE//gLhZ4wGARXCzfj2FI0PbhlEsEJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BuVEeTEtLaeSeLb35b/P4K6lwhUWXQ8GqdHwbbMRKRAbLOg4+MsvbP5Gzytpd/mU7
	 XVQp8hnoo5E5uE3rNJnstfjDje1OHY3fEWSU893kgN79h0mnFG4fxsQJ9F7+kPUFLG
	 qQL9toveNQP5BwLb2Ub9htUTUbVsTq0Umypp96QZqktjYsQgH4biq905Mz/zCM5hhQ
	 K3Ui+qZTOowcgvtBl3KJe0U0INcBIyyQMprc+m1mxldzIFve4GF4pmDeTTRmFPLIWf
	 9VnU2aRfQDlC7QHgYx5WegqqamGoUc4AaeRZUYbu1WInySpJhIar2s1fUODCV9fqfm
	 hocLB4kJoS31g==
Date: Wed, 15 Jul 2026 16:49:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: guzebing <guzebing1612@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH v3] nvme: reduce firmware activation poll interval
Message-ID: <algOi6OByZV9an8p@kbusch-mbp>
References: <20260715114401.1084214-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715114401.1084214-1-guzebing1612@gmail.com>
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

On Wed, Jul 15, 2026 at 07:44:01PM +0800, guzebing wrote:
> ---
> Changes in v3:
> - Add a common polling delay helper for nvme_fw_act_work() and
>   nvme_wait_ready().

I guess I was expecting the common helper to be the CSTS check and sleep
loop rather than just the sleep. I know the fw_act loop also checks the
ctrl_config in addition to CSTS, but that's fine to put in a common
function too.

