Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E352C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:56:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EE920708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ILTyVrj7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTfqrIlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EE920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oTVG/ami4uiwgk/QFXd8v+Yg+qYkAXfhhPQ6zHp08+w=; b=ILTyVrj7E+9+OuRGBMIlBvG5A
	9CG9yOx/GOa/Su6C/zl7h1U/LhF6we+LvZq1Z041WIc8hTY65PgF4MOMXhFbmy0sTfDpfCLM/eLAM
	d26KTYy2JqEQq8r6SeILQelJTKqDTBqeTpiFOEkz5ht1qRFjgJwr8bEGq1qJayLha8GHEJ9tWLG0E
	GR+nQjldLMMdlDyjOBxogL8CEYTMFjfrFJaTtwY/1KuJBsVXp72GP7o6lVnHZ5IXsuaEvzfOYn/Vu
	tVGR08KbRDyAspKfXF77ropWMrGKsbMRHAe0Ma4Xmilg3NdoAZIQGC2DUtRjFd/ZmRrdVNYZS7wAz
	Qiz+q3ZSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TdF-0006xg-Lo; Fri, 14 Aug 2020 06:56:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TdE-0006xU-Aa
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 06:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=A7rovRodGegwr3mp+afscrcT460pwnzXboyS7eN6p18=; b=DTfqrIlKyeIWgxDZKDHEkJ4TUM
 eb6oFwR3NzVh11QDPl/6NgnN9W4GaI+wFSd34spIhL5i6nNzPVHLZXgSeIoGjKRmRQsSa9xgFliIf
 PpD5RKYfG6UkSyo8nYr91PHI1XkppusBS7s0f2nLyc4nr9a1GXN41YrZp++J1l0ezhD3lJc/MjlPY
 kxs7NWSFqvb0bDd1LY6+GTn+x4qPwrWPYbgvOj1FKSTbUvx0aGLGg81UQm6aN3FqLAKX3zMSdUzLO
 4SZwupCh0eftoXb31A9nGpwawlWGQvzOflIOcy/+PI3mcYYlCigQopTCkI4PpTmZNVWP97EZZd8qy
 bsTBBimg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6Td9-0007vE-5j; Fri, 14 Aug 2020 06:55:59 +0000
Date: Fri, 14 Aug 2020 07:55:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200814065559.GA29917@infradead.org>
References: <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com>
 <20200813184349.GA8191@infradead.org>
 <96aff2d0-5907-f5c9-9164-8fea0d030d95@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96aff2d0-5907-f5c9-9164-8fea0d030d95@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 dm-devel@redhat.com, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13, 2020 at 11:53:14PM -0700, Sagi Grimberg wrote:
> > +	switch (nvme_req_disposition(req)) {
> > +	case COMPLETE:
> > +		nvme_complete_req(req);
> 
> nvme_complete_rq calling nvme_complete_req... Maybe call it
> __nvme_complete_rq instead?

That's what I had first, but it felt so strangely out of place next
to the other nvme_*_req calls..

Maybe nvme_complete_rq needs to be renamed - what about nvme_req_done?

> Maybe call nvme_req_disposition again locally here to not carry
> the is_ana_status. But not a biggy..

That means it would have to become non-static in scope, limiting
inlining possibilities, etc.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
