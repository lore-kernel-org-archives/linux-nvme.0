Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFACFC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evy27whUE2o7tcdPVqIYzZEz3/zQGpGtwrNYlWGJ6dU=; b=AyTUmCfumGPr/XKlnN7I63KllP
	7oyGzC7tRqdwsYE7OY49QOKrZAcIJejBQw2RTBPW0x4NsuNFxrOUi6/QrQXS1o5MEcPjCuNj3gMhv
	iCzUGPOVwpmkmXlT0wnU8QpvrLI4spdwWe/7G8zNSz1Og0zeXJyuZsjI+OgCzoawWTkVF2I+oSbBE
	ZEDZm+DEKmSmYbRPXVB1KJpISQGqk/piL5frfvOYA19RHaWsjAnnKN6mxPdO33RbMgwzS9Pzeyqpt
	bGni8YUmf0eXPddX7FPjGt2j4Cv640fHY7KcnRnolIqmn5uTocRQNM2G71chW6sBVYD7nDj5Mcg3p
	SXaZOHSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN6V-00Fyr0-Hr; Thu, 22 Sep 2022 14:23:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN6S-00Fyoj-LD
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:23:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC13C68AFE; Thu, 22 Sep 2022 16:22:57 +0200 (CEST)
Date: Thu, 22 Sep 2022 16:22:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't wait freeze during resetting
Message-ID: <20220922142257.GA28185@lst.de>
References: <20220920015719.1840164-1-ming.lei@redhat.com> <20220922142211.GA28140@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922142211.GA28140@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_072300_879607_E83FF54B 
X-CRM114-Status: GOOD (  12.62  )
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

On Thu, Sep 22, 2022 at 04:22:11PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied for nvme-6.1.

Sorry, I replied to the wrong mail, so strike this.

