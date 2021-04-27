Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C8C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 08:54:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054EF613B1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 08:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054EF613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ICjXnhQoigJaZA9y+wEBt+EIvDqNxGziv1gXGF2t0pA=; b=QAD5E4PoNHGFpe9PnDfrOxYuD
	rUcUGMH6z9WRCBWQ/FWna5ODe4UOtZ/nZg7ygQqOQmjCJfythCLGAAhv3J8CQT7KjQWDIzuhwPrm5
	Q5m/6LGp9uFnARpK6U4pP7fjK8pag2p+A1sl33hScjmdMRfAOxbmrmeLbOgOUiAwpb0VTI3/3O9yt
	2hPE5V3Z7vpFKykmvCdS+cMjKpTQpfo8GGDrm6lLi6udQnztHqmSQ1N5Q1Cgt8Yvx2i5aaQDTYbm8
	yuUuczicqmEGGQvImU+lTrYiM3p6LTCstf1IKYzCEGJspHA/h7rJ7cY/7GyBTV7RaHD0AK9v8GW0W
	Mc5RoCOWQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbJUG-0019TE-NJ; Tue, 27 Apr 2021 08:54:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJUE-0019T3-NL
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 08:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZZ/NQlCaJK/0v5kyGD3++s9FSBVlBWJKG64tPlZ/6fs=; b=FsiX/Jc65Do1DgSoubEJElj3qS
 t8YN98I5QP8koL3MK3egqTKVFKI3ADQ1oL5Le/WWuw9pKnU3tZhDORrOBNZb5m+YOC8kX3qCfwZDP
 NZJdF/QkSKm+cuBaf0AHnVY6Dlt3c3v6P7vrpnqWJEvVhG8U7SXwTcId+2rDuUQM5XUTnmfJmHFwl
 es3bevaFwyWGnnrVFNVA9sGfqDItnD9IrVUw3fX5RTurqbQxvFicJDA+svRLAW5Ef+s+HODrgSjLp
 h6pljtikePmYIaZYZGGeQnn19s66mPQHdWfNCfzu6y1rJbLhb761JllPpSvVn3jORHYNfSKJ0r8rF
 yhF38QYw==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJUC-00GYbg-0R
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 08:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619513665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZZ/NQlCaJK/0v5kyGD3++s9FSBVlBWJKG64tPlZ/6fs=;
 b=MFgugRFfKiRvNi2d6qxIo6xvnCojSSGHih7J9m0iG/ni2ghFFB1DKD9ynMVae0X886uxBh
 r8HdrjJp7mlAayfpEhI8tQmF30Pnqbl0ZLGbkNeN9f84GiJ/SJPtOTL/KrET+hSdHBhXZJ
 c4UHvb1rSh+Ppabpmh5A+Znm7AYivqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-uLEy_RLKOnueLZtG0VH-0A-1; Tue, 27 Apr 2021 04:54:23 -0400
X-MC-Unique: uLEy_RLKOnueLZtG0VH-0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB50C107ACCA;
 Tue, 27 Apr 2021 08:54:20 +0000 (UTC)
Received: from T590 (ovpn-13-248.pek2.redhat.com [10.72.13.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7301A100763C;
 Tue, 27 Apr 2021 08:54:11 +0000 (UTC)
Date: Tue, 27 Apr 2021 16:54:17 +0800
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
Message-ID: <YIfRObi3RTEbA5vd@T590>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <20210425085753.2617424-7-ming.lei@redhat.com>
 <bcdfc3a0-f5fa-dc06-8067-4349a133e531@acm.org>
 <YIZcuMkLV1+DKhLZ@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YIZcuMkLV1+DKhLZ@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_015428_156178_7079E1AB 
X-CRM114-Status: GOOD (  24.52  )
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

On Mon, Apr 26, 2021 at 02:24:56PM +0800, Ming Lei wrote:
> On Sun, Apr 25, 2021 at 08:02:10PM -0700, Bart Van Assche wrote:
> > On 4/25/21 1:57 AM, Ming Lei wrote:
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index c289991ffaed..7cbaee282b6d 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -1568,7 +1568,11 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
> > >  	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
> > >  		return;
> > >  	trace_scsi_dispatch_cmd_done(cmd);
> > > -	blk_mq_complete_request(cmd->request);
> > > +
> > > +	if (unlikely(host_byte(cmd->result) != DID_OK))
> > > +		blk_mq_complete_request_locally(cmd->request);
> > > +	else
> > > +		blk_mq_complete_request(cmd->request);
> > >  }
> > 
> > This change is so tricky that it deserves a comment.
> > 
> > An even better approach would be *not* to export
> > blk_mq_complete_request_locally() from the block layer to block drivers
> > and instead modify the block layer such that it completes a request on
> > the same CPU if request completion happens from inside the context of a
> > tag iteration function. That would save driver writers the trouble of
> > learning yet another block layer API.
> 
> Yeah, that is possible, and one request flag(eg. RQF_ITERATED) can be added.
> The flag is set before calling ->fn(), and evaluated in
> blk_mq_complete_request_remote().

Thinking of the issue further, we have grabbed rq->refcnt before calling
->fn(), not only request UAF is fixed, but also driver gets valid
request instance to check if the request has been completed, so we needn't
to consider the double completion issue[1] any more, which is supposed
to be covered by driver, such as, scsi uses SCMD_STATE_COMPLETE in
scsi_mq_done() for avoiding double completion.

[1] https://lore.kernel.org/linux-block/YIdWz8C5eklPvEiV@T590/T/#u

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
