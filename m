Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2C2C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2+qeq0JgnGOpt+C/CZ/JR6EIs1Cxtjx4y7+UO1YN5s=; b=0Mtjk0DEPa6xltMnGqmJuVauDt
	m+haOdyF+0v5EP/PJeZeui5W9y3QTy8HOOqIFlgoHJH66UxCox9bSQiav+s9L4qOzseoyeNmKgj4d
	8JC0tkUifeMWRraDNQZTYI3ZmzKhWKIxvXBB+Tv9pNBppoWTXjTNYh2UIU+EWKllRfzs2jOeLZtjH
	BVaigNYTH5yi165/YtwJYrQy9H5adMeF/9fZaqFC1hR3ofd1b0BaPVuTcuosYlaoB2KHfnXT26iCW
	K3AAaSvEd7AnOHjKbAbhl5NxHryQohbneYV9FQSeLipop7mQccGS7AgB/ZsxVd9LUrIuTK5QG+2nC
	1N4U/IFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtMh-0000000H11v-3YFr;
	Sat, 22 Mar 2025 07:33:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvtMe-0000000H118-3BFC
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 07:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742628830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2+qeq0JgnGOpt+C/CZ/JR6EIs1Cxtjx4y7+UO1YN5s=;
	b=QTrRL3jKqC4iVTePUOH046DQ8PT34WPNyoj2/uWr/cGdqImz0uFk3dNjf40Awbw3xHwDaH
	Cen/oKrFcRNp7AMhscEwocBpZqSH9eTZmO+JPCa0SIdO8lnbLAcFFhwc2S09Tsw+89b2Zi
	diLD6kxNAPM4hcpm5pGcpHVkUN/gVvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-zJ8_zrk0MiuB6v8_0t0EuQ-1; Sat,
 22 Mar 2025 03:33:47 -0400
X-MC-Unique: zJ8_zrk0MiuB6v8_0t0EuQ-1
X-Mimecast-MFC-AGG-ID: zJ8_zrk0MiuB6v8_0t0EuQ_1742628825
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FF681809CA6;
	Sat, 22 Mar 2025 07:33:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0644E19560AF;
	Sat, 22 Mar 2025 07:33:36 +0000 (UTC)
Date: Sat, 22 Mar 2025 15:33:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
Message-ID: <Z95nyw8LUw0aHKCu@fedora>
References: <20250321184819.3847386-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_003352_870426_FADD1F96 
X-CRM114-Status: GOOD (  18.50  )
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

On Fri, Mar 21, 2025 at 12:48:16PM -0600, Caleb Sander Mateos wrote:
> To use ublk zero copy, an application submits a sequence of io_uring
> operations:
> (1) Register a ublk request's buffer into the fixed buffer table
> (2) Use the fixed buffer in some I/O operation
> (3) Unregister the buffer from the fixed buffer table
> 
> The ordering of these operations is critical; if the fixed buffer lookup
> occurs before the register or after the unregister operation, the I/O
> will fail with EFAULT or even corrupt a different ublk request's buffer.
> It is possible to guarantee the correct order by linking the operations,
> but that adds overhead and doesn't allow multiple I/O operations to
> execute in parallel using the same ublk request's buffer. Ideally, the
> application could just submit the register, I/O, and unregister SQEs in
> the desired order without links and io_uring would ensure the ordering.

So far there are only two ways to provide the order guarantee in io_uring
syscall viewpoint:

1) IOSQE_IO_LINK

2) submit register_buffer operation and wait its completion, then submit IO
operations

Otherwise, you may just depend on the implementation, and there isn't such
order guarantee, and it is hard to write generic io_uring application.

I posted sqe group patchset for addressing this particular requirement in
API level.

https://lore.kernel.org/linux-block/20241107110149.890530-1-ming.lei@redhat.com/

Now I'd suggest to re-consider this approach for respecting the order
in API level, so both application and io_uring needn't play trick for
addressing this real problem.

With sqe group, just two OPs are needed:

- provide_buffer OP(group leader)

- other generic OPs(group members)

group leader won't be completed until all group member OPs are done.

The whole group share same IO_LINK/IO_HARDLINK flag.

That is all the concept, and this approach takes less SQEs, and application
will become simpler too.


Thanks,
Ming


