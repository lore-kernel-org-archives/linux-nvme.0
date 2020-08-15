Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90050C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:40:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE2122DD3
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1KsmLJJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE2122DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=1KsmLJJxPnfNl5A7EjmK3DtUd
	Ib3SJk1dz8FQQnI7nwmOq+HO+YE9qQ1JhFoXH/TlcWeHTfSlQROe0PhBOIN7IItqHVp04gp2bVfN9
	d6KqwxxF+f5h3EhdKqNg/k2JCbirxDrSLJVl0mEoKJ4H3dc53PZlUhM4VbUQFQdclicVy/eEIGG4l
	7QZdeIRZupQ6hEzsqAR4iEjcCE51tqtxA8f8u7EAqB7xgQV8plE9c5ZrFAvjRcZKfXlBBA4YtYTKo
	zSGnzFk6icV23nem5vWw08oq48WOKaCdn87fJfAoTzr6JbCCRekotanwpdDl5BsPgmKXjnRVU0OmG
	LXj92L0rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6qnH-0008Oz-UW; Sat, 15 Aug 2020 07:40:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6qnE-0008Of-Lj
 for linux-nvme@lists.infradead.org; Sat, 15 Aug 2020 07:39:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 13D0868CF0; Sat, 15 Aug 2020 09:39:54 +0200 (CEST)
Date: Sat, 15 Aug 2020 09:39:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and
 nvme_queue.q_depth
Message-ID: <20200815073953.GA15990@lst.de>
References: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200815_033956_866430_035064CE 
X-CRM114-Status: UNSURE (   7.59  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
