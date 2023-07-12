Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B7EEB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M75GqfeVLo9IlQfq08yQMg69StED4cf8yihbSaaug+k=; b=kcXdpQlbUWPZNy2G7zoGOwPmte
	wDb8vm6sMx9H6V6DxjqQmy8epr09nSiODq9hY64fM15F5twnCKhKzKv8dauF7g8+oFkb2xxSAW9kn
	I9ZlgZ6w4YNS/F7sAAnjc+Ahu8MV/0R3ein5IJ59kaze1CDu7zRryrjF23CXvumRHH5RLqH0ZD7+n
	UnN1vFhRlD/ErIgzdBCTuIZKLAIsj6UMXB5+uUVFt5ROdx+P9y4XV5fo42tF9O/VYD2dryPu7NLTx
	aZEUYel5VKPr62q+5QFUhC2OVvSSav/N8iRg7HDS09Bbxq2+7vvnRuFpaUjDHG7IlF9Fogk+bQ9Ji
	gj7VgDqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbMT-000HLA-2N;
	Wed, 12 Jul 2023 15:02:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbMR-000HJv-0N
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 15:02:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EC3A67373; Wed, 12 Jul 2023 17:02:29 +0200 (CEST)
Date: Wed, 12 Jul 2023 17:02:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] nvme: warn only once for legacy uuid attribute
Message-ID: <20230712150229.GA22618@lst.de>
References: <20230712145921.85333-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712145921.85333-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_080235_296631_6FDA9DA1 
X-CRM114-Status: GOOD (  12.15  )
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

On Wed, Jul 12, 2023 at 07:59:21AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Report the legacy fallback behavior for uuid attributes just once
> instead of logging repeated warnings for the same condition every time
> the attribute is read. The old behavior is too spamy on the kernel logs.

Warning on allocation just seems wrong - no uuid is perfectly fine.
I think what we should do is warn once when reading the attribute
and then never again.


