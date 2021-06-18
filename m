Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7768C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 13:43:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665BA60C41
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665BA60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xIXgYYgVdwQ6z+j/kNNmE/Snh2/D6His9ndjbL4MKB4=; b=ObLMhFCDWYiCca
	L5iOkjO5g/yGP4ay0zeUE/Mn/4lta7coiq08QIpCnoHmEFIvafvX8V2KS4XUCBubSDAjA7codARMT
	VkVISM+4P7Id5z1U95M2pyPWgbpa2e3PQ3PuYIewNyR4FhYBPlqmeuXzaZNUgh9CJ5AljoPRugtBK
	qoWQghMEOd2gKKjmLEiryDdR9oM5os3ClJGtwtxU9HvmSJG93dubYd3XZonRh4KjJxuziC+SE0cvi
	Y1s7FvPzPsys9v7/z3xsoy8A4HpSZQ+uOftuLsMeQjPkdD/io/ovbudx3AATo8JIfvGXfZ0lzH9LV
	OmSQ6iq+gju4EGls3YDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luElp-00EKnw-8b; Fri, 18 Jun 2021 13:42:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luEll-00EKn5-CL
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 13:42:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E6D9368D08; Fri, 18 Jun 2021 15:42:44 +0200 (CEST)
Date: Fri, 18 Jun 2021 15:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, martin.belanger@dell.com,
 aelior@marvell.com, okulkarni@marvell.com, smalin@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead
 dev_get_by_name for OPT_HOST_IFACE
Message-ID: <20210618134244.GA16005@lst.de>
References: <20210618133956.10637-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618133956.10637-1-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_064249_606697_68E61441 
X-CRM114-Status: GOOD (  13.35  )
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

On Fri, Jun 18, 2021 at 04:39:56PM +0300, Prabhakar Kushwaha wrote:
> dev_get_by_name() finds network device by name but it also increases
> reference count.
> Increasing the ref count,
> If nvme-tcp queue is present and the network device driver is removed
> before nvme_tcp, we will face the following continuous log:
>   "kernel:unregister_netdevice: waiting for <eth> to become
>   free. Usage count = 2"
> And rmmod further halts. Similar case arises during reboot/shutdown
> with nvme-tcp queue present and both never completes.
> 
> As a fix we will use __dev_get_by_name() which find network device by
> name without increasing any reference counter.

And when you remove it without the refcount we'll now have a stale
kernel pointer?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
