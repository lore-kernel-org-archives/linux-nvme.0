Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0FAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:29:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053946115B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 09:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 053946115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oarUMsE+yLHYJ5q9sN/Q6TTYzT0GV/hjLx4CUDud2S0=; b=SOCxwhJlozUfRNMK3kuDh/YG7R
	j/sdqta+LTOgG9z95d+hFmiR7ULelrhHrFbbZszcpuNF41onHIJ0izr6WOcsF18ApNanRgU3tZIqi
	soMMKPwHw+j0Vlh1SjTzLbX4i2VUHKsN6OHSjDs/Yv5iAVnNNOTTJ2NXSMk00v38Zoch81BbP7IS4
	Zo/ciUr6KO7P/pN8+7JzpZ+7XC2fW6E6naRWTwbTIhphlDtAkkURZpzeFU3WpwTyS7RGi5HLrKo+v
	Jk7MOeWyJUDA6jJGBC0xjDhiQHN2bbPu208324BXwk82tjgaIQF9R/A7O/B25K2GtgPzkwYnGdi4F
	9fKBhPVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkjvW-004zOI-Im; Wed, 10 Nov 2021 09:29:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkjvU-004zNL-0N
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 09:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636536588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oarUMsE+yLHYJ5q9sN/Q6TTYzT0GV/hjLx4CUDud2S0=;
 b=AS6s1hQtLIBb0y1YD24s1AdKZnRy5sAlU8SDqR0spVEd3KdWCVa0uimxSTQg83WuoD7J2A
 YkIP2INiKS2k8N8UwGpQDjoHeVcpij/GaQYCalYFQj4yXUTqfcXMHwdBbIFnvO/N5+yGoo
 uESQw/7AbphK4gRHzcQyMqve191DEg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-xoD12RhyOSCKeWJsjuROZA-1; Wed, 10 Nov 2021 04:29:47 -0500
X-MC-Unique: xoD12RhyOSCKeWJsjuROZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E2F804147;
 Wed, 10 Nov 2021 09:29:46 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 384F860C05;
 Wed, 10 Nov 2021 09:29:31 +0000 (UTC)
Date: Wed, 10 Nov 2021 17:29:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: sorting out the freeze / quiesce mess
Message-ID: <YYuQ9mhHtDNDVFQ3@T590>
References: <20211110091407.GA8396@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110091407.GA8396@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_012952_337636_4F14A896 
X-CRM114-Status: GOOD (  14.61  )
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

On Wed, Nov 10, 2021 at 10:14:07AM +0100, Christoph Hellwig wrote:
> Hi Jens and Ming,
> 
> I've been looking into properly supporting queue freezing for bio based
> drivers (that is only release q_usage_counter on bio completion for them).
> And the deeper I look into the code the more I'm confused by us having
> the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
> is a good reason to do a quiesce separately from a freeze?

freeze can make sure that all requests are done, quiesce can make sure that
dispatch critical area(covered by hctx lock/unlock) is done.


Thanks,
Ming


