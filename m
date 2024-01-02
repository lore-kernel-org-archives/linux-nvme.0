Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628ECC47079
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VUM715omF3578Mmk+5SHT9AO/wvxoVW8vn/CZVsjQCc=; b=yksUVU/RsM+ti9nXtSNpeKuCwK
	1t/hfvNNDj6+r0JgMdRWYVKzU7alG0Nkk6KJbr8C3qqG6RPFh4fMd1Df6v5cc0CDN98FrLS72qWNf
	KkmVq0lh4FXHziRK4f64omeQV8PSc2aABCQeq6cBPwHIzKmeuZ0U5WLnVQlBs0fp7pPHGtwDBWR7y
	yCQZ7eBxbjhSxpZ5FVdrfxYmx8u8oVuuY8MWQBmU7xqm3InYKRJn9xgk3CSQgq3GfNavkmF76cQoe
	iWj9YhqD17p83baVwCxH6U0JC6ByBWEMZrUzeT3Kc4cXssG6ocChZ/xmfetuNjKAz4a3Ok/feXpMO
	SDCfRnhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmAf-0092Ex-0M;
	Tue, 02 Jan 2024 21:19:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmAc-0092EM-0Q
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:19:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9685061228;
	Tue,  2 Jan 2024 21:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CE7C433C7;
	Tue,  2 Jan 2024 21:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704230369;
	bh=Ac9sY8QL1WZFRp+l3xJy75UJleljP01945ZqK3wJKPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gw6446Lsvvut9SEaZKlZhgVprXqHIXrrr8pPXimW6Oed9GwxQ2uqyE7D2wEwwrr8R
	 4S3E+9HtvO81PHZbdB/K0rTX6tkAqgW7KcTV8PgN3xmyt+wiBa8XSfHHVZsvqNeMgj
	 YBDQLfFGjWvwhhWNv2kr1AKezmkeXgtkJRbqyBMS/0TC5EEvSR7a8N29nZoekmybqw
	 ww0GFRPmtaQGYT2uwpkPjHb8bR9hugcfsMsXTT6f8Y23UeTZ5NVTH2sqMY8fPckZd+
	 LlmdCESsu88RMJ2tqGEAoxqKXssyDePhI/3LB3PghnF16AsQcQ1CwcnEzZEUnEQ++N
	 zD8JAwDKN6RdQ==
Date: Tue, 2 Jan 2024 14:19:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 0/2] nvmet-fc: Adjustments for nvmet_fc_alloc_ls_iodlist()
Message-ID: <ZZR93keoL4S6uF-_@kbusch-mbp.dhcp.thefacebook.com>
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_131930_213447_7F5D4369 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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

On Wed, Dec 27, 2023 at 06:14:35PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2023 18:09:09 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.

These look good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

