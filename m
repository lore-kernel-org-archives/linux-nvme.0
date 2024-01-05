Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04682C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 04:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gF1cgk48S4hsLo6vP5me9vcBWl5c5jDy5Hlj7ZER2Jo=; b=b6xhYK2cXqSGWrEQy0UHOfgHM1
	mu9fQcn+JcdWsmoDhJ+zm5cCE01imUcFmS9kssdqFn0iWND6rBxEaYLcu+PmbYIDsGDpDnGcuCL2s
	8V5LRBzja2tCi8t+Cd31wZ27aIaf5mbMvF1rN22jasqSlfYT4nksLmg3OCnQYirEXXfc84XPyIXWR
	3fbXQUC5l2oM1oKNEP8pJR2YZympw6UbaERd7EDcynP46psUUCQ5plh3xdXAXA34+E1u47lE26Tis
	UzK2Uic741pP/noM8GBziHwEMC5L/6/iBvX4XTKwIUyoNTG8ekx0krYYMUKyO4XdlTlOG2O+EJcb/
	tM97BpQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbru-00FuoX-06;
	Fri, 05 Jan 2024 04:31:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLbrr-00Fuo7-2E
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 04:31:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A16B68B05; Fri,  5 Jan 2024 05:31:33 +0100 (CET)
Date: Fri, 5 Jan 2024 05:31:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: trace: avoid memcpy overflow warning
Message-ID: <20240105043132.GA23716@lst.de>
References: <20240103155702.4045835-1-arnd@kernel.org> <20240103155702.4045835-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103155702.4045835-2-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_203135_866910_02E5AD8C 
X-CRM114-Status: GOOD (  10.36  )
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

On Wed, Jan 03, 2024 at 04:56:56PM +0100, Arnd Bergmann wrote:
> -		memcpy(__entry->cdw10, &cmd->common.cdw10,
> -			sizeof(__entry->cdw10));
> +		memcpy(__entry->cdw10, &cmd->common.cdws, sizeof(__entry->cdw10));

Please avoid the overly long line.

