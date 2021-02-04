Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B00AC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:30:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D249464DF5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D249464DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tH9bWKcC+HhWnJspcV5iMhG23shMT5cebDFY0FViLjw=; b=SCcn1sKOsrabU7jMqTIrnoOjG
	3h3TToG/7n6tUBytowy1FopbQbfg196M7rrB50/TF7DDTykiCXK9BlRKPtPJyANTsgCJbk8VsAlzt
	m1S8u5RhOkbs+TUbKTst/bozqmeBFG5gmhLKUOYzK11y2Ar4kxI5wAdAEuXHYns9yNC/BDBjuW10W
	DXqTWbx/kQVeHHrf18vcrkZq9XC9/d75UaEh3M+4dMkhlyfSkQ2tYGkIMDhgOIfeEZo0QzOWcp2d3
	Nt5h4i53IUip05+n5ZgHw/Ys0uYmwIxddzbhNGV+dXMrGWKK/dCVoptOn3dC8BQiD8f26g9pbh3L6
	vfwWxv6bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7gaN-0003Ar-UI; Thu, 04 Feb 2021 15:30:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gaL-0003A1-HA
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 15:30:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 105EB6736F; Thu,  4 Feb 2021 16:30:15 +0100 (CET)
Date: Thu, 4 Feb 2021 16:30:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210204153014.GA29736@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210201034940.18891-2-lengchao@huawei.com>
 <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_103021_696851_0AC8A581 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 08:27:46AM -0700, Jens Axboe wrote:
> On 1/31/21 8:49 PM, Chao Leng wrote:
> > nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
> > directly complete request in queue_rq.
> > So add blk_mq_set_request_complete.
> 
> This is a bit iffy, but looks ok for the intended use case. We just have
> to be careful NOT to add frivolous users of it...

Yes, that is my main issue with it.  The current use case looks fine,
but I suspect every time someone else uses it it's probly going to be
as misuse.  I've applied this to nvme-5.12 with the rest of the patches,
it should be on its way to you soon.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
