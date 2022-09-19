Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9B5C54EE9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVQWtY+qBurNIIN+tVfsobpAgBZPYA/2RHcaJq3nZGU=; b=X3KfHRWIa0iw95um96OtAKsXdr
	ekefTjmiAL8tbFTAqf5GZ9YH9hBr0rrv5S07z9+cZm76+oDhASz0UEWDDtthXMAcbOjbYvc6D/5qF
	SkE4iacJn7VuqcbdX7Lg4GzaaKSG2wBc505FymdcSo101V2Y7KFw9wqnRMEARfIXoQ/dt5Zxjix3O
	kNACAhczR8ArfkkHV6YxxUyvm9yacMzEO8mkjTa4QLa8ZLXL/fVz5cBUDO+wdzJiJ50Op38sLESRD
	nMyqwUaMzuxcPD0mhaWiBA5rOu+zAoFbnLgvDkwnUrGZmtj8SxgG4jrq5d0BzKgLnP1E3ZRPATazm
	FAhRUlJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaI8E-00CBRC-NH; Mon, 19 Sep 2022 14:52:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaI8C-00CBQJ-AS
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 14:52:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFD4B68BFE; Mon, 19 Sep 2022 16:52:15 +0200 (CEST)
Date: Mon, 19 Sep 2022 16:52:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: make NVMe freeze API reliably
Message-ID: <20220919145215.GA29098@lst.de>
References: <20220821084754.340585-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821084754.340585-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_075220_534945_22357799 
X-CRM114-Status: GOOD (  11.00  )
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

Just trying to get back into this:  I think we're all in agreement
that the approach is fine now, aren't we?

Ming, can you respin the series to cover all transport and not just
PCIe, please?

