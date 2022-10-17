Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE97C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IX+NHOlqIhcM5q8O2EaaFjNj9y9oZQhyBGjfOUDzitA=; b=RA0Cz/gw2pCEu8fxtYxkxB1GHA
	EtwJgUCukr84XfnwabsgmmgQ0lNPptfakg6YsIJ786yYEvfsfM/W0tW+ifLdoCeux9kfvRJe5fmFr
	Ccom2x4dPMxK3d1CgYKNCGIDjfCJe8erwFIljo6a4Lo+LZXha9pImsqGaW4Qmo/kfCodfpkcyP0da
	ngewof3U9xj9n86xlPNPIBafbCm4v1vmedUJulz/4dX5athsbiF6Jsn+ztqAffaZrLvSZemnItJt9
	8wv19fIfQFylhsS1sAawfWvy0JEmzqzJE0S8LlYRTcz32mKMIt4Jl4bycugDieyPxhqSWFUt7fp60
	PWIuNSBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQ6E-00C6eP-Hm; Mon, 17 Oct 2022 13:24:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQ6C-00C6dZ-2f
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 13:24:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8EF168BFE; Mon, 17 Oct 2022 15:23:59 +0200 (CEST)
Date: Mon, 17 Oct 2022 15:23:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: clay.mayers@kioxia.com
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Message-ID: <20221017132359.GA23141@lst.de>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com> <20220929223955.3275715-2-clay.mayers@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929223955.3275715-2-clay.mayers@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_062408_280248_FAB53912 
X-CRM114-Status: GOOD (  16.14  )
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

On Thu, Sep 29, 2022 at 03:39:54PM -0700, clay.mayers@kioxia.com wrote:
> From: Clay Mayers <clay.mayers@kioxia.com>
> 
> There are AENs from alternate command sets that include
> extra data in their AEN's CQE.DW1.  For example, the ZNS
> Zone-Descriptor-Changed AEN uses it to indicate the NSID
> of the event's log page.
> 
> NVME_AEN uevent now includes the value of CQE.DW1 as a new
> property.  It is only included when non-zero to keep previously
> existing uevents unmodified.

I don't think we can actually do this.  If we ever want to handle
Zone Excursions or any other event where the device can chane the
Zone Descriptor we need to handle this AEN in the kernel and thus
control the clearing of the even by reading the associated log page,
so we can't just send it on to userspace.  This is a bit of a sad
state of affairs but unavoidable due to the NVMe AEN design.

