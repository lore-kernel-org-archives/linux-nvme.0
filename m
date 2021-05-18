Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1796C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:49:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA02611BD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA02611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OyLCHJUhPpI1uy6uoQqFr41bFt8eA65h8MaY/itJRrs=; b=WcVFcgnIX4iJw4M8eK3CiX98l
	4f9ngNoI/+pC0cMocjWQK4YFzhjQ2DbYgRix5ygLtzBvZ7b/wLX4YHGHcxn0MY42AiM4qm0QoK4bq
	c9bPbgYD94ifNwOydIjSkTTFD4Aqf/VUgs5FcdW9XUBIZkziz55Sf3MKC7hznqQa0oqYtG6CnMS6M
	2wrxaTscIk5z4jbiL2TGlzedtMd/wxxgNCuCFGtk7HazNTJo/UKMat4KNBDHNRvAzAjviyc88E7X5
	GIPmvrHtKga77GlEoGXEgACEqOnsEF9wH98J57XEp/HfLKN/w6rl3xDXw7LmtTy7nzc01swf46t8s
	nvNHhEx8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litXq-00HCim-CY; Tue, 18 May 2021 06:49:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litXn-00HCiP-2a
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qsHZRcLUP/cuKvr0RI615y1CVc5+iLl2Q45FWgrXbSA=; b=Ij5CtiKJJhuz3S3W8BzQZcEAI1
 cGhindopK4/BvcXhOsBLqV9HgeOEMtzO0jbveoiAZmgYNugMBOmn9cZTfWdG2JYGJKFOQfSSV6z6m
 VWwXgLOAjDmRgSkqLReZUyHc5HMHUDxEVi/fde/UbMWaCnJHixvhxucIAF1PWAkkfVUJ4Wie3H5P5
 esCgqgRk7vO9cbf6ks1WQhu0a9/hLFkkOHFGiDte5Bl3d3sSTypN57oEmiL88+G4EhxDACA3AUx+b
 qUlbME/mQmjyAbTv83gAlQP3CJXUWUSMXnTaVPAUJsHFoPHD0dYTbCC2N4n7TUKaSKAJ83E5GkNNS
 22y/fM4g==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litXj-00ENWX-LV
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:49:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3EE1067373; Tue, 18 May 2021 08:49:18 +0200 (CEST)
Date: Tue, 18 May 2021 08:49:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: Re: [PATCH 0/4] nvme: nidt and ns-desc related clanup
Message-ID: <20210518064917.GA8093@lst.de>
References: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_234927_875992_0C34D880 
X-CRM114-Status: GOOD (  14.62  )
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

On Mon, May 17, 2021 at 10:05:53PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small patch-series tries to minimize the number of the macro
> identifiers. 
> 
> In the current code we maintain NVME_NIDT_XXX identifire values and the
> their length NVME_NIDT_XXX_LEN separately which has 1:1 mapping. This
> adds founr extra macros and open coding of such macros in the host and
> the target.
> 
> With this open coding in future we will have to maintain one extra macro
> representing length for each new NIDT identifire that we will add.

I really don't see the point.  You remove one define per type, but
need to create a mapping table entry.  This adds (slightly) more code
and is less obvious.  Do you have any grand plans for which this is
a preparation?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
