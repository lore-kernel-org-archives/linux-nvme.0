Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247CEC43217
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 12:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83EC60174
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 12:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C83EC60174
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtvsF8mXpE80UYW2OrXXY1bIfvLkc8J2fHaNZRqNyxI=; b=EOLBxmC7AqpghyNRVbi77fc5qh
	bjjUJE0MGJNk39nAoKaTHFr9ZqjKV9gAzoctCrppZPn8/XhMU4M0h1NoakoaEK/4ySfXW5BMPfUev
	nMGP8pO8BMrjMvxPLXw6P1cZUdhyVY5nHjsOTBlNKPSpoI2oX74fJU+Rjpv5EliVAK5y/kJPJ79xL
	XHzSu/KbPykznnZzBJt7H7Wa1+QMewzlibZijT4EtCKCjP1vvmZV6hcYldcRbsIgQzcfnQAJkkkIh
	0e9PyhYW3S+UTRyvmiRquxf8aeg4tUShYMX2mJojaGWoj8Xs7N2doAUHML6gfdCW5dd7x9vPSsy01
	RuduFGHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mazZj-003269-BP; Thu, 14 Oct 2021 12:11:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mazZf-00324L-HG
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 12:11:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F8E368B05; Thu, 14 Oct 2021 14:10:56 +0200 (CEST)
Date: Thu, 14 Oct 2021 14:10:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 3/6] nvme: prepare for pairing quiescing and unquiescing
Message-ID: <20211014121055.GA15198@lst.de>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014081710.1871747-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014081710.1871747-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_051103_752297_71EA2514 
X-CRM114-Status: GOOD (  14.23  )
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

On Thu, Oct 14, 2021 at 04:17:07PM +0800, Ming Lei wrote:
> Add two helpers so that we can prepare for pairing quiescing and
> unquiescing which will be done in next patch.

I'd prefer to not add these wrappers with 1 or two callers, all in the
local file respectively.

