Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FE5E77188
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imjPGe2wWwbZPrTyZsznpVBVYJYH04fIhX7CpX3xCfM=; b=w/BcNP6q2Oud0SZfZXjoe0ocSQ
	i5ffmJSkQcayXNe8UkXs3QWkqaYrwn7xJgfcxrx+2hSjB3Nc4YMtQVFI9WcRwRFd0sNEytucOA3WB
	TjfTsEXgwjoSTpVCs00/W8mNeRKuETAiU04TOpsS1MvSzbGW850SuBA3yEL9MaD2tdd3nCuyZBDx0
	ofTAqgIkqcVUYhnWijQQUXECASeBSZ86H1mBBoHyWTvHf6WFc04OY5jMt1wjx02n4RK99aEYoCTW5
	ymIOm7Jx3EScxIqFwrnBoG++IZScrZA9myY2t4T8/1TyucrHZpfXYfbjz0KzqGO2ssLDK45gbidU4
	k+fiHQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhpV-0000000AMcw-1v3a;
	Thu, 09 Jan 2025 01:59:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVhpR-0000000AMcP-1GM5
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 01:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736387959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imjPGe2wWwbZPrTyZsznpVBVYJYH04fIhX7CpX3xCfM=;
	b=iOPXxbH8JuNtFjAm1v2YOIs+qEM2jnL0prrEFqZ4/iNnMdrRtNGeZLLihF6/ZYt+kV4plV
	+v/3EDOumK9CYtZ7azc1Zwi9ozbQruNK7hw9vLV7S6gQdsMi4C8YJjprXJ0jzlbJOTiRbJ
	93AnKaSPsIUArevvlkEdz24KOn2X+pQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-U6GY-sVXMNeOT_9J5cJOWw-1; Wed,
 08 Jan 2025 20:59:18 -0500
X-MC-Unique: U6GY-sVXMNeOT_9J5cJOWw-1
X-Mimecast-MFC-AGG-ID: U6GY-sVXMNeOT_9J5cJOWw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E75A19560BB;
	Thu,  9 Jan 2025 01:59:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6146219560AB;
	Thu,  9 Jan 2025 01:59:08 +0000 (UTC)
Date: Thu, 9 Jan 2025 09:59:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, randyj@purestorage.com,
	jrani@purestorage.com
Subject: Re: nvme-fc: Question about __nvme_fc_abort_outstanding_ios()
Message-ID: <Z38tZ99hIX2stF8L@fedora>
References: <Z38nGkThjH59LFrf@ceto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z38nGkThjH59LFrf@ceto>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_175921_414396_91BEAA72 
X-CRM114-Status: GOOD (  15.20  )
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

On Wed, Jan 08, 2025 at 05:32:10PM -0800, Mohamed Khalfella wrote:
> Hello,
> 
> I was looking at this code and I had a question about it.
> 
> drivers/nvme/host/fc.c
> 2473 static void
> 2474 __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
> 2475 {
> ...
> ...
> 2503                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
> 2504                                 nvme_fc_terminate_exchange, &ctrl->ctrl);
> 2505                 blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
> 
> nvme_fc_terminate_exchange() calls __nvme_fc_abort_op() to abort all active
> ops with status FCPOP_STATE_ACTIVE. I think these active ops map to in-flight
> requests MQ_RQ_IN_FLIGHT. After blk_mq_tagset_busy_iter() returns it is not
> guaranteed that all ops had done callback functions called on them. Some
> of these requests might still be in-flight.
> 
> blk_mq_tagset_wait_completed_request() makes sure that we do not have pending
> completed requests, but it does not check for in-flight requests?

It is because many callbacks call blk_mq_complete_request() to complete
request, and the request may be completed remotely via IPI, that is why
blk_mq_tagset_wait_completed_request() is needed.


Thanks, 
Ming


