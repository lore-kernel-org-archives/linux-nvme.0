Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AC9C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lceFF/cGfnnjWUNpIJE0hyxx4M9dPQswgLC5BpYwDiE=; b=FKPfwjVq/37ZysRpujXBAt9AB5
	Um4Rqh65XLVcT1FS6+7L8XAohCqb6I+b2bUoTh19oBxkSWBKBFFf+O40Brhj2yaBkdedRghIIl/Cv
	W+x4owE8p4vu/ZJ0PtZsNgX5gsgt57/TyclI337RPEAtn9kq+jwsXgt5n6LOOKm6vi/eRFN6IMcDj
	rnG+o4emKq5nZ72370PglpzQV3MUQIwb13iFn4q3llIzyDZMEbPUVckbZKbl0QmetE4Ibo/Uy6nTX
	+AIB72euve53Bzx34OHRsaZ4upC5XOK5gP+Vlzp5cyhINu7J7CBcBmKGH+TNM1DQHKc7gOaVKfpyk
	xA+RGINQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUD1-00BQBl-7b; Tue, 06 Sep 2022 08:45:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVUCw-00BQ4M-OJ
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 08:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662453918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lceFF/cGfnnjWUNpIJE0hyxx4M9dPQswgLC5BpYwDiE=;
	b=TZNJZhTkhzjT5KvgdZVttV2vuaVpfsiiLQ5oraH631qYeGyh75hPPMkvVs7wK96mJnFGQk
	adMwCFhKLwx5ss5ZFfWKSRLdKVnN5EJyqz86R0ZozDHZNGqcq4NWvfOlaBjMkFjKGW93pB
	qZRdIGNDSsOVwGLtl3tFC+FYomgJvfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-du5jiK2xMWWV1NuyEkngmw-1; Tue, 06 Sep 2022 04:45:17 -0400
X-MC-Unique: du5jiK2xMWWV1NuyEkngmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3D77185A79C;
	Tue,  6 Sep 2022 08:45:16 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D20C492C3B;
	Tue,  6 Sep 2022 08:45:11 +0000 (UTC)
Date: Tue, 6 Sep 2022 16:45:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Message-ID: <YxcIkV2slhTR9MHX@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
 <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
MIME-Version: 1.0
In-Reply-To: <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_014522_948035_BE8706F5 
X-CRM114-Status: GOOD (  15.95  )
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

On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
> 
> 
> On 2022/8/21 16:47, Ming Lei wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > In some corner cases[1], freeze wait and unfreeze API may be called on
> > unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
> > freeze APIs more reliably, then this kind of issues can be avoided.
> > And similar approach has been applied on stopping/quiescing nvme queues.
> This leads to another problem: the process that needs to be
> in the frozen state is not actually frozen.
> It's not safe.

The flag is just to control if queue wait is needed, blk_mq_freeze_queue_wait
can be done only the flag is set. Not sure how it isn't safe.

Meantime calling blk_mq_freeze_queue_wait() on queue not being started
to freeze is usually a bug, and I think WARN_ON_ONCE() can be added
in nvme_wait_freeze().


Thanks,
Ming


