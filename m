Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DEBC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TjZ8Zn05j/7HLCXA871Ze8Zg7Vkdz9h9Wy4xiZ3bCU=; b=gDlF8n/gRpBsM+T7DcU/CXVwtY
	vagq8/0aY9AUfRGHjehw3AOqwjdiwDNMiuKTjM8ckuq0ncYqX/NQ44SAD5+/SsPjMJK3pwHiTyEXl
	uq+Th50mbM3voQSlpNfmAqoJUzZhsP/mn9LYMLyznjJ4IZ06azMqyUbeSr9I6j/PbCkEDvzB1Q45R
	9ls1bEi1cB+hYfQw8/RxsF9Te96a7MzU7yJvUGUmxLybDsH/4vkhs1RoVhfW7d4yRVTvF2dLQDhTt
	ha+dd/8ANTRKTgbD+OfZuqbx6/aPkodlZn2l86dpDydTVfK9eXysTD/VNW4uJ+Q+BNQ3MmPgjjA+G
	bRCC30YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfEPK-008emt-00; Fri, 15 Apr 2022 05:22:10 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nfEPI-008emO-Kp; Fri, 15 Apr 2022 05:22:08 +0000
Date: Thu, 14 Apr 2022 22:22:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
 yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlkBAKBec6BULlE+@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <YlcSiszuNqVZMsb5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcSiszuNqVZMsb5@bombadil.infradead.org>
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

On Wed, Apr 13, 2022 at 11:12:26AM -0700, Luis Chamberlain wrote:
> OK so CONFIG_NVME_MULTIPATH will be nuked, but the module parameter
> will remain, and if the module parameter is used with multipath=N you'll
> end up with a single namespace once the phase out of
> CONFIG_NVME_MULTIPATH is complete.

The other way around.  The plan is that CONFIG_NVME_MULTIPATH will
stay around forever - for deeply embedded devices that only have
a soldered on or sd-card nvme device with a single path there is no
need to carry the multipathing code around.  But the code to support
multiple controllers in a subsystem without CONFIG_NVME_MULTIPATH
will go away.

