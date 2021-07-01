Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C61C11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 11:52:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EF4613D1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF4613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=saX2DrXnVBwHZs15D6wKEcafP3jKoxHAC4vH5wDA5zM=; b=O1aphQewnR3f3a
	/xctsAOXSs58zEuRTizQb0u/cG9n1hR2+kaoxemXM8+pNE6ROKzAgF08FcHSNLMMdo52fE9G1IM/a
	MOj+wVVuYdbkXD9wdlhqBky+06lqsZqj8G988+1Asyj/yIkLt4TKXGlm4Oii/wgTRvOY5Dj+IkbkL
	ffc0kKJ+gowgtbtD4HhYG9YN2+YGtJMpZOa099Xrc8AX2iIrEf985cuHuYXRwGJtRvLvtaByZa9hl
	xCIrKVGFVWFi7lCcqmftsgO3MLHkJQ7AgQyM2MXZ3hfeKnZJyh+qifLZG5UukOG/CKFd+64VkbWNI
	edT7r7CJnMXmdORNKYNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyvF7-00H7DB-EO; Thu, 01 Jul 2021 11:52:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyvF5-00H7CM-2O
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 11:52:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A45B067357; Thu,  1 Jul 2021 13:52:20 +0200 (CEST)
Date: Thu, 1 Jul 2021 13:52:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request
 reference after completion
Message-ID: <20210701115220.GA12095@lst.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
 <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
 <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
 <20210701115123.ir7huzzpifhsk7cz@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210701115123.ir7huzzpifhsk7cz@beryllium.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_045227_334618_3AD7AEF9 
X-CRM114-Status: GOOD (  13.86  )
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

On Thu, Jul 01, 2021 at 01:51:23PM +0200, Daniel Wagner wrote:
> On Wed, Jun 16, 2021 at 02:05:16PM -0700, Sagi Grimberg wrote:
> > Cool, Christoph, where do you stand on this? Can we move forward with
> > this?
> 
> Same here, I would like to get this merged. Thanks!

I think this can go in as soon as we open the nvme-5.15 branch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
