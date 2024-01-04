Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51373C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlOUemu3DMWy7bRRhfReOsckz6TeZyAkeLf3pQ4MJ1k=; b=moYj7qMfGe1a95+kZtx4m5UGn6
	2iJavlPeZ2ikc2ieKK0AczckDSpqhm29WK5tV+gYbF3xQHcAJw/jUfo30gbDRsSe8GodcU8Nu+sve
	oL6dGuLwHJz2lZniRTiC7VKdyxagNFnS7ZzrkaOSGpg20m6WKDgBfKedii34G0Tr9RePzAnyM/6KO
	iniPJjJLimUhK5EjAGggEK7AbqLhTIM5KNjaj7tcplhUAcD04OcXmQL8YWoQly4tBdaw6oG1jiC/q
	j4nkcyLoJzKiGjmF4YwLGoCT5cktz33/u5ZtMoSSA75oSMjQ+97ko4PdYuP/Lu3A+EkiFlAywgTOg
	5OhYS9AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLQsh-00Ejku-1x;
	Thu, 04 Jan 2024 16:47:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLQse-00Ejjh-3A
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 16:47:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D0124615E9;
	Thu,  4 Jan 2024 16:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1113CC433C7;
	Thu,  4 Jan 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704386859;
	bh=gUL3ydGH9gI1f05tOKDtRIs4ksaWn/LR5N9XebQaO1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmUFVV+7jEZvhSjq03hi0FLNJ85H8T6nqcxIvwlhNEJls+vxHNPopDZalFbP6Uo81
	 qPR6VobMUiIbrOgEkd27J59G2rbFxza+r0VWkux2Z7yB4YLeaEUvVXgraY4wvILYcf
	 zpjVhyVt0L8x3rq44R4OW/VNZq0iaR668hl2VMbm8vXPM9aUTylTNEy5r9aKgVxWOq
	 WQhkOngqIIeDJh+k2aryhU28WPQWfhhDseHzll2NRbm7zdmBjt1i3QXBpuH37iUHog
	 w8+KjRy3K67WgWcVtLr5iGaqLNJEgb9mdxfH4aI/y4fGKxuemOdHHqKCImDzE/A+n7
	 5EWpxHeVv9sFQ==
Date: Thu, 4 Jan 2024 09:47:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Message-ID: <ZZbhKM0L8pFYX_zd@kbusch-mbp>
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_084741_085018_8B499E06 
X-CRM114-Status: GOOD (  13.27  )
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

On Thu, Jan 04, 2024 at 10:38:26AM -0600, Stuart Hayes wrote:
> Currently NVME namespaces are scanned serially, so it can take a long time
> for all of a controller's namespaces to become available, especially with a
> slower (fabrics) interface with large number (~1000) of namespaces.
> 
> Use async function calls to make namespace scanning happen in parallel,
> and add a (boolean) module parameter "async_ns_scan" to enable this.

Hm, we're not doing a whole lot of blocking IO to bring up a namespace,
so I'm a little surprised it makes a noticable difference. How much time
improvement are you observing by parallelizing the scan? Is there a
tipping point in Number of Namespaces where inline scanning is better
than asynchronous? And if it is a meaningful gain, let's not introduce
another module parameter to disable it.

