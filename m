Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A5C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646DF21D90
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ydfwuAcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646DF21D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DEooU7qtEcL0i8icvZUUxqvRQ5/gru6cEuV3yiKLsdU=; b=ydfwuAcOQHnSvecJ0hA47ok21
	fra+ekL6zfVcBaX7/lBvGQFMznMR7ciojK2ceH6nWgrJrbNER6AVFLKYd8JoQMw6WKjEBbqP8Kp9v
	2hMjXG33ZGM0b4VOENuSqFvgmZ0Pkp8X2ZTkm+rWRVznVEukXD6TbtRET5HBXNh2CkicMtAs/bNOT
	mG1QmK9mb0FVRE9tnmQasFTdfcusvB7Xz+avKxHtKQMkR8pfXllBBRpyqSsVs24VPXO0VTih1B3U3
	bRE6R6NYItEvlwEMOeV7B0WOVIXi8CrKez1ZID1Y9VdkrQy2EewUMkCz4aUpB2XX5vma8a8q9UAWL
	7fgANVTzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIvo3-0004mj-HO; Thu, 17 Sep 2020 15:26:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIvnz-0004lK-Tr
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 15:26:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 928576736F; Thu, 17 Sep 2020 17:26:34 +0200 (CEST)
Date: Thu, 17 Sep 2020 17:26:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200917152633.GA521@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200917082651.GA4595@lst.de>
 <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA5qM4B=KcDK=SmduJt3am=gL1miNKoKuEZWRqft1f-kG03fEA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_112640_095697_5DDE2B1C 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 17, 2020 at 11:24:59AM -0400, Tong Zhang wrote:
> Hmm.. OK. Any suggestions on how to fix this?

Yes, we'll need to make sure the block layer doesn't double put
for a not fully setup disk/queue.  It has been on my todo list for
a while, I'll plan to get back to in the next days.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
