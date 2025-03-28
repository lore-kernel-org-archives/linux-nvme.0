Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A9C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kpbQnSNJWGGBfdPkHm2mE4AHN2MvkeYAFgepfSk9Vxs=; b=Ef2snz8Okcj/xBLcUFVnDKxQvj
	v0oMxRsBq6gMbgw/B2eZVh+Cfxg3naDAj7Du9CBFwTC9IixQNbG2ptQJfAfBG3t1zOnR8Uosmbv1a
	JS9xu7KWeD7xApqBa145OFJKTR2GcR3i2bgZBgBN5MDtq39GtIjQfoMY9wARtZGceqczot+hp9e36
	KohnFxDmcOqodMLxJISjXS0IA458Yk9ScGoucvHhXUIOOuQQp1GHf51b2sdQjCYfK589NvyF+Ujx9
	/brNXPnz2MvNejLXKeGjqmlm1xvOqRRyuwCWFMMYMU3RKkjeK/o4wLsCuZYN6oUflOGsxZUfyVfCz
	FAAzEQUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyDY2-0000000E0ZW-08It;
	Fri, 28 Mar 2025 17:31:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyDY0-0000000E0ZK-1dCt
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 17:31:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0341C614B6;
	Fri, 28 Mar 2025 17:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3F0C4CEE8;
	Fri, 28 Mar 2025 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743183071;
	bh=YbxivTapwxnGN4pqI9VK6fEXAti0c2E3era2k3yXVM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1oEExVcXQbCEh2YWXY33OVsDVJYwbiuItRF9rNQv6dH66HeXXkjcYskgDFE7OYWx
	 OP7QmH6lMxk4kT1NSWmKN5a4TouMb4PuyMPXGjVXvrr4vykQzrL0z1Lglxy4GSYoqV
	 Qa4/ntx7Kcec7IL2iPiMaUfaTHqtmouHRVsh8NZxARYAjin6PjObu5b2PL9bGWtKQQ
	 GP7R3TPIRzSQbDiKaQecA5HkU/xSWKociWe8UC1axnp49qOEpABOloaZiyY7Lelpqt
	 rxnuK9txRzhgr0P4FbLNmp26d+VVsb5R0kb0CH6sqs9OQiJWKzCWgKuG/Qdsgt+gEW
	 rXHzrWEc+po3Q==
Date: Fri, 28 Mar 2025 11:31:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] nvme_map_user_request() cleanup
Message-ID: <Z-bc3Hjc2eVSRK7X@kbusch-mbp.dhcp.thefacebook.com>
References: <20250328154647.2590171-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328154647.2590171-1-csander@purestorage.com>
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

On Fri, Mar 28, 2025 at 09:46:44AM -0600, Caleb Sander Mateos wrote:
> The first commit removes a WARN_ON_ONCE() checking userspace values.
> The last 2 move code out of nvme_map_user_request() that belongs better
> in its callers, and move the fixed buffer import before going async.
> As discussed in [1], this allows an NVMe passthru operation submitted at
> the same time as a ublk zero-copy buffer unregister operation to succeed
> even if the initial issue goes async. This can improve performance of
> userspace applications submitting the operations together like this with
> a slow fallback path on failure. This is an alternate approach to [2],
> which moved the fixed buffer import to the io_uring layer.

Thanks, applied to nvme for-next. I'll replay this to nvme-6.15 after
block-6.15 rebases to Linus master.
 
> There will likely be conflicts with the parameter cleanup series Keith
> posted last month in [3].

No worries, this actually makes some of those cleanups eaiser.

