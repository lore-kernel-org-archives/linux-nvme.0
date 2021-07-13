Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D796C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 21:23:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32336128B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 21:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32336128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SDbTNxFIl4H6yIfOSWkaMy/uBq8ZFkahKR1999t1wyg=; b=ZnlLm7WRp8e2A4
	K2cNRSv83WK4aleUNX/7KqYdpjGJkLuGjPDnyUwao8fGOBgLOzVATYlTtHeYMTNlFOXuSsfekBo6m
	NIfx4vAyufCjpgisDsdcpHnHv4VivfTYkc9VIlu0WLNMK1SKUOt6uN3JEbrcfixt35jEjGzOYpydx
	Kjgko5tojT8W7616sLK41vXVtOw9W06b3nQvujzF4c09idCIDMw2X2UL7QlIj4nG6e4kbZyFvdSdT
	jqF+vOFxqPY0zqm8stalXbBv1+jrg+qVWpgrowuoFYp9fmCANL5EKnGZ3bIejXZH5Sda/El2LPZQc
	+i7kB4Ag3W20z5SryxPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3PsF-00BNmm-20; Tue, 13 Jul 2021 21:23:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3Ps1-00BNmS-4v
 for linux-nvme@lists.infradead.org; Tue, 13 Jul 2021 21:23:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87D60600EF;
 Tue, 13 Jul 2021 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626211392;
 bh=wQKFf84wjf6F8N9lhjlPUJjEbc/L5c32xo9x3g7ZYbY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ippOJPALun+stiQfoCowlga7mIbL53gm+ch17pKzFlJN/Mj/+kX6eLVnuS4b0ekf+
 0MDkV3qykd3Ls66m2yBWXbVAsJr4L5rZPMw39Dh1sYDkc9wvA06I3v1fx5b0HguKAY
 L/cBgCTZvOsGwJIZ3VFr1UVG4sZml0Tf+WkLghcI3aUgUYc2iKq45vmTnUOtM6ScWf
 zZqrg6W2q3/bPbocneFG1BUNFFs2geavEKPRdu0XVnRVuhhZGPGBGwA0q1I7Sqde9v
 O1HnYzXrjp5cc4rQvW5v2GPDCg9qpzYvh+vVoz9UiZO8iGEYksJjBgpYGuMTInQVb+
 ei+VuOam66aog==
Date: Tue, 13 Jul 2021 14:23:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv8] nvme: fix refcounting imbalance when all paths are down
Message-ID: <20210713212308.GA1159813@dhcp-10-100-145-180.wdc.com>
References: <20210624085546.123824-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624085546.123824-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210713_142313_252374_C7BA6ED5 
X-CRM114-Status: GOOD (  12.01  )
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

On Thu, Jun 24, 2021 at 10:55:46AM +0200, Hannes Reinecke wrote:
> When the last path to a ns_head drops the current code
> removes the ns_head from the subsystem list, but will only
> delete the disk itself if the last reference to the ns_head
> drops. This is causing an refcounting imbalance eg when
> applications have a reference to the disk, as then they'll
> never get notified that the disk is in fact dead.
> This patch moves the call 'del_gendisk' into nvme_mpath_check_last_path(),
> ensuring that the disk can be properly removed and applications get the
> appropriate notifications.

I think you may have tried every possible way to address the underlying
issue. :)

This most recent one looks good to me, too.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
