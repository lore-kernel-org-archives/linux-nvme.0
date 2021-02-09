Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59349C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 08:47:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA69964EBE
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 08:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA69964EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ltvh4bbmXbePpQciq1j8CVL0gZYXTiIpnkKUnftmTuI=; b=DiYkrkard6k3WKvJO6JWjxbh3
	A46GLXKSoQ4q1KSCPdQDK4Cg7qbSttgpamxINyRB6kLFJaXca3S5N8twXPIORrS0oC5/WabaPLwvs
	52aZw8+FKLu8cA6mrAOP2nQjySIGX9hspfAQfpyzf4cXGOs7EaonudS9EqupN3RN9igZlYjoTCIoF
	nzpqK8st6yCLs0lvgMHpb/cF+36Ga0RMvfuri8QjuqCUdebhXdO7NrfS0r2XKC6dKnjTqRHXFvjq+
	f0h8H8DLS7ktM5rKCtKT+S70MmgtV6pVbnHp7b2P3eHLW2cC0+gBceeG5sGGct+cBbQTNgFBEleYU
	DECxZPTjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Og8-00050w-3F; Tue, 09 Feb 2021 08:47:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Ofn-0004sY-Mf
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 08:47:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52D3764E54;
 Tue,  9 Feb 2021 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612860421;
 bh=z/Bdck+IaHkIZeXXQMqQh3l+DYhl/FkuerjrS0Z4okU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O6K3hXvBw+0tB/PGcQXYmKY9Plixk3xp/I/YfiCfq/M62b48W8fvfkfGWVS4AoJjV
 5izxtFjdYMfv9yCc8RXWG7CIZnR7mqx8EgENWn+GeVN57nP8pNzawAzDhhTjFSDq9w
 b0WuNObJ3egYYnClmK62iL21NscRORo99j5Ur0Ew=
Date: Tue, 9 Feb 2021 09:46:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: preserve DMA offsets when using swiotlb v2
Message-ID: <YCJMAxPi1HlVedfL@kroah.com>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210209084156.GA32320@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209084156.GA32320@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_034703_886855_40A3A174 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 09:41:56AM +0100, Christoph Hellwig wrote:
> Sorry for being a little pushy, any chance we could get this reviewed
> in time for the 5.12 merge window?

No objection from me, my ack is already on the patch that you need it
for :)

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
