Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 08:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBE561A55
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 08:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FBE561A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gET37+W1NLj9OEtiOS1TDk9Pd6SGaFZ7d16hynuXJnI=; b=AIUs3vZOgDyLX5++B2R2MEfxgU
	0KJzD1k3S1tzqMNYvETUnMcWMywhstdQr+rXSSsEOdtLvofz0MRzy4+S4IagZHCDc0AB03xEvdak8
	O0A2GzUI81S5TdcZFalIzqIdH+TtJpvQyzkC3BcyoRBqXM9amrvwhfc/4fBZ/994KedEv6S6xORN+
	YHO4kPzqkDlg6bVZ7q/p7gqTQBsxBb8afDQDY1X39wGIAbWELD/UhUtw+OgabtyyjFsL4SQo48Mkj
	zNyc2xaO/15pNdU2T5u2WitJ9BohH2XWNdBkT3BJZcRAvs2Ue5M8vb+NkMVbNjwTN0CBf29LR4J5X
	l2iEtFWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnyyo-009hwv-HO; Fri, 19 Nov 2021 08:10:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnyyg-009huo-6U
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 08:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637309432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gET37+W1NLj9OEtiOS1TDk9Pd6SGaFZ7d16hynuXJnI=;
 b=R1Mzg3xJ9IHwJ8UjcQn0syq9yrEf13PK6y9KmVqiQyjpkq4MM51HnubuNx2OjjAkoiN9CI
 pI65xnFeZliwoOEtjUkZb39BIQ4MoIcSQ18hjn6BKaxbQkztmO+cI5dVuIC75fPuoDT9p6
 U2YaRVtDoiskn84FT3fgbDo7pzkMWlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-r6sukmb6Mx6PP1eWQM-AnA-1; Fri, 19 Nov 2021 03:10:26 -0500
X-MC-Unique: r6sukmb6Mx6PP1eWQM-AnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5B718125C1;
 Fri, 19 Nov 2021 08:10:25 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8644860854;
 Fri, 19 Nov 2021 08:10:08 +0000 (UTC)
Date: Fri, 19 Nov 2021 16:10:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
Message-ID: <YZdb2/XoJVJOa1r+@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-2-ming.lei@redhat.com>
 <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_001034_364201_0F39E403 
X-CRM114-Status: GOOD (  19.61  )
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

On Thu, Nov 18, 2021 at 08:30:49PM -0800, Bart Van Assche wrote:
> On 11/18/21 18:18, Ming Lei wrote:
> > +	bool			alloc_srcu;
> 
> I found the following statement multiple times in this patch:
> 
> WARN_ON_ONCE(q->alloc_srcu != !!(q->tag_set->flags & BLK_MQ_F_BLOCKING));
> 
> Does this mean that the new q->alloc_srcu member variable can be left out
> and that it can be replaced with the following test?
> 
> q->tag_set->flags & BLK_MQ_F_BLOCKING

q->tag_set can't be used anymore after blk_cleanup_queue() returns,
and we need the flag for freeing request_queue instance.

> 
> Please note that I'm not concerned about the memory occupied by this
> variable but only about avoiding redundancy.
> 
> If this variable is retained it probably should be renamed, e.g. "has_srcu"
> instead of "alloc_srcu".

Fine.


Thanks,
Ming


