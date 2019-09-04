Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5DC3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 06:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6C223400
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 06:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvpt9l+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C223400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vEV+bz/IVMqIZDbZj8geSrDBPNaGVHiLT5VKqdRR4Dc=; b=jvpt9l+ZR6itne
	cpTHjVSxR+vFcoyeGHyXYKYMDFgEsMHITSSPx/EyI/4TBf8YAdO+QBzC5oYIyzR+dEm5YNlujJFGw
	UwKopkJLFg3wJOjbj2CtuzmYv/jtkvSlNjmTr6OVMV8CGQ/1Z2QfQMdAvX97HD2xXrnWI/nEw/fv+
	2IVtQLV17DZRHp25sC+7c9L+s6Jii9Y0Y6jIwgAPk8O7yYE16R4Egd9xeIVoFpER2YjyAfNyRVmgN
	gwF1OSqAr3pJbz1VIubNyWzuUmhj+AB3tyVA0BLQqN+658gQHwo2QFOHF05qmgKhYuR4U08Jl5Vm5
	n3bceotQ6lhBYtgDDv5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5OQi-0004jZ-I7; Wed, 04 Sep 2019 06:06:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5OQf-0004j4-Pt
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 06:06:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D026227A8D; Wed,  4 Sep 2019 08:05:59 +0200 (CEST)
Date: Wed, 4 Sep 2019 08:05:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904060558.GA10849@lst.de>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903164620.GA20847@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_230605_991745_4CFC7041 
X-CRM114-Status: UNSURE (   8.93  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 10:46:20AM -0600, Keith Busch wrote:
> Could we possibly make /dev/nvmeX be a subsystem handle without causing
> trouble for anyone? This would essentially be the same thing as today
> for non-CMIC controllers with a device-per-controller and only affects
> the CMIC ones.

A per-subsyste character device doesn't make sense, as a lot of admin
command require a specific controller.

If this really is an isue for people we'll just need to refcount the
handle allocation.  That is:

 - nvme_init_ctrl allocates a new nvme_instance or so object, which
   does the ida_simple_get.
 - we allocate a new subsystem that reuses the handle and grabs
   a reference in nvme_init_subsystem, then if we find an existing
   subsystem we drop that reference again.
 - last free of a ctrl or subsystem also drops a reference, with
   the final free releasing the ida

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
