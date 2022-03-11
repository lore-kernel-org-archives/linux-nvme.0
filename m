Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD20EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nf51P7/kjL5NpZvi+pNY06strrEDKxXIsFrJb9s+bC8=; b=g0uVn3IdZdYL3NHvYjNBfZx/jd
	ZqJmHKsBpiYWdfCTpMrM+82C9KxRLI7xwLumWbIfgn7wlSgltwB5WQIKoKlXOFZ47tXWXk5NKZ7m7
	DrutYL6khl2nUbzOt75P3VFrrE9wqwjWT2no0xo0DBJPDiHgLJOe0ARA81ArLy6nox3vmo4ZypMzx
	YmuC5NXW2/ckW50AnON4OWAlyL26gtnZrflmfG6/FXhwu/gKfDPc0edYIf7mFe8UEGi9DrNsAcLMq
	fQU7GCI6nDJw+8yk1nigpF5oSVNhJXYssJZUsfQgHX02kxbWXoWiWYyGVKdO2BoS7KnDjxNhQDq73
	dwwy8Jfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSYuh-00FFhv-Vd; Fri, 11 Mar 2022 06:38:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSYuf-00FFhF-Oo
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:38:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D09D668AFE; Fri, 11 Mar 2022 07:38:05 +0100 (CET)
Date: Fri, 11 Mar 2022 07:38:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 04/17] nvme: modify nvme_alloc_request to take an
 additional parameter
Message-ID: <20220311063805.GB17232@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152700epcas5p4130d20119a3a250a2515217d6552f668@epcas5p4.samsung.com>
 <20220308152105.309618-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_223809_980456_6FEB5968 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 08, 2022 at 08:50:52PM +0530, Kanchan Joshi wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is a prep patch. It modifies nvme_alloc_request to take an
> additional parameter, allowing request flags to be passed.

I don't think we need more paramters to nvme_alloc_request.
In fact I think we're probably better over removing nvme_alloc_request
as a prep cleanup given that is is just two function calls anyway.

