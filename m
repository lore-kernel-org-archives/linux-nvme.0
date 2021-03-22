Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F396C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0116761931
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0116761931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m9fBpb+ohdq6cBho8BBpD8ESSbPpdSzTE6sB5mY9Y2U=; b=kT8v0nqOTHj8fR2kxZmyh8ICf
	zIITnTfXvub38lhVluONslItIUJFRWNjLGR43wDWFlQOZmnbfjJer00RBDoO25iH2AXiNJv0wpuYQ
	MWkG0lHsaOkoY/udAKGHiPembnTM//kCBOuu1eaasD41cjZXPCydPU+nFkg1vfFTlL6qG1FUz787M
	R/BXzLPbaWGViBA0ScwAm++fc6DiQXJhs/m8dZfzmTLHVbygS6t6DX2XfKclg/sXyLFrc5xBj4pH+
	zXMFZerPUtNRJtqipVb0mri2gu4rnsSXRTNWputhtfWciid8Ff0ASs3CTKFT3snWGhIfciGD3bM+H
	ogylbZAGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOMVl-00BttK-OR; Mon, 22 Mar 2021 15:30:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOMVe-00Btsf-6V
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 15:30:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0135161931;
 Mon, 22 Mar 2021 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616427020;
 bh=2dO3ApbwwimsIPO8Z+7xEFYSB59RRiJapAD647NFm9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y7nYBh4GIXFvqrjoc4b0g9IswpzGsGE7BN01C1PxUwu/KMUa+tXhlRuRpUQcN69ho
 DHh3exXkwUBwVkxOUvMx/13IbO1FvrX1m1GyOXzBxmJrl+hDgsDwQdAQ45UxXn2GQV
 Mfnpd/v/rm46CRsKdudvzn6+0eZIqaOvGLkYKMUtJbqj+X35cceUA1PNUI4/Ar0BBB
 alqsrkBKxg6E1dyC61v1pQq56L+SK3di1EfeBjCEIWAjf0M4LPBAIm++u5hSaOm8wj
 HWBsu/95odYKCgqeb45AGOXjXWpR1EIy6VACtzqa32ErQ7NX6R4EKOGutcU5YPgAaX
 2lLO/VZw/VojA==
Date: Tue, 23 Mar 2021 00:30:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] blk-mq: add a blk_mq_submit_bio_direct API
Message-ID: <20210322153013.GA17311@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322073726.788347-2-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_153026_980256_196ADFC2 
X-CRM114-Status: GOOD (  11.83  )
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

Looks good. Just a couple minor typo's in the commit message.

Reviewed-by: Keith Busch <kbusch@kernel.org>

On Mon, Mar 22, 2021 at 08:37:25AM +0100, Christoph Hellwig wrote:
> This adds (back) and API for simple stacking drivers to submit a bio to

                   an API

> blk-mq queue.  The prime aim is to avoid blocking on the queue freeze
> percpu ref, as a multipath driver really does not want to get blocked
> on that when an underlying device is undergoing error recovery.  It also
> happens to optimize away the small overhead of the curren->bio_list based

                                                     current->bio_list

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
