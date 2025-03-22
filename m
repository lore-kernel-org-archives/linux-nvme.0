Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883E2C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSfN4adD6Yy/dTw2Fx1VYIssqdlx2Rs6iAavKyg5Vos=; b=JPbASouHy121Su7ARJ+vE8QA+h
	Qb8lBHxuZ39aSMpI6/bLeOlkNDamBOc26T6mBgrBp8cPHAUBz60dWYi+8NGHArIdXnNLeW59Zv0M2
	zwiZ0KuEt0zCp+NRd55fGWuR4X13CVhwATuzdODEbB1xzONdT2Fq3YMUaaTFEeINpcspdCPmgF5j0
	alpB/fl7P0CpeS3cz7FXf2ynP41HhlU83sPWXv9otqp+Ny75bXBgunywFOyZm9j2vGz+SUARhbpZy
	ma3V8FyniXsntd2B9Stw9mqUcj4X2RootTXsKi3Fe05jgZidxmmZL9qOriV3fbVFI1KrtHmRl24xv
	h9yLnqug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtVE-0000000H2mH-2iO5;
	Sat, 22 Mar 2025 07:42:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtVB-0000000H2ln-2oOY
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 07:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742629360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eSfN4adD6Yy/dTw2Fx1VYIssqdlx2Rs6iAavKyg5Vos=;
	b=ipw7TbEBHQgg/kGmITyf8Rc3fWyDt/mJYyhqbaai3efz2G0P1vgu9h9cox83N8FR3SUrgP
	wvirDeaJl/KyBgxf8cJ/WGa48p+4y9O8U0kEsFwWcLtKw4jv/qUR64SRHgQuE2bmK7A3ZK
	mW+UlBtNTjAlBe94n1RSFswlFoe0hJM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-7JhKs1JWPs2MMRscdvmx2Q-1; Sat,
 22 Mar 2025 03:42:34 -0400
X-MC-Unique: 7JhKs1JWPs2MMRscdvmx2Q-1
X-Mimecast-MFC-AGG-ID: 7JhKs1JWPs2MMRscdvmx2Q_1742629353
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 491C6180882E;
	Sat, 22 Mar 2025 07:42:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B375230001A1;
	Sat, 22 Mar 2025 07:42:25 +0000 (UTC)
Date: Sat, 22 Mar 2025 15:42:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
Message-ID: <Z95p25fOUY6X7lbX@fedora>
References: <20250321184819.3847386-1-csander@purestorage.com>
 <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_004241_779797_9DE0503C 
X-CRM114-Status: GOOD (  29.47  )
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

On Fri, Mar 21, 2025 at 08:24:43PM +0000, Pavel Begunkov wrote:
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > To use ublk zero copy, an application submits a sequence of io_uring
> > operations:
> > (1) Register a ublk request's buffer into the fixed buffer table
> > (2) Use the fixed buffer in some I/O operation
> > (3) Unregister the buffer from the fixed buffer table
> > 
> > The ordering of these operations is critical; if the fixed buffer lookup
> > occurs before the register or after the unregister operation, the I/O
> > will fail with EFAULT or even corrupt a different ublk request's buffer.
> > It is possible to guarantee the correct order by linking the operations,
> > but that adds overhead and doesn't allow multiple I/O operations to
> > execute in parallel using the same ublk request's buffer. Ideally, the
> > application could just submit the register, I/O, and unregister SQEs in
> > the desired order without links and io_uring would ensure the ordering.
> > This mostly works, leveraging the fact that each io_uring SQE is prepped
> > and issued non-blocking in order (barring link, drain, and force-async
> > flags). But it requires the fixed buffer lookup to occur during the
> > initial non-blocking issue.
> 
> In other words, leveraging internal details that is not a part
> of the uapi, should never be relied upon by the user and is fragile.
> Any drain request or IOSQE_ASYNC and it'll break, or for any reason
> why it might be desirable to change the behaviour in the future.
> 
> Sorry, but no, we absolutely can't have that, it'll be an absolute
> nightmare to maintain as basically every request scheduling decision
> now becomes a part of the uapi.
> 
> There is an api to order requests, if you want to order them you
> either have to use that or do it in user space. In your particular
> case you can try to opportunistically issue them without ordering
> by making sure the reg buffer slot is not reused in the meantime
> and handling request failures.

I agree, the order should be provided from UAPI/syscall level.

SQE group does address this order issue, and now it can work with
fixed buffer registering OP together.

If no one objects, I will post out the patch for review.


Thanks, 
Ming


