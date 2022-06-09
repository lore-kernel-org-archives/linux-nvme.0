Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B087CCA473
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIaleO7+7sDvupmQCAOzUSRzRwmszaSSUrLFHNHJTuo=; b=tL8sRaIGNBLgbmVo8tldjXoQ67
	CrWndiYhzh3yk7kSJg5T8aKZ15t9RqgEcuphY8xNJqpP5vRyAHwbsVgiGi7TV35WCeuvtTlvRWfOE
	Tsso48QOHn2D0wCZB6mZqAHNjbtlm7f4AUNuhLKAHoRKhyEoXhbe7pd3w7grE2UWUZdAyeCQCDM0T
	hCqMvrZiRWiUseZagjc31YUpSwyduBB9PVHWkjV8gW0u8xFUolPu+5jqr3zkyF+dwOruIi2oDn7Og
	fjElHRhFlEu+rTYjlS14Pn9IvVviJQWvYQaK5TT99b5uSj82X/fxHK+QOhIozoCrgvwVM0DZgOVnP
	5HDsc+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzMIA-003Jxs-IG; Thu, 09 Jun 2022 17:49:58 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzMI7-003Juj-Lh
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 17:49:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 49DBBB82F35;
	Thu,  9 Jun 2022 17:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A9C34114;
	Thu,  9 Jun 2022 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654796992;
	bh=KEA31MLTgqqgx/N9ejDRe6N/XouefBuhfPKrJ9fHZ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmAnBODclZCdQOn6Arsbum/fMmcsNyeXpPRoURqC1KZYBL/E8fM6qD6hTI+hZbedh
	 5tnEERtkNiCnTATuY0nBXBEXjxdnlUEFUOz7ZIeZUPI5l3HsTWkA8IWt5xYhcNGRsX
	 M8kdqwuRz5SKtYJzDj1IuIfRF/Ar8r9jQGfzI+aZWuRX69wfjHcsAymTPDIy9qNz5L
	 k2Y89R0S0pZtFv5OgWN0pr5+pf3NwQr8XtC37AwOLfuVcS5w8xzmFIzyIPClq07AGr
	 mWUbqT2CQ37wSpnuOmWfmmMsyj/gHsLgFddAtAXbWwrdKbmzQSJFiEsKt4H0K/iOuJ
	 ONaRcU9+yjYAA==
Date: Thu, 9 Jun 2022 11:49:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: allocate MQ disk
Message-ID: <YqIyvQdcASwatPx2@kbusch-mbp.dhcp.thefacebook.com>
References: <20220609173734.381654-1-vitaly@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609173734.381654-1-vitaly@enfabrica.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220609_104955_895839_05B8A10B 
X-CRM114-Status: UNSURE (   9.69  )
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

On Thu, Jun 09, 2022 at 01:37:34PM -0400, Vitaly Mayatskikh wrote:
> @@ -490,7 +490,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
>  		return 0;
>  
> -	head->disk = blk_alloc_disk(ctrl->numa_node);
> +	head->disk = blk_mq_alloc_disk(ctrl->tagset, NULL);

No, we don't use request based queues for stacking drivers. Especially not one
that re-uses the same tagset with the lower layer it stacks on.

