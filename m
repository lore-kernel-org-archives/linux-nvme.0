Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCACD6A221
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8+CWFtKXPpfyuHiYrxr55SS5Zd425Aocwqn1b7ypkU=; b=3mpMl8aJPn4Wvx/KYJNvmVYn28
	25K3w4+RmXKDY6Y/WOlQ9WgON+QgrP126TRNTp4EW8ResmURzksHkLsNWgPhGf+xmqxD06QmN30j8
	fAGZ6MDooBCCa6IgoFqyIez7y1nmVWfgu0WbRNTPCefUKpdB1SJ091KkqGf0QGbXIccFoHRGGlSql
	pXMPKHE628/43Bl7eVIiItfbUTLON31E4PqaPKHjJLfRQsHs9G7gyQjJC1WVokQbbo+napdcxUvhJ
	OwP+zzGGqz0ZLGuXZXHGHM1Fwv9uSv3lYIjJiKZb28WGM9x8LhNqGVQNxqYrSjdvyERH1nRiMn+tL
	pQVs1aBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBe8z-00000000Pdn-3Uw4;
	Thu, 14 Nov 2024 18:00:37 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBe8x-00000000Pch-0w2j
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:00:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 49400A41972;
	Thu, 14 Nov 2024 17:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A54C4CECD;
	Thu, 14 Nov 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731607234;
	bh=/IWFpM6Y53TPwB52PLE/0ScY+BYAIXmy0NSKjuRLYnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bt0JY8sKE4W7aRU8aJOSlslWHLxLk4yRWhi10sR5AV10yNfZBsZkyQ1Dvo7tAC+Xx
	 5npP8/N56rNO23mmVBpb73J0NlezwRpvNKDiNqmQB1gDeN+YP1hw27/dTbrhV4Dnl/
	 jSKAlY0C6DvuIbkcwUSGvtBaotxD3/ITR0Bue5BfSF4XLb7+SJQzwKs1dlS+WmCKpu
	 AqypnWYvKYYjTPQOrMYdVddbmmlC/1XHMSRWJ/ypkW5v+MihpfCTQc8NIb54iGqJqF
	 D5D+zv2MYfsv+WIMvESw+6lxlC7Q7t/J9j+bS+ecYavuO0s8kmdObjRZb4GGOmkajY
	 HlrtnKxLY541Q==
Date: Thu, 14 Nov 2024 11:00:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzY6v4d71jliy78w@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_100035_332082_899A60A3 
X-CRM114-Status: GOOD (  19.30  )
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

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.
> 
> Currently it is not known why this fixes the corruption.
> Perhaps it is doing something nasty like using an mmc page
> as a cache for the prp lists (mmc min. page size is 512 bytes)
> and not invalidating properly, so that the dma pool change to
> treats segment list as a stack ends up giving a previous
> segment in the same cached page.
> 
> This fixes the previous queue depth limitation as it fixes
> the corruption without incurring a 37% tested performance
> degredation.
> 
> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

I had this queued up for the nvme-6.12 pull request, which I'm about to
send out, but I guess we should drop it until we conclude this
discussion. With 6.12 likely to be released on Sunday, this better
mitigation would need to target 6.13, then stable.

FWIW, given the current understanding with the last entry boundary
chaining idea, the QD1 mitigates that by always allocating a 0 page
offset prp list. So it effectively works around whatever errata we're
dealing with, albeit with an unsurprising performance penalty.

