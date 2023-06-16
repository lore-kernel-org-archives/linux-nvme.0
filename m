Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714CAEB64D8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tqp0jBy0MAwlbUsOY9gyPmPTKTK42ZPVNu6TVt7Ucvw=; b=AKI/SsMpzsImBuCRns8tBecLbw
	A7AwtVXJVO1rfmjK0cB7c1E7qGc21KYohfFdaP3c25YkbIcNOJbr8wmJjRr8eq3ECbacYI0MvlNzc
	y4bEUCWsCMdJQVJ/3ggH5JRCvOQn0k62hEdeatDAEjUSYN7e26/hFZA0gi5cl/sS4rNuieqN9m0eS
	1Q7wnxLt+aHrHHIyYegEQioUaSuwdNktsqLTB/kYgaivwhc8IpT3O9YN5UgAMUdopdF49fUying4e
	okd9ADYEPLI2kTdZaVaM/i0rwHXk196Hp5pRJXToZ53p0NYzEpt9qeVRlVMEZV/bi0YZCOAfg2P8M
	oyfZh5xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3lP-00H8Qj-1v;
	Fri, 16 Jun 2023 07:20:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3lM-00H8PI-1o
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 07:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686900050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqp0jBy0MAwlbUsOY9gyPmPTKTK42ZPVNu6TVt7Ucvw=;
	b=C10ZLzN6LRYRbBfw0/c4mH0FHGBuOchemNucNmcPhLhhEQFCxHASkqsKKBb/veRl4O1esR
	SQK4LopXeI+uMMJ+61xCtws0LZ5NPt45+wP/4LQHDoZn9ErUiN9xfpkt4O2Seg475v0eRd
	n3WnGxsiSf6H5APj2clMOTptr6OGRPs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15--JlAnzDoOqqlAjkngnYWaA-1; Fri, 16 Jun 2023 03:20:49 -0400
X-MC-Unique: -JlAnzDoOqqlAjkngnYWaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10D55281424C;
	Fri, 16 Jun 2023 07:20:48 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 366D540C20F4;
	Fri, 16 Jun 2023 07:20:42 +0000 (UTC)
Date: Fri, 16 Jun 2023 15:20:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
 <20230616054800.GA28499@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616054800.GA28499@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_002052_676389_5DBACCAF 
X-CRM114-Status: GOOD (  18.59  )
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

On Fri, Jun 16, 2023 at 07:48:00AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 15, 2023 at 11:43:51PM +0800, Ming Lei wrote:
> > On Thu, Jun 15, 2023 at 09:16:27AM -0600, Keith Busch wrote:
> > > On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> > > > NVMe calls freeze/unfreeze in different contexts, and controller removal
> > > > may break in-progress error recovery, then leave queues in frozen state.
> > > > So cause IO hang in del_gendisk() because pending writeback IOs are
> > > > still waited in bio_queue_enter().
> > > 
> > > Shouldn't those writebacks be unblocked by the existing check in
> > > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > > disk state update or wakeup on this condition?
> > 
> > GD_DEAD is only set if the device is really dead, then all pending IO
> > will be failed.
> 
> del_gendisk also sets GD_DEAD early on.

No.

The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
bio_queue_enter().

Thanks,
Ming


