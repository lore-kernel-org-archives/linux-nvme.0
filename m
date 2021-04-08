Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1410FC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 16:56:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC43B61056
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 16:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC43B61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NPTOy+UivzdVNWyl1QeSlsA07V9AFeTSKdxrjoJw2+k=; b=icTzq159K7KKptJ7KsotR3+OE
	Y/TdTgu2788ACIiZutxnqKM4sD4u00OfEMMhisNL/Coo8kG4WJPnAjPiB82KYHifH2eSyjaMP0VwD
	Xy8OH1iMjBQIpQnuPdjZjtGyG5GwMQ6BBUURNPiy6b2pOGSHsI+w6OxW5lzFXWO5NhdvbDONXph/K
	YK1SatlvKsI1cmMfdze4gAdQdjJAKS712Pn4WDzF+fO4HAe43kSi2LRKECGobAEVUIWQbE0rZnZ4k
	ZPssAVULAj+wVn8Wu2zOTT1XJsxNjwRy7Z1afBe7fdTjXYmnUjQhJk5QNe4g9kGpwg8xIFu67DdLK
	+ZqdyDOsQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUXx7-008hQQ-Vy; Thu, 08 Apr 2021 16:56:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUXx3-008hPB-W8
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 16:56:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B83DC61056;
 Thu,  8 Apr 2021 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617900976;
 bh=gJxvEp0no+4aCisHGIrlAUs1pxuYXy+BWxfoVL0IVt0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g5/17Mbjt58Peuq+77rYr7Xu5aDb0QdkUPDsNMfQc1hwURdcMfsHTEJkgKR3U3R3L
 XFdWgJFRU9FLMPh06o3XF5Fufer37oD9nzhfrehpE+vpPd49Wen3YEd1vRrboN3AyT
 nf8aAB0Nu79ngnb8ZVtufNeyK5sTheqGDuRLgtOaRasKtGW8a/EingDgjgTFzvfZ0U
 XKlUXS+yzpHABKyRfj33lGsMVcLvouWQyEqtTQ11Nh9XmppqwepMn2JTFNk2umV9f6
 darNZ8kwHBC4eNo7OyqyriRZ80huuy2hWzFjhCeJM2nRWeA38d3/ccM7gsg14QKLRB
 FOhvGBvGCkWig==
Date: Fri, 9 Apr 2021 01:56:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210408165613.GA3774@redsun51.ssa.fujisawa.hgst.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120842.1450092-14-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_175618_293819_CED19F7E 
X-CRM114-Status: UNSURE (   9.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 08, 2021 at 02:08:42PM +0200, Christoph Hellwig wrote:
> +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> +		const struct file_operations *fops, struct module *owner)
> +{
> +	int minor, ret;
> +
> +	minor = ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);

Do we really need to allocate a minor specific for this char dev? It
looks like the ns->head->instance can provide the unique value.

> +	if (minor < 0)
> +		return minor;
> +	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
