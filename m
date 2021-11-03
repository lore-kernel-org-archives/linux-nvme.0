Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D4CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 10:45:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E328760524
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 10:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E328760524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKjM8KQkY11zyN0i3t01mXgIi/4Vd7w8FzA375EM8BA=; b=BLUgvtBFG8kgpxhXNJv/EdPjsV
	5QEEG+lWtP1HnFNUobUVYk6R1PtzMTxw1p1ebje+Ly9vty+D/K5pBkBq4RrY8VXayrteRBliJ7Tc5
	3DJHbNACrPCQjDeFy4QevnK4RhCFdjLgkVYu5c+s0k/cWb/5eRfG+DTUPNk7sF+m+4twiFY02ki1e
	7YiMGo6xYSkkuRgThYj1I4O6x9OiaY/luZhWg5DXNy2AOub9dT3IsNqDm+tdMP0gV9Flzm4/khbvs
	SPAD+Hh2aUNMVZSobN1KRuIuL8fArN6kHRT8q88B8SKBn4puFTQsAASC/zmEYCmevjIRw6VEqbhQR
	/axn4B4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miDm7-004ryv-IH; Wed, 03 Nov 2021 10:45:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miDm4-004ryN-Bo
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 10:45:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635936342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKjM8KQkY11zyN0i3t01mXgIi/4Vd7w8FzA375EM8BA=;
 b=V23SBngJ7aCxeAHyCVE1nb6q68xPr6lnKQ1+uLI8bMARru6EoFQ1GpLFtCePc8NTFYeGmo
 16/MhWxmcTnruRHlkh8cJRaPgoRNKqvB2up8zEfvBXMY8fhF+ALXcg9D2oZrR/rBc+q6I9
 1Ld+vGDwE4AI8sowa22ZQrbQA40NdAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-i1RCmjlpMJ6XP_-SApq-9w-1; Wed, 03 Nov 2021 06:45:39 -0400
X-MC-Unique: i1RCmjlpMJ6XP_-SApq-9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BBE5100B700;
 Wed,  3 Nov 2021 10:45:38 +0000 (UTC)
Received: from raketa (unknown [10.40.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4991ACBB;
 Wed,  3 Nov 2021 10:45:34 +0000 (UTC)
Date: Wed, 3 Nov 2021 11:45:16 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Subject: Re: [PATCH] nvme-tcp: fix memory leak when freeing a queue
Message-ID: <20211103104516.GD4840@raketa>
References: <20211103081817.94820-1-mlombard@redhat.com>
 <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <a609e935-f529-d87e-a950-33367694aef5@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_034544_624254_34BE6EFD 
X-CRM114-Status: GOOD (  22.50  )
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

On Wed, Nov 03, 2021 at 11:23:45AM +0200, Sagi Grimberg wrote:
> 
> > Release the page frag cache when tearing down the io queues
> > 
> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> > ---
> >   drivers/nvme/host/tcp.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 07156ea9d1a8..999417626b15 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1229,6 +1229,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
> >   static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
> >   {
> > +	struct page *page;
> >   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> >   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> > @@ -1238,6 +1239,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
> >   	if (queue->hdr_digest || queue->data_digest)
> >   		nvme_tcp_free_crypto(queue);
> > +	if (queue->pf_cache.va) {
> > +		page = virt_to_head_page(queue->pf_cache.va);
> > +		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> > +		queue->pf_cache.va = NULL;
> > +	}
> 
> Thanks Maurizio,
> 
> Why do we need to the pf_cache.va protection? nvme_tcp_free_queue
> is already protected against re-entry with the NVME_TCP_Q_ALLOCATED
> bit.
> 

It's not the re-entry what worried me, I thought that nvme_tcp_free_queue()
might be called before page_frag_alloc() had the chance to initialize the pf_cache, triggering
a NULL pointer dereference. I am doing some tests right now and it seems not to be
possible so maybe we can drop the "if".

However, we still need to set pf_cache.va to NULL because the queues might be re-used
in the error code path and we have to prevent page_frag_alloc() from dereferencing a
freed cache page and corrupting the memory.

Maurizio


