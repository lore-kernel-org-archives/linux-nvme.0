Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E49EA4FBE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxSBdU9Y5seomme4qUEWPMhyvchV2ptAxVmy1iF35GE=; b=WVsI3XSKxlmaa5NTRFKX3hPqMw
	h056BGRj3fco71R31twSP0m3qhjcm0GFLcp7cEah7XyJqPeuWZou+rcSVhh5GxgDv3mMfIwNp2Uhq
	EfLyZGLSqheSQ/2BhW+oK799kZoMaMhC3UkKDVqNzQji+m/aMEXczezrm0uP1r8HOKLDYLji8mRjc
	sppk6M6S2yfjLk+skGI2TJV+kS/kX5WH933shpG7LjJWrKy0pIesSFaOivTQ5AVzMJR+5p0S+uqKJ
	zcnYDiX+t488TnE+kO5Fj0TwyCAghHNlCBqc6ztCwcmdq7xRR+z1dmNuyx5HXRhyVtDBrZGZZsOsF
	OJVgDpTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuWBT-00000000OXj-31HY;
	Mon, 23 Feb 2026 13:41:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuWBR-00000000OXJ-1WZf
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 13:41:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF12568AFE; Mon, 23 Feb 2026 14:41:04 +0100 (CET)
Date: Mon, 23 Feb 2026 14:41:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH] nvme: fix memory allocator in nvme_pr_read_keys()
Message-ID: <20260223134104.GA15458@lst.de>
References: <20260216003541.161806-2-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216003541.161806-2-iam@sung-woo.kim>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_054109_543913_95CBB9CC 
X-CRM114-Status: GOOD (  12.49  )
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

s/allocator/allocation/ in the subject.

> -	rse = kzalloc(rse_len, GFP_KERNEL);
> +	rse = kvzalloc(rse_len, GFP_KERNEL);

You'll also need it to free it using kvfree if you you use kvzalloc.

We might also want to add some upper bound to the number of keys
to not allow the user to allocate 4GB of pinned kernel memory.


