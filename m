Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25751C624D0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrtrd0IT8TCm+/LtrvZd5MMtsuZoLdXYiqnizgIxvao=; b=gIgB6Et7qw2v9RA7lHvcIu2riC
	PdKvlTK9y7Pvgv5hrLntkoN8MPuGyFcRdLFBfKeNXdhVChTgnOSZFC9cTE8RtP3ZHfSnyW57R6mio
	XNmBmvg97+1O3dEJC7IZmKFNHtb8eBx/71OujmCrYmzzq10nUlE4ev581HPa3L1FB9rOf4eiEYq+9
	7tfJPmGOZMq7IKwBiqIZCIWYzEmm7hVKBTLX0OUl/dQOYB391KzmfhPqeUxhgkCWyw5Lc9fPd3J01
	hDUnl/BKyD+l2JzAoQka/ABWhPii5lS3+Vj4I/NF8gobvJlMnzvGhAxw4lpqoU51UWjxc+5cdwmWa
	EJk6ndFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iFW-0000000EMHS-3o5s;
	Wed, 02 Sep 2026 10:31:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iFO-0000000EMGd-1AtJ
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 10:31:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F097A68BEB; Wed,  2 Sep 2026 12:31:00 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:31:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 1/3] fs: configfs: add helper to identify configfs
 paths
Message-ID: <20260902103100.GA8095@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_033114_495318_7708B97F 
X-CRM114-Status: GOOD (  11.82  )
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

On Wed, Aug 19, 2026 at 11:52:26PM +0800, Runyu Xiao wrote:
> Several nvmet paths need to identify configfs-backed resolved paths while
> already running under configfs callbacks. Keep the classification in
> configfs itself so callers can reuse the filesystem-type test instead of
> open-coding string comparisons.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


