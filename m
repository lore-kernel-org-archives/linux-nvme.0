Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EBBC43217
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=; b=x4Dd4VhT5IXDKKmLG5klG3yxBl
	iMK/zwGeSNBuwRstVhhiKmBBjqq8nzGUhfU7VRJnd16b723pk1FL9y2zX7jzKT2LGEoBbSgG2fjoL
	DZupxGJ50VnIGxL4rtDE9d+fcWUTtU+73Gwi56vdwm1TWXyf856CR2MonSwdt5a4MCF4WX7B8hNt9
	sOurPy2W+EtKAQEwJYKZR58issVY2GCI171J1Ff7zHuEh1Luwpbnok4fjBEWlQSGFe/t+bTIIylCa
	j6Y4tCrNagtXcME7mZ/aqf2jSSbn7xW+DCuU5OHXtFTpPs86367pYLRuuLqQHf3PSyK20LaFW4JkX
	S5V2Ml3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5Fj-00GKyc-Cg; Mon, 07 Nov 2022 16:45:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os57O-00GFPi-W4
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 16:37:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4FEEC611C3;
	Mon,  7 Nov 2022 16:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4F3C433D6;
	Mon,  7 Nov 2022 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667839021;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wi15GrYM+tqEFQeANITyB9KKkgz8fhuM2cEjfesBXIQFfroFZvRqKwQnQD0dpa4up
	 MIWDy0grHAOps4oR/sxRY/i6Q/kVkOg8OgrCgjI3S45+QSVkLXmxOP9e9vPgWoTJa8
	 tA8nzh6WkDDCPzCFf7iuyYrkOWsSxaoowseBea9ifbhSnip4XrhUFx/YUpJPgeMRl2
	 TsUznzZIIH8iJJQr9+vIpIAL7zCllU6UgreaBYqtHCUofcBi4GpZZUh7/O2XxlSEwh
	 esNImVKSzA0n9f8RvwM3LnvV9+nrTto4sRMs0XzqO4O72z7Atwb29wORmy5v68dXzh
	 j513RTGBbrn2A==
Date: Mon, 7 Nov 2022 09:36:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: only allocate a single slab for bvecs
Message-ID: <Y2k0K/ZXh/VECrEk@kbusch-mbp>
References: <20221107140019.1503818-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107140019.1503818-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_083703_093023_4317F260 
X-CRM114-Status: UNSURE (   7.42  )
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

