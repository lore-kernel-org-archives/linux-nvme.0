Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641DCD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tNYYrDuDMyYFDD0FDG/x48ay54+ujRwvxoRBAIfdcdA=; b=KC6M01BIZUyuj4cJ4IxEtuX56Y
	YOX00JFNKKVEn0XajXf30AUAgW3gv2syQ+bF9L2A25IgyOOv7wFIMLe+HInKr87kh/5vbV3Tv4CsA
	HLRpV46oraV93Tls0h1t53DBek/DHdh6sQ91bGobYdW48pbJG+0U56CxgODFVSXDju98zN8v7Z0Jo
	xJ5x8fQj6OQ967LREkbg192VxoHnJYRYmQj3vPWNa8wuivnWuGBWX6bMH5Km1rZfINgilA0XhHqWV
	qMONeWVnCj1pb5N2V/L+fpadL5X8qs+wBL0MJJlD61kINuFil7gR+KGqyhcdjl8i9X1PHiHzECvIP
	bHnHIXIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0La-0000000AcYP-1qDG;
	Fri, 26 Jun 2026 06:47:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0LX-0000000AcXs-35Lt
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:47:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5199B68B05; Fri, 26 Jun 2026 08:47:22 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:47:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 11/17] nvme: add Clang context annotations for
 nvme_queue::sq_lock
Message-ID: <20260626064721.GA11106@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-12-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-12-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234727_924736_8751A326 
X-CRM114-Status: GOOD (  13.35  )
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

On Sun, Jun 14, 2026 at 06:45:26PM +0530, Nilay Shroff wrote:
> Accesses to sq_tail used solely for tracing are annotated with
> context_unsafe(), as they only require a lockless snapshot of the
> value. Likewise, nvme_init_queue() and nvme_free_queue() operate on
> queues that have not yet been published or are no longer reachable,
> and therefore do not require sq_lock protection. Similarly,
> nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for
> the queue which is not yet published or in use and hence it's safe
> to annotate all these helpers using context_unsafe.

Accessing scalar fields without lock is pretty common.  Don't we
have an annotation that only requires the guarding lock for
writes?


