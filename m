Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45738C433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 16:48:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53DD6103D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53DD6103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DId+TM0o8q4uB8jm2egqTxvM0Pl3BI0ejjxhjaF0xEE=; b=M7u1RTbrFSvm2BRvZgKfEEi2y
	kemmRv0KA9+5G/Ur5gkwhY51YhnJI9aEEbdalArU4U5LFORcemKFiUyg3cG4aM7UFA52aDVx1sh0I
	1aHkLcGOIqyP+N0Vt1eQ1jlvP1rBLC3oCNFpiGcexgJVZF0r03O14av4MVj9mYeqZPMsmL0IH71NM
	anBX6c23A9t+1iNUCzZdljmY3WIY57n+QGJ9j88h7JBVqw497YrTkFJNS3WzPzs31X8h6m7wYaCV4
	hxtrXuv9bBlvWyS6BLxJGAtyMJqfIEvy2b02f7JbrW1PlIGRBUTByM4pSTbi3KhegvU7hdpLO+J4Z
	lvCiLqKcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUBLv-005VX0-8r; Wed, 07 Apr 2021 16:48:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUBLq-005VWF-B1
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 16:48:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 564A068B05; Wed,  7 Apr 2021 18:48:19 +0200 (CEST)
Date: Wed, 7 Apr 2021 18:48:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407164818.GA31878@lst.de>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <20210406064841.103393-2-minwoo.im.dev@gmail.com>
 <20210407131527.GA15142@lst.de> <20210407141128.GB2805@localhost>
 <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407154730.GC8667@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_174822_592409_C901615E 
X-CRM114-Status: UNSURE (   8.21  )
X-CRM114-Notice: Please train this message.
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

I've force pushed the branch with the updates, let me know if this
looks good to you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
