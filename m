Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97739C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpnZJDDiDyijtK7RRV1itq7H+wET+4n1xf8niepFDzs=; b=4R6NulfzzzaKws6YyBE/jJb1UY
	hAKB4lgvduaUs0BJlEs4lW5L0nE5eUSRMpmr0Dbsxtyg3psTkehlcHFke6ZIalcp/omQjITyvn5+K
	CXLFP3yGOJp8hgpVZx3QzJztlIeG7nFrWT9kfjHOlxNBecMYXoE0RoJBtxwRy4ednEtjjMQO71a7g
	aAZ+uqay9oYLErfntYmRqqNGv3yR9j4lXNeiDeU2yoqLpKdMDNdvBmakPuEzHlF2o2xQ5oWLk9Uqu
	noyM2s8p+HtY1V3s0iRQ/0guDAefMx/vVuE9ZNtMvPxY+Uxn7ZBAJwPBuf1WZ8AejQRhh8354wPFq
	wclGEc8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhkpO-00G3HZ-GQ; Fri, 22 Apr 2022 04:23:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhkpL-00G3G5-DV
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 04:23:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 80F1368B05; Fri, 22 Apr 2022 06:23:19 +0200 (CEST)
Date: Fri, 22 Apr 2022 06:23:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <20220422042318.GA9977@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
 <YmHQS1pyIglK+gfS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmHQS1pyIglK+gfS@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_212327_641359_23199671 
X-CRM114-Status: GOOD (  19.35  )
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

On Thu, Apr 21, 2022 at 11:44:43AM -1000, Tejun Heo wrote:
> The patches look all good to me and I'm not against making things more
> private but can you elaborate on the rationale a bit more? By and large, we
> have never been shy about putting things in the headers if there's *any*
> (perceived) gain to be made from doing so, or even just as a way to pick the
> locations for different things - type defs go on header and so on. Most of
> the inlines and [un]likely's that we have are rather silly with modern
> compilers with global optimizations, so it does make sense to get tidier,
> but if that's the rationale, mentioning that in the commit message, even
> briefly, would be great - ie. it should explain the benefits of adding these
> few accessors to keep the definition private.

Mostly to help me understand the code :)  between all the moving to
and from the css struture it is a bit of a mess, and limiting the scope
that deals with the structures greatly helps with that.

