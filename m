Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92760EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kGytBMT/4D8N3PdlUpmb4evMLlTEamUTcj7Gwbg+z3A=; b=26k0GH9nq8SzdgffjzTehuQ3fE
	hxiXrrljIH5aD0XquG9Irl8gfl2DbXW9EMU43czuzRpxZr5enJGsiN+fOcnyc+/9Q6wQj+xH0zJnz
	7yR2kZx9ksKFVRkEmY8VWv6b90QWsSmn4O2aEJvmEIdWZObphUGhUZGD6NjWCNUFts8HdjsqXfNGZ
	+28CVP71EwSs86wKugYBFBWXaiZqnlTgl+oxgCg5CyAcBLl4KVPXHQh4zMgD3n7oUKs+ySqdCJCtl
	cIiR7Z2ixGH9gl3JATleabErt1AKkNoXl20yjE+Dl9VwRxUtJwd9fJE6/if9T1f4gGhoWgwwFl9QH
	5f7nw0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPGJ-00F18m-27;
	Wed, 28 Jun 2023 07:06:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPGG-00F18I-2L
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 07:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687936002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kGytBMT/4D8N3PdlUpmb4evMLlTEamUTcj7Gwbg+z3A=;
	b=KlNRKmgSfqLtm40XdVTEwrg5yD5ZgOKg1L4qIGy05ikCOl+Jdy/QEMMNDJVcH0kZ32kjDB
	YaETpouhpu5towyFHTejIPtvlHMjXQNOCSI4dlAnrbyWuGrajzOyWc7Av7kXO6yIZcR+DP
	MVNTyYm4Sqjdl/WyU8iYighsQziTqts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-hCjEIBPSMzWGqhs1ltmbFw-1; Wed, 28 Jun 2023 03:06:38 -0400
X-MC-Unique: hCjEIBPSMzWGqhs1ltmbFw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D60D185A793;
	Wed, 28 Jun 2023 07:06:38 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D858E40BB4D;
	Wed, 28 Jun 2023 07:06:32 +0000 (UTC)
Date: Wed, 28 Jun 2023 15:06:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
References: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_000644_863568_C639131F 
X-CRM114-Status: GOOD (  23.34  )
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

On Tue, Jun 27, 2023 at 11:21:36AM -0600, Keith Busch wrote:
> On Sun, Jun 25, 2023 at 08:26:48AM +0800, Ming Lei wrote:
> > Yeah, but you can't remove the gap at all with start_freeze, that said
> > the current code has to live with the situation of new mapping change
> > and old request with old mapping.
> > 
> > Actually I considered to handle this kind of situation before, one approach
> > is to reuse the bio steal logic taken in nvme mpath:
> > 
> > 1) for FS IO, re-submit bios, meantime free request
> > 
> > 2) for PT request, simply fail it
> > 
> > It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> > always set for PT request, but not see any better approach for handling
> > PT request.
> 
> I think that's acceptable for PT requests, or any request that doesn't
> have a bio. I tried something similiar a while back that was almost
> working, but I neither never posted it, or it's in that window when
> infradead lost all the emails. :(

If you are fine to fail PT request, I'd suggest to handle the
problem in the following way:

1) moving freeze into reset

2) during resetting

- freeze NS queues
- unquiesce NS queues
- nvme_wait_freeze()
- update_nr_hw_queues
- unfreeze NS queues

3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,

- if the request is FS IO with data, re-submit all bios of this request,
  and free the request

- otherwise, fail the request  

With this way, not only freeze is paired with unfreeze. More
importantly, it becomes not possible to trigger new timeout during
handling NVME_CTRL_CONNECTING, then fallback to ctrl removal can
be avoided.

Any comment on this approach?

Thanks,
Ming


