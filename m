Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E23C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5862E208C7
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 16:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z4b9cMIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5862E208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LCInm7UVWxwJCquAuBpMGhMQVfUPIfD/l8T45x++YMc=; b=Z4b9cMIHsrqH6l
	VP30ZUF7VHcKJYj5fVvWA1B8VcCEdMW3+3vUfXGOYCv9Lvuj/ZhvG5QmFIy68MGRNcgLR5A6Y234Q
	ITj9myZdfsqjcByf77lZsLa7Cm+qoDr6HCqx1o8k2Xwd9Gc9JkDqSG60hUAoJgpCDpe2qZh8y1n9P
	e4M6YQA61h64uXxiccqWG5Vfu6/SIAkdPYALEIVLC+yYR10omnLj3CWBqpv71JgafSosN4qu6IkDx
	0rNaE26NGQKnTdJ7zNGR7qeJ+m5a9BS+4WjQ/fhTR/hkppaa4MwkpgeKULt5xR68I5PCr6e0B+/k5
	moVnjfsADgzKb+iPz3Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlxZH-0003kv-U2; Thu, 18 Jun 2020 16:39:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlxZF-0003h3-K3
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 16:39:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 98088ABCE;
 Thu, 18 Jun 2020 16:39:07 +0000 (UTC)
Date: Thu, 18 Jun 2020 18:39:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/12] blk-mq: add a new blk_mq_complete_request_remote API
Message-ID: <20200618163907.e43oml4dvvix6eko@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-11-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_093909_805373_17C14A2B 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 11, 2020 at 08:44:50AM +0200, Christoph Hellwig wrote:
> This is a variant of blk_mq_complete_request_remote that only completes
> the request if it needs to be bounced to another CPU or a softirq.  If
> the request can be completed locally the function returns false and lets
> the driver complete it without requring and indirect function call.

s/requring/requiring/

> Suggestions for a better name welcome.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
