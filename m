Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CEC4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:51:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C54206A1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ir9e3Jek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C54206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N20hwoGbQ3xVpC3k4WKXFP+29eU1tdSrrmXIdoc6usw=; b=ir9e3Jeka8aVOXRUStv6OrO1M
	nQEyzNJBF8c1wmgA2BWBUx0NV/8tawPhwq/4TBrD80oX7PXYxnGlyUy1FUy0BGzDHyEyOQMY+48+9
	KuS2dB5IfSqhKe9K13w+31Yy5g7dCqRmROHdxk3hX+g6Dka5fUUk1+jyFAuNkSoPqrD3e/QlofyLU
	4fOUFtud/vczb+9srURpZKh91I9o2g8W5Ps+x7h3RYPJ151/9Rc8e+usDBVwhME1P8JXZKQYGnQ3B
	ypzEJQCxzebAs+HfzWL05Hb6SvArUM6mp6vIuZnvuEAh8mhqG+AVkv5cPQaqvLUmfOQNIiBxtKN7F
	pCfq1cLRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPPxE-0004ip-5K; Mon, 05 Oct 2020 12:51:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPxB-0004hz-IC
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 12:50:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DEB3E67373; Mon,  5 Oct 2020 14:50:54 +0200 (CEST)
Date: Mon, 5 Oct 2020 14:50:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] nvme-mpath: delete disk after last connection
Message-ID: <20201005125054.GA1125@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005124500.6015-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_085057_712364_73DDB065 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> -	nvme_mpath_remove_disk(head);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (head->disk)
> +		put_disk(head->disk);
> +#endif

Please move this into a helper in multipath.c with a stub for the
non-multipath case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
