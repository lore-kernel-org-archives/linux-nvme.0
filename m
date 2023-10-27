Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700C7C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRlVCjC0Tqwt5rl3j0mgfKODon4uU3QvEB2rjJMoBL0=; b=Gtk04u/SrALo8Li2UnLLI+6KoC
	CXEXlkfUZiBAQuUIKXa5nSqMhUM2u6LAKUbMTJmVNXiF4yRcOjYJpiSEnts5jBorHIebkbOiCvlco
	+16GZkq0gbWb9DblLesHQU+J25ilXcUIR5XitpbvhmkMXxBYqqiyQNvmTlKe2pJ9NGhhgcfc6k1yU
	pDUroQmC0IuqnggbIEB6vTNGJc4SVEheWdtzS6YfsK/Gt37qAEKPQEWFbPr2GU6nBlPp1XaJRq9HU
	nIXp71Z9bZiGnnAVnfj13hufTBgvL8j7eJEywflkkVcTWKhWCp+lCrrCfLuYMS5J78N71EWZZFpQJ
	kEQmo76Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIeC-00Fydx-1o;
	Fri, 27 Oct 2023 08:56:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIeA-00FydG-1V
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 08:56:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DF8068AFE; Fri, 27 Oct 2023 10:56:44 +0200 (CEST)
Date: Fri, 27 Oct 2023 10:56:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231027085644.GA19366@lst.de>
References: <20231026130804.142586-1-hare@suse.de> <20231026130804.142586-3-hare@suse.de> <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com> <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de> <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de> <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com> <20231027083003.GA17042@lst.de> <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_015650_645981_C3DEDD6E 
X-CRM114-Status: GOOD (  16.50  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 27, 2023 at 10:54:42AM +0200, Hannes Reinecke wrote:
>> I don't really mind the link order, for these cases I usually add a
>> comment to the Makefile so that people don't accidentally change it.
>
> Point is not that it has to be initialized first, point is it has to be 
> initialized only _once_.

module_init ensure it is only initialized once except for the case where
the module is unloaded and reloaded, in which case you actually do need
to initialize it again.

> So when moving it into a separate module we cannot use the Makefile trick 
> from Christoph

why?

