Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B008DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 15:17:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4CA207A6
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 15:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4CA207A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e26bhkBizM/BKUP6ZZq8SSlthsSysWshmb8dw16Dzic=; b=dIsNGm0NheAE2V5M8YnK/iN1O
	YZCqLUV+6GJbm06Vy0uU5ornHBuFA3WTRUb+2n6Tl2NLr4biy9pkbvTXfsbyVkEFdt+sKRFhXFNdy
	+RWd3obddHZnmSiz3lWJHNEc6grYhx/slwcUnZMMQ1IjiU6SoewjYrpwu2XVod/OzRwy7Ckt/Z172
	fH/0egXk4OZVssPkPDWEA3SHLQr09hHgvWyIDDAs7ngxvMXrg+IJ6FWiZ0oZqK33MVz0/6akv0wQx
	XxF5ZaQjHKqqChyRvlwb8mhblXtuT+CWTrWBaF169epiGLobdz804Wb57iwPCfVuIw+lg53X6A3th
	3IxgCRuCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kudDg-0001r0-0V; Wed, 30 Dec 2020 15:17:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kudDb-0001qb-LD
 for linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 15:16:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BF456AE53;
 Wed, 30 Dec 2020 15:16:53 +0000 (UTC)
Date: Wed, 30 Dec 2020 16:16:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Message-ID: <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_101655_823080_B0BB408E 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Enzo Matsumiya <ematsumiya@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 30, 2020 at 03:38:05PM +0100, Daniel Wagner wrote:
> I've enabled CONFIG_DEVRES_DEBUG and see only 'DEVRES ADD' message. If I
> read it correctly the problem is that the resource is attached to the ctl
> devm object and not for the nvme devm object.

I've attached the hwmon to the nvme object, which fixes the obvious
problem. But I still don't see any 'DEVRES REM' message. This would
indicate the nvme object never really goes away... more debugging...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
