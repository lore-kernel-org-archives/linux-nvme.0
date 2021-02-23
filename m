Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC92C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 07:25:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D58364E12
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 07:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58364E12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3t6RGl6/nqwJj9dQX9T8RNMko8QxbFu1jBSQgvhDie0=; b=kt/vD1cnG+sN+XlPXhYyUY/nI
	2SKz+owoV+RAQv6wIRd0ejOqG/2wHVrptXP20ZD7F/6XxjrMgQGlzKAO9Q6zvNKVAOLF7TOuS5SSV
	B409Y1GlYUcJi+iTH8ngFZmGPIm5MhDPvg8S+AjLxe9JKNBmYXjvIYu1uSPw9Po4A6x9kgSa7ggAc
	MPeOep0h2xgLCLf0+r0UG5hQgW9dEiR4wGWQGjGnOdsChLCD/qrteugur22MwTgkS2+ZtUmV62ZRo
	N4w1sdKcRGaT5sFaZFvIUVXWGhmmgNJ4vAzYedMI2jyaiQ02XrAkr++b6BZpJA0iW2jQYhyTOCt2y
	eYzpEKJLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lES4T-0003fP-30; Tue, 23 Feb 2021 07:25:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lES4Q-0003dH-RO
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 07:25:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8623A68D0D; Tue, 23 Feb 2021 08:25:14 +0100 (CET)
Date: Tue, 23 Feb 2021 08:25:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
Message-ID: <20210223072514.GA18079@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210207160327.2955490-7-hch@lst.de>
 <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
 <YDQGIb4YqFpTKfyB@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YDQGIb4YqFpTKfyB@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_022523_002329_3CCFA6D3 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: saravanak@google.com, marcorr@google.com, gregkh@linuxfoundation.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 22, 2021 at 02:29:37PM -0500, Konrad Rzeszutek Wilk wrote:
> > 'max_slots' should be 'unsigned long' here. Breaks SWIOTLB on RPi4. Do you want
> > me to send a fix or you prefer editing the patch?
> 
> I can roll it in. Thx!

Thanks to both of you!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
