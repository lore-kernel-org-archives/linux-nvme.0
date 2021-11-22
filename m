Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5864EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oalec0n4qeLKP6WG5TThGvL/7+vKr5m1+M6UMeUuzNM=; b=V10O8pK80rxlhRUBSUESwstSjd
	RZZiGTTT2eAaIBwuh1Q8nIVj2LRgBY8F4WFuDozsnAb2coPgabu3khxGXdDO8aombDNqGeytetkWJ
	HEJxt6knOIDutbR4LYl17BOfCSSwFqTzJRrojFIE4bETtjw9K+IefulDnRwA4+bmTmeLhCTVP2PmI
	LL3FsfuBhAbMlY6sn7cCRqAR5ta4n+Xlp6AWt1BXnhj5y4GzGAqzRLasCtFumelgqNvdwsRfwV4bT
	tAer47A0iEipK7njaG+bdUgobs1INOXhzgYqk+aH7Lt1WOrblp/BQsaB45tscxy46F1bzzakcrOmH
	Vv+50iBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9LH-00Gdvt-UM; Mon, 22 Nov 2021 13:26:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9LF-00GdvO-Sd
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637587600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oalec0n4qeLKP6WG5TThGvL/7+vKr5m1+M6UMeUuzNM=;
 b=TWqExlKHPJ+robHhagrTNob4AbrY6j56os2p6uQcnTVbyRFRb4oOSDu5iQY3YIh0vO/Adz
 PW5KdR4XyxpIAWTqHiDDnxkBmFd20wujkLMUMu8nhwDIkT3ttrty+76GV1obj6kQQ5TXVU
 Js7i2gjbHrs606cVzAuJRzDxJw+jWOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172--vk2ugstMdeICkgiPk5IDQ-1; Mon, 22 Nov 2021 08:26:35 -0500
X-MC-Unique: -vk2ugstMdeICkgiPk5IDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE448066EC;
 Mon, 22 Nov 2021 13:26:34 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F37C908B;
 Mon, 22 Nov 2021 13:26:29 +0000 (UTC)
Date: Mon, 22 Nov 2021 21:26:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
Message-ID: <YZuagPbZJ6CjiUNi@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_052642_021543_6D192ACA 
X-CRM114-Status: GOOD (  13.37  )
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

On Mon, Nov 22, 2021 at 09:56:10AM +0200, Sagi Grimberg wrote:
> 
> > Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
> > queues in parallel, then we can just wait once if global quiesce wait
> > is allowed.
> 
> blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
> obviously it has a scope.

How about blk_mq_shared_quiesce_wait()? or any suggestion?


Thanks,
Ming


