Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3DAC3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F4123400
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iQ5UDQWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F4123400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FX/UbbkzeC6rzwcTxDtL2OaFCLl5MPl+EOtnSK8XsaM=; b=iQ5UDQWjh0f8+i
	GP55bo1yP9NwEdhtGZTaP9pkKGt5VOh4+VxQNXhP0odTqS3oEI4vxlcL0t3imrc3n4eF2pPAcydbq
	Q0oaPKoZrFtCa7sLgFgDM+VdyvAhw5XLCv9klv6XtUckTdBJ3GCPtvY4+XCsUAV9y6Rwz2LTcDoZY
	ei3QE7yU3q254Ca96ru5RQ6hVM8YagiQuEfPwL5TcuqCpZAL0V2baRRqEs5EyOUrWO0pXRMhnVKSf
	NrWNdRUC6scbFdC+d9Jlxinf4X0nlaqWS2lRBFlwG3GHo7zYOGDcUa17l2qB0oe8v75IOs7Gc9FkY
	f8Ik2UJXs0o57qVZ1EKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5OBC-0007jg-AU; Wed, 04 Sep 2019 05:50:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5OB8-00074I-DZ
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 05:50:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69660227A8A; Wed,  4 Sep 2019 07:49:56 +0200 (CEST)
Date: Wed, 4 Sep 2019 07:49:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
Message-ID: <20190904054956.GA10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
 <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_225002_643152_8407BE15 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: keith.busch@intel.com, Sagi Grimberg <sagi@grimberg.me>,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com, Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 01:21:59PM -0600, Jens Axboe wrote:
> On 9/3/19 1:11 PM, Sagi Grimberg wrote:
> > 
> >> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> >> +	    error == BLK_STS_OK)
> >> +		t10_pi_complete(req,
> >> +				nr_bytes / queue_logical_block_size(req->q));
> >> +
> > 
> > div in this path? better to use  >> ilog2(block_size).
> > 
> > Also, would be better to have a wrapper in place like:
> > 
> > static inline unsigned short blk_integrity_interval(struct request *rq)
> > {
> > 	return queue_logical_block_size(rq->q);
> > }
> 
> If it's a hot path thing that matters, I'd strongly suggest to add
> a queue block size shift instead.

Make that a protection_interval_shift, please.  While that currently
is the same as the logical block size the concepts are a little
different, and that makes it clear.  Except for that this patch looks
very nice to me, it is great to avoid having drivers to deal with the
PI remapping.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
