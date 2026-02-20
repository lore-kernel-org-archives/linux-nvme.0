Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB69C5ACC1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4OfGMWPMFENDNIl5IxeVVp4tHP7UkrYjaFKpM8Ac1Kc=; b=l0mXR7a6PmSs/2x1Oj2yriiYNd
	5ucCGMIdWit2bMeeoXCUG8u9+pb+EL9iBDvWGdrZ9c5mEd9ooH7xMEURiX1ZUICFQu+Ashvs3jMnO
	ZSGUourl2zqHqK9gZMx5pLukFWTc6dbo4zXTF9nzW5Y+ZzXpdPK6aT0E+oNmiWVlSvhllbGhlrF8i
	xQhVNBHv8gwWndd3GSqDMF7OUsE2WFi3UuueB6zTn/2xqMdujTFrvkaB6y52jQJCotDT312oJPiEF
	jW6dp85X3sDJTxvg9KCPUKWZDNhqlSVF/OY9ZHmru6QkM5XeCVS9wfZKxK58tTgr56T4fx+ksq0F8
	tXCtI8MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT7c-0000000FDIx-0nlI;
	Fri, 20 Feb 2026 16:12:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT7a-0000000FDHa-0u5X
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771603969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OfGMWPMFENDNIl5IxeVVp4tHP7UkrYjaFKpM8Ac1Kc=;
	b=hg51ibqhjZkzEIoLgLPiJN/L+oDu0fEDFxu0Wk4qXBj3wQvreqAp2O3er7DIaqxQSFSWMl
	yDJV3xuyx3ojm+4kqdFXxfmdK03AIFyN2FLEOPvPlee1Sw2DEPmTNJgkcMM4fuq7wLN4/Z
	naMr5x8Y/K9SB9oWpYPFPFaIzhTaKCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-L7orrYm5OqOaGkaPNLxxBg-1; Fri,
 20 Feb 2026 11:11:15 -0500
X-MC-Unique: L7orrYm5OqOaGkaPNLxxBg-1
X-Mimecast-MFC-AGG-ID: L7orrYm5OqOaGkaPNLxxBg_1771603874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB8D61800473;
	Fri, 20 Feb 2026 16:11:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D5061954117;
	Fri, 20 Feb 2026 16:11:07 +0000 (UTC)
Date: Sat, 21 Feb 2026 00:11:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anuj gupta <anuj1072538@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
Message-ID: <aZiHlp8nOPgQFGMq@fedora>
References: <20260219172228.429479-1-csander@purestorage.com>
 <aZhuwOku9lFe33UM@fedora>
 <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADUfDZr3ksmd=ZZOhU4RJsqEzbxBHnDPCtOQXJ5ft=X7irWvPQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 8ES0-Q7Cy5Suh9QPAGDQC5WfcLHl-CoCwWzAx-0FpYM_1771603874
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_081250_320631_F70C61BA 
X-CRM114-Status: GOOD (  19.47  )
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

On Fri, Feb 20, 2026 at 07:55:33AM -0800, Caleb Sander Mateos wrote:
> On Fri, Feb 20, 2026 at 6:25 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 10:22:23AM -0700, Caleb Sander Mateos wrote:
> > > Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> > > requests issued to it to support iopoll. This prevents, for example,
> > > using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> > > zero-copy buffer registrations are performed using a uring_cmd. There's
> > > no technical reason why these non-iopoll uring_cmds can't be supported.
> > > They will either complete synchronously or via an external mechanism
> > > that calls io_uring_cmd_done(), so they don't need to be polled.
> >
> > For sync uring command, it is fine to support for IOPOLL.
> >
> > However, there are async uring command, which may be completed in irq
> > context, or in multishot way, at least the later isn't supported in
> > io_do_iopoll() yet.
> 
> Can you describe the issues you envision in more detail?

Basically IOPOLL doesn't support multishot request yet.

For example, when io_uring_mshot_cmd_post_cqe() is called and new cqe is
queued, it can't be found from io_iopoll_check()<-io_uring_enter(IORING_ENTER_GETEVENTS).


Thanks,
Ming


