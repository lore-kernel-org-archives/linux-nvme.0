Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD0BC433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 01:19:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A8B216C4
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 01:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bFX5hTzG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJq9fp+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A8B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j6f5/MzUydzn8Ul7V/eKS1HFr9FgY6NfgMRIpDnD/j0=; b=bFX5hTzGJFovI3TvH+CpnXfkz
	4BhZaziro4I4Fw4ZQXsLKWWaYa7TYwnHTq6EgjwXhpvx6615cbcRVr3653RHX8jTKUVfW1VOXdtJM
	96rHL0Kh+iMa99ssMMti5pCbd5pzmQUL3y+AF2Ow6vgqdUFjV5KF2yFHRfHH/d7iiyROjPywSsQQl
	i1TAff5xba+cq9X3M9fnrWw26oJBllA4d0/DjOsFARym2lHliZBVPSUMTPba4kYzo5oqElG1/bbTN
	fg1Ehrw1nyRCmyRCZniDSjbrSDC7vW7/UszHz9QAgO+9kawkoNed4LyVUJ1AXruxGuuQq0eVu0suJ
	MwD1cy8HQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFolt-0004WV-5u; Wed, 09 Sep 2020 01:19:37 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFolp-0004Vm-UD
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 01:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599614373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gf75B6Udqf9iPOzPF2w9rijRVVDFIq7lsR+ojBwz+4k=;
 b=eJq9fp+nYhAbk4mR9vYT/DT1bs8snBCuFGPKatk+mbC3WMaEk+obb1wSmrPYRRyeG095HZ
 WCdDIkRGptirKDyhwthGwJn2k3gBBG0P60J7rlug7vwlbBfs2jkOXoHOitZYqJ6daYAWHm
 V76qoD45U3nEE7VQMs7gLM2ocgyA94k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Ceczz7n6PMSNJVVC4SLU4A-1; Tue, 08 Sep 2020 21:19:29 -0400
X-MC-Unique: Ceczz7n6PMSNJVVC4SLU4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B7D109106A;
 Wed,  9 Sep 2020 01:19:27 +0000 (UTC)
Received: from T590 (ovpn-12-76.pek2.redhat.com [10.72.12.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDF91002D5A;
 Wed,  9 Sep 2020 01:19:19 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:19:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200909011916.GB1465199@T590>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
 <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_211934_207180_2F94DEB5 
X-CRM114-Status: GOOD (  15.19  )
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
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 08, 2020 at 08:31:08AM -0700, Keith Busch wrote:
> On Tue, Sep 08, 2020 at 04:15:36PM +0800, Ming Lei wrote:
> >  void blk_mq_quiesce_queue(struct request_queue *q)
> >  {
> > -	struct blk_mq_hw_ctx *hctx;
> > -	unsigned int i;
> > -	bool rcu = false;
> > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> >  
> >  	mutex_lock(&q->mq_quiesce_lock);
> >  
> > -	if (blk_queue_quiesced(q))
> > -		goto exit;
> 
> Why remove the 'goto exit' on this condition? There shouldn't be a need
> to synchronize dispatch again if a previous quiesce already did so.

Hammm, this change is supposed to be done in next patch of 'blk-mq: add tagset
quiesce interface'. The tagset quiesce interface starts to apply async quiesce,
so synchronize dispatch has to be done in blk_mq_quiesce_queue().

thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
