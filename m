Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E926FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 00:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A702E61074
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 00:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A702E61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHu0xi8kNhwEy8umE0S0z8zYWzB1LSxz+DK8Rurzgc4=; b=GdXfxkdYamDUNwbP+kS8pAApwj
	ZxBUfIaWnwfwEM6fu2jzYahwRJUVuMNQevO4oCm6UFmlqrrxEklieWIwJcfqcvNaMLcu0W80xD8iL
	xKqEufn/GHwN/k+93U/8UrUNLM2E+TTmke3Xl2HezXpsVcDvi1+Zv6l/icLDhF46vb+MRHPFC+OJt
	2uyzdKu1gEJQa/xNYjXbJsnyi2G8+ziTZIQH5yKIdwqcAiUFly3iLsF+m2AQvvKukZsmlPlSLrWCD
	cU3V8Eaci8pPXndE/NwKHvcy90nZFxGqvfSx7ys/c9q2v9d+5v2RbDvAeX7kUOS9q/LlnwnPEVHSS
	BKEQALNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mczOt-0033l0-30; Wed, 20 Oct 2021 00:24:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mczOq-0033kT-8i
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 00:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634689444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHu0xi8kNhwEy8umE0S0z8zYWzB1LSxz+DK8Rurzgc4=;
 b=VsbUre4ZIRE9XAKBLdhQ/gbOeUYzry7Qi1+NviNzYmtJNkFiYEFlDbHZgoFqT/Ok6qsflR
 tXQI2F0aAud8IpuvsF5tbAVxZx+iWAOUCLSpTaI6xe0Di0PvzBFrhN5/SE41zo/wKAt8J6
 yGkLNEz3oPfTlQWAxiDUbppNUIPKGVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-AcgGz8wXPES9A5MyHxFeCA-1; Tue, 19 Oct 2021 20:24:01 -0400
X-MC-Unique: AcgGz8wXPES9A5MyHxFeCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269628042DF;
 Wed, 20 Oct 2021 00:23:59 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DD3B17CDB;
 Wed, 20 Oct 2021 00:23:50 +0000 (UTC)
Date: Wed, 20 Oct 2021 08:23:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Message-ID: <YW9hkWyO6H5sc6vY@T590>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de> <YWzIazr+VjY9MNCv@T590>
 <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_172408_428924_3B545091 
X-CRM114-Status: GOOD (  19.49  )
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

On Sun, Oct 17, 2021 at 07:19:13PM -0600, Jens Axboe wrote:
> On 10/17/21 7:05 PM, Ming Lei wrote:
> > On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
> >> Except for the nitpick just noted this looks fine to me:
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> >> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
> >> up locally.
> >>
> >> Jens: do you want me to take the last patch through the nvme tree as
> >> well?
> > 
> > Hello Jens & Christoph,
> > 
> > Any chance to make it in v5.16?
> 
> Yep, I'll take a look at this in the morning. Rebasing the block tree
> anyway, I'll let you know if we need any changes here.

Hello Jens,

Looks the 6 patches can still be applied cleanly against both
for-5.16/block and for-5.16/drivers today, do you need an resend?

thanks,
Ming


