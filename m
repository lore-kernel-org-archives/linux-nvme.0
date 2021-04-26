Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A71C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:25:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E5D6113D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 06:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E5D6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X3bGHZcS4ckHoDMUbmLcfNWFjpoVhQIx3dvrY+0y5Bo=; b=g2DfVOTrvgRmYjqBTmBoc2MWW
	77RsJPpQ1gTV10dKjHqjWZ/gfRNwUnwd4ph3l6PBP6twF3/vTnUgi2M6ee4gE0QCCL5YZWU+IS9FY
	2loaN/XMA5NxtwD49rq0rlfkR1JRj4W1GVl3id32XMPIQC78rO2L1PJbmXy7GKvFb8ddmqujBXK2Z
	r4Eb5S+p4ZXAELFfG9WaNb+bWhIf8buL3gMGiyTly+jPx1m20kApXuk5hKj0EkcHSSno5oiLCCdij
	6BjuwsWs8YeOb0l9CcsqXfaZpqXzxx6u+yRdXZXdY1gAIGyGmhYyVxQcY/ixmsiVOLQzA6Y5A5oTt
	3YOFzGiUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laugI-0073LO-DQ; Mon, 26 Apr 2021 06:25:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laugG-0073LA-G2
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 06:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KsQ9Ev+W/YY1U8469HseTNaWg7XademXCNuYNtvXPuw=; b=1FR+XqgYAc4jV7woV8EDJobK5W
 rq1il4P9JRlHXfQtd3+iPWD0UUviAFOpHZVHOFmLAxlEPdVWvl9R6BDZDfdIiin5CiboR6JPMoXAb
 MsoiX9Gkfl16DV5fVK6ABHLTqeCNWNMKFxFP2ORYrl/Ew89rSBpiE83lMi7DxZs8MzPrT9o34TjDF
 eEHl9AJYs0HROkSEvbCeN2WOTd/PxQYvHayoDWhsIyBznzEKgZ0aDCVNJBQ3DXGF5cXbCzuR9BMJ9
 +9DoBtexfu2rJH09uBOfD4pEiXVr1dnK0eGsNT4A9rd7op5K6tdjj2z3cU/A4sM6kHqaexdlvzTVi
 lUfrnqoQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laugC-00FlE3-PG
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 06:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619418309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KsQ9Ev+W/YY1U8469HseTNaWg7XademXCNuYNtvXPuw=;
 b=cUJ4Brqwv7ERtkt1Ml4rpQa7MzUnp75f42nnHXhbkouguXJDhoXWN1MN/8QwjpLlMQFZ6Z
 f2iEVbulZ0lvLPdki2GsVvAObR7jIQ6taspdqsgEzTL4y8TxX4sCWn/SijUgE2LBoNcBKz
 RxbUVgSQs2xex8KbcpHHOwx+ALFfq04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-PJJy0g5NOIi2DY46aq2myQ-1; Mon, 26 Apr 2021 02:25:05 -0400
X-MC-Unique: PJJy0g5NOIi2DY46aq2myQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC367107ACC7;
 Mon, 26 Apr 2021 06:25:03 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3973461F38;
 Mon, 26 Apr 2021 06:24:51 +0000 (UTC)
Date: Mon, 26 Apr 2021 14:24:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH 6/8] block: drivers: complete request locally from
 blk_mq_tagset_busy_iter
Message-ID: <YIZcuMkLV1+DKhLZ@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-7-ming.lei@redhat.com>
 <bcdfc3a0-f5fa-dc06-8067-4349a133e531@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bcdfc3a0-f5fa-dc06-8067-4349a133e531@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_232512_956603_7B36B82B 
X-CRM114-Status: GOOD (  19.96  )
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

On Sun, Apr 25, 2021 at 08:02:10PM -0700, Bart Van Assche wrote:
> On 4/25/21 1:57 AM, Ming Lei wrote:
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index c289991ffaed..7cbaee282b6d 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1568,7 +1568,11 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
> >  	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
> >  		return;
> >  	trace_scsi_dispatch_cmd_done(cmd);
> > -	blk_mq_complete_request(cmd->request);
> > +
> > +	if (unlikely(host_byte(cmd->result) != DID_OK))
> > +		blk_mq_complete_request_locally(cmd->request);
> > +	else
> > +		blk_mq_complete_request(cmd->request);
> >  }
> 
> This change is so tricky that it deserves a comment.
> 
> An even better approach would be *not* to export
> blk_mq_complete_request_locally() from the block layer to block drivers
> and instead modify the block layer such that it completes a request on
> the same CPU if request completion happens from inside the context of a
> tag iteration function. That would save driver writers the trouble of
> learning yet another block layer API.

Yeah, that is possible, and one request flag(eg. RQF_ITERATED) can be added.
The flag is set before calling ->fn(), and evaluated in
blk_mq_complete_request_remote().

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
