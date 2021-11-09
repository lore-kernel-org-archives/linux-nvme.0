Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB0EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 03:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B556120A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 03:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1B556120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/tDkykZsFN5OZCu57vQp5oNz6gnK/qbWS+eRe3IMJqQ=; b=2qe/dkf5HHXDd7N3rHhNDrnQuX
	nEb+33OlIdg9QZI36wtk26UUizuQzEV9G/4YrPRvuUXApWSNVLKt11+eKiDFAbPXstvJuqJnxhUW+
	x7TMPprl9HtLTPxIDjrC03duC+s2upPCmwHndtqHTUMEeAUMa0fpegzXO/lWnxtxxlmiVRGeTIUeL
	LqWZ4jlsQm+y7+C9yLdsTgzml4r49D6vYzYaKXBLbEMP1RdxtGWBOqwHEuqYxv2VJcEjAtSEbsBUn
	6moAnPHe0pU4ljExOj2HeZtQnQDci4MBfVU9W+XkH5MaKFM5fizCQNWPg20IWEwz+N9JIa1vr7gFm
	oEl/dwGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkHfR-000aXa-MX; Tue, 09 Nov 2021 03:19:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkHfO-000aWt-Lj
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 03:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636427960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tDkykZsFN5OZCu57vQp5oNz6gnK/qbWS+eRe3IMJqQ=;
 b=EcH8FMrT6DRvQ8/CtUANDowEgDp+lp18cUlWWh0BzrHFPSGOZBcBqEqQ6kWJB+3IsjWJRi
 m4lzNedl17x3SGOcvldEokubRUXa/deuUjwqP7wtNo3r/7Job0OgjLIuNhMvZfRm981dEL
 1eKqL6F46UjkHe2Ed6HnTdzBwBAjnF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-IujRaP_1Ng-F6m1Cre3dgA-1; Mon, 08 Nov 2021 22:19:17 -0500
X-MC-Unique: IujRaP_1Ng-F6m1Cre3dgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E4681006AA1;
 Tue,  9 Nov 2021 03:19:16 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BD2660BE5;
 Tue,  9 Nov 2021 03:19:01 +0000 (UTC)
Date: Tue, 9 Nov 2021 11:18:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/4] scsi: make sure that request queue queiesce and
 unquiesce balanced
Message-ID: <YYnooJNLvHIQA0Xk@T590>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
 <20211103034305.3691555-4-ming.lei@redhat.com>
 <08f0e186093b0d5067347a1376228010cb4cc7f4.camel@HansenPartnership.com>
 <YYnEVuwp/jMngPYo@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYnEVuwp/jMngPYo@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_191922_811801_1C260AC4 
X-CRM114-Status: GOOD (  26.67  )
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

On Tue, Nov 09, 2021 at 08:44:06AM +0800, Ming Lei wrote:
> Hello James,
> 
> On Mon, Nov 08, 2021 at 11:42:01AM -0500, James Bottomley wrote:
> > On Wed, 2021-11-03 at 11:43 +0800, Ming Lei wrote:
> > [...]
> > > +void scsi_start_queue(struct scsi_device *sdev)
> > > +{
> > > +	if (cmpxchg(&sdev->queue_stopped, 1, 0))
> > > +		blk_mq_unquiesce_queue(sdev->request_queue);
> > > +}
> > > +
> > > +static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
> > > +{
> > > +	if (!cmpxchg(&sdev->queue_stopped, 0, 1)) {
> > > +		if (nowait)
> > > +			blk_mq_quiesce_queue_nowait(sdev-
> > > >request_queue);
> > > +		else
> > > +			blk_mq_quiesce_queue(sdev->request_queue);
> > > +	} else {
> > > +		if (!nowait)
> > > +			blk_mq_wait_quiesce_done(sdev->request_queue);
> > > +	}
> > > +}
> > 
> > This looks counter intuitive.  I assume it's done so that if we call
> > scsi_stop_queue when the queue has already been stopped, it waits until
> 
> The motivation is to balance blk_mq_quiesce_queue_nowait()/blk_mq_quiesce_queue()
> and blk_mq_unquiesce_queue().
> 
> That needs one extra mutex to cover the quiesce action and update
> the flag, but we can't hold the mutex in scsi_internal_device_block_nowait(),
> so take this way with the atomic flag.
> 
> > the queue is actually quiesced before returning so the behaviour is the
> > same in the !nowait case?  Some sort of comment explaining that would
> > be useful.
> 
> I will add comment on the current usage.

Are you fine with the following comment?

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e8925a35cb3a..9e3bf028f95a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2661,6 +2661,13 @@ void scsi_start_queue(struct scsi_device *sdev)
 
 static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
 {
+	/*
+	 * The atomic variable of ->queue_stopped covers that
+	 * blk_mq_quiesce_queue* is balanced with blk_mq_unquiesce_queue.
+	 *
+	 * However, we still need to wait until quiesce is done
+	 * in case that queue has been stopped.
+	 */
 	if (!cmpxchg(&sdev->queue_stopped, 0, 1)) {
 		if (nowait)
 			blk_mq_quiesce_queue_nowait(sdev->request_queue);


Thanks,
Ming


