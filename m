Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9CDC3B186
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:56:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D0E20714
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIoGZDQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D0E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PNOOo9VkxeciXi7CoFMEQ7Pv5cZ6pluESN3NZODMRFQ=; b=LIoGZDQh789Mtl
	H9SuAqbocv9kjXHfh+J2Ndhgul4huOR9a51B2D+tj0FHLKcxte1yRGcSGxrhQLtOUBlJu2EaG1guk
	NyRCsHpn3SRAfM6HaXkVzf7P6I/d9TEbsJhy6WyxyNM+27TPirZcaz6/1qAwzfg+BSmQhyCp/bCPq
	41nLX0rcLBsuan0E3dC67h52WHuJCUcG+g1pRTYC9ydTa0zCgkEtw/entUgvhbvbQ4ciBlzN9HdHA
	zSgV58EZkIeVdDjS3wIj1BlWjFY5ufGDUVHJMJXFecHALlj5R6navFL4n3duWu3tpzGD2IpqVigkx
	X0ntrh2jrNk1FlME9kVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1wEz-00056S-CJ; Wed, 12 Feb 2020 17:56:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1wEx-00055f-9Y
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 17:56:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E7FFD68BFE; Wed, 12 Feb 2020 18:55:56 +0100 (CET)
Date: Wed, 12 Feb 2020 18:55:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: Case-sensitive host NQN
Message-ID: <20200212175556.GA6014@lst.de>
References: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
 <20200212173529.GA5648@lst.de> <055b0c4e-905a-7f3f-d5eb-595e127d423b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <055b0c4e-905a-7f3f-d5eb-595e127d423b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_095559_489543_8D6CF10D 
X-CRM114-Status: UNSURE (   7.36  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 06:51:54PM +0100, Hannes Reinecke wrote:
> IE we would be perfectly within the spec to convert the nqn to eg lowercase 
> when reading it from /etc/nvme/hostnqn.

We could, but why would we?  Case sensitivity is a complete pain and
avoiding it wherever we can is a good thing.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
