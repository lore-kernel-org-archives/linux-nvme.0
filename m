Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16626C54FCB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 13:54:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC02D206BF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JKApvbZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC02D206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qwlgzkZON3y5iyb550d3DUWEqUTeuEOzIArZhpF0Fw=; b=JKApvbZuV4wRgq
	x4ftuo0TRHvILTeasjYkIkpCEXPdaDtWuPL+YU13O2dLgjjocbUO79IYXD42jfNK757PnkmQOtnGB
	+Y1OVdFs5Eym7PznKP1D3+y78fV0DkpA3ffpPdvwuZCO7hd9tww0oeLGhYH/73Eo0aM00wOPgCe2t
	fy9mht+hhlM+ym8XoQ+8W+XAwEPKGIlJoIX9A3FU2PadxP0qWkfKqFiFn5HBdvIgsJT0zSwNLcrX+
	kpbPZrGIdhB0TRZSq3Xx6CVi8/U8xmatnm+xqSiDVKOAsmg1irriVeHXQU+7nKgRuSqxpMCn6Xazx
	SW39M9KcXBjTBWP+YCpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT4DT-0004us-KD; Mon, 27 Apr 2020 13:54:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT4DQ-0004u2-I3
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 13:54:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 31B2268C7B; Mon, 27 Apr 2020 15:54:28 +0200 (CEST)
Date: Mon, 27 Apr 2020 15:54:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling
 metadata/T10-PI support
Message-ID: <20200427135427.GA2835@lst.de>
References: <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
 <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
 <20200423055447.GB9486@lst.de>
 <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
 <20200424070647.GB24059@lst.de>
 <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
 <20200427060411.GA16186@lst.de>
 <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_065432_743964_C079C265 
X-CRM114-Status: UNSURE (   6.42  )
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
Cc: axboe@kernel.dk, James Smart <jsmart2021@gmail.com>, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 27, 2020 at 04:52:52PM +0300, Max Gurtovoy wrote:
> but the default format on NVMe pci drives is without metadata and to enable 
> it we do an NVM format command.

The defaut namespace format is entirely vendor specific for both
PCIe and Fabrics.  For OEMs that rely on PI the drives will usually
shipped with a PI-enabled format.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
