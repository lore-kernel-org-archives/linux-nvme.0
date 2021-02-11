Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:31:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF96D64DCF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96D64DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9OWpcoGU7W9bR1azJttO+dem/FK9RVeiQ6t+u/p+178=; b=mVxgCLNdUG97V997h/8lsIyvE
	DS/tpbXYXb7wyiOnF5eN7FO/WwzrSFn9qjQOdLPC7dUF9KSa9+CyWuHYXQWumSyg9HPJGJPJrF4Tx
	7wkJH/hpgS5N/xR6Sg7bBaYt+R8GXBxckIhoYzjXFyZK0mR9SWs4KlKcfOPTzsx7tLMnurVk2Soko
	Dh/C9JA87d2sDLptKFgPPvYgxTuJ8gJkoJd0vUXFd0Ab0RV7DZHQxRZgDwInrnDFv7gQ7gUkGIDQ8
	mLeyfhtyWOxbFnVMZbgJCh2gSt3Otacf3u+Dg3x0wHhHfrSKe+w66dEBC4j+/uwDtKxfhaJ5kua3q
	b3JuG/y8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGkT-0002zv-HO; Thu, 11 Feb 2021 18:31:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGkR-0002z3-89
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:31:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF45A6736F; Thu, 11 Feb 2021 19:31:24 +0100 (CET)
Date: Thu, 11 Feb 2021 19:31:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
Message-ID: <20210211183124.GA26045@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
 <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
 <20210211070250.GA13708@lst.de>
 <f279bd6a-d4e3-52b6-740b-66f90434cf69@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f279bd6a-d4e3-52b6-740b-66f90434cf69@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_133127_439392_036BE707 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 02:43:27AM -0800, Sagi Grimberg wrote:
> The annoying thing here is that this issue will manifest in the host
> waiting on nvme_wait_ready for a long 7.5 seconds to understand that
> its maybe incompatible and re-attempt (nvme_enable_ctrl writes to cap
> and then polls CSTS)...
>
> What I have now looks like:

In terms of what to do about the retry this is what we'll have to
do.  That being said I think for existing controllers we should just
stick to the existing wrong value, and only set the correct one
for versions > 1.3.  This isn't exactly correct, but probably causes
the least harm.  It will need an extensive comment, and maybe we need
to add an option to override it if controllers show up that do not
like the wrong value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
