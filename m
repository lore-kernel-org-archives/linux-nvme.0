Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903CBC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:20:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016E6619B8
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016E6619B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WG/dHiEu5v5ltStq9menq5NtGMwygR02sjxwYuxE9T0=; b=pIXW7IL6zLyM2I2u/xn6EPHZX
	vekzSsb8HBkB8mh8VVVXBzcHKYjOV5pP6D/PF6GSQDFt2PLMcKjtfVsa8nFiKvtdQ9c7FomrQgnN3
	GTrGhytZOzPNvCfQZlhr78Qquv3DeUe2oPFdRC8JQWtjmW3/mHqSabOYphzEnlfnXP7bAGTt84gj8
	ojwwwH5YYysKwdmVrP0txhDdCTOe2biq8psy2Z1gm6/UaiITlaVvWZUZVCHWS5U3cye3Nt60LVysw
	YXxJoaSSU82DLkxodXzyp5dp81s84LEVX0unBu9pNYqCVBD4Ur1HjBqGpNEbzoFuhDz/CYivw49of
	NZcNSFNbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOjkx-00FIca-Ea; Tue, 23 Mar 2021 16:19:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOjks-00FIbw-5D
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 16:19:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3E7E768B02; Tue, 23 Mar 2021 17:19:40 +0100 (CET)
Date: Tue, 23 Mar 2021 17:19:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161939.GC13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
 <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
 <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
 <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_161942_334330_7ECC5968 
X-CRM114-Status: GOOD (  14.50  )
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

On Tue, Mar 23, 2021 at 11:53:30PM +0900, Keith Busch wrote:
> Failover might be overkill. We can run out of tags in a perfectly normal
> situation, and simply waiting may be the best option, or even scheduling
> on a different CPU may be sufficient to get a viable tag  rather than
> selecting a different path.

Indeed.  Then again IFF there are multiple optimized paths picking one
could also be a way to make progress.

> Does it make sense to just abort all allocated tags during a reset and
> let the original bio requeue for multipath IO?

Well, this would again hard code multipath information into the lower
levels.  But then again we could at least do it so that we check for
the REQ_NVME_MPATH to make it clear what is going on.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
