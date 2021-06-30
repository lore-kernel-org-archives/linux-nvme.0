Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA4C11F66
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 00:00:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231D461447
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 00:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231D461447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p7WJLj0WdGJ9biQFuLOQaZ/9WpT95e6HTHt7r87aNdI=; b=x/d9h3Iy/jl+4I
	lHjCS9812UsKG4nErWmq/pO77tTmng37gfDo52ns0CGMWVDAJ0lOyMTU7XXAY/QMdW+1eXAQuyXYE
	g3/DhftXqi1ivNS5zx+htpyu5hY3qQkDP+LbhJDeTa/PQDbJx5mOov0na5B9jWZM13n+Ewq9lkVqf
	Lb4IPXdTP0n1lz1m1JtsDYivWVNfXnqMOJ5rp3ecmhW4udMab+f0sRxC9pJIO/gnqJWOgsuRttMiB
	k0J1FuHGwoeWrQIdRVvidctKfwYm2pVdz7FMwWN0+4bblOt4P6bNdazN5Au6qNXHRQkKIDWa5vN2E
	ZNonwSQp3sSWd4dQQHKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyk7R-00Fdj3-1s; Wed, 30 Jun 2021 23:59:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyk7N-00FdiJ-5v
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 23:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625097583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jw4lNKzQTa8WoEHtp9xHFeVAe2ctfiqLinrekfQ4TYU=;
 b=C9UJ5OAXlE0mg8L2lfICREjfn2pwX3yuGzZQ0S1VFMv/faEEKiZrBHVme53WKavd+2Z+Do
 1qziK9DIg50oEdnphiEaRAz2QzR/6ZVncE5IDir7U5mEKEX4aU+JYjQH+pP9HPk98fj3nW
 yIR+ebHhzBUOW1sTXJgNy2AA8WuJ0Sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ECrR0RMFNkKwyZnwI0pO2w-1; Wed, 30 Jun 2021 19:59:41 -0400
X-MC-Unique: ECrR0RMFNkKwyZnwI0pO2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF811084F40;
 Wed, 30 Jun 2021 23:59:40 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15D215DA60;
 Wed, 30 Jun 2021 23:59:30 +0000 (UTC)
Date: Thu, 1 Jul 2021 07:59:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YN0FXrcwXfAwGU6w@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
 <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_165945_930152_C4200B87 
X-CRM114-Status: GOOD (  26.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
> On 6/30/21 8:59 PM, Sagi Grimberg wrote:
> > 
> > > > > > Shouldn't we rather modify the tagset to only refer to
> > > > > > the current online
> > > > > > CPUs _only_, thereby never submit a connect request for hctx with only
> > > > > > offline CPUs?
> > > > > 
> > > > > Then you may setup very less io queues, and performance may suffer even
> > > > > though lots of CPUs become online later.
> > > > > ;
> > > > Only if we stay with the reduced number of I/O queues. Which is
> > > > not what I'm
> > > > proposing; I'd rather prefer to connect and disconnect queues
> > > > from the cpu
> > > > hotplug handler. For starters we could even trigger a reset once
> > > > the first
> > > > cpu within a hctx is onlined.
> > > 
> > > Yeah, that need one big/complicated patchset, but not see any advantages
> > > over this simple approach.
> > 
> > I tend to agree with Ming here.
> 
> Actually, Daniel and me came to a slightly different idea: use cpu hotplug
> notifier.
> Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
> no I/O is pending during cpu hotplug.

Why should we ensure that for non-managed irq?

> If we now add a nvme cpu hotplug notifier which essentially kicks off a
> reset once all cpu in a hctx are offline the reset logic will rearrange the
> queues to match the current cpu layout.
> And when the cpus are getting onlined we'll do another reset.
> 
> Daniel is currently preparing a patch; let's see how it goes.

What is the advantage of that big change over this simple way?

Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
