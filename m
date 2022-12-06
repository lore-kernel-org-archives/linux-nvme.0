Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D364C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 10:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmBS4RKWsLzxqB/oMm5ccTAkis22K/i79HZasZnsIvg=; b=tsvAv3NUnIKX8ZJP/ShoGFS6sN
	I7pKv3ZcYuhT4NOxu0l4kPlTC/ZIA851jA1dPPPnR1vPYZpH0jSYU60/lb4H/Rb3k3Is3WKrGqH3Z
	VqBrG3wESo0iNLAbqSB0JqwqpviqfVbyf6fS1vkL2vk58D3dhpGPJnI7CDvBkDQkOJzxhZ5ImiS7S
	msaB1NGVOP1pSxePxTDCfXMGtyofHjfKurQEmXVETmPyQ3yT2z0RAr+Gs1CRQrhcONOGr9BfeD50M
	L1w91C8YzQjqRLoOc649Mr7KtV8pSXZmub6ARr+8kz5y3s8gjkmT+tPqYfz4maePbTKouTDYPgNlu
	0K2iLxkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Ukb-006ZwP-99; Tue, 06 Dec 2022 10:00:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Ujj-006ZPx-8N
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 09:59:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2DDA3B81711;
	Tue,  6 Dec 2022 09:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA74C433D6;
	Tue,  6 Dec 2022 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670320776;
	bh=dHWmPs8X95+/KnvC04cJNU7is9xdsAnns4bZ7XpK1jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aH4M/wEYX4YAYz5YCppY6ezDNfZyXj/OAiNKYp4rnwLCtw8WHuWKrhFZfjU0wbpfM
	 GNXuvT3pUl2rWZzS9bvrSmnLcXbpOmeAMDXZdRECjRak/PYVmdddZ7MoJsnheaSfpR
	 rSM12pI4FR/L9Oorjni6xGH2P88HbkIyzZlF81CTOiBvZBZVIvfupLnNw9NCyu7W0H
	 cxdW34TDyJjrMBYY2J41I6J1lvfCU+SmOcdAXyWiGf03hhqBMEY7RbKik7mMyPXDen
	 dA3jDVo4ji9ve7ks4OKe7xdW+1yZgiXH49EkQVWUR9wkRQzljbuCct2THK0N9blesx
	 D8/cn9O+QQNaA==
Date: Tue, 6 Dec 2022 09:59:31 +0000
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvme-pci: use the tagset alloc/free helpers
Message-ID: <Y48Sg275HL0jmzkM@kbusch-mbp>
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130174240.227616-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_015939_493097_F663EB66 
X-CRM114-Status: GOOD (  10.66  )
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

On Wed, Nov 30, 2022 at 06:42:39PM +0100, Christoph Hellwig wrote:
> Use the common helpers to allocate and free the tagsets.  To make this
> work the generic nvme_ctrl now needs to be stored in the hctx private
> data instead of the nvme_dev.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

