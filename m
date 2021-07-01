Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A3EC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3D161413
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3D161413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X1nzjbjJCKOXX5JGrFZ2JXMmdwA3vyCD6Y+9yI5zWys=; b=yK0CU3IrpEVMrf
	TBdKJN8TYmBeZQqis7PNROLJ37qpm9rsMjuWCYb60Gr8NSmVn1a3SAnDAOlOuz8GBI18Ij80OVbO6
	hHqVa2RQiMVEwBEEoCAnxEC4i5T62k8zR4jW/UhCrWNc0r9fM/ljQSXtDcbM0zan7hdezCC+mzRwv
	Rwsr7nWaWF9XMHj7DmllCSkLpYCSCQS/CG/Vk/CF+O5L/7MBzJRJVZO1F1Jpuvua/BYRZ3BXVI4jY
	n3XNL8vxIuUTMdGXL07q0VBGT79zyYfNeRBQ2ycan07XUt3DTvK8BLIw7nKxxZjyAvmyZZLkEc2Ri
	ZVP0+e4rYZSpIWYHsphQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lywey-00HQss-Kd; Thu, 01 Jul 2021 13:23:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyweu-00HQrX-Uu
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 13:23:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5046B67357; Thu,  1 Jul 2021 15:23:07 +0200 (CEST)
Date: Thu, 1 Jul 2021 15:23:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 kuba@kernel.org, smalin@marvell.com, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v4 00/20] NVMeTCP Offload ULP
Message-ID: <20210701132307.GA18548@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210629124743.6898-1-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_062313_176760_6D17056C 
X-CRM114-Status: UNSURE (   9.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I looked over it a bit (and will send some individual comments), and I
have to say I really dislike how this layer and how the hardware works.

The whole point of NVMe is that we have a nicely standardized PCIe
register level interface.  One that you can trivially hide a TCP offload
under with just a little control plane logic.  But instead we come up with
this gigant mess.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
