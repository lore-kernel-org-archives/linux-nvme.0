Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB732C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 07:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7436B6127B
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 07:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7436B6127B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7cR13GJ8+XD/9uzjEMFWK3LZDRae/L3AKC11WbU4bOI=; b=3b4hluOEzvrx53
	IkCzHa8rOkzKFp0WS/9pYmxmQUgeSeGVYWeURaDeI8p/gj8Fj3RJ3LHGuIpQXGCNxlq1PFEcm0lNp
	VvFLU7Pux/BNdZ0Erw9DCtbrfNCPqYqs2DZjhaCbtYz5JDGS/r/0HAkJeX5bzjwyq/Eic8/dD2FJP
	4m10rJLEx+l6FT9F/QiRsZ1ajYKe9YqdEfqFwql3vUnqCJRG1gAz7CTUJ8mPshdYKWVfjMaFeQrWh
	zkjHiEFnZMqGdPV+jUG8poSYHnzfW7HBpzNPiN+fyC71xbvvEYKXjOg1vihj6IXxHP0/Ks2VRsTZ+
	nqLoQHOg2FQcpzXPH9rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mInH4-005nlS-U5; Wed, 25 Aug 2021 07:24:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mInH4-005nlB-6R
 for linux-nvme@bombadil.infradead.org; Wed, 25 Aug 2021 07:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kXhulwCsHpOwdnbocHy5ZJeMGvemrXslAdvnV0AL1CE=; b=f4Jr6paYDUsArFWQQeaso3Ly2j
 LKkz88V7T/pCM2TPUFD3hHHQSro50JZG4JWT90ArEdwC3WBQMNfurEvWZtbaqUGa4TZgWViIelpsc
 Tt0/qc3P1xWUfuEFNgmdoj/39nGvok9uUtlSpGz0/CHIe9SAh4qvCph8HJa3rQ2RYIex04n/y1gPj
 7jIjP80+6F1ieWLYEs8Bkv+uHWi1Bc86YzCMSZtg3exrgBU9oPsDlc5BvQCcV2Sbty91b9aT5OSFS
 8NjVzZuIrAql6ExgG0XRVUDeweLaFj2WXyBCCHMMoqwlgXW2Ap01sB7DOIXbOjk5oZV6WLke7/E7T
 UmEZWQ0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mInFo-00C1Eh-F1; Wed, 25 Aug 2021 07:23:41 +0000
Date: Wed, 25 Aug 2021 08:23:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvme-multipath: revalidate paths during rescan
Message-ID: <YSXv6E7vIQ+UdMBp@infradead.org>
References: <20210824145742.94212-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210824145742.94212-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've replaced the version in nvme-5.15 with this one.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: - introduce NVME_NS_READY flag instead of NVME_NS_INVALIDATE
>           - use 'revalidate' instead of 'invalidate' which
> 	    follows the zoned device code path.
> 	  - clear NVME_NS_READY before clearing current_path]
> Tested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

I've dropped the Tested-by here - the tag is for people not in the
signoff chain.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
