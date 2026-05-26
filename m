Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BB2CD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S8xGth6pf7eNo2Xwd+YtTPggqwpp7m9sBjiE/SxNsWk=; b=MLn1QadqXMZmCy/nPV3okk4rZv
	FgNrHEJiZDLpjhiVnh0aZOlA/FcnaiCTQAgsnnIV3xp9yBHGzQPjGJSf5EPePQCNqeh5pgv9JGtr8
	VJxnihuYHQ7panR/sR9sLMbeN1zfkpOcO2B1j3Xfp2zj0aO7vouR3CcMyZVP6oaRGCJbN2zVAdAb6
	MCRg/2t1Lht7zOwo1bDvNA3KiJvFqLA1gMuAZib+r/G0V3Z/bD6heVc3lOkHCtI68yBQ+unqGYBVd
	YUMt5ajzB5IijSdjDCaPo1IVaqFvKmar7qxE/XCCrCqGtbsyTF7I1Sv6ZFeGwmt+5AxYGc7DTq1QS
	un6K/sdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRsxw-00000002Bsz-1DUl;
	Tue, 26 May 2026 14:41:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRsxu-00000002Bsc-3csJ
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 14:41:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DBD4660128;
	Tue, 26 May 2026 14:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F831F000E9;
	Tue, 26 May 2026 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806465;
	bh=S8xGth6pf7eNo2Xwd+YtTPggqwpp7m9sBjiE/SxNsWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RiKBGIsrg4KJJw1rHb/phZ9i0CZ9Gf/1NuDQeoB13nOIcuXtdIvGu2WhWEGN9uJUS
	 lw3bNczQmA8zPq62UzQZtgv3UtYMeURL4SeKxaWrJT9Fn3Mvl8fS2fGrqWx3eY6XjE
	 +tiEWpOzpadaxjjAK6iRjgCr3JhvcWnnCZ5Imlp7sZExzfeJG8rGuRdMmTUn8Rl+FJ
	 a42ts5WafeDok2lGC6HV4b7+6Ojd20bmiPxi5XAZYsN6x/H9fK9o5vU29jN13XqfGR
	 7SYZtcx9RBsQu75/52ry/QEDXQZ2uT1fCQ5l+2wrXe1J/7glB7qY9/MOm2LnrCcPLz
	 3Y+jckOPPoSKQ==
Date: Tue, 26 May 2026 08:41:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] nvme: fix FDP configuration log parsing
Message-ID: <ahWw_09BJkQi9zQe@kbusch-mbp>
References: <177978195864.4106423.11658267582906445997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177978195864.4106423.11658267582906445997@gmail.com>
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

On Tue, May 26, 2026 at 03:52:38PM +0800, liuxixin wrote:
> @@ -2262,10 +2263,10 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
>  		goto out;
>  	}
>  
> -	n = le16_to_cpu(h->numfdpc) + 1;
> -	if (fdp_idx > n) {
> +	numfdpc = le16_to_cpu(h->numfdpc);
> +	if (fdp_idx > numfdpc) {

Can't this be fixed with just a simpler one-line change:

+	if (fdp_idx >= n) {

