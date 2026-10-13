Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1B8CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkAT0YkwoNVuPrBgY3GgZbtc10yS7c69UrEAnRmjKFs=; b=1KYGFWsl7QlQ+BZlt6Lx8kT305
	8zIsCTSMKPB/sxedsoN1PvV+RYStAEk5QrknI9GXzZKqSprVL12SEuSZ6QG4Fmb+Q36BYeF57yAoo
	9232x9kR1sqP+mxf5rn3qNwdVK4LHlRvtc6J69uk6NB2oJt5DCBO7DOIbiCgQYZdCsnmH51ausycp
	kOiwZEEAfkdkvESkbJNIN85a6aAjxX+5uzqtTBbs0FCuOlXScKJVPKCxcEfmKCPlcYK4UWQ5ZsZdv
	WjIGMWbQ73GDXzkZxNU/M+aV51jy49a5UOF2wR1uQUa9z/UtOkYz/DOpCFOnrH/L6VUXK+t0NqnX1
	c0SmGOcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGecI-0000000DNx3-0mdm;
	Tue, 13 Oct 2026 15:40:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGecE-0000000DNuy-3Wo9
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:40:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 983F641B19;
	Tue, 13 Oct 2026 15:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE971F000FF;
	Tue, 13 Oct 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906034;
	bh=BkAT0YkwoNVuPrBgY3GgZbtc10yS7c69UrEAnRmjKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcK7ZvNOCZCc596UYCqg5W7wGCvjX0Xb9J3QhuXIPCujKxQqgVMvEuW4fNB3uNcSF
	 ARnpYPPLHMtsn8w3Ls6RS3Mcy/STuksbjiXr3/hYpuh18dl0kP6jU9juV+6xoBwbV4
	 RBsvWaFHvvin100+ooG68ZCoboSGWK7aTR0H2SPQBFVD/BNqdM12U3XhPnOd86pNwh
	 ydqlz9qWUr+zsMFGyoYRrcFdtXQmyEBbDSLUJonJwsiSDtbqktBAVdoKVL+btSZfMg
	 TXFcxYYCe9RAHLaE6dgnTE0C1H6rxGHX53Y1+4fseBS2DmeVAOHIdf9CPJodj64Y9n
	 zlIP98XbTYcSQ==
Date: Tue, 13 Oct 2026 09:40:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: free the bvec on file namespace range errors
Message-ID: <as5Q8AqFMkRydVre@kbusch-mbp>
References: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

On Wed, Oct 07, 2026 at 07:27:46PM +0000, Jérémy Jean wrote:
> nvmet_file_execute_rw() allocates the bvec before
> nvmet_file_execute_io() checks whether the request fits in the backing
> file. If the request extends beyond the file, nvmet_file_execute_io()
> calls nvmet_req_complete() to return an error. This skips
> nvmet_file_io_done(), so the allocated memory is never freed. Repeated
> requests can exhaust memory.
> 
> Use nvmet_file_io_done() to free the bvec before returning the range
> error to the client.

Thanks, applied to nvme-7.4.

