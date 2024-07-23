Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88764C3DA70
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 00:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NvLURcNp96r0+EYq9OKwE8SUYsmmRNEQLv0M9DD0M5I=; b=CyYsiexw3khCEoltpSwcD2i7Ad
	RaLz51MvO+czXrhj6e8FeQhrnXsFsF4YgpuWLQNCugmUPb8rNSn6T7VE5gu3xuzUtlWrIsQnjRUly
	Cjt1TbYpCX7DdyQDbIs3qIYHbbFKvFBoLfv9vhgCXTCwmfPgvBhdMdOMAKPvevgXVHQOaxSPptWFS
	5Pj22hkvA36Yu8KKXeii0Bz4Fh5XcVl+/5xUmbu38pK5PKJqkqB20wjdtb6aF3aGtR3vAybEF/Wed
	2yRHOLW/uQbbobHvdvjjMJPDhkVYMZx5GTOyX+X6V4NQVH0Lc7DJqxHCj1Xz/owaN9qYuet7ksaIj
	rJSOnOVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3f0-0000000Ayed-0lNX;
	Tue, 23 Jul 2024 00:45:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW3ex-0000000Aydd-3WTU
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 00:45:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 52B22CE0C92;
	Tue, 23 Jul 2024 00:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2308CC4AF0E;
	Tue, 23 Jul 2024 00:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695540;
	bh=UFq8TD0aNOJmVzfMqq4NoRuO6kLMdPZWR9goKFLapXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHV8tTO5tkp8k5YT+4PsPbZ1X9n9IBb48I3ONpPaTeA+6FpuYASA27MvO46bLyhpa
	 EigO2+jSm7ZvvEUkNIuSq9/E1JoOHwD+pqKM0xYTaDS6O776Sepa3E+ho9theTTNjG
	 Te1Juhp+iBU9kWPsSiQpOlhk5Ligr29K1Rp6ypl1l1/GESJhVIXPNHFaeY4lEHld9g
	 Z/KAPtU4ZSFscIQg7mbxZQVkU7V8IgdlBArLFbFF6AbWmJiJs1I2+fAKcy3DahRsEs
	 D7JnfyCcuna5FP+93Qj8LnIEZ8HJRYvgyAQtaTveTVYaFB20jqrTplWHJQhytwfv2I
	 yawbUrMSzFmSw==
Date: Mon, 22 Jul 2024 17:45:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpages_ok()
Message-ID: <20240722174539.461bd2dd@kernel.org>
In-Reply-To: <20240718084515.3833733-2-ofir.gal@volumez.com>
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
	<20240718084515.3833733-2-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_174544_116223_4F3F3BC7 
X-CRM114-Status: GOOD (  12.09  )
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

On Thu, 18 Jul 2024 11:45:12 +0300 Ofir Gal wrote:
> Network drivers are using sendpage_ok() to check the first page of an
> iterator in order to disable MSG_SPLICE_PAGES. The iterator can
> represent list of contiguous pages.
> 
> When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
> it requires all pages in the iterator to be sendable. Therefore it needs
> to check that each page is sendable.
> 
> The patch introduces a helper sendpages_ok(), it returns true if all the
> contiguous pages are sendable.
> 
> Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
> this helper to check whether the page list is OK. If the helper does not
> return true, the driver should remove MSG_SPLICE_PAGES flag.

Acked-by: Jakub Kicinski <kuba@kernel.org>

