Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7273CF34C3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JE/jwJzlshOKPTBgJtEtVI+Wxfomb7k5yygkbKlFdU=; b=kpR4SEDXUYh70BPLH2hAPrTGBh
	rLdwcMATtk5FKkMzwOol6oB2rOlijUokA9ra83OnU4A3KJwnl76bCLYZivIKNzTdgPXb2qPAVSPmM
	A9Umcj0wKeSPL/eb+efP0Brfdf7xB4OA4EwMHjAhujj+e/YwqIreqLsNOemAIJC1zbHBEdHzXzN9K
	l7SqydqX6CmE0mq+5BNa1+eqHM06xoTsKYrO9SFgUUCiqSp77mfRLlj1FfcjSqqHdgLj497KX7sqo
	CP74w6/UPwLQK+xpv9pSwZiROqDLlZWV3qdsiWERBXymDeCxSA7U5YbjYCNcDv0lu6gVMtYChntFD
	AQ+hSfKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swSD4-0000000AHIQ-438D;
	Thu, 03 Oct 2024 20:14:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swSD2-0000000AHHb-1kTK
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 20:14:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2DD5B5C5DCD;
	Thu,  3 Oct 2024 20:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCDBC4CECC;
	Thu,  3 Oct 2024 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727986438;
	bh=np4ldZL5+d+NBAbBifYrbTGrI8aOWxY083cjGdIvEEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItP/ySw+WxWUW7LethbrvHTN9gJAbbvwS5f6i45GzxAbYmhchAdUQ08StrtaJLs3P
	 g1YY5SlrZQCaP8dQIYpMbUpCiGClVFO2Nv52S0QTn+ZYCqH6MeZdViR7hvv5DZqIfi
	 QPKUtmBr2IwJc+HQrzemYIkdYG2g0Sp7GyMHhNs7NI1klMtfdJLKapz2rX6Y9m2NOu
	 kZLtlM4zlo0Aeo6+QmLRH7izlJV/aMaeUoBmgPoGn3PfgpXuLnkMPwJv87dwdyGEj5
	 M1l6tKEp9VIkEFCrRX79spaCHV2scx6UJjJJY3CqWZuDpL82RenpIiIiN37TbdEl2+
	 uvfevml4Vj1vw==
Date: Thu, 3 Oct 2024 14:13:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: tcp: avoid race between queue_lock lock and
 destroy
Message-ID: <Zv77BPZnS2hJMUjZ@kbusch-mbp>
References: <20241002045141.1975881-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002045141.1975881-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_131400_520705_8F8746C9 
X-CRM114-Status: GOOD (  13.42  )
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

On Wed, Oct 02, 2024 at 01:51:41PM +0900, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
> error recovery") added a mutex_lock() call for the queue->queue_lock
> in nvme_tcp_get_address(). However, the mutex_lock() races with
> mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.

<snip>

> The WARN is observed when the blktests test case nvme/014 is repeated
> with tcp transport. It is rare, and 200 times repeat is required to
> recreate in some test environments.
> 
> To avoid the WARN, check the NVME_TCP_Q_LIVE flag before locking
> queue->queue_lock. The flag is cleared long time before the lock gets
> destroyed.

I've applied this to nvme-6.12, but the existence of this queue_lock
seems strange. It looks like tcp is relying on blk-mq's timeout to
individually complete requests after the queue is stopped, but I feel
like there should be a way to complete everying in a single batch. We
have the generic nvme_cancel_request() for this reason, but fabrics has
it's own other way to do it once at a time?

