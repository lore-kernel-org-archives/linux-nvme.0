Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1013C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 11:11:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A656F206E2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ncQ5Klmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A656F206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BPfR/eUc+Cot+kjrcfPDAhOdWtLiR/29slUdODdhIWY=; b=ncQ5Klmpw9estk
	ou840xuSEfNTY8cEA+ZRT3oDva8KMquJuCSZNHN+ATDk/RR2RpZ3oRynayZfKd6PSoPbHXTMnXLXt
	3N95W+ac2T7x4ZMxuURHddBo3ow6X+Oe8ikLzuiDcohOceBhWXH1NBnHcgsHP6qN4Fbr3XyPjl3BB
	8uvVud39e+L8AHeX7VC0CoX7EAT+QIRfupI6VgiH2PWAsSRCsuNsQhIgXGhIkmAFNOolkfbdYF6tn
	EO27xw7Va9T6tGkcl2SEfRq7S0CPWVn0xeWLBtkGayGF5ByTPm/ysux1jd6dJDqjm2Ei6jaiW9z/r
	hNYe1r8qtlZ3cPYuFO5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCiDa-0006oa-EX; Fri, 13 Mar 2020 11:11:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCiDU-0006ls-CG
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 11:11:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 83EDF68C4E; Fri, 13 Mar 2020 12:10:58 +0100 (CET)
Date: Fri, 13 Mar 2020 12:10:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 4/5] nvme: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200313111058.GD8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com>
 <20200313053009.19866-5-sblbir@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-5-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_041100_573163_658A5EB9 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 13, 2020 at 05:30:08AM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for
> sending RESIZE notifications via uevents. This notification is
> newly added to NVME devices
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
