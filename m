Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD47C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTkVWj0YGNjAYGZYMDSngkkttyG27itErsooHMllJ60=; b=vpV5bVnDgOE6v9UNehmuZJBuAG
	5hbH3WXQ/2UJwftkzO3HdjT+2RJu84FFgTJ3pQSknwKHFBiJjaz/PtyOHHVY9u0rKutv/RWv6C+Ie
	7WkE2hTf1S/L8rawc/KcP9UaevBc/9fm97LEgCq1oUrD0UYONjUlyiKIbO735m2VRsDU7Jp8nHl3p
	lxFRuvg6Pcjhj/vosfEBp9AQMNAqfoCVaqs2b5sw1My0cCrrDAeiGF5eaeXzIQ4tFXHGiqGKBiF/V
	i49nLzcQQkGmwvZL3Mxa52UKfLIDd4gEDhCND+j0XEv1D9Qqw9I8+R0kUxmbYg5pv4ooKAk6vTqBL
	18hVHCug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJFg-0008Pq-O0; Tue, 10 May 2022 06:21:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJFd-0008No-QK
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:21:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 84CD268AFE; Tue, 10 May 2022 08:21:38 +0200 (CEST)
Date: Tue, 10 May 2022 08:21:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Message-ID: <20220510062138.GA11163@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
 <20220411121209.GA21711@lst.de>
 <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
 <YlQ3xWkZNKcMvvOU@kbusch-mbp.dhcp.thefacebook.com>
 <cb42edaa-a545-e7df-f9ed-fcb57caf9139@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb42edaa-a545-e7df-f9ed-fcb57caf9139@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_232142_060094_905EF09D 
X-CRM114-Status: UNSURE (   8.04  )
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

Can you pick up where we stopped and look into a fix here?

