Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C117C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 07:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3EB20707
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 07:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="arM8EtOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3EB20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0F7PDd1HNXpzCsAWVkA+gX2igGN8975oUk01LzJ7tAA=; b=arM8EtOhuEsnnu
	W0sey5g6X0gzlOuIx1TiWKU9URoWfCzkqYEeGvoft1DNCklutTjIb8DOnTHzSib/kUg5a65/0BnYn
	raOR7PIItCLzKovZerdzub20RdlXgDP+PzldOEM3k5ryd/keiWmC8FFR1X+J0c/W7h/Sinqzk45wV
	OxxlxyoUe6xP3kwECj/VwNprFIuRH2UE6IlFBBJUEZeW4sOkNhapg8S0nobaUiZJil20M8dwutBPN
	osENk6xLKvS4W8VHp/DLC6ErnkZfqFWB8wPXmdon4dClXn/Q0mca8bDFDyJc0LG2yTHyQqVAmPb1X
	CRzTp/RVw6zfvU7jX3Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkjI1-0003gB-IA; Mon, 15 Jun 2020 07:12:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkjHx-0003fM-B7
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 07:12:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E3CAA68AFE; Mon, 15 Jun 2020 09:12:04 +0200 (CEST)
Date: Mon, 15 Jun 2020 09:12:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 2/2] nvme-pci: override the value of the controller's
 numa node
Message-ID: <20200615071204.GA21856@lst.de>
References: <20200614151556.88558-1-maxg@mellanox.com>
 <20200614151556.88558-2-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200614151556.88558-2-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_001213_529552_22D7DF85 
X-CRM114-Status: UNSURE (   8.56  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, israelr@mellanox.com, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, kbusch@kernel.org,
 hch@lst.de, "alexanderka@mellanox.com"@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jun 14, 2020 at 06:15:56PM +0300, Max Gurtovoy wrote:
> Set the node value according to the PCI device numa node.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

It doesn't seem like we use ctrl->numa_node for much, though.
For RDMA which initially added this set->numa_node is initialized
based on the ctrl one.  Maybe you want to add a patch to at least
use it for the set initialization everywhere as well?

What is the motivation behind the patch set?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
