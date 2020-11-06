Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E1C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 18:00:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA73206FA
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K/gfA0s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA73206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tNMkrUEPkrlYh9tGQhGY+rH4xTBGjIwB5dZReplLopc=; b=K/gfA0s5H0+yJBEPS8uow3/33
	DTw0VpwE8CHrXvaKgjfQ8r1s7LhZ1Oqtp9i+rkbyC/UySxP6PxFpPwjCH8ELECEAt4aouSXRA3Q2+
	LUdE4u8hCelccUNVAav+N5YJzNOwP4yJFvryaSb8iPq+9ZVFW28Q86YYo7OOnuIkbNJUalaXi4H8W
	vFP9oH6hFP3qbFc+ZU8isS0PcMt3YTqm9AIhKTTg4Qrysl7zc9CJQ1ExdUSU8lh7s5QLjzAov+vxg
	mrGQaZ9pozswyZed9zPIEniO9YWSL/KajsAKOVqphsdO/UybWne1L5TnmedVqPyMriep77RBv1a2V
	9VF45o/QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb61k-0003Cj-J6; Fri, 06 Nov 2020 17:59:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb61h-0003Bx-OX
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:59:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0786968B05; Fri,  6 Nov 2020 18:59:50 +0100 (CET)
Date: Fri, 6 Nov 2020 18:59:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: revert commit 1293477f4f32 as it is breaking
 BLKROSET
Message-ID: <20201106175949.GA7529@lst.de>
References: <20201106171835.38236-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201106171835.38236-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_125953_930011_A72A7FBA 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 06, 2020 at 09:18:35AM -0800, Sagi Grimberg wrote:
> The offending commit breaks BLKROSET ioctl because a device
> revalidation will blindly override BLKROSET setting.
> 
> The author should resubmit this commit in a way that does
> not break BLKROSET.

Let's fix this properly instead of a blind revert.

> -	if (id->nsattr & NVME_NS_ATTR_RO)
> -		set_disk_ro(disk, true);
> -	else
> -		set_disk_ro(disk, false);

Just dropping the else part is probably enough for now, although
as a follow on we should probably add a "hard read-only" state to
the block layer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
