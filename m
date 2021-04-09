Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A9C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 06:15:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F336610C7
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 06:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F336610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AjRXM7XgxJBul19i58fDBnkgeebcurcjboylhCJQSkA=; b=e2oKwgchjNPMG1yHX1deXCrxK
	Qvd/aYk5MyDPuQFi3nE1yaikqooeQn810ZcyE8v96pYT9owrLpooepayqq/iyD0NX4pRpSzSmBnDQ
	0xlkNpooyIqL1PD+Y3fYxeuHCrj9kPk9vAbpPabOpjYCdM/zBoqG4xBWf0yVsON7PM5FIBZYXzW2s
	DLioPVr1RwPkwBpbUVKcT8qvfTjP/SxHzHuPQSOrhmf4XpZxmy7mYX2lb7kqWFk9GYIbGy5uBgJCX
	0HDB0DMBsxg/R4cebUCsrY/OLo6clrYlAO6QRKKfTaufHQ5+R/YJPdzrnCDAEJfCRj2v0EyQSFRLB
	tYIMVMLDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUkPk-00AH84-JE; Fri, 09 Apr 2021 06:14:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUkPa-00AH5D-DA
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 06:14:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8840068BEB; Fri,  9 Apr 2021 08:14:32 +0200 (CEST)
Date: Fri, 9 Apr 2021 08:14:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409061432.GA3702@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
 <20210408165613.GA3774@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408165613.GA3774@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_071437_766919_8D3F4DE3 
X-CRM114-Status: GOOD (  14.33  )
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

On Fri, Apr 09, 2021 at 01:56:13AM +0900, Keith Busch wrote:
> On Thu, Apr 08, 2021 at 02:08:42PM +0200, Christoph Hellwig wrote:
> > +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> > +		const struct file_operations *fops, struct module *owner)
> > +{
> > +	int minor, ret;
> > +
> > +	minor = ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);
> 
> Do we really need to allocate a minor specific for this char dev? It
> looks like the ns->head->instance can provide the unique value.

Looking at this:  no, head->instance doesn't help as it is an
instance relative to subsystem, but doesn't help with a global
allocation over all subsystems.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
