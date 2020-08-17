Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05290C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EF823142
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6mDbRUO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDJ5XtdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EF823142
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VeoyDJIi+lP0WSxvII6K+Qo3VrPsrxEvF/ZBdmgY1NU=; b=K6mDbRUODTs3AtTBIlEwMSQbQ
	k74cekMMQFOyC5ORSRV366z0zNptvlgIK84Zs9D81xUD0fJaz6w5zYOZaPCixSx/ElZeK+BiT4YDE
	0OIcWzNtvCiGDjeFXxxzytHYPjSfqdfE77onjHfoSIc5ZVlcgHGq0kAqGuUzgqdehj4Cw99MOSMyV
	rQUl59HvZtkNnbEDZTHOYVLMacc6uhskdIV7V48s147NragFXPSxJtJ22rRLoJ2f8zH/qCAeAO8UA
	psFDhIxSZCECwsmIsulPpIqW3d0/qeZI2x23QAfTMmEGqS0k4qt/RPPazOglCkVbgtAbXE/IQ/RT3
	jDNtiLAOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7gyx-0005E6-Gp; Mon, 17 Aug 2020 15:23:31 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7gyu-0005Dg-Bu
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 15:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xtV+YjtZsC+LGewmjOYdFMyZcep903G+n5tkMM2tnRM=;
 b=TDJ5XtdK92y6qgvSSMTShqwelkXHlbTKQrugGUbblxVOSa33U/c/h8e5o0RhzagYlytKMm
 mhBcsA8VCUNKh43mxdCfmv2i+zlVE7Fjq94EQa5blZXq94QyRdCfXcsEP2zAZMK04Uncbq
 Qh0EuWrzVK4ie/y5+DbBJrKkKvRXZg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-FNCuKVYCOIG0WRb1dJFB3A-1; Mon, 17 Aug 2020 11:23:24 -0400
X-MC-Unique: FNCuKVYCOIG0WRb1dJFB3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 102B4100CEC1;
 Mon, 17 Aug 2020 15:23:23 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B485D5D9D2;
 Mon, 17 Aug 2020 15:23:22 +0000 (UTC)
Date: Mon, 17 Aug 2020 11:23:22 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] nvme: redirect commands on dying queue
Message-ID: <20200817152321.GD30005@redhat.com>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-5-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-5-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_112328_484894_E85C5A0B 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17 2020 at  4:15am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> From: Chao Leng <lengchao@huawei.com>
> 
> If a command send through nvme-multipath failed on a dying queue, resend it
> on another path.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of the completion refactoring]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Did we ever learn from Chao what the original issue was?  Deciding to
failover on completion because blk_queue_dying(), without any other
insight, is definitely new to me.

But this looks fine, just in general such blk_queue_dying() checks are
pretty racey right?  Feels like this might paper over something else but
without knowing more:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
