Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3420EE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2bXmUcBFpkVyZydcs1hNRJwTC5QKFwyDn/WpP0C+Yw=; b=gNPA8OmoOOGGoBLlmrfxXndWiu
	Q4dwNz1SQJabfHqerCi34buuqvaCOD/odHKjxfHApCNBsoNA5zHrtBsHOjIeWimcBxYHdzWzmtQv/
	h099TT5QHa4TkQ2APEsolXgMySS9CN78o3+5/HTW8+EOyfhPU341Ei6yzB00zJyo71qMZgnM9REL8
	IvT1kDyfnaRIfH1HtiY9l+VyC/30QsXNpoh9zKubwNdeyI3AnK02KofQ5d+pi0yNLG7GgkOauhlGc
	pj/XQu6iNfQguvMN3yGOSpJie1pgTLaYcUDVXrpnt79NwLK2UDgcAaVYk1DanBTuwLuo+oKptPCWz
	wsChH6RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjsP-00000000ldw-2Qa6;
	Mon, 06 Jan 2025 09:58:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjsM-00000000ld1-2hEB
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 09:58:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2734868C7B; Mon,  6 Jan 2025 10:58:14 +0100 (CET)
Date: Mon, 6 Jan 2025 10:58:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Baruch Siach <baruch@tkos.co.il>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: use dev_err() to make message more useful
Message-ID: <20250106095813.GA20536@lst.de>
References: <29637ab5b312249da0b0cfc5e138e2aa7f6cddfe.1734371040.git.baruch@tkos.co.il> <04a0778c-61d7-48db-b5f6-2dbe8b8ca752@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a0778c-61d7-48db-b5f6-2dbe8b8ca752@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_015822_824058_477BF631 
X-CRM114-Status: GOOD (  16.55  )
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

On Tue, Dec 24, 2024 at 12:53:49PM +0200, Sagi Grimberg wrote:
>
>
> On 16/12/2024 19:44, Baruch Siach wrote:
>> pr_err() produces no prefix when called from pci.c, and only generic
>> prefix on other call sites. Switch to use dev_err() for more pleasant
>> debugging experience.
>>
>> Since we now pass nvme_ctrl to nvme_find_rq() directly, nvme_find_rq()
>> can figure blk_mq_tags by itself. Remove local helpers that are all
>> almost identical.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Link: https://lore.kernel.org/r/20241212062241.GA5586@lst.de
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>
>> v2: Pass qid to nvme_find_rq() instead of tags (Christoph)
>
> The call-sites are all printing similar errors. I'd just get rid of the 
> error in
> nvme_find_rq...

True, I had completely missed that.  So maybe we should just drop
the pr_err entirely.


