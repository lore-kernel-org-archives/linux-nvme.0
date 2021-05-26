Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD771C47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:25:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0FF613C7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0FF613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gdzVKftse2iQ6T0+wPznJtCOsasS4Rq9I7Dzc58ir1E=; b=zcDadaslhld1pj
	04x4wzIcW/KSeGtCXAYNSvSjQ4/bQCwl8TPfPwBLHZeKNc9mUR0f5DvRN93OrQprDQkrPzhju4X5S
	R7E4KTqo6mPz9HeQFM7GPm6vLi1wJZa/Tt1O1n3bGpoznPjw36cE38eJ8UxSB0Ypc8CMIo/L495FA
	fD3Mk7G74isqV9QX6t6Dpy78ddnhOtzWuU0sJS2LdPAW5L8vT1EN4TvRI551g6gdDl0xlRJv8TaVH
	WS0bT4nSM0FEcue5XXxnzLP6V2TF5gJo6pSNoAsL+TUTuih9JRie7b+eJuXblUdDYsFUayM6dOlKR
	P0dwX0omDeuS/6igz7kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lloqo-00CQEN-Sq; Wed, 26 May 2021 08:25:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lloqm-00CQDI-50
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RMhOAcQOW55vgjgxWWqrSlVhG/1Gigk5KVeEqYJeD0=;
 b=EzkefCNLCsbBpuQLHbXPXHZ8KkHWyIhXM7ovptiLWy2nc/EkLSbH8sjR8st848BnDVyuQn
 nfSA7sF96367sADwgHiUDA6U2HIIej3cC0MaeFwRu4Pm4+/jiv1opWX+xELBSR8EL/lE1m
 Y30Ft382UEXnAsUgiQMzk8scNXKgo/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-m5ztJeveO0CkkF2uuxx8dw-1; Wed, 26 May 2021 04:25:09 -0400
X-MC-Unique: m5ztJeveO0CkkF2uuxx8dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 207F5804B89;
 Wed, 26 May 2021 08:25:08 +0000 (UTC)
Received: from T590 (ovpn-13-243.pek2.redhat.com [10.72.13.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7BCD6A046;
 Wed, 26 May 2021 08:25:02 +0000 (UTC)
Date: Wed, 26 May 2021 16:24:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <YK4F2ll2qLWqzlKT@T590>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-3-kbusch@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_012512_296202_8F952CC1 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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

On Fri, May 21, 2021 at 01:21:43PM -0700, Keith Busch wrote:
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> No changes since v2

Looks fine, one thing need to pay attention is that this nvme polled
request won't be marked as REQ_HIPRI.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
