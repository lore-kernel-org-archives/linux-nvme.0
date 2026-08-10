Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FCAC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/TSspw6p0KKcMXEs1j1MiiLdBJ452QPMmLq6/adWGM=; b=RvyzUa/SrDXJkd6/6J9ON9jw3I
	3GeXVOv0aBiD7dHjb3lyNnlUxO25DTuXIhPDQwJYrQbbhCj5OtaW8QrZPE153wS0fZ2eK5h6SSOX6
	DYIO2kdSykA43+Ppk1ed3LcFjjjaRPfW873ee2OYt209mLfqki2T0tHf/TYscnUvgkyx8+HoBWO2d
	k7WS3lV21pqMjbL7D5SflLH6EhhbeGsGmJPzyxRPU1GKTXtZHd6iEAJCr4jRESK7X6CatL0sbAMGG
	glb6Qm+AQKMk/cKT2Y4kb/eKe5qFxcDVMcawSfd2yA3jAvXDiDuQUhMxcQyFAnl0EkBv7HMwPFar5
	pJX0DaKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVAS-0000000CgRA-0tg0;
	Mon, 10 Aug 2026 18:56:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVAQ-0000000CgQx-0Ri9
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 18:56:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D7E744394D;
	Mon, 10 Aug 2026 18:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3FC1F000E9;
	Mon, 10 Aug 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388169;
	bh=6/TSspw6p0KKcMXEs1j1MiiLdBJ452QPMmLq6/adWGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B4HURN+OerX2pZb708WhKZ3kZG6elTG/kGIAy4ug92ARIgthKUtgu5Hv/Not9j2uH
	 xD4H13RwOKMooyWJPmS6cEnPqfpBG1zYeqeBYpqwl0kGK3YM9aOKubASSU42B1FLjh
	 k0SUvVpXu2SYtaA51WBkE0l9uIqB+lOWj6hE/mgx09zSIqF2DtnDVsLsvCk2atV2eC
	 KbrWARYQK9Scg7YwiEQltx1Z4+4PMkcj32zmXQVAc9froe6dqzgGHrW2KhGVQGQz0Y
	 yGi2Q1R8QCgpgM9i2wUwNoV2kbUpqO3O67cwTBLs3hbKUaTnLx5ejZKC4LMXNa83wS
	 GgwlyO0ffJYuw==
Date: Mon, 10 Aug 2026 12:56:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: look up host_iface in the current netns
Message-ID: <anoeyK7WiQTj15e1@kbusch-mbp>
References: <c14cd4633c27abe2dec863480168691023694aee.1785033817.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14cd4633c27abe2dec863480168691023694aee.1785033817.git.tanggeliang@kylinos.cn>
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

On Sun, Jul 26, 2026 at 10:46:49AM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_alloc_ctrl() looks opts->host_iface up in &init_net, the boot-time
> netns. When called from any other netns - e.g. the selftest's ns2, where
> ns2eth1 actually lives - the lookup misses and the controller setup fails
> with "invalid interface passed":

Thanks, applied to nvme-7.3.

