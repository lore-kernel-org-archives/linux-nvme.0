Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DAC11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 10:14:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E1660FDA
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 10:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E1660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BEF+wvBJdclSBpqonkqPndjz+v+mE8k6ebwfvKz8uns=; b=x6LriAVtkpzfqD
	DQAT7ugtxuMBKFU9aNFc0r0Q8C16YdZGXku5EEtvub15hjxTn9ykVdxB9r/kToU9nOAG6/TZbcVk5
	Q7bEBjmSrabeh/y2nbM4u9lDVUN93kipvU/pkMSzP0UjSIOaOMI/YJaxoOgRIEdcr0+VfUoZVMblL
	o4sXcBB0u/DX96CuqFT+IR83OYtGnAW/jzeRBLEWQXfQ5LldUbge6QaMA9/FL2AgDjyUTUVGjG2K5
	lVqBc2qaAOA6PBvolztRSCW13t6aa2coDxkjHk1Bc2+gsxf6aeeX8F3WlUHioLnosyrjHViiqVQ5L
	RBPaCMgSf4iaqfYp9ybg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyXEN-00Da2G-Jc; Wed, 30 Jun 2021 10:14:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyXEL-00Da1B-5u
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 10:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625048043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sE33PaxiQVlndCHStL5H+OZPSUiiG6L+MMVETSDNJso=;
 b=Iz33Xs709oObCmJZobWi9xZXc25/udmbL9pmOAxuWVA5qTvIy0SU/J7Adw5NQWzwvH55UL
 nUlTpJYXiCwqxfyzHLflDJHskCuvhPMdytOVRM0MWkkqMy/iVAgK2U40uvvuwA6dxINDJf
 uxsEwGizfwnHCt0dTrvrG1X6bBgyRqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-1bQ7HDSyOgSQq9wKMoxHlg-1; Wed, 30 Jun 2021 06:14:02 -0400
X-MC-Unique: 1bQ7HDSyOgSQq9wKMoxHlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BFB7804144;
 Wed, 30 Jun 2021 10:14:01 +0000 (UTC)
Received: from T590 (ovpn-12-133.pek2.redhat.com [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D786460C17;
 Wed, 30 Jun 2021 10:13:53 +0000 (UTC)
Date: Wed, 30 Jun 2021 18:13:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <daniel.wagner@suse.com>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH] blk-mq: don't allocate requests when all cpus in a hctx
 are offline
Message-ID: <YNxD3ekRJrZK8FKm@T590>
References: <20210630100342.1100-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210630100342.1100-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_031405_346466_1BDE41D1 
X-CRM114-Status: GOOD (  12.22  )
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

On Wed, Jun 30, 2021 at 12:03:42PM +0200, Hannes Reinecke wrote:
> When all CPUs in a hctx are offline in blk_mq_alloc_request_hctx() we should
> not try to allocate the request, as we'll fail later on in blk_mq_get_tag() anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---

Please see my yesterday's reply why this way isn't good:

https://lore.kernel.org/lkml/YNrwnWfsxf8cJcoe@T590/
https://lore.kernel.org/lkml/YNrhXFgv%2FgEWbhbl@T590/


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
