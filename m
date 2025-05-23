Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FA6C54EDA
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iano7InUoFqQduDdkaL5y2QwS0GgnADPFGNkPdjC45s=; b=w8Qvc4jTdDyoHkb4rrZ0YlQRYJ
	vLnrLz3e7ZqaCRZ0P3zkuJNyiuBEhXidfkE7CPnt/ar/J/lUe5h5yO5IyecNt6onim34DDffJu8+c
	gGhN7g64sDZy4GATdkIpi9d8iFybttJmzYEQlCG/4jkeO1N+ShDdftFOHeyGQc09e/HRVYfdSFxXx
	VaVxhCWAXG2U0fXBZUVhQAgzmvicXAw1q8E6FwpmqO36tIYAjWSZ+2SJblmB0Vc8a6s835jQg+yuT
	v0p709I1lO1nU0m0JTvU/N0kfEt87u5jt+tt8wqAz7D5RzhKd4w6Eao8JptTBLJqKeue1Ufl/W8b6
	xSq9nQbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIW7N-00000004WlE-2ZsC;
	Fri, 23 May 2025 17:23:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIVml-00000004Tn1-3lkr
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 17:02:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 595C840C00;
	Fri, 23 May 2025 17:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6FC4CEE9;
	Fri, 23 May 2025 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748019739;
	bh=d06y+t7JFqi/D6PQ4ks72NPGGFC2M7hmUEw6fWfr6CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOJZcwPOAvEpIhy3iz/yw5CtssnznRPy+5kRbz5clt+hujQUJOwkt0oXyivXApajy
	 ahHkYBX6Sw5qaw3IMmQgLyTDIL+hjTCDr6phBk4NTmgXPAp30S20o9PWt2TLvQUOnp
	 gWTnt0pwr1QWOMDwMX+OvX4dZGgocjssQnyC4k11XJbRINJppL0R9WcDkJ+rePw8QW
	 Zx/MjAJtnHPzc6jcNrOhDhugF76uucpWnfz6aOXE5qj+1fsVQ8gaQSF7T/4YtOFaw8
	 Cp+2RkrfcNOPsb3VzdEwvf90krsPvstSEgmU9H+eZTvXHZ4cCT/XPVyR311l+hJoOE
	 4wh5HoWAQFblg==
Date: Fri, 23 May 2025 11:02:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDCqGLY4irp-6N5M@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDBt1qXj90JO1y2v@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_100219_955735_B2084696 
X-CRM114-Status: GOOD (  19.16  )
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

On Fri, May 23, 2025 at 05:45:10AM -0700, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 03:31:03PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Provide a basic block level api to copy a range of a block device's
> > sectors to a new destination on the same device. This just reads the
> > source data into host memory, then writes it back out to the device at
> > the requested destination.
> 
> As someone who recently spent a lot of time on optimizing such loops:
> having a general API that allocates a buffer for each copy is a bad
> idea.  You'll want some kind of caller provided longer living allocation
> if you do regularly do such copies.
> 
> Maybe having common code is good to avoid copies, but I suspect most
> real users would want their own.

But the end goal is that no host memory buffer would be needed at all.
A buffer is allocated only in the fallback path. If we have the caller
provide their buffer for that fallback case, that kind of defeats the
benefit of reduced memory utilization. So it sounds like you might be
suggesting that I don't even bother providing the host instrumented copy
fallback and provide an API that performs the copy only if it can be
offloaded. Yes?

