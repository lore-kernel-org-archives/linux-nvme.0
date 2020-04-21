Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C6C54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 18:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309D8206D5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H3eIsKke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309D8206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y6avX0KPgR+iJh6vIW1UtvgAT530wTPT423NOT+/8f0=; b=H3eIsKkejAhOt6
	4H9utDQTEEW/9BYba7sqLIv4s4phxUmaPxa4XVxiuNeT8wgVa4qgpxs4+ncar4tHyY45263oH1Ud8
	C6kyzQLzj/xulcoiJSfdwQuIS902GoW+kXzc/1uGZHY2ihVpj95NYnMETbB9tCdVK8O9wsKhjbdKz
	ROJLSfkrfa71xJF8sL4fEQ4yfNojT7jW3M6S56VDLeXmT2b5EVkWHdXJuUhP0uF+HGp67v/a5XX8M
	3HhpoodohEY7Otw48PRFQEx7kqRUkxMgvufo+MYWkcOQCg3/ZYipPSwmN7z9SrUx4jlDPiHygmD3u
	ibuIopAsWWt4pyGo7h7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQxFu-0000bB-IX; Tue, 21 Apr 2020 18:04:22 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jQxFs-0000aK-DU; Tue, 21 Apr 2020 18:04:20 +0000
Date: Tue, 21 Apr 2020 11:04:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [RFC 3/6] nvme: Introduce max_meta_segments ctrl and ops attribute
Message-ID: <20200421180420.GC31265@infradead.org>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
 <20200224184859.20995-4-jsmart2021@gmail.com>
 <7e85bcc2-cba8-4795-5c15-f7a586d339ac@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e85bcc2-cba8-4795-5c15-f7a586d339ac@mellanox.com>
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
Cc: Israel Rukshin <israelr@mellanox.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 25, 2020 at 11:49:36AM +0200, Max Gurtovoy wrote:
> 
> On 2/24/2020 8:48 PM, James Smart wrote:
> > This patch was originally posted by Max Gurtovoy <maxg@mellanox.com>
> > 
> > This patch doesn't change any logic, and is needed as a preparation
> > for adding PI support for fabrics drivers.
> > 
> > This patch parameterizes the number of sgl segments supported for
> > a separate metadata buffer.
> > 
> > The parameter is added to the nvme_ctrl_ops struct and the nvme_ctrl_ops
> > struct. nvme_init_ctrl() was modified to initialize the controller
> > value from the ops value. It was done in this manner such that if the
> > transport supports a singular/unchanged value, it can be set in the ops
> > struct and no other code is necessary. However, if the transport must
> > set the value on a per-controller basis, likely due to differents in the
> > host transport hardware, it can directly modify the field in the ctrl
> > struct.
> 
> I don't think we need to add a ops for that and override it per ctrl if
> needed later on.
> 
> And if a new op is preferred, please add a callback (see bellow).
> 
> Btw,
> 
> This was already reviewed by Sagi and Marting so it would be nice to leave
> it as-is (or maybe only rename it to max_metadata_segments).

I have to say I prefer your simpler version as well.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
