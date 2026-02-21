Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA23C5AD7B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28qhnRDYbIMza8wCtEF45tLfB5UezN0tXVglAwww3+A=; b=nM2N35du5j84q/Ur0byvQoOO5m
	w3MNUOmrcOVxp4MWJjCa8vIg20VeTQzRwxof0HmhQk9v8d1/O7TlU6AhBv3wCO/dRA0pTrnWsnvpw
	xgexXgaHpenNC59PNeBDTs0Fdp5v56Eg2HkYRcfQ5prYH+bHE6SuZqk7BPKNLnq7YqVDXhu+pcl/0
	7w5DP4w4rryD81oRk9oVBhz4LTHBj1otlxHqpxqKUIauWrnpHcUFhpj6kdrNY/50hSccIUn2Ml+80
	mEPFD7XTmEtTfkPNgkHVtPeXT5z9+zmhtRGC1oFjXreIL5MJ5gerWHf2RDIyLhlFVpniyjJFroE51
	rO9iEKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtcZB-0000000FlU5-3eEn;
	Sat, 21 Feb 2026 02:17:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtcZ5-0000000FlTi-0atg
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 02:17:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771640268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28qhnRDYbIMza8wCtEF45tLfB5UezN0tXVglAwww3+A=;
	b=J+YroBPgP1/TptoSz8M3aHdwIMikuW+3XYITRY+ks+KH1E4UqOz4CtneAgSMYR8woxaywp
	2Hbgw5EGqik6XCa3f4UMhE9KUJVAWoBvaqH5GzlJaWMcvA4RzxQldRD/BCpOgiilbLzfOD
	eiSqgAzaGDEEAcEBgwCydyD8kIPIHPw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-3w5VkhJyNSKzFIOPSprUfQ-1; Fri,
 20 Feb 2026 21:17:44 -0500
X-MC-Unique: 3w5VkhJyNSKzFIOPSprUfQ-1
X-Mimecast-MFC-AGG-ID: 3w5VkhJyNSKzFIOPSprUfQ_1771640262
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13965180049D;
	Sat, 21 Feb 2026 02:17:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D676B19560A7;
	Sat, 21 Feb 2026 02:17:34 +0000 (UTC)
Date: Sat, 21 Feb 2026 10:17:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
Message-ID: <aZkVuX2OmQr8Ca3D@fedora>
References: <20260219172228.429479-1-csander@purestorage.com>
 <aZhuwOku9lFe33UM@fedora>
 <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
 <aZiHlp8nOPgQFGMq@fedora>
 <CADUfDZoxW0m4nptfNYqmqFCdTj6zSaYOk1vYSKU5JztkjEjD=g@mail.gmail.com>
 <aZiMS9EZrOqEBhQL@fedora>
 <CADUfDZoRFRzXd4c=qu+7i5nTqFi1BfC4DvaDXA1neov591ps3w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADUfDZoRFRzXd4c=qu+7i5nTqFi1BfC4DvaDXA1neov591ps3w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 0o5LrcWpnxeiMf5dItNtw_Dbjypq1DewDyi4O3FXEHw_1771640262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_181751_277369_46C423AD 
X-CRM114-Status: GOOD (  31.98  )
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

On Fri, Feb 20, 2026 at 09:47:38AM -0800, Caleb Sander Mateos wrote:
> On Fri, Feb 20, 2026 at 8:31 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Feb 20, 2026 at 08:22:29AM -0800, Caleb Sander Mateos wrote:
> > > On Fri, Feb 20, 2026 at 8:11 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Fri, Feb 20, 2026 at 07:55:33AM -0800, Caleb Sander Mateos wrote:
> > > > > On Fri, Feb 20, 2026 at 6:25 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> > > > > > > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> > > > > > > requests issued to it to support iopoll. This prevents, for example,
> > > > > > > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > > > > > > zero-copy buffer registrations are performed using a uring_cmd. There's
> > > > > > > no technical reason why these non-iopoll uring_cmds can't be supported.
> > > > > > > They will either complete synchronously or via an external mechanism
> > > > > > > that calls io_uring_cmd_done(), so they don't need to be polled.
> > > > > >
> > > > > > For sync uring command, it is fine to support for IOPOLL.
> > > > > >
> > > > > > However, there are async uring command, which may be completed in irq
> > > > > > context, or in multishot way, at least the later isn't supported in
> > > > > > io_do_iopoll() yet.
> > > > >
> > > > > Can you describe the issues you envision in more detail?
> > > >
> > > > Basically IOPOLL doesn't support multishot request yet.
> > > >
> > > > For example, when io_uring_mshot_cmd_post_cqe() is called and new cqe is
> > > > queued, it can't be found from io_iopoll_check()<-io_uring_enter(IORING_ENTER_GETEVENTS).
> > >
> > > I don't think that's a new issue, though. You're right that
> > > io_uring_mshot_cmd_post_cqe() assumes a non-REQ_F_IOPOLL request, so
> > > it's up to the ->uring_cmd() implementation to ensure that (which ublk
> > > already does). Since ublk's struct file_operations don't provide
> > > ->uring_cmd_iopoll(), any ublk uring_cmds issued to an
> > > IORING_SETUP_IOPOLL io_uring won't have REQ_F_IOPOLL set, so
> > > io_uring_mshot_cmd_post_cqe() should work just fine.
> >
> > Please look in the following way:
> >
> > 1) without patch of `io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL`,
> > multishot command submission can't succeed
> >
> > 2) with patch of "io_uring/uring_cmd: allow non-iopoll cmds with IORING_SETUP_IOPOLL", people
> > may see hang forever in io_uring_enter() if multishot command is submitted
> > in context IORING_SETUP_IOPOLL.
> 
> Okay, I see what you mean. If ctx->iopoll_list is nonempty and a
> non-REQ_F_IOPOLL request posts a completion without going through task
> work, io_iopoll_check() won't check for CQEs already posted outside of
> iopoll. I think it should be simple enough to check for CQEs
> unconditionally in the io_iopoll_check() loop.

Yeah, it shouldn't be hard to deal with.

Thanks,
Ming


