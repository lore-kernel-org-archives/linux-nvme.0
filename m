Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C03C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgptRwxvGDPBTiM4EXqiBw6C4HDyRkpaiwtvF9ovYKA=; b=xNJRJn1BjLdOJM09VZpxbHWWE/
	z8nyqv92hF/75f90yd6MhVAY+IYxRTUOfJqZir5EunMeR5G79pfpAG+Mtel6f0PYTvD2dJEPVJ1R7
	+TWrAN4akUVpMbYLkH9X03AOnKbj/KQHkz8TjAWdpo8vDcRw59pNK8E1O1sj8zlqPhypBlgtbaJrA
	awOSlpM//dUNS0xIFsDc1vGP0OAbbyo70ydfLE5yJ7fIbhR0tOrEPuKa462D9dedsVHZozQRcT/hJ
	UGls8v4bkA6ZxeYkf7s6Rvn7XCoCPSbYX0Lg94Q4D02uEmaazEyv5cYcaXYUB7cTsuF0wEglomieV
	/ZXd6vAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiJ2-00000001B1u-22Ig;
	Thu, 09 Jul 2026 06:32:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whiIz-00000001B0n-38Dx
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:32:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1374368BFE; Thu,  9 Jul 2026 08:32:15 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:32:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 12/18] nvme: add context annotations for
 nvme_queue::sq_lock
Message-ID: <20260709063214.GF18056@lst.de>
References: <20260706141452.3008233-1-nilay@linux.ibm.com> <20260706141452.3008233-13-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706141452.3008233-13-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_233217_937402_2D09E92A 
X-CRM114-Status: GOOD (  10.27  )
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

On Mon, Jul 06, 2026 at 07:44:14PM +0530, Nilay Shroff wrote:
> +	/* Initialize unpublished lock-guarded variables. */
> +	context_unsafe(
> +		nvmeq->sq_tail = 0;
> +		nvmeq->last_sq_tail = 0;
> +	);

We'll still need to find a way to avoid this mess..


