Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C48C5ACD9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8/OVHwRsfHW8M5wsM6NVhU4lqLzcoc5jo8xC3NZ8ZA=; b=tNtcBSpB9Bngn3w6bCC7IpOteo
	bxMwWY2acjUOleKgXevoheezA4JgZMF9jMa7oc50KqQ9pBlngrs+WIiWXA1vaIkBJ+0nyag4xX35L
	NFS2EBe8Fb1en51SqynAwmfOHPiPeDZeNWVVpMYT5Cz8P+45v+kOBTgKki/BOafxaFpypcZhjJ+P0
	iioA86r5wPrs7XKOhP8jygUY50r/c4r3iL8tEgbprjthj9ibR4IqmewNutckDZxdkGpJxw+8zPUAz
	Bhonhf14gzf6jgQBakZbshpgbnBM2H/9RA3mRws8bghmuUHsQsDDhg7IwH04wIUMvcHVu6k1MEwNE
	NnLdWUrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTPe-0000000FHQe-29t4;
	Fri, 20 Feb 2026 16:31:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTPb-0000000FHPb-2XMO
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771605086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8/OVHwRsfHW8M5wsM6NVhU4lqLzcoc5jo8xC3NZ8ZA=;
	b=JezuoQF4Fus0wBBvlw63k2ytE+x+OLApJ5zVhs5okSR3vfsEMkN6fZ33t0yKUQUaspI2Dx
	ftcj8B9H/dxGR+pktrsvPXOSSRFwVj4RsjLecwTorxJdQeqiec5BnPK4nQA786YcRb81nt
	jpJUsycEH/xOJSzUc0MzjvVJAzGUgt4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-_cunhcL-P5ujd4hiEGDiRQ-1; Fri,
 20 Feb 2026 11:31:22 -0500
X-MC-Unique: _cunhcL-P5ujd4hiEGDiRQ-1
X-Mimecast-MFC-AGG-ID: _cunhcL-P5ujd4hiEGDiRQ_1771605080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0489180049D;
	Fri, 20 Feb 2026 16:31:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F28E81800672;
	Fri, 20 Feb 2026 16:31:12 +0000 (UTC)
Date: Sat, 21 Feb 2026 00:31:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
Message-ID: <aZiMS9EZrOqEBhQL@fedora>
References: <20260219172228.429479-1-csander@purestorage.com>
 <aZhuwOku9lFe33UM@fedora>
 <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
 <aZiHlp8nOPgQFGMq@fedora>
 <CADUfDZoxW0m4nptfNYqmqFCdTj6zSaYOk1vYSKU5JztkjEjD=g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADUfDZoxW0m4nptfNYqmqFCdTj6zSaYOk1vYSKU5JztkjEjD=g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mzqvWTW5vfxQInqqF4C_dRu5FI2FA8YsHEOCO5c0uBs_1771605080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_083127_737233_300CF6A3 
X-CRM114-Status: GOOD (  24.87  )
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

On Fri, Feb 20, 2026 at 08:22:29AM -0800, Caleb Sander Mateos wrote:
> On Fri, Feb 20, 2026 at 8:11 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:55:33AM -0800, Caleb Sander Mateos wrote:
> > > On Fri, Feb 20, 2026 at 6:25 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> > > > > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> > > > > requests issued to it to support iopoll. This prevents, for example,
> > > > > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > > > > zero-copy buffer registrations are performed using a uring_cmd. There's
> > > > > no technical reason why these non-iopoll uring_cmds can't be supported.
> > > > > They will either complete synchronously or via an external mechanism
> > > > > that calls io_uring_cmd_done(), so they don't need to be polled.
> > > >
> > > > For sync uring command, it is fine to support for IOPOLL.
> > > >
> > > > However, there are async uring command, which may be completed in irq
> > > > context, or in multishot way, at least the later isn't supported in
> > > > io_do_iopoll() yet.
> > >
> > > Can you describe the issues you envision in more detail?
> >
> > Basically IOPOLL doesn't support multishot request yet.
> >
> > For example, when io_uring_mshot_cmd_post_cqe() is called and new cqe is
> > queued, it can't be found from io_iopoll_check()<-io_uring_enter(IORING_ENTER_GETEVENTS).
> 
> I don't think that's a new issue, though. You're right that
> io_uring_mshot_cmd_post_cqe() assumes a non-REQ_F_IOPOLL request, so
> it's up to the ->uring_cmd() implementation to ensure that (which ublk
> already does). Since ublk's struct file_operations don't provide
> ->uring_cmd_iopoll(), any ublk uring_cmds issued to an
> IORING_SETUP_IOPOLL io_uring won't have REQ_F_IOPOLL set, so
> io_uring_mshot_cmd_post_cqe() should work just fine.

Please look in the following way:

1) without patch of `io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL`,
multishot command submission can't succeed

2) with patch of "io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL", people
may see hang forever in io_uring_enter() if multishot command is submitted
in context IORING_SETUP_IOPOLL.


Thanks,
Ming


