Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78607CF537D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m20qBKCxYo5QMn5C35aeIouSZ55pRcr0RwOoWTNf5Mo=; b=OltamNNWuRoUzvVlUW4DdE9GAh
	OKlidIUD9h91g2RW6VSJXXlJsvSJad9aOGF3FCqsWK/UOelxg/LES+WDZoejJUBvMbH/F362SAlhc
	peOjV2j6SawW91ylJlXgO5ippC2AmSK6fR7qIlQroKfyYbWY1xmWF8roRCV7cS7F9y90cCeWSxaUc
	RExpbt7k0Ebq5Yc2YTggCfRiRof8WZ4+gA0gR1CqpkbKzRg+DblqLiAan7jRX8Aq1txmsOZpNw/pp
	NAp3Cp8LcKp8Cexzv7m7DXy3cMTY/OD918d0qLF1flTba6Tbm/lKviItOghF+/ZGu1PFdmyogFJIx
	IGVCgf+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3aji-0000000EMzx-41wL;
	Wed, 23 Oct 2024 12:45:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ajh-0000000EMz6-0zLm;
	Wed, 23 Oct 2024 12:45:13 +0000
Date: Wed, 23 Oct 2024 05:45:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v3] nvme: fix nvme_ns_has_pi() to check PI size if
 metadata size or below
Message-ID: <Zxjv2TL6-3557BvJ@infradead.org>
References: <20241022181132.19871-1-ikegami.t@gmail.com>
 <Zxf7DJ-BTW9odH7M@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxf7DJ-BTW9odH7M@kbusch-mbp>
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

On Tue, Oct 22, 2024 at 01:20:44PM -0600, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 03:10:54AM +0900, Tokunori Ikegami wrote:
> > The PI is the first bytes or last bytes of the metadata.
> > So its size is not equal to the metadata size only but below also.
> 
> This is still wrong because the only users of this function are with
> respect to PRACT. If anything, you could change the name from "has_pi"
> to "supports_pract", or something like that.

It's also use in the NVME_NS_METADATA_SUPPORTED for fabrics.
Where fabrics really means RDMA with the Mellanox PI offload.  I don't
really know if that supports PI smaller than the metadata size offhand.


