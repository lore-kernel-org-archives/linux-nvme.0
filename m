Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB096C432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1BE206D7
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Td9hTzHS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J27Y+S9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1BE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6FzbPaNFGbvTdYBo17lH2YJUlns25QAgz3iaLri6CO4=; b=Td9hTzHSSHs5a+
	5yKX8Vh5G66sAQDEAiRKUmebWqtRCFWvq865WL/pkobb69SXswGIoIfyHGb6wk4SddJ47WmTksGBp
	fXtdo1fw44OtZJUY1Bypn6D2iLBRnnrkmnOwv5vpFqOJYfaKvHmmYnUFvEiNBI4XJuqrapP5q8GOE
	aznJ7Be4JSmWWLjMmLv0fU9IvDMLwE+2ugI1rF55dh3AjDQKwGU/RERNDoEXsO3CKdgYbanArAMvq
	Tk/0A6a+DpBWvg1qYY7uYhdFxkqdFSNg/yIlqGDXy54UG3YOvQ4Ia+ms0bzAGQidw38McjQrCx9o8
	AkX+4lD6w/dZwHnfLx7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV3xt-0003q8-Hk; Thu, 14 Nov 2019 01:30:29 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV3xq-0003pX-Nb
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 01:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573695024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0YhjhKs5EmwdbzBQaPybUfvVyqHi+iwUdIe3QF3h/c=;
 b=J27Y+S9emQuvt3gFzed4xkXJiw/7dRm07i/5amVKZ8Jm7d28eFCDpiGLUNcobjHe+Zu5DE
 kjvMihLtoydc+zNgr9X6KYuehymA23W4/HUQ1i+fjzyoDEL9hYxWw2CSEuH6S11cQ3WEnH
 CJYGOP9lJI3C/X3SD2cGJCPYN6wsX9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-9fX_EZFhNsW-UikrW2BnIQ-1; Wed, 13 Nov 2019 20:30:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECBFB1005509;
 Thu, 14 Nov 2019 01:30:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A957360BD4;
 Thu, 14 Nov 2019 01:30:12 +0000 (UTC)
Date: Thu, 14 Nov 2019 09:30:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 2/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191114013007.GB14190@ming.t460p>
References: <20191113134248.26022-1-ming.lei@redhat.com>
 <20191113134248.26022-3-ming.lei@redhat.com>
 <20191113155306.GA26795@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191113155306.GA26795@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9fX_EZFhNsW-UikrW2BnIQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_173026_847867_CA11B191 
X-CRM114-Status: GOOD (  10.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Long Li <longli@microsoft.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 14, 2019 at 12:53:06AM +0900, Keith Busch wrote:
> On Wed, Nov 13, 2019 at 09:42:48PM +0800, Ming Lei wrote:
> > +static void nvme_check_cq(struct nvme_queue *nvmeq)
> > +{
> > +	if (test_bit(NVMEQ_CHECK_CQ, &nvmeq->flags) &&
> > +			nvme_cqe_pending(nvmeq)) {
> > +		unsigned long flags;
> > +
> > +		if (spin_trylock_irqsave(&nvmeq->cq_lock, flags)) {
> 
> What's with the irqsave? This isn't called from an irq disabled context.

Because .cq_lock is required in nvme irq handler.

> 
> Not saying I'm on board with this approach, though. Checking the cq

I am open for other approach if the issue can be solved.

> during submission was cheap when submission and completion sides shared
> the same lock, but this quite different than what we previously had.

Previously we have single .q_lock to cover both completion and submission.

Now we have splited the lock into two, that is why this patch added
.cq_lock for this purpose.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
