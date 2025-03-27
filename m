Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC30C3600C
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IS6W6cH3POj/0Rmb94pGgFe3/Y46U3LwABUo9vfWCOw=; b=0rC5s2rWcgu/+r0wD2ZxefEaxy
	VA3ACIPStc2XxR0gv20TwROSSS2JpOjurjVwuJyhJ/E4Djbqly9SuMtQqFium7yi4JiHiJ9OSwpM7
	qHFT9W+n5y3Gbkcla2w8GYp/hXUw99beOc3vLVjIrJMmZKRIg9nluRWfHbzGPnFMQqA20UtJWBwdg
	rFVdnEfTnRdb4DIlEvFl7ekCue+1rh8O6dniDiu8nHA8z5bX5gPZ7o30NMq3g7ZJ+gJTqGdp/egEf
	fDvzG0lapF3311b5DRti9XoOs695sUF8xUxGCcs8BrqnLvcYOp3/MprBzvT6mJphrFcAAQWvqo23i
	Sw1ZOdGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkh7-0000000AjFy-3chZ;
	Thu, 27 Mar 2025 10:42:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkh6-0000000AjFH-0XcA
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 10:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17E7568C4E; Thu, 27 Mar 2025 11:42:33 +0100 (CET)
Date: Thu, 27 Mar 2025 11:42:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nvme/ioctl: don't call blk_mq_free_request() in
 nvme_map_user_request()
Message-ID: <20250327104232.GB10068@lst.de>
References: <20250321205722.3947901-1-csander@purestorage.com> <20250321205722.3947901-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321205722.3947901-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_034240_313393_E05CA0BA 
X-CRM114-Status: GOOD (  11.90  )
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

On Fri, Mar 21, 2025 at 02:57:21PM -0600, Caleb Sander Mateos wrote:
>  	ret = nvme_execute_rq(req, false);
>  	if (result)
>  		*result = le64_to_cpu(nvme_req(req)->result.u64);
>  	if (bio)
>  		blk_rq_unmap_user(bio);
> -	blk_mq_free_request(req);
>  
>  	if (effects)
>  		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
>  
> +out_free_req:
> +	blk_mq_free_request(req);

We'll want the request freed before nvme_passthru_end here to avoid
deadlocks with namespaces scanning.


