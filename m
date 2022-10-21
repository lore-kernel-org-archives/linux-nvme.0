Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A55C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0v8fCov6JT023F59mHS307YwGTnGWhQRNzV/UnBn+lg=; b=pWOzV++MdqYs90Y/iVnAZgPHds
	MPq4292NLzcT58xM4qLfkkre10LSvsnnSYsE6pmLzFIfI8CGGVjweVPQJx8mJJFdjDwHDAE1V0FUu
	gNUW0PXu8StpU6gVadqu/dPyqsVWTWkSPNZhwNnshr4cjnFp37A2D2LKXn/QygcvRpMaO+7kdOlDu
	MY6pyaz9e3tI10J48CFqG4bR4TFwKNpW+Nzcd+ypeDfOz6mpwSy9Jp3T3MeswI1flec8ISF+Vrv5H
	ufzjv1Exyc7EIQwC5UownTryqWXFstMZFX38buqMK8D7oR1Y44/d+WQ5yODF5zgXOQTBfb9pt6KMf
	wGSAMAjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltdR-008dWv-CJ; Fri, 21 Oct 2022 15:08:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltdO-008dWI-ER
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 15:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666364908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0v8fCov6JT023F59mHS307YwGTnGWhQRNzV/UnBn+lg=;
	b=PoJ8heYGLTj98Og1Gg65sktYgtRhJ4GzbK8xrxp3QkqVuvOuMw2/wNDSqJGQ96pRNh1qV2
	Lc0PtD5gOeWnmcIz8tVuIhtuAIwlSvnAQjqlJ9wiQbvC8yszjKQRtU25dtNPM3qW2WHGOQ
	Jj6EDmLff6DGIkP9UsmTU3muFCk2c5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-RSR-Zy2fMXCAv38dKQUiEw-1; Fri, 21 Oct 2022 11:08:23 -0400
X-MC-Unique: RSR-Zy2fMXCAv38dKQUiEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 344B81C004F3;
	Fri, 21 Oct 2022 15:08:23 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 83FAB40E42E3;
	Fri, 21 Oct 2022 15:08:15 +0000 (UTC)
Date: Fri, 21 Oct 2022 23:08:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <Y1K12u3C7Bnz91Xl@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
 <Y1HyOS9A72GZIQWT@T590>
 <20221021131932.GA22327@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021131932.GA22327@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_080830_572995_D742453B 
X-CRM114-Status: GOOD (  18.31  )
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

On Fri, Oct 21, 2022 at 03:19:32PM +0200, Christoph Hellwig wrote:
> On Fri, Oct 21, 2022 at 09:13:29AM +0800, Ming Lei wrote:
> > > -	blk_mq_wait_quiesce_done(q);
> > > +	/* nothing to wait for non-mq queues */
> > > +	if (queue_is_mq(q))
> > > +		blk_mq_wait_quiesce_done(q);
> > 
> > This interface can't work as expected for bio drivers, the only user
> > should be del_gendisk(), but anyway the patch is fine:
> 
> Another one is the wb_lat_usec sysfs attribute.  But maybe it is better
> do just do this in the callers and WARN?

wbt is only available for blk-mq.


Thanks,
Ming


