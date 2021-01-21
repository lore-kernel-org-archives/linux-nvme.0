Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:05:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7080D23A54
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7080D23A54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZIouOlDNwlHgy1FfuMksIDgcnphjrvMsrblTNNY3lF0=; b=WUMzuUN+oEIAmcpqJTcT98E4p
	pXKmzzkWjhwprCw6oBkgsryutpuDjq5qS3HPtavF89lSATplA75tEIKVaRul2YOXx50TpEY+mBES4
	DZt6dzKtQSKQY+gRZCm7pZ48X/2PjVqOp91+jTZ69OEOvNb6fWyJbp/bK63BSZNhtAr2+n/q4RKqq
	OhPJtDl9JozzO9i9ZfOyxcWAUqTc/aWNYEgxgwd0iGk4WSPFyL9ZHXuTC8jnVzARXw/mAmfU/W9MF
	zbs2AK8QNtlQdtpv85pqj8y1IJMsMnl4ZQMCF5IwM4dEhHLz8UHIezqkcAepun+KBXEruOICk2cj3
	Qn3300jyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2dO7-000877-6z; Thu, 21 Jan 2021 17:04:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2dO5-00086t-Jb
 for linux-nvme@merlin.infradead.org; Thu, 21 Jan 2021 17:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WXp9P2+4ttOF7WOJ6N6+oYIjL/n1xFJfDmqOtrJBLpU=; b=gd4BKa4iFPPuT/lD2l4BSb7o3D
 CcZwhIeTFXpXFqJD7zm1KvhSW779Tw+VeuicSpzqOYgmQKe4y9bE4q0XwrV2FsRd0k3PdBFb+bpW/
 /RQs1TEqLYPidsbGr4wAwL0sHpKJEn9FCbbWRyhRHuoVk0i8QSB3Imxpsokzc9D3i8gabl7lj5xpS
 le/fJd0Q0THs9DBKuCcPcXJ4dZYELr7B/+V5dHjXnOgJjAHd+4JqUCv/DNHbG0Ng2PVhcxqxNrhGg
 e1ahOjpwMV0H6IKQqoBM0no7vfgQSDJsKHdBSL6kx7XXLhD8nhdOpQ3cL9dT1JDTT5SYOU8uSpxtx
 fdX0PhQg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l2dNh-00HIE9-Vn; Thu, 21 Jan 2021 17:04:26 +0000
Date: Thu, 21 Jan 2021 17:04:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH 2/2] block: remove unnecessary argument from blk_execute_rq
Message-ID: <20210121170425.GB4120717@infradead.org>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-3-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121142905.13089-3-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 21, 2021 at 03:29:05PM +0100, Guoqing Jiang wrote:
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.

Same trivial nits as for the other one.

Otherwise this looks good to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
