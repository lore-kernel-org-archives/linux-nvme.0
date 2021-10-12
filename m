Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 10:36:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D692261076
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 10:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D692261076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e6t5W1KUX6h2ZJ101MN37vRpizV9Go13L8ONcgQnwZw=; b=31MWrraqwDioHg
	Z0UOUmTYe3NosaUYzeLE1+cqlqwdNEaWfKX2QOB2pke/39xGHCPNPxDLn2qdo3k66lykeFoYE3hxr
	HiKJyl6LcwCHB6lqVq66o6momp+dP00DZprjhp9JD0q6Xeps8YZF+WEDuNF9JeneDJa8iBaR00gkJ
	WrUXTxi2ghiFym/GkM5hBxPj6WviLurdD/UWed1fNAbrXe720XyVPDr8TZkH0DUhfYIYzhpLj3FvX
	TP/FNJsL/oySx9BLeraRgpmHNfC8dJJTtM0T5L2QExLl8gauWPRLdGJW454qo8237ya6YfY3H1wZ9
	6aixeyTuFeuCqpKawDxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maF91-00CSBO-5c; Tue, 12 Oct 2021 10:36:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maF8y-00CSAg-UM
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 10:36:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6276A67373; Tue, 12 Oct 2021 12:36:20 +0200 (CEST)
Date: Tue, 12 Oct 2021 12:36:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <20211012103620.GB29640@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211009034713.1489183-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_033625_153349_F93F67F1 
X-CRM114-Status: GOOD (  17.37  )
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

On Sat, Oct 09, 2021 at 11:47:11AM +0800, Ming Lei wrote:
> The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> stops and starts the queue unconditionally. And there can be concurrent
> quiesce/unquiesce coming from different unrelated code paths, so
> unquiesce may come unexpectedly and start queue too early.
> 
> Prepare for supporting concurrent quiesce/unquiesce from multiple
> contexts, so that we can address the above issue.
> 
> NVMe has very complicated quiesce/unquiesce use pattern, add one atomic
> bit for makeiing sure that blk-mq quiece/unquiesce is always called in
> pair.

Can you explain the need for these bits a little more?  If they are
unbalanced we should probably fix the root cause.

What issues did you see?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
