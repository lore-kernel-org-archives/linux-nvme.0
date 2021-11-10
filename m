Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:52:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B2D61076
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99B2D61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7oqI1vSf7oW8hr4gNp34G0zlAlDGH6S3+qYy9C5RByg=; b=QlgzBri0fS1JEH8NZZeOMEnM7U
	xlTx6jtZAP+nHn1/8B/5MTd1wFZOaXPULQRjaFRNwWqQUJc+XZ9ueV6AbPWw3I0IRO5TRRikL9kgh
	bMdjeXAYb9G+r/pGPhFmNWXN1U2aGgAYh7s4JNjpA7lbrobvqAwnqJ7VER9Rz/nVFg9yPe5Zl9EDN
	pe037HW8vRDmgNlM7DgXOHwCTBc16HQkDvmyVoj979i0SMEYhI4aIWUlm4U8SbdpVYjCu42hDW+xs
	OKf6vqWY8NIUF05cZ5vF+Mdme27BTNFLvYfE4+yZS3QAGeNJ7CIolNCHklJu+Ds0OJNcQz+DiEOQz
	wjNnZ3OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkkHO-0051od-Dx; Wed, 10 Nov 2021 09:52:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkkHL-0051nv-G4
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 09:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636537946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7oqI1vSf7oW8hr4gNp34G0zlAlDGH6S3+qYy9C5RByg=;
 b=f2jgHEhl3pAW1QX0dOpMf39e9G5VKa6SMehA6t5SHjf3xzlg9SrRntmVxS7z+MPyQFJhtn
 iHP4pZYaL9DtidvEdwsy8NMbYtjy9DQISigNawtQmXo6YnOJun4b94LiUNDSl9CBJJeE/x
 SgVn2LhxsQCkSTTEXlH34ZzrIf3RdIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-pCtNLx6KN3WaiDesogfB7w-1; Wed, 10 Nov 2021 04:52:25 -0500
X-MC-Unique: pCtNLx6KN3WaiDesogfB7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07A50804141;
 Wed, 10 Nov 2021 09:52:24 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 118E410016F2;
 Wed, 10 Nov 2021 09:52:20 +0000 (UTC)
Date: Wed, 10 Nov 2021 17:52:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: sorting out the freeze / quiesce mess
Message-ID: <YYuWTefkvpy5uYgs@T590>
References: <20211110091407.GA8396@lst.de>
 <YYuQ9mhHtDNDVFQ3@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuQ9mhHtDNDVFQ3@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_015227_636134_C96172DB 
X-CRM114-Status: GOOD (  18.11  )
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

On Wed, Nov 10, 2021 at 05:29:26PM +0800, Ming Lei wrote:
> On Wed, Nov 10, 2021 at 10:14:07AM +0100, Christoph Hellwig wrote:
> > Hi Jens and Ming,
> > 
> > I've been looking into properly supporting queue freezing for bio based
> > drivers (that is only release q_usage_counter on bio completion for them).
> > And the deeper I look into the code the more I'm confused by us having
> > the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
> > is a good reason to do a quiesce separately from a freeze?
> 
> freeze can make sure that all requests are done, quiesce can make sure that
> dispatch critical area(covered by hctx lock/unlock) is done.

Another difference: quiesce usually is used to stop to queue requests to
LLD, and driver needs no requets queued any more after the interface returns,
freeze can't do that.

Thanks,
Ming


