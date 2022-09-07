Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5ECC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfOPXyuxBiEgEdUCkkLMici9jfQaSWt0Prj1+8Am3sM=; b=YQ09OUmxlfggvoE8uAMIAgkNbH
	L9fF+m3CCJlYZODTLrepaJMGCewpIDK2WcyVNak3T9gwE5bwwNBQ3ckjJd6f2qA4RAOxjU0nHEyh8
	6gUmy2JlkzVXhAhuQd3rP/s8wX5t1zs4h7apmXHa1RVZOUJzm4gxwzRIBMXnkHnu8lLPLtrXs7Ipk
	QvwuBR57LlDhQ1QfHuwad3wOZ267ehB1fDbb0h16fyUzn9ermM0DYVBc8hOOyTB8tvYz29Ll+v2CV
	eENYog8XgboZ8OaWnS+PD3sbILQxjAaBuYVD98zrbA7aD0HE2dSXdafMfw7AlPf/iZTZJt/WvN5Px
	9x0aZRHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVj0Y-000xbt-6f; Wed, 07 Sep 2022 00:33:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVj0V-000xZq-4C
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 00:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662510809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfOPXyuxBiEgEdUCkkLMici9jfQaSWt0Prj1+8Am3sM=;
	b=bz3viIM287o2KI0rJqpDoP9DqljA30vZXfA+7DGNeqsCLgwXJYaknYodbjHhKRmdKwBJmk
	u30l369oVkycTRL1ta9dpRikwDOlBefPz3SnoZqQXIKyIvcJfKnzXfgyPjKg5nWs65BE4i
	ePyW2PdfdxQ79sKxH7+55vHnArO+4LY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-flgZAXhcP5atsdgwUPt2Zw-1; Tue, 06 Sep 2022 20:33:26 -0400
X-MC-Unique: flgZAXhcP5atsdgwUPt2Zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7AE3101A54E;
	Wed,  7 Sep 2022 00:33:25 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBEF640C141D;
	Wed,  7 Sep 2022 00:33:19 +0000 (UTC)
Date: Wed, 7 Sep 2022 08:33:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Message-ID: <YxfmyvCRQiYBGkHI@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
 <YxcIkV2slhTR9MHX@T590>
 <5656419a-6271-b387-3e75-4dcb70047545@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5656419a-6271-b387-3e75-4dcb70047545@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_173331_258176_9D885304 
X-CRM114-Status: GOOD (  25.95  )
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

On Tue, Sep 06, 2022 at 05:32:01PM +0800, Chao Leng wrote:
> 
> 
> On 2022/9/6 16:45, Ming Lei wrote:
> > On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
> > > 
> > > 
> > > On 2022/8/21 16:47, Ming Lei wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > In some corner cases[1], freeze wait and unfreeze API may be called on
> > > > unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
> > > > freeze APIs more reliably, then this kind of issues can be avoided.
> > > > And similar approach has been applied on stopping/quiescing nvme queues.
> > > This leads to another problem: the process that needs to be
> > > in the frozen state is not actually frozen.
> > > It's not safe.
> > 
> > The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
> > can be done only the flag is set. Not sure how it isn't safe.
> I thought that the use of NVME_NS_FREEZE was the same as NVME_NS_STOPPED.
> If just set_bit in nvme_start_freeze, it will cause another problem in
> below scenario.
> A: start freeze and set the bit;B:start freeze and set the bit;
> and then
> A:test and clear the bit, and unfreeze;B: test and skip;
> The queue will be frozen for ever.

One simple approach is to replace down_read(->namespaces_rwsem) with
down_write(->namespaces_rwsem) in nvme_start_freeze() and
nvme_unfreeze().

> 
> In addition, I think patch 2/2 can fix the bug well, patch 1/2 is not necessary.
> No matter how to use NVME_NS_FREEZE , it may cause problems.
> The freeze mechanism is perfect, and no additional protection mechanism is required.

block layer requires queue freeze and unfreeze APIs to be called in
pair strictly, that is why I add the 1st patch.



Thanks,
Ming


