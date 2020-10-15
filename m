Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F2C433E7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:50:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D49722243
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1vtgf9jr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEfTdlZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D49722243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BiXKuy0RIHc0BzaK8/AzXp+EomN5lfuNngNGkLXHljM=; b=1vtgf9jrEMDr/X8o5vs+Ol4Hz
	5gLEL39Pq7fYJ/7w8OhK6VJGdaXBDrZDmBf3mBkKThvT8wUocg94E6Vce0d7YejfkQpXfWRpkaIhc
	ID+byUhBOmCktTMOKQjT3gOa3bvMz7TPFJ19pHp8TQiuG4+L5n9JteUULQIPvmswcOfYmLx9eFqwI
	AJ1u8rrk9WKzmYyPqyN9UPuJCDkOb2ASAfRQCY1vuBkb9fW5i6/Wn0VRtGkZgGfCApdAenuLsuerY
	1nnEmd76o+DBNuWWONINIB51H6DKkkp25CtQHPATvylxzM12Qhzfbu4pV08BtHrZwKOgol8yN+RAf
	VSXIgJ8Iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSy2D-0001HZ-A2; Thu, 15 Oct 2020 07:50:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSy26-0001Ga-Ah
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 07:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602748240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qX1PP+9+SdYeiYGqy1KGjgVUbwdcndAAl0qhlOTkOU=;
 b=IEfTdlZIjoUic+EuRY++Q6eMrIoebRsp9cMzmbiaviGCisXYo8m83OOg7cauglnB3aXH5N
 R3xlJrzfWqMU2K4JoU6amsicQgaPVWuw0Uw2h16xaHzs6P+mJw+2jpGadQIFx5nC0LIaqK
 BW93i12UkrtbXSsHpcGEZpLcNCIWz9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-CQLWX3oUPCGm_D_LRB0wvw-1; Thu, 15 Oct 2020 03:50:38 -0400
X-MC-Unique: CQLWX3oUPCGm_D_LRB0wvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC8D1084C82;
 Thu, 15 Oct 2020 07:50:36 +0000 (UTC)
