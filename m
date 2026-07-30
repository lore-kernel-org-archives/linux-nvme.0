Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB213C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rsel0yr65AVDeCmOJU6JZvZI0mYsQS045jYToDvg6fw=; b=wMJzbcU+b11ZSk7DzpG28Ph0ur
	HSKAqms6M4xSkUII7D9weT8z16arWoPwSRsBT6rTDDu2ljBe5PUsRhuMrIrdTsPzxZidwSZ11p3OG
	8rVbOruABi6WLo3f9kY8KzhrLbZXFzhMYz3ycx/uvzm2F1ADhT4fZyh/f0r3+F8BWQBlaUSMye0B3
	Dhz7KKnZNfNH0SagZxs3yMXhZRW7NVkd+T5kovUfJGkwCZ2poGBXhFra130Z6zMKnjL6LcXWGQB4P
	H1Og2A8tkbo7EmSZ3ulVQPfAIh4SOyf3hUIWCIBf82tUqSHZjTVNEY+0JSUV98ZU8UQ4WW4CYuDK6
	YwH/vt0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP1v-0000000AMDL-0EbB;
	Thu, 30 Jul 2026 11:34:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP1s-0000000AMCw-1kJX
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:34:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA53068C4E; Thu, 30 Jul 2026 13:34:17 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:34:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
Message-ID: <20260730113417.GA25454@lst.de>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com> <20260730043105.3071328-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730043105.3071328-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_043424_606017_5C09AC36 
X-CRM114-Status: GOOD (  14.03  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Thu, Jul 30, 2026 at 12:31:02PM +0800, Guixin Liu wrote:
> When a host issues an Identify command with CNS 07h (Active Namespace ID
> List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
> called with match_css set. The command-set filter dereferences req->ns,
> but this handler never calls nvmet_req_find_ns(), so req->ns is always
> NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
> namespace with an NSID greater than the requested value exists,
> req->ns->csi dereferences a NULL pointer and oopses.

Can you submit a testcase for that to blktests?


