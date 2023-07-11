Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC3AEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eiiAFyM5lPoN2QRtm6culkhUd38woaD2yifwD9NG6qk=; b=aNP4DazbZi7rYl57/FctIRM3Y1
	QeiBd3nSLqktW0s4JD9i6xgGam288uzO7H11Q/Dv1KgXG4AAVMi6kGpzUdn9EDX4SIZ9Y4RvnBCGL
	dkgu4xE2qPCc5mAnXlC4E563IELIMBH9iDxlWD6WN4X2VL4AwZrmcDBooDuzNIVJpb3G4i4QhnuKu
	4x9n+FpKargLtqLPtcC/8ti5u6vyQXOrxqASCJyR64YfeQ7nfamS8wl9g6s7VxfAe3JzSCEon0/KA
	mIzraY/A/AT2mn5jCQYO5NCLmZt4QYnToXM6HRBL20eAlFgi/jhm41YcI1TpXC0VznefD35vq9/IH
	Yq2NtqyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8By-00E2TA-04;
	Tue, 11 Jul 2023 07:53:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ8Bv-00E2Sf-2T
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689062024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eiiAFyM5lPoN2QRtm6culkhUd38woaD2yifwD9NG6qk=;
	b=QIzACyV+2Nr6kekRXSgcXUwO2ttzalWLVfKuldDBKBM2QCLgtEKA7WtyVo9Iix2uvqte6n
	L0Co6uakfVyB2CeDt412h9OUdg4UrZCL+ae3Gt893BcyzoSGVW29ShaO8obKengnhXaO6m
	rwAxAd9x9AAvDljaFi2GVzE2HDnxLXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-BadKN_ZMNvqZ18pBfpaOyQ-1; Tue, 11 Jul 2023 03:53:41 -0400
X-MC-Unique: BadKN_ZMNvqZ18pBfpaOyQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A95C89E743;
	Tue, 11 Jul 2023 07:53:40 +0000 (UTC)
Received: from ovpn-8-22.pek2.redhat.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44D4B4CD0C1;
	Tue, 11 Jul 2023 07:53:35 +0000 (UTC)
Date: Tue, 11 Jul 2023 15:53:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 3/6] nvme: tcp: unquiesce queues after ctrl state is
 changed
Message-ID: <ZK0KemgHZEkvrA8i@ovpn-8-22.pek2.redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-4-ming.lei@redhat.com>
 <c794c9d5-f665-3d5e-edee-7dc36ed69bad@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <c794c9d5-f665-3d5e-edee-7dc36ed69bad@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_005347_885747_44CAF5C6 
X-CRM114-Status: GOOD (  25.31  )
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

On Tue, Jul 11, 2023 at 10:41:46AM +0300, Sagi Grimberg wrote:
> 
> > Unquiesce queues until controller state is changed successfully.
> > 
> > Prepare for moving start freeze into reconnect work for preventing new
> > request from entering queue in LIVE state.
> > 
> > Before removing namespace, unquiescing queues is done unconditionally, so
> > it is safe to do this way in case of state change failure.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/tcp.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index e414cfb3433f..e68bf21af348 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2109,10 +2109,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   	nvme_stop_keep_alive(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	nvme_tcp_teardown_io_queues(ctrl);
> > -	/* unquiesce to fail fast pending requests */
> > -	nvme_unquiesce_io_queues(ctrl);
> >   	nvme_tcp_teardown_admin_queue(ctrl);
> > -	nvme_unquiesce_admin_queue(ctrl);
> >   	nvme_auth_stop(ctrl);
> 
> This is potentially a problem. It is possible that auth work is
> running in the bg here, and without unquiescing the admin queue
> the the auth_stop may take unnecessarily long until its I/O times
> out.

There isn't any IO queued to nvme before unquiesce since nvme_cancel_*tagset
cancels all inflight IOs.

> 
> I think it is fine to keep it as is...

If ctrl state is LIVE, nvme_check_ready() return true, then IO is
sent to socket before changing ctrl state to NVME_CTRL_CONNECTING.

So unquisce has to be done after state is changed to NVME_CTRL_CONNECTING
if we want to move start_freeze into re-connection work.

Thanks,
Ming


