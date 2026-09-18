Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7219CC982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djdRHiwxqrCnAdeShcd1OdZPd6PKGm4408SCT9wbp1w=; b=eOK1TwFvET3sPXowq2guvWJkqb
	IdOXNWhxRgujsbQaeFJkfZl5w3so5NFYqSVlgS11UXXJKAYpuS+1NBJZXrIzZ1PMRX06HE6rYT00h
	qWmni8QTC7i6ldbE81mQSzOTKBG2q+hHPr5UsrMDJAgX4sWNSRpvd7CeajQkb1rQsZmQDo4pXRB8X
	EJzafmaL75fnak0gFUKVT6qIwEmO0BH/BzyIOFeWnZTwP7QA+F++cz/BnPS8ImXPX7BrU5pQxr1Lx
	AExp0oBlVRwaZOnz5J9km1u9H6mxi5zT5ZEIhVLsDsMucXqffZknWFMZGcqq4M8v/Fi8W+jzpbmkZ
	SMI6I9WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7YbM-0000000EVL4-2gDq;
	Fri, 18 Sep 2026 13:26:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7YbK-0000000EVKN-12TT
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 13:26:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EB3E68BEB; Fri, 18 Sep 2026 15:25:56 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:25:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] nvme-multipath: expose path_state via sysfs
Message-ID: <20260918132555.GA17993@lst.de>
References: <20260724090004.1146014-1-kanie@linux.alibaba.com> <097fa1af-41eb-461b-873e-b5f27e1ae872@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097fa1af-41eb-461b-873e-b5f27e1ae872@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_062602_429187_C8E6BAA5 
X-CRM114-Status: GOOD (  11.15  )
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

On Mon, Sep 07, 2026 at 10:15:24AM +0800, Guixin Liu wrote:
> Hi, any comments here?

Looks good to me.  I'd probably merge both patches into one, though.


