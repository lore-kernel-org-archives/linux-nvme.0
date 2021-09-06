Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40FFC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:02:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD1A60F43
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AD1A60F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vggKL16zCKapHH/vBonzI7RrcxFC90g55JMtR+ypI+E=; b=Aey8rA3c3HblOY
	tEzD7u9v/kIxxqyLu9EC9bLy1yMM/+Rzjmo9PLf/CbCmAh5wqBPXE7i7SrQukWfz5pFUwWfZf16Wo
	ZOcTHddzh7korhZOcP7XDzDOsSvVh62qzxNxkM5aVRBT0lrb2aPq4AWLfdyOiKcfPidMICcKcMuKB
	a6KQmP3/7fMX5dR6IqSskR3o+X0I5M/4DbfyguX1I1Qsv21QpPaeyRHaKMDjYPoY7pKZXkZl901Jj
	ZV2tm2dWw8nNl/n15xRetrx32Lfr4vszknGUymYGcRe/Sc82X4bC97feJ7FUg7XHuHOBlGxnpwyVc
	nKB+0pdqqOWk9nKrHeHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN9Zi-0008u0-Vj; Mon, 06 Sep 2021 08:01:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN9Za-0008rc-PN
 for linux-nvme@bombadil.infradead.org; Mon, 06 Sep 2021 08:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Yhsez13STG6J7J5L5MmBsOcg+6XZ1TXjQyFULBqbcS8=; b=sCrmIiylKZYgWkzKln9qGYnOzD
 /Yv1Emgf2N7ikulvlwJqmJAgnPW0qX5cKZizUWsbZnGK4xghYYLwrgdWKaeWTGoCb9tRVOgo/AeQL
 nh9ElVx6A4VZ7V+fVFA/UPbXUfqfNnOWWr+3ncZKEu2a0pWFoMq0gkGSCdoRJcDE8QwtF4NhSEWZm
 +SqN+gfLXmhxOASmtT1c2PLrzaqAdJ9m7v/qbzsAzSvXIC7RBqxnzDMCRbveAtam32j5Zz5YtCZ35
 WPcRCatziGk8y4b4K9+b3s8pHfb6h/eSBSxe/N0wW22HSGQ9YTFy9dAVPoE6a5c+Ln6XhvF8AdhGl
 7efr9jnQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mN9Yu-006kyn-Cp; Mon, 06 Sep 2021 08:01:12 +0000
Date: Mon, 6 Sep 2021 09:01:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <YTXKwOvCtJOHnhpu@infradead.org>
References: <20210902092002.67614-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210902092002.67614-1-dwagner@suse.de>
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

On Thu, Sep 02, 2021 at 11:20:02AM +0200, Daniel Wagner wrote:
> When we remove the siblings entry, we update ns->head->list, hence we
> can't separate the removal and test for being empty. They have to be
> in the same critical section to avoid a race.
> 
> To avoid breaking the refcounting imbalance again, add a list empty
> check to nvme_find_ns_head.

Hannes, can you look over this and run your tests on it?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
