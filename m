Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BA6C282C5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bYndnnhsKipQ6hxTRPQ/mbEwD8lnDV7Rugy7tX+s/I=; b=k+zGHpJWi4jdZcwxySeFedEKe5
	eWkl/n/D1gWjE0O3U5B4zekzRr8Q2eHbAflK5OM+4+ekJfuyh261BezM1xI4Llvp5ywShHKQshDOz
	mjIvJLFViHBPk2pVLtoFKuHdT+J41LRj/ivaERzs+A01eZ2l2x5IZlQFWx+pQ8EyqwDdNrzjntK4H
	i0NGIEEkaJuhmNpkbIgBzX4rn4kn8hBOu8x26fei11saDTkciuGzIV1ndfVclNLVr9+2639vp0T2z
	LzdJA6o8jqeI15wwALf9fDtwA8OSwSB56FB5qWTqeWxSLza+g5/g7nMGxlMWCo7zvRxunyn9LKoID
	XWHVnJMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvX6-0000000A8FP-3SLV;
	Fri, 28 Feb 2025 08:15:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvSn-0000000A7KI-3WC8
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bYndnnhsKipQ6hxTRPQ/mbEwD8lnDV7Rugy7tX+s/I=;
	b=aDeu/cE75bRPpUt7CY+Fc1VimRLJWzRwJJSuqIABy+5hjFodZs1m1rewk2gzhcOw1jqW9r
	p9L2ZD57I7DuAs7HEK12jVT8629DpACjqQVjD3MC9wTFCCPtFSthV88oy0wGnMLia3Xhn7
	8QzFYGc/tK2sbXVf3jnpGiurtlUzXg8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-LWpd0YdXOKGwfvZYcMN0PQ-1; Fri,
 28 Feb 2025 03:11:09 -0500
X-MC-Unique: LWpd0YdXOKGwfvZYcMN0PQ-1
X-Mimecast-MFC-AGG-ID: LWpd0YdXOKGwfvZYcMN0PQ_1740730268
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A9B1800879;
	Fri, 28 Feb 2025 08:11:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F343E19560AB;
	Fri, 28 Feb 2025 08:11:00 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:10:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 1/6] io_uring/rw: move buffer_select outside generic
 prep
Message-ID: <Z8FvjnXq3RpX4eZ3@fedora>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223916.143006-2-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_001117_948390_1697DB03 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 27, 2025 at 02:39:11PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Cleans up the generic rw prep to not require the do_import flag. Use a
> different prep function for callers that might need buffer select.
> 
> Based-on-a-patch-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming


