Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B23EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bmbPTwTlXbEUFynqjscHRUcyH7UNZcr+XWpTPghPmZE=; b=bTfcuJufyR4OP81Cx1z8+g5WvS
	V6UDcTP1CXsDt2edFSYDIgwvbQ2jxurifMlwHUmyvAKM/l1wx4Hp1QwMWJ2cki/8NHl1skwep7tUe
	zyT6Sx6jrB5bSaPQ6co6nVe9t3d86G7tgHIY0yEQJ8s5Sr4/dtQrcx9lfWD3snIJ8vwyIYAvn6JuP
	IqHaI/WGUe2aEUTQdyod3kEbUiPxMyZI+Q2b8a3xGXm787RjLh1FFoDgJno5TSVCdsN/h0SiE7dXp
	BSKGESMF7kjYQUJuY5iu2mRUHh6Nwc1xKXB89F/g6uYlsUgC76x7fP7zOI4+5xaDSyr4wxacokxN3
	NTizIYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5Ara-00Fa5x-Nc; Wed, 05 Jan 2022 18:18:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5ArX-00Fa53-KL
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 18:18:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A342C68AFE; Wed,  5 Jan 2022 19:17:59 +0100 (CET)
Date: Wed, 5 Jan 2022 19:17:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 1/4] block: move rq_list macros to blk-mq.h
Message-ID: <20220105181759.GA12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org>
 <20220105170518.3181469-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_101815_862354_20A1CB85 
X-CRM114-Status: GOOD (  11.51  )
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

On Wed, Jan 05, 2022 at 09:05:15AM -0800, Keith Busch wrote:
> Move the request list macros to the header file that defines that struct
> they operate on.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

