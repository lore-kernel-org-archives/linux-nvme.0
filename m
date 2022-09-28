Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4595C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQCw2kRqKI+M3epNunZs7+0g1ARO/1k8qaOx8IDT8wM=; b=s7x05w43chBJC7dLKfjNElJIdU
	J09hHtE5HYhk77+R7cNRdoAapzV7AR6Cg6mwjeUBHJt4WCrD43zBSWH9qK45b2inaKqZnCKxePP9a
	yb12xJlGddEyS7kS6tE3FBaFGVBbk/pvChIHE2LK/+aZxlHkVYQa/JjgfppEJL/luQx+Bgt03q7yS
	MaFJP85q2DinadaPEb3kbP9gYoJeZTYPNQIAa2r4BZipZ1dTGT9c5X0lqCWAj9hiRVjv0lb+eVmZw
	oSbpZBhKQYfArgBWUC+xeJFTQddltNKJxptSs1AN/yHPuP6aCwtFUWCmLvVUNMsthBxD+NtiriExW
	qv6joArg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odafR-00HJH1-63; Wed, 28 Sep 2022 17:16:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odae2-00HIbs-PY
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:14:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3BB468BEB; Wed, 28 Sep 2022 19:14:46 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:14:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize
 with ANA access
Message-ID: <20220928171446.GA16939@lst.de>
References: <20220928135816.132213-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928135816.132213-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101451_013267_D7161835 
X-CRM114-Status: GOOD (  12.95  )
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

On Wed, Sep 28, 2022 at 04:58:16PM +0300, Sagi Grimberg wrote:
> When we revalidate paths as part of ns size change (as of commit e7d65803e2bb),

Nit: a bunch of overly long lines in this patch description.

> I was easily capable to reproduce this regression with a small debug patch to nvmet

Having this patch in the mail won't make git-am very happy..

Otherwise this change looks good.