Received: from T590 (ovpn-12-134.pek2.redhat.com [10.72.12.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D40355C1BD;
 Thu, 15 Oct 2020 07:50:25 +0000 (UTC)
Date: Thu, 15 Oct 2020 15:50:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201015075020.GA1099950@T590>
References: <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590> <20201014033434.GC775684@T590>
 <f5870b91-28c5-ea99-59df-cdcc8c482011@huawei.com>
 <20201014095642.GE775684@T590>
 <c9cf7168-d8ce-276f-de01-739199ed4258@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9cf7168-d8ce-276f-de01-739199ed4258@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_035042_406192_677F23E5 
X-CRM114-Status: GOOD (  38.04  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 15, 2020 at 02:05:01PM +0800, Chao Leng wrote:
> 
> 
> On 2020/10/14 17:56, Ming Lei wrote:
> > On Wed, Oct 14, 2020 at 05:39:12PM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2020/10/14 11:34, Ming Lei wrote:
> > > > On Wed, Oct 14, 2020 at 09:08:28AM +0800, Ming Lei wrote:
> > > > > On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
> > > > > > 
> > > > > > > > > This may just reduce the probability. The concurrency of timeout
> > > > > > > > > and teardown will cause the same request
> > > > > > > > > be treated repeatly, this is not we expected.
> > > > > > > > 
> > > > > > > > That is right, not like SCSI, NVME doesn't apply atomic request
> > > > > > > > completion, so
> > > > > > > > request may be completed/freed from both timeout & nvme_cancel_request().
> > > > > > > > 
> > > > > > > > .teardown_lock still may cover the race with Sagi's patch because
> > > > > > > > teardown
> > > > > > > > actually cancels requests in sync style.
> > > > > > > In extreme scenarios, the request may be already retry success(rq state
> > > > > > > change to inflight).
> > > > > > > Timeout processing may wrongly stop the queue and abort the request.
> > > > > > > teardown_lock serialize the process of timeout and teardown, but do not
> > > > > > > avoid the race.
> > > > > > > It might not be safe.
> > > > > > 
> > > > > > Not sure I understand the scenario you are describing.
> > > > > > 
> > > > > > what do you mean by "In extreme scenarios, the request may be already retry
> > > > > > success(rq state change to inflight)"?
> > > > > > 
> > > > > > What will retry the request? only when the host will reconnect
> > > > > > the request will be retried.
> > > > > > 
> > > > > > We can call nvme_sync_queues in the last part of the teardown, but
> > > > > > I still don't understand the race here.
> > > > > 
> > > > > Not like SCSI, NVME doesn't complete request atomically, so double
> > > > > completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> > > > > 
> > > > > Given request is completed remotely or asynchronously in the two code paths,
> > > > > the teardown_lock can't protect the case.
> > > > 
> > > > Thinking of the issue further, the race shouldn't be between timeout and
> > > > teardown.
> > > > 
> > > > Both nvme_cancel_request() and nvme_tcp_complete_timed_out() are called
> > > > with .teardown_lock, and both check if the request is completed before
> > > > calling blk_mq_complete_request() which marks the request as COMPLETE state.
> > > > So the request shouldn't be double-freed in the two code paths.
> > > > 
> > > > Another possible reason is that between timeout and normal completion(fail
> > > > fast pending requests after ctrl state is updated to CONNECTING).
> > > > 
> > > > Yi, can you try the following patch and see if the issue is fixed?
> > > > 
> > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > index d6a3e1487354..fab9220196bd 100644
> > > > --- a/drivers/nvme/host/tcp.c
> > > > +++ b/drivers/nvme/host/tcp.c
> > > > @@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
> > > >    static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
> > > >    		bool remove)
> > > >    {
> > > > -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
> > > >    	blk_mq_quiesce_queue(ctrl->admin_q);
> > > >    	nvme_tcp_stop_queue(ctrl, 0);
> > > >    	if (ctrl->admin_tagset) {
> > > > @@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
> > > >    	if (remove)
> > > >    		blk_mq_unquiesce_queue(ctrl->admin_q);
> > > >    	nvme_tcp_destroy_admin_queue(ctrl, remove);
> > > > -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
> > > >    }
> > > >    static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> > > >    		bool remove)
> > > >    {
> > > > -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
> > > >    	if (ctrl->queue_count <= 1)
> > > > -		goto out;
> > > > +		return;
> > > >    	blk_mq_quiesce_queue(ctrl->admin_q);
> > > >    	nvme_start_freeze(ctrl);
> > > >    	nvme_stop_queues(ctrl);
> > > > @@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
> > > >    	if (remove)
> > > >    		nvme_start_queues(ctrl);
> > > >    	nvme_tcp_destroy_io_queues(ctrl, remove);
> > > > -out:
> > > > -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
> > > >    }
> > > >    static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > > > @@ -2030,11 +2025,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > > >    	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> > > >    	nvme_stop_keep_alive(ctrl);
> > > > +
> > > > +	mutex_lock(&tcp_ctrl->teardown_lock);
> > > >    	nvme_tcp_teardown_io_queues(ctrl, false);
> > > > -	/* unquiesce to fail fast pending requests */
> > > > -	nvme_start_queues(ctrl);
> > > >    	nvme_tcp_teardown_admin_queue(ctrl, false);
> > > > -	blk_mq_unquiesce_queue(ctrl->admin_q);
> > > Delete blk_mq_unquiesce_queue will cause a bug which may cause reconnect failed.
> > > Delete nvme_start_queues may cause another bug.
> > 
> > nvme_tcp_setup_ctrl() will re-start io and admin queue, and only .connect_q
> > and .fabrics_q are required during reconnect.I check the code. Unquiesce the admin queue in nvme_tcp_configure_admin_queue, so reconnect can work well.
> > 
> > So can you explain in detail about the bug?
> First if reconnect failed, quiesce the io queue and admin queue will cause IO pause long time.

Any normal IO can't make progress until reconnect is successful, so this
change won't increase IO pause. This way is exactly what NVMe PCI takes,
see nvme_start_queues() called from nvme_reset_work().

> Second if reconnect failed more than max_reconnects, delete ctrl will hang.

No, delete ctrl won't hang, because 'shutdown' parameter is true in case
of deleting ctrl, which will unquiesce both admin_q and io queues in
nvme_tcp_teardown_io_queues() and nvme_tcp_teardown_admin_queue().


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
