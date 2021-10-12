Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75434C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D8060E05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34D8060E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4yE1SuF/vp7/Dm0i7QrvbhVyf5odGa8wqCEqgqI+scU=; b=W0SGy3zbHyomUu
	cCc0m75Lt0qJAGk66QnuDdrNWjvl1c4DHdUbpFlQ9ecbAaSgb2XSR01IP/T1tMUFRa1wKijSa8AD4
	qMmQu5ImKh91GIlC6Q2RFUiPw4lMUUY7tbMgmJpGTpraYYkNAnhSnP1rcUpefT5ZNLEGpiKLLpprR
	Rxmm10806TUB9g7KzVFztfI62uHlF/DjQQJ/5rXtqjKiZpvsVIeMGRStiqiT2rOiIJn6DhEeKoZ9R
	x7EWObdxuW7+hrwGFSyTfLIy6riYSPC+FU07Lf/QlrzIK6oOa7HLlhIOg0Rc+uwWhkd/2HYChuK1o
	Bs7DoCEYcD3JkPC/jMgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJTr-00DK1h-MN; Tue, 12 Oct 2021 15:14:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJTo-00DJzT-Vg
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634051651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xvN2vLxgg7nr/3sm0rZxnDgmYjVBd3T2S4YxkSk3YY=;
 b=JHjUJIvpgbpLyuBTHpojPp9hgsXU0/aLpFJyjqxPrrM6+M9tFUCnsMebuMgo8GzlTK3ueg
 j6SeShZ0VlVSJYXm+onlqSELDI46y7tr/9Jt+qv8Y5KzVKV++jZkhmNtMjWpmd3fg7IhLX
 gS5SfOMYcaffrR6kPoTqeCr+eWB0Whw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-i9Dvu8TpNbmzFE8yTvmj4A-1; Tue, 12 Oct 2021 11:14:08 -0400
X-MC-Unique: i9Dvu8TpNbmzFE8yTvmj4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9719B112A0A0;
 Tue, 12 Oct 2021 15:14:06 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC0F196FA;
 Tue, 12 Oct 2021 15:14:01 +0000 (UTC)
Date: Tue, 12 Oct 2021 23:13:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <YWWmNMNKEUtBI1EH@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
 <20211012103010.GA29640@lst.de> <YWWki6An1sOpx3rV@T590>
 <20211012150827.GB20571@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012150827.GB20571@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_081413_121290_B146FD06 
X-CRM114-Status: GOOD (  17.24  )
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

On Tue, Oct 12, 2021 at 05:08:27PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 11:06:51PM +0800, Ming Lei wrote:
> > > We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> > > at ->quiesce_depth directly.
> > 
> > I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
> > path.
> 
> Checking an integer vs checking a bit is easier actually faster or at
> least the same speed depending on the architecture / micro architecture.

->queue_flag is always hot, but quiesce_depth can't be and shouldn't be
since it is used very less.


-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
