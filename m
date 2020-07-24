Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED6C433EA
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BC1206D8
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EiNndxMP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFdEZU6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BC1206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QU5RiN4eZWxzFYb7PE2tVNyDbscPPj3ZRpbQuImJkkU=; b=EiNndxMP62RKfivSusvqvBoF6
	fYCG/vskf9lK5LzIkBSpKaOmE1nCYELtHtxBhaHXKzzu4w4s41zkF2LWObgn2c31yFJZFwBNQdwIO
	0YiA7yP9I90iKJnxOW5Wr1yb1ZIipppX0esRtIZxNbtDDzh50rHl/fzMKXwuUmdVO0Wy211tBwKYO
	BhVYOzcHGHfvCLnn/QPOZIFai7qHAP2rhDyLRkzTvZ6emHhbqnqulWsxebEjq1NCYOh34bm10cQaU
	KU3+HG2ieq0f8XhtNk12a4OpO/Ia9NCm1YUO3fcJxiUJ1b0lYYssfKa/gF6Bd+Y6AiDq0X3gmGVFD
	khNqFkr0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz3TO-0003Uu-9n; Fri, 24 Jul 2020 19:35:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz3TM-0003UK-Od
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 19:35:13 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D3EE206D8;
 Fri, 24 Jul 2020 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595619312;
 bh=OyWnGKGYTbGw+IY4gpJNqzKFV+CQ5aSvZCLKgmsvSw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NFdEZU6IOueyntu8q4uunWpKhG/WXNlg+x2jV/pxv6WEM7UJcXJtfBsxQ6E2L7gz/
 go0xqISCK/aUR+Nj1Zn0UpxkXA5C9aILzzIO9UVNmK1zvXTKKATScDgPPkcYVq09w8
 YYuHLCAF/9PlnTYbuJ02Myf6CID30DiQgroi96zI=
Date: Fri, 24 Jul 2020 12:35:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v16 0/9] nvmet: add target passthru commands support
Message-ID: <20200724193509.GB2857771@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_153512_870986_CDBF8BB1 
X-CRM114-Status: UNSURE (   8.07  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 11:25:11AM -0600, Logan Gunthorpe wrote:
> This is v16 of the passthru patchset which make a bunch of cleanup as
> suggested by Christoph.

Thank, looks great. Just the comment on 6/9, which probably isn't super
important anyway.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
