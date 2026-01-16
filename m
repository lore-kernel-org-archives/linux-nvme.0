Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF5D4A5E2
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jan 2026 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WS2SICUrwaPPpzRXOUocpqBLbS1kjBn3jEB2NsfxtKA=; b=fl+1F2fx5pLuqNt5qJkK9jhSUk
	TZ8oXn5UcGier7cCDR0UIpRj9utK1SaJvAlFUq2i5wiEKOm1vZczKVDoZVi0VcdJ6aEEvGT1ti9Lg
	TyLP3IsMYOQgWvBfbck7F5ZtxhGd3mbRwjdnOpoVbI2xR8/S3nrDyI4DH2XFSwMmmmdvXoGZu9hRR
	ZB6PSuisvsmApgE6+jhtGGUcJOyZ9N+6zgs7HTwfN92Te+uWp7C8y594fmcpQdbmngIWCFVKS+4L/
	slA0u6EwpD51xNv/2t18Z/BpCbcmXWcMBplUDfAAAWAKthxSvvy5E7GZ24hHq+SJsXLLWsOSQGxyE
	RkoD7klg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgZay-0000000DTXC-0uCg;
	Fri, 16 Jan 2026 02:29:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgZav-0000000DTWp-2M1i
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jan 2026 02:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768530588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WS2SICUrwaPPpzRXOUocpqBLbS1kjBn3jEB2NsfxtKA=;
	b=XaI0FnSckVsECukq35Nuyt8zdfqu6I3iv0G/O4MaQXaFCMP20gwOyUw3WgWx4jmTD7Yrq4
	oKZkYOk2jPiXOCg2x/eO/mJcYtLgr6OlG5T8Xri4YMUoeQKt2nD+om62ypOMw7GlMczh3n
	6yUGVtM5YGrG0hD4lVklS1W2uEXSnlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-knSiroeYO4e49MsBlmhXOg-1; Thu,
 15 Jan 2026 21:29:44 -0500
X-MC-Unique: knSiroeYO4e49MsBlmhXOg-1
X-Mimecast-MFC-AGG-ID: knSiroeYO4e49MsBlmhXOg_1768530583
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA9031956048;
	Fri, 16 Jan 2026 02:29:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345DC1800240;
	Fri, 16 Jan 2026 02:29:37 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:29:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: optimize passthrough IOPOLL completion for local
 ring context
Message-ID: <aWmijezYIIWLKeM2@fedora>
References: <20260115085952.494077-1-ming.lei@redhat.com>
 <aWkwNVgAyBbx732l@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkwNVgAyBbx732l@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_182949_681544_2C1C7569 
X-CRM114-Status: GOOD (  23.63  )
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

On Thu, Jan 15, 2026 at 11:21:41AM -0700, Keith Busch wrote:
> On Thu, Jan 15, 2026 at 04:59:52PM +0800, Ming Lei wrote:
> > +	if (blk_rq_is_poll(req) && req->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
> 
> ...
> 
> > @@ -677,8 +691,14 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
> >  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> >  	struct request *req = pdu->req;
> >  
> > -	if (req && blk_rq_is_poll(req))
> > +	if (req && blk_rq_is_poll(req)) {
> > +		/*
> > +		 * Store the polling context in the request so end_io can
> > +		 * detect if it's completing in the local ring's context.
> > +		 */
> > +		req->poll_ctx = iob ? iob->poll_ctx : NULL;
> 
> I don't think this works. The io_uring polling always polls from a
> single ctx's iopoll_list, so it's redundant to store the ctx in the iob
> since it will always match the ctx of the ioucmd passed in.

Yeah, the patch looks totally wrong, what it should record is the
io_ring_ctx for completing the request, instead of the context which owns
the uring_cmd, which can be obtained always from the uring_cmd.

> 
> Which then leads to the check at the top: if req->poll_ctx was ever set,
> then it should always match its ioucmd ctx too, right? If it was set
> once before, but the polling didn't find the completion, then another
> ctx polling does find it, we won't complete it in the iouring task as
> needed.
> 
> I think you want to save off ctx that called
> 'nvme_ns_chr_uring_cmd_iopoll()', but there doesn't seem to be an
> immediate way to refer back to that from 'nvme_uring_cmd_end_io'. Maybe
> stash it in current->io_uring->last instead, then check if
> io_uring_cmd_ctx_handle(ioucmd)) equals that.

One easy way is to add `iob` to rq_end_io_fn, then pass it via
blk_mq_end_request_batch().


Thanks,
Ming


