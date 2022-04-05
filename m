Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21712C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Bv/cKJ5jWNuINQyirlu4MaEk9aoNd3Iz369PvK+aqQ=; b=bJrU6HTMU7dkHpYf7MfvS1ns52
	FL8+5HNktREEpmwxlQasOtQgUfcqGW8DwO4BmdQJJDJ7gPoaYpjjnWFKLvyact5eWu/BTfECMmuBh
	N/msAW5q1rttwXMr0RKxHXx0MSJ5HwmcFoSkzExcKVpcRKKFvBjePqiXMCOgw5A1bY58mXRgyUGO8
	nT3a7BN2z9we7k5a/XYySZmsg7X5i0oUWW/6SwYLhsHerxdJCwmPdoJ0NAhF0nkfEEjB54qGU9wfi
	Re8tCfu2zXr+h/Ltmeg7ber3+x2oCozxSClkoaaUhgPwptKfELg1w7bmJIp/TgZRNqU/riZjXzb42
	AwuYEaow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcO1-00HGUi-Na; Tue, 05 Apr 2022 06:09:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcNy-00HGTu-JY
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:09:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1A32C68B05; Tue,  5 Apr 2022 08:09:47 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:09:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
Message-ID: <20220405060946.GB24073@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_230950_829183_ADECBE84 
X-CRM114-Status: GOOD (  14.30  )
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

On Tue, Apr 05, 2022 at 08:00:25AM +0200, Hannes Reinecke wrote:
> I actually looked into that with my previous attempt, and really found no 
> good way of having an entry which is
> a) pre-filled
> and
> b) removable by the admin later on.
> From what I've seen all pre-filled entries are static; I haven't found a 
> way to do pre-filled dynamic entries.

I don't think we need to remove the well known discovery subsystem. But
we can allow removing all entries from it and thus reporting an empty
log.

