Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCDC433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 05:11:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7984A619BC
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 05:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7984A619BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ls1CvdF9LBT+y3GUEVjeV+BKD612d+krtFQv9wUPbKE=; b=Uo0R3vMdaeLfCwkFHb4HOstEQ
	Isgku2JOsK5cakNGIL/N0NYsE7JGdg31BMc8oVzgYg1kPhzt0nl8vlhPjgvyDdnD18abdr/tuTYgY
	cNSRiJHWQpiDHM0yK8da+AU+oxAxYclHoWJzEL2WXOW5cv/TpeLRMi1Fg3sLRBKsnpYVJBclB/PQQ
	pM1fenNjGFij3s15R0z9xLRhPGoGKDVKAGDvFvUuyAwhrbDbQsVxz6NLpO+GiXbFsY2S3qxjwGy5T
	JVNsv74n5UYLyQUjC4KxS20MD0p8tuUGsH9L2l9n3e3xpG3iKPbCF6q2dZcKlnE1Us6UWW6Dm4mUP
	PcUMaDc5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRT8F-005WNU-JJ; Wed, 31 Mar 2021 05:11:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRT89-005WMh-Ss
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 05:11:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 12C0D68B05; Wed, 31 Mar 2021 07:10:59 +0200 (CEST)
Date: Wed, 31 Mar 2021 07:10:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Report MDTS values that are too large
Message-ID: <20210331051058.GA6244@lst.de>
References: <20210331034214.5792-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331034214.5792-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_061102_291350_BFCACAF1 
X-CRM114-Status: GOOD (  11.34  )
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

On Tue, Mar 30, 2021 at 08:42:14PM -0700, Bart Van Assche wrote:
> Instead of triggering an integer overflow and undefined behavior if MDTS is
> too large, set max_hw_sectors to UINT_MAX and log an error message.

I really do not think reporting an error for something that is
perfetly valid but not useful to Linux makes much sense.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
