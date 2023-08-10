Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52CBC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bs+EzDzKejNehwXguDrSDBRwU96r1I++/XRoFp6RJVo=; b=4sh3fONOoZx4Rh6u0f9XHgsCKZ
	piGVzfIJDuNvRmigTev9g9ZxQbrS7palHHa9Y/i8wy4K1mfhEoGXvO2GFfxxPxfwCgYpZVZzGm5Ya
	tq6qfbzJrpwSfXIwoRZs/GtQNU2b8BkFO2NtEVcqghKy8SgwQhDr7GxHVQnVG1UttLJECVrwEgrv7
	9XlrGUVuq3+w2SMsFfKxIbXCsYEoSZb5VH0QE617ljgPMeM6zSjEd2SvqWbFSVK5LriI2feW/EXpH
	Oq8esl09XMVGTBc2tZ5UjI5lVvGxk4FlNDdJ17BvazAdeY54+sPQDurlt/ITVV2t3s6ezaSH7DJL8
	+nYfT07g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU0on-006qML-1t;
	Thu, 10 Aug 2023 08:14:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU0ok-006qLl-1M
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 08:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691655289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bs+EzDzKejNehwXguDrSDBRwU96r1I++/XRoFp6RJVo=;
	b=LSd9EH+uxdFueyIDk5mOXJz5zY7W39ngE9aJxc8qohwNEutZDMvE+HoYPXAny+pvozMB9a
	lSEQzhDHep0wLccVhJBttkkYgNQ9ueA3/D8murWzT+doWKzpn+QslT9QxLcMtesMguW8nV
	5zGBXWe7Ilvg9pIBKXjXNFLraxTeTfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-BbTKM07vOym1l0RiW5UL7A-1; Thu, 10 Aug 2023 04:14:45 -0400
X-MC-Unique: BbTKM07vOym1l0RiW5UL7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DEED85C6E2;
	Thu, 10 Aug 2023 08:14:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA32F40C6F4E;
	Thu, 10 Aug 2023 08:14:40 +0000 (UTC)
Date: Thu, 10 Aug 2023 16:14:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Guangwu Zhang <guazhang@redhat.com>,
	Anuj Gupta <anuj20.g@samsung.com>, ming.lei@redhat.com
Subject: Re: [PATCH] nvme: core: don't hold rcu read lock in
 nvme_ns_chr_uring_cmd_iopoll
Message-ID: <ZNSca/sJGA3zXpJ4@fedora>
References: <CGME20230809020844epcas5p30e520491fa59ab8c20836d4275931e8f@epcas5p3.samsung.com>
 <20230809020440.174682-1-ming.lei@redhat.com>
 <20230809065920.GA19415@green245>
 <ZNNF/2NEPYCeiXlM@fedora>
 <20230810063411.GA13970@green245>
MIME-Version: 1.0
In-Reply-To: <20230810063411.GA13970@green245>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_011450_528639_296EFF1A 
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

On Thu, Aug 10, 2023 at 12:04:11PM +0530, Kanchan Joshi wrote:
> On Wed, Aug 09, 2023 at 03:53:35PM +0800, Ming Lei wrote:
> > On Wed, Aug 09, 2023 at 12:29:20PM +0530, Kanchan Joshi wrote:
> > > On Wed, Aug 09, 2023 at 10:04:40AM +0800, Ming Lei wrote:
> > > > Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
> > > > polling, and the associated NS is guaranteed to be live in case of
> > > > io polling, so request is guaranteed to be valid because blk-mq uses
> > > > pre-allocated request pool.
> > > >
> > > > Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
> > > > isn't needed any more after switching to request based io polling.
> > > 
> > > > Fix "BUG: sleeping function called from invalid context" because
> > > > set_page_dirty_lock() from blk_rq_unmap_user() may sleep.
> > > >
> > > > Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
> > > > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > > 
> > > Thanks Ming. Looks fine, but any link to this report?
> > > I don't see this breaking in my tests. So I wonder how to reproduce and
> > > improve the coverage.
> > 
> > It is reported in RH BZ2227639, and follows the stack trace:
> 
> Tried to access, but no luck.
> Any chance that steps can be posted here?

It is reported by Guang Wu, and I think it can be triggered by:

1) enable CONFIG_DEBUG_ATOMIC_SLEEP

2) run some nvme pt read workload, and fio should be fine, but
don't pass --fixedbufs

Just run a quick trace on set_page_dirty_lock() in non-debug kernel, which is
really called from bio_poll()<-nvme_ns_chr_uring_cmd_iopoll().

Thanks,
Ming


