Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA56C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 07:46:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD87620786
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 07:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNiC0cop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD87620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AezJu2lyNjFRSozvseBwE52l4NrKrz4zYwscpDQRc+w=; b=MNiC0copyux9f+o7o0Nkpqg6y
	rciEoyWvI19ElUo6wA+9imgdsjZ9gVwS48at9tQpax8Q7prd7umG/IOEKDQdhzE70Wp6vUw5li/Bu
	+PdNt4LlNqthqlJXtmJNKwr69qS0/ELXIOKjwTAHmFJuHW32TPS2F3IgrPfLn5btVNT0xyl8nvXlo
	IicvQMjcbDMI2t8ZMO8ImRE3GSeFWBJUQkBTfu3OC3AV/JptlCgK6aP2Sv14kyoPJU56qJRv6wP/E
	6aXbl6yeQT5xLFiTxWzfxy7NVtUg+QjcvIV/1r0M/o1wHuSlRALnPixGQcn0sOsDbhFsLh2rIbhsG
	e9It0e+lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBCby-0001MT-9x; Thu, 27 Aug 2020 07:46:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBCbv-0001Li-44
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 07:46:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 818A068C65; Thu, 27 Aug 2020 09:46:12 +0200 (CEST)
Date: Thu, 27 Aug 2020 09:46:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: only use power of two io boundaries
Message-ID: <20200827074612.GB7448@lst.de>
References: <20200825163516.1706267-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825163516.1706267-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_034615_279859_761D4B8E 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 25, 2020 at 09:35:16AM -0700, Keith Busch wrote:
> The kernel requires a power of two for boundaries because that's the
> only way it can efficiently split commands that cross them. A
> controller, however, may report a non-power of two boundary.
> 
> The driver had been rounding the controller's value to one the kernel
> can use, but splitting on the wrong boundary provides no benefit on the
> device side, and actually incurs additional submission overhead from
> non-optimal splits. Don't provide any boundary hint if the controller's
> value can't be used.

Shouldn't we log a warning about non-power of two sizes?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
