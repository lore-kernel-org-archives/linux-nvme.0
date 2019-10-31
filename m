Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE5CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 14:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7152086D
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGFWYkue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7152086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l0DtMn49K1Ce4BrEh1HY/dwV64K/8pe+jRlgRzAyzdg=; b=IGFWYkueuqSXa6
	xBN0gsIZjihh8gBE1pTY/4ERflFyhewzouMpHIm8DPBYLT12HljJyGTOKi23Q6fLD2gqHL/p21fsE
	TyXmDqVsxdttCvsaWzYZPsU7oCwJd/rIY9SAquh8OvC8EnkAX7k3DzH/919e9xswH4N2sDQIw1HTQ
	1GO+zoYlsUr6o7Ly+LSUFauAFhRF2H3bJf4vza9cNrtFc5RuDIJetUVARLuM1qBt2lVEAnAOulIHe
	JPg2KTFwMlr7m+I60lEvCN5VZWRrpZWcqnKk+bfIGAzHeVdBEANGpJnqJnCxK/yKp6W5U+XWR9kfg
	28CKkSe5CLi1nuMKLBuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQBnR-0001wr-3i; Thu, 31 Oct 2019 14:51:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQBnO-0001wF-OQ
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 14:51:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B76EF68C4E; Thu, 31 Oct 2019 15:51:27 +0100 (CET)
Date: Thu, 31 Oct 2019 15:51:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Message-ID: <20191031145127.GC6024@lst.de>
References: <20191030152418.23753-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030152418.23753-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_075130_943668_DE0338CF 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 30, 2019 at 04:24:18PM +0100, Daniel Wagner wrote:
> All async events are enqueued via nvmet_add_async_event() which
> updates the ctrl->async_event_cmds[] array and additionally an struct
> nvmet_async_event is added to the ctrl->async_events list.
> 
> Under normal operations the nvmet_async_event_work() updates again the
> ctrl->async_event_cmds and removes the corresponding struct
> nvmet_async_event from the list again. Though nvmet_sq_destroy() could
> be called which calles nvmet_async_events_free() which only updates
> the ctrl->async_event_cmds[] array.
> 
> Add a new function nvmet_async_events_process() which processes the
> async events and updates both array and the list. With this we avoid
> having two places where the array and list are modified.

I don't think this patch is correct.  We can have AEN commands pending
that aren't used - that is the host sent the command, but the target
did not have even event yet.  That means the command sits in
async_event_cmds, but there is no entry in >async_events for it yet.

That being said I think what we want is to do the loop in your new
nvmet_async_events_free first, but after that still call the loop in
the existing nvmet_async_events_free after that.  That ensures we first
flush out everything in ->async_events, and then also return any
potential remaining entry.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
