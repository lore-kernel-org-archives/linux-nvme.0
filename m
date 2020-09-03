Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD09C433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:23:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ACE20775
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jwTo44EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ACE20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vW9YBtKgZDr7zUcxZtpU4O5i6jGFXil8a1Cu0iPOSU=; b=jwTo44EIo6hTA25iK5ViEs5ZP
	LhkQbPiuRO+vi0y/7cnho49DLWUhfi+bUJEU5c8ch2ZbL5LCYsrncjWRWfd4tadbK9a6s/Oh00gbe
	rlLOMpL2182/fuDJVbHrKszg73+Biz1ewlO9sf8XTNqA6I3bxxq3zpx5agNcXA1Qf/M38DHQYWcRZ
	UiGsXYd1l1OC7v4qRf+g49JlXKDmccboEcNkw3B+WZzsq1RrXnTypYydd5ukyfPonE2VLx7P/0V0p
	gXEfT3R/cRqEjTBzs/BHKrFXLjbBkNngycNHEKVSj7L9cZgBfnZjYWiItyxPXj2udnkVyKdIglvzI
	Em1ZYk8Ew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDs14-00075G-7a; Thu, 03 Sep 2020 16:23:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDs10-00073c-S6
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 16:23:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3B1D568CEC; Thu,  3 Sep 2020 18:23:09 +0200 (CEST)
Date: Thu, 3 Sep 2020 18:23:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 11/12] nvmet: use minimized version of blk_rq_append_bio
Message-ID: <20200903162308.GF25423@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-12-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831222707.35611-12-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_122311_042042_B0447D6E 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 03:27:06PM -0700, Chaitanya Kulkarni wrote:
> The function blk_rq_append_bio() is a genereric API written for all
> types driver (having bounce buffers) and different context (where
> request is already having a bio i.e. rq->bio != NULL).
> 
> It does mainly three things: calculating the segments, bounce queue and
> if req->bio == NULL call blk_rq_bio_prep() or handle low level merge()
> case.
> 
> The NVMe PCIe driver does not use the queue bounce mechanism. In order
> to find this out for each request processing in the passthru
> blk_rq_append_bio() does extra work in the fast path for each request.

We need to be able to deal with all transport drivers.  None of them
uses bounce buffering, but the changelog needs to be correct.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
