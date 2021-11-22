Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2E7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWmBfg1nuOBRdYR+mWwAp4mqSyWbybJ6GUyoPE7fU9A=; b=4UaXLQOjL9UAH6aMcGSqe15bjs
	y1P9hb1E3q9VX/N+xBJIThLdy77dywrtOCqF/ZZfzHF4iXCoUv1g/5LjvGv78y1G8Pfh5Kcs/A/YU
	Myz3A4a/rqibyMpFuBcAAYxabchj7bQp236iHaSTzhPCBYL03nHMbVbIykLVgk6p4AUXIHeM2fqaG
	fmsSwG17SKHjD34ZRWmPzSkj2ZveLna5hJp7N1JGpfo3wTc8vBl1gmPdlZbf9UUJVjg2+zLhM8ui+
	2ZIoqsK4x285ixwcIRJByyDu/eZq5FMDsS7cWHSx24OJkKuMyHmptFrkbnBOQRVeFGkgryjjo9+ep
	pLuKJkMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp948-00GaPZ-VF; Mon, 22 Nov 2021 13:09:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp945-00GaOE-Ra
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637586535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWmBfg1nuOBRdYR+mWwAp4mqSyWbybJ6GUyoPE7fU9A=;
 b=C4lrnxM6X0ESyWG7Fq685NSQtrhMbX5jLrSOCb+HGpoMZYZ/feAL9LJklEhCzZizOhfbEc
 AWezuxtr1zJeLIKHnFo8MG90tFmyioNvsRO5an7sQVQnOGPfHoG9kDipOK7Hl77/qFlwV+
 WnESodBqvVboGs1RJ66n2GkfWpcvOeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-OYo08hrzPFCgYWnFe0L2Bw-1; Mon, 22 Nov 2021 08:08:50 -0500
X-MC-Unique: OYo08hrzPFCgYWnFe0L2Bw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6957280668B;
 Mon, 22 Nov 2021 13:08:47 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A937945C;
 Mon, 22 Nov 2021 13:08:42 +0000 (UTC)
Date: Mon, 22 Nov 2021 21:08:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
Message-ID: <YZuWVlakjrzICKc1@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-2-ming.lei@redhat.com>
 <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
 <YZdb2/XoJVJOa1r+@T590>
 <a219fff8-8f2d-adb1-eb8c-3e5712cea5bd@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a219fff8-8f2d-adb1-eb8c-3e5712cea5bd@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_050858_008535_914E41F6 
X-CRM114-Status: GOOD (  20.97  )
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

On Mon, Nov 22, 2021 at 09:48:35AM +0200, Sagi Grimberg wrote:
> 
> > > > +	bool			alloc_srcu;
> > > 
> > > I found the following statement multiple times in this patch:
> > > 
> > > WARN_ON_ONCE(q->alloc_srcu != !!(q->tag_set->flags & BLK_MQ_F_BLOCKING));
> > > 
> > > Does this mean that the new q->alloc_srcu member variable can be left out
> > > and that it can be replaced with the following test?
> > > 
> > > q->tag_set->flags & BLK_MQ_F_BLOCKING
> > 
> > q->tag_set can't be used anymore after blk_cleanup_queue() returns,
> > and we need the flag for freeing request_queue instance.
> 
> Why not just look at the queue->srcu pointer? it is allocated only
> for BLK_MQ_F_BLOCKING no?

Yeah, we can add one extra srcu pointer to request queue, but this way
needs one extra fetch to q->srcu in fast path compared with current
code base, so io_uring workload may be affected a bit.

Thanks,
Ming


