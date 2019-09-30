Return-Path: <SRS0=mwZ5=XZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E46C32792
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 20:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA11C205F4
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2019 20:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rsX8S8f9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA11C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e+hJoauwjC06HWhbI+47tCM5X4eYNzHF7zdS2mnXw3s=; b=rsX8S8f9a63MZq
	MnxJXAqPV8bMjCzoUhuKhpSb81kLjDg90suZdHI5+OQTehS5AgVSuwwqfjhOK8YeqyI4Ali5qgw2j
	z9ehYl9hXywG3PwjKCk+pkRgD2S1buiBvvhcS17R18bnviK23vNcv2k1apbAZCq7B64OVfkvz2fEl
	Y9nB9yAbIeE5Z1n2UzvyErDnEta1COl8rnDycXVlSo41n/4GSBfF04Vya46Tct1tVqGsOT86RhlGz
	fCMI/U4OB20CFaiJ5J/RCihOfLsCyW5vn1kJWUZRK+T2KfZxaQDO0MiNKbEQRlwAPkkPLvqFVYQB6
	KUvHmCc9bUyCcFgo/EzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iF230-0008Tw-Nn; Mon, 30 Sep 2019 20:13:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iF22x-0008TK-1D
 for linux-nvme@lists.infradead.org; Mon, 30 Sep 2019 20:13:28 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB3933082231;
 Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18B5A60F80;
 Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
Date: Mon, 30 Sep 2019 16:13:24 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/1] blk-mq: Inline request status checkers
Message-ID: <20190930201324.GA19526@redhat.com>
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
 <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190930_131327_094110_49B20319 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-nvme@lists.infradead.org,
 "Pavel Begunkov \(Silence\)" <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 nbd@other.debian.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 30 2019 at  3:53pm -0400,
Bart Van Assche <bvanassche@acm.org> wrote:

> On 9/30/19 12:43 PM, Pavel Begunkov (Silence) wrote:
> > @@ -282,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  	 * test and set the bit before assining ->rqs[].
> >  	 */
> >  	rq = tags->rqs[bitnr];
> > -	if (rq && blk_mq_request_started(rq))
> > +	if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
> >  		return iter_data->fn(rq, iter_data->data, reserved);
> >  
> >  	return true>
> > @@ -360,7 +360,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
> >  {
> >  	unsigned *count = data;
> >  
> > -	if (blk_mq_request_completed(rq))
> > +	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
> >  		(*count)++;
> >  	return true;
> >  }
> 
> Changes like the above significantly reduce readability of the code in
> the block layer core. I don't like this. I think this patch is a step
> backwards instead of a step forwards.

I agree, not helpful.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
