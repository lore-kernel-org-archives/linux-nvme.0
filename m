Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C4BC61DD8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C73B221FD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RoVJQ23U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C73B221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ac1ra0UgAOBeDpJFw9WUmAZd5FUQwj637YFn7ICp73Q=; b=RoVJQ23UDMIYgQtHXdKYlYBjm
	iQTL/fwynAoVqzce5LccB5pgH6RUzLtmSV3MLmxMvxosuKueoj3pquWeOQWy5pRpHy39RU6M5tpnr
	vKwqXdFmUBCa+6NFzqsNZftTqHISfVHV134BLme4YNvcASKa9sIMXFzgQDFtN3vrCJ/q9n+NFzWDy
	GUCwLg2VNbH920OVJDOeEMoKyZ+0ax7AHv3sYBs3TMA8W2da2BAip44+LDFv3URCKYfYs/nMLYsap
	6n6fK3Nv+dHLbXkiBcU0gq3PaBaYf6Ljsw3+gDwptUgcwOiVdPVB2gWMgswiPiL9NTR+B8iyNpxBv
	p1uhzhoOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keiHS-0008UB-NN; Mon, 16 Nov 2020 17:27:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keiHP-0008Sv-GQ
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 17:27:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A1A46736F; Mon, 16 Nov 2020 18:26:58 +0100 (CET)
Date: Mon, 16 Nov 2020 18:26:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Message-ID: <20201116172658.GJ22007@lst.de>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_122703_692942_FEAB67EB 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Qian Cai <cai@redhat.com>, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 linux-block@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> flush_end_io() may be called recursively from some driver, such as
> nvme-loop, so lockdep may complain 'possible recursive locking'.
> Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> request queue flushing") tried to address this issue by assigning
> dynamically allocated per-flush-queue lock class. This solution
> adds synchronize_rcu() for each hctx's release handler, and causes
> horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> 
> Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> we just need to use driver specific lock class for avoiding the
> lockdep warning of 'possible recursive locking'.

I'd turn this into an inline function to avoid the (although very
minimal) cost when LOCKDEP is not enabled.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
