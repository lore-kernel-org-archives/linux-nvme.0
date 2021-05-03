Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7BCC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:54:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9789B61244
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9789B61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G1akJL7Dpt/D9de6txCwnic7XcPvPGEOv0PTPEtDMdA=; b=PzY/7auL2wMbaBehGChmWdgOG
	IhrI/ldbOOqBgMvFVOjFq/sqwmbxub9ZISo/98JWPe6zumz5Lgw/jIBk89wwyDIIITGoC1P8GmPrp
	cre1LRSXfRK/RHI5UDwz0A/o7GJOZV/PGsNvwxzCekSuSVH0jhkrweXBtuycv0omgoKz0DhJlsH/2
	mw9XZ/u1EE09bblINW8D8n7bGvYfzlhRGJ3soKh+IIC/DEzi3wJfumJ73bcinJNuUvWTq9vNc/6ah
	Vk5bCumv/0nacwCvljup8N1OyvGUqUWzAH/H0Z+NIk5Srejif1TQLWajjcNqLubIMX5zZWrAPBJQj
	hNAsb5/RA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldatU-00EJ4A-L2; Mon, 03 May 2021 15:54:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldatR-00EJ3A-QT
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=6p5oZbkhtk5XknkAiA5IrgGZY9W2Qnms+dn7b9vj9jY=; b=t1qau4xMkpNp32ct5Iap1DlZN5
 n4G6pQlO/FgCx3cDE2g9mTJhPhPfMQkmyMFKTS1i/G5kgtsUEGPZiWXpXQV5B5zvQihBRAV/GzAqV
 kidvNKcb7HdYXoD66yS+GKmRyaQxLEBCKtOiPKnDaTWvqPxopZZgzlFvq40YG6DXAr30e0FWZmg5C
 UWTkzvKFkDOTYq3cyypE/uYgsulrPl49jfjfkg2cqRhIutuXFmPb9ufDx9VyysoNmR3vHhkMhIvOi
 p5bk97weQYdpOH94QOW8olKgXI8LbVUDLXrREUvrvEMTwgktYGzRbOwun6dfgC/CwEMz3hn8KAjYc
 VYe2Mrsw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldatO-003CfK-US
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:53:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D5AA68BEB; Mon,  3 May 2021 17:53:45 +0200 (CEST)
Date: Mon, 3 May 2021 17:53:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: Reset bi_disk to ns head when failover
Message-ID: <20210503155345.GA5342@lst.de>
References: <20210503125741.68117-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210503125741.68117-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_085355_149143_A4F87B06 
X-CRM114-Status: GOOD (  16.83  )
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

On Mon, May 03, 2021 at 02:57:41PM +0200, Daniel Wagner wrote:
> The path can be stale when we failover. If we don't reset the bdev to
> the ns head and the I/O finally completes in end_io() it will triggers
> a crash. By resetting the to ns head disk so that the submit path can
> map the request to an active path.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> The patch is against nvme-5.13.

There is no bi_disk in nvme-5.13, but fortunately that slipped in only
in the subject.

> +	bdev = bdget_disk(ns->head->disk, 0);

Please just use ns->head->disk->part0 directly.  No need for the
reference and bdget_disk is about to go away.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
