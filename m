Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48054C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7cKhGZbNn0cTfINoGM+8H9su2ksUdFx27vnXufiDesc=; b=sIPCXDWKo3gzAO/HHC/lqfgIAG
	rPrfQ+ocJ9GCwe/JYxuM1XTIDaMApaKLoXFbQq9P8FXJ6+4vTJqSiuA9DfGovIQd33M5Jfcy5P5rn
	xifGhM71efMiNgQI2VuUuA+WxU8i4E48XkS3lhYEry0NeBTRNOc3LHnQiS+Dxsi3zAOvniyFoZbLP
	AL/gXCZyibjcHPKSmr2t3sXtlpcAyRURVEfLVtTaa8uaDwJozu5g9+8WN1G/ezauM5A6TfM5fMCcL
	PFf0Cehoe/tHHBJI7JMPh5WxqXTm7agLcoDQoXI/IyvIFfUBdyH6FO5i1kvJiV5eg3sevsAo/4jFx
	Td6as64w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okx3g-00Cqcc-VW; Wed, 19 Oct 2022 00:35:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okx3c-00Cqbd-JF
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 00:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666139731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cKhGZbNn0cTfINoGM+8H9su2ksUdFx27vnXufiDesc=;
	b=bQ50e+QWGPlwJbPJjEQJCOO/vv3adrRabsnjhrNcxMaID3XwWA4L/Zj4yKtKnVjNJOYZsY
	L0ApNLlfRwLs0De1UYNgn0scPYJ94+Pjgod5yuX7DicncHj1mjfv9lHQLojR4+jjbokqiF
	cvdttVIZr3U5jVFRQ7T8QhztvvsD+/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-pGDy-2YKOKuCvWFRkmTPJg-1; Tue, 18 Oct 2022 20:35:25 -0400
X-MC-Unique: pGDy-2YKOKuCvWFRkmTPJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 488DB862FDF;
	Wed, 19 Oct 2022 00:35:25 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B05140E0420;
	Wed, 19 Oct 2022 00:35:19 +0000 (UTC)
Date: Wed, 19 Oct 2022 08:35:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <Y09GROYqk3FMM21W@T590>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018051956.GA18802@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_173540_815492_90B55D7B 
X-CRM114-Status: GOOD (  28.42  )
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

On Tue, Oct 18, 2022 at 07:19:56AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 03:41:15PM -0700, Paul E. McKenney wrote:
> > Then the big question is "how long do the SRCU readers run?"
> > 
> > If all of the readers ran for exactly the same duration, there would be
> > little point in having more than one srcu_struct.
> 
> The SRCU readers are the I/O dispatch, which will have quite similar
> runtimes for the different queues.
> 
> > If the kernel knew up front how long the SRCU readers for a given entry
> > would run, it could provide an srcu_struct structure for each duration.
> > For a (fanciful) example, you could have one srcu_struct structure for
> > SSDs, another for rotating rust, a third for LAN-attached storage, and
> > a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.
> 
> All the different request_queues in a tag_set are for the same device.
> There might be some corner cases like storare arrays where they have
> different latencies.  But we're not even waiting for the I/O completion
> here, this just protects the submission.
> 
> > Does that help, or am I off in the weeds here?
> 
> I think this was very helpful, and at least to be moving the srcu_struct
> to the tag_set sounds like a good idea to explore.
> 
> Ming, anything I might have missed?

I think it is fine to move it to tag_set, this way could simplify a
lot.

The effect could be that blk_mq_quiesce_queue() becomes a little
slow, but it is always in slow path, and synchronize_srcu() won't
wait new read-side critical-section.

Just one corner case, in case of BLK_MQ_F_BLOCKING, is there any such driver
which may block too long in ->queue_rq() sometime? such as wait for dozens
of seconds.


thanks,
Ming


