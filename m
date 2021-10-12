Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140B4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:18:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEE660E0B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEEE660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dbv63cGybQL6Y/lktIgarNdJC7iLpE5XEMpiPx0mIx8=; b=NRLbHX2E+d4ujn
	slt7NsdZi8rGQXQC+ub7SqXCdjOMACrGjaI0EB7SPrAwuC83WL6imzu4LKexP+X6Uw248zyMmIA2k
	/vyKJ+Gj+/8rh4OnqmSiAiXkMJsCzxdE0/hp8yUEgN6u5c0RxW0pzlx7YBqKFwdqFBUzRseX3Xy+q
	FPssWFdGnWXzP9iDI/ijMRHEWNWKUCfUX8CcPKraonDXRGVgQn3l+VPO2iYsKgJ/QKUqosUjX4xyr
	QPONi1FOLWthrROiVOjl0+aUXeMARC5KUA1G1/uf5O9aU5StxQ43mcucT8c+JdH/31NMAdolLTAwI
	i9rfKVRfbH+Z1iwSeNRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJXR-00DKUx-9t; Tue, 12 Oct 2021 15:17:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJXO-00DKUW-KH
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:17:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634051872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cI6wSNt3VFHTO0Dz206mUxF9fpkASifNApOqsUeK/gQ=;
 b=PvyvcXl/nar9hEI6VtJokQU0eXKg0PIngpedIrB/dX9f+Fzn/ZySW848GbBU6ty/AQPxf2
 s3HNctO5ECKB5OFEPS8ab7QTg6l4+K/xqSUlUUH4gZ3HNcR20vQe8a6vteE/YTomn+/OL0
 DJcHYLZK1E1qCBPYMxNbUF7XJ0F1gXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-TZYveaiiOAmueDKcVEuUiw-1; Tue, 12 Oct 2021 11:17:51 -0400
X-MC-Unique: TZYveaiiOAmueDKcVEuUiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81EE1926DA2;
 Tue, 12 Oct 2021 15:17:49 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB3A10023B8;
 Tue, 12 Oct 2021 15:17:43 +0000 (UTC)
Date: Tue, 12 Oct 2021 23:17:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <YWWnEvX2uT4mUDpE@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de> <YWWjXN3GEzypVFZ/@T590>
 <20211012150741.GA20571@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012150741.GA20571@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_081754_761050_05DF110C 
X-CRM114-Status: GOOD (  19.24  )
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

On Tue, Oct 12, 2021 at 05:07:41PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 11:01:48PM +0800, Ming Lei wrote:
> > There are lots of unbalanced usage in nvme, such as
> > 
> > 1) nvme pci:
> > 
> > - nvme_dev_disable() can be called more than one times before starting
> > reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
> > 
> > 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
> > are never quiesced, and similar usage can be seen in tcp/fc/rdma too
> > 
> > Once the quiesce and unquiesce are run from difference context, it becomes
> > not easy to audit if the two is done in pair.
> 
> Yes, but I'm not sure a magic flag is really the solution here.
> I think we need to work on our state machine here so that this is less
> of a mess.

Frankly speaking, I am not sure you can clean the whole mess in short time.

At least the approach of using the flag is clean and correct, and it can
be reverted quite easily if you finally cleaned it.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
