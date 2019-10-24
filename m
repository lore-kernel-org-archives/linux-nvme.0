Return-Path: <SRS0=/YZe=YR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33455CA9EAF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 22:01:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DA32064A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 22:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LbRaszoZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9sNcutS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DA32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eqHDC9d5/rpwoVZ6/8vdkMhJ46TehhWhK9+hHnmbox0=; b=LbRaszoZ1AT5VQ
	8r6wIjjCaQfC1LWfS2LsGxE9a8Ubad6q38aQKNnm+0sajzEwjPgw6mga20f7desVwqVeaoDup/lgh
	C9d1uSCX/cAQ3NCeKGaw1lb4aofhdD+IjOiEmEMD0oWWgLsnvaD8I6hLZHDNlV3tWqy9K6irN3d56
	inKKTiCnLzTdc7zR0zy9QntOHrF9irvxWXO3oJqEFfvMxwjQzl6cgseW3gedSQA8hhSZ6FN2ILNkY
	3a4LeKLerFg/84aBG6fC4QqmStVBmK3wwEKtodhba1SOFdmAfIwdbP4boR+W+sVyf51o9FhCgKnQk
	zBuJOIUvnHk91lMlTFtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNlAh-0001rk-Hs; Thu, 24 Oct 2019 22:01:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNlAd-0001rF-Du
 for linux-nvme@lists.infradead.org; Thu, 24 Oct 2019 22:01:28 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B87492084C;
 Thu, 24 Oct 2019 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571954487;
 bh=xdkUuckaMOBUTSgtdoX+0pi45xYQHnglOzJcvNws2gY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F9sNcutSsj5Fv/b8Pi6ss04WXvRffLCQ3Gr6fFO5LczCpOTqxQUa6E/dg8aIbOL3m
 SWZNxYOzxfu8DkSenzaJqkhDKxR1OXkIz7hfotNLoZzIfB/7Ij41ATARStpLvenDe+
 d9N1aBCsR5eaUKZvQjzfe/61HGg4iyTs5hBBkCQg=
Date: Fri, 25 Oct 2019 07:01:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Message-ID: <20191024220119.GA25484@redsun51.ssa.fujisawa.hgst.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com>
 <20191024011743.GC5190@lst.de>
 <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_150127_488134_FE61B7D5 
X-CRM114-Status: GOOD (  12.07  )
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
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 24, 2019 at 11:18:20AM -0600, Logan Gunthorpe wrote:
> On 2019-10-23 7:17 p.m., Christoph Hellwig wrote:
> > 
> > First signoff needs to be the From line picked up by git.  I don't really
> > care if you keep my attribution or not, but if you do it needs From
> > line for me as the first theing in the mail body, and if not it
> > should drop by signoff and just say based on a patch from me.
> > 
> > Otherwise the series looks fine.
> 
> Ok, understood. Do you want me to fix this up in a v2? Or can you fix it
> up when you pick up the patches?

I'll adjust with the commit. Just let me know which way you'd like to go,
whether attribute author to Christoph or use the "Based-on-a-patch-by:"
option.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
