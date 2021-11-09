Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B254C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 00:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133E361101
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 00:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 133E361101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6y2CSINO7ZO/q4u9acqEKykXpomoTCTu7/e6MyVdqzc=; b=MGLtZiKxE2b9U5Ch6Ch6ur43xO
	/FzwRb+k0kP45xlmKqHxBOqqTlY7nRVqlBGc8ioiXpo4klclNAhO3yO4G+LNNKjjJov6zAMG3kfvS
	NGcXMxOQKfxMhmhV/QzYx0/WsPIj5AsJ7eTwPpRzqK8hEilaL8pk4T+dOQ86rSIC8KNdZIMRazikM
	Y5assRM6/Uu2DrjKDN1qqneH6i3ou8gLaVUt5oOUib7zh9hLMPPIfhxx2qQ2924sZnYYuGzWn2WhG
	pBWcLXGh6ck4h7NTblKESL8otPTVtZzs5uszrfs96izouPPui24u3h6WzgdoYl0pckrlK9G7pm851
	tHgREV5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkFQS-00093c-IG; Tue, 09 Nov 2021 00:55:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkFFb-00062w-6x
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 00:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636418672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6y2CSINO7ZO/q4u9acqEKykXpomoTCTu7/e6MyVdqzc=;
 b=JgoAlWxYDctcCTt01wdzWq+xl/srwi2KnDNHgUHjLqMgODIfQKtlabNJ0R6GLP2qw2k6BR
 iNHuNr2sT0CDryWtLNEM8ST1n11GTXHqaLl95oZw2dn1qmiVQpPLi+/r1nPPwa+HzOb557
 c4654sdmgUV3OVo56FPAh6fVdLpIq8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-QF7HsbBFOFqUbaJzmuB39Q-1; Mon, 08 Nov 2021 19:44:29 -0500
X-MC-Unique: QF7HsbBFOFqUbaJzmuB39Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EB3871805;
 Tue,  9 Nov 2021 00:44:27 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C2601017E35;
 Tue,  9 Nov 2021 00:44:11 +0000 (UTC)
Date: Tue, 9 Nov 2021 08:44:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 3/4] scsi: make sure that request queue queiesce and
 unquiesce balanced
Message-ID: <YYnEVuwp/jMngPYo@T590>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
 <20211103034305.3691555-4-ming.lei@redhat.com>
 <08f0e186093b0d5067347a1376228010cb4cc7f4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f0e186093b0d5067347a1376228010cb4cc7f4.camel@HansenPartnership.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_164435_472972_53840D2D 
X-CRM114-Status: GOOD (  19.03  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello James,

On Mon, Nov 08, 2021 at 11:42:01AM -0500, James Bottomley wrote:
> On Wed, 2021-11-03 at 11:43 +0800, Ming Lei wrote:
> [...]
> > +void scsi_start_queue(struct scsi_device *sdev)
> > +{
> > +	if (cmpxchg(&sdev->queue_stopped, 1, 0))
> > +		blk_mq_unquiesce_queue(sdev->request_queue);
> > +}
> > +
> > +static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
> > +{
> > +	if (!cmpxchg(&sdev->queue_stopped, 0, 1)) {
> > +		if (nowait)
> > +			blk_mq_quiesce_queue_nowait(sdev-
> > >request_queue);
> > +		else
> > +			blk_mq_quiesce_queue(sdev->request_queue);
> > +	} else {
> > +		if (!nowait)
> > +			blk_mq_wait_quiesce_done(sdev->request_queue);
> > +	}
> > +}
> 
> This looks counter intuitive.  I assume it's done so that if we call
> scsi_stop_queue when the queue has already been stopped, it waits until

The motivation is to balance blk_mq_quiesce_queue_nowait()/blk_mq_quiesce_queue()
and blk_mq_unquiesce_queue().

That needs one extra mutex to cover the quiesce action and update
the flag, but we can't hold the mutex in scsi_internal_device_block_nowait(),
so take this way with the atomic flag.

> the queue is actually quiesced before returning so the behaviour is the
> same in the !nowait case?  Some sort of comment explaining that would
> be useful.

I will add comment on the current usage.


Thanks,
Ming


