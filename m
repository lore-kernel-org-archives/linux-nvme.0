Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4926C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 08:48:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739672064B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1QfgeKLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739672064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQ8rX/BoGzSaOrw/Pz8r+iPSbZH7XfRcjd1AlHME/0o=; b=1QfgeKLyvdBVewM+46m6w/zLG
	xjvxaQndG5CM4eHoivbqGaYYcVSimTbEOEom9R5dPvp4ThfBYbu2YcMW1Co16wCV6K9L7+6UqM4x3
	SIkGMte7rxLDdCQ+BD21HDceliYRWmH2vSnSLQ8IxDyCCFaZu3405Bova2ky0qpBgK+ACufzTgEeK
	MLR2b3w1NC0qcOlML/ntfXZodCMcJULijKBieRuOVuRGnT/MIZ4ycteexFfbN/CmV0qNDFGcBtvee
	KhTk4w1u/bX9REu+lIpWiuZRyUlFHsC3b7JwnIXIC4JF3btqVgMLgE9EtHMGyd2+REs2L9+3GnAtJ
	vnTCjypPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsjH9-0003xA-Rt; Tue, 07 Jul 2020 08:48:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsjH7-0003wn-9g
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 08:48:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 522D068AFE; Tue,  7 Jul 2020 10:48:23 +0200 (CEST)
Date: Tue, 7 Jul 2020 10:48:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH] nvme: document quirked Intel models
Message-ID: <20200707084823.GA27485@lst.de>
References: <20200702213122.50167-1-david.fugate@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702213122.50167-1-david.fugate@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_044825_450916_E472EA8D 
X-CRM114-Status: UNSURE (   4.95  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, david.fugate@intel.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
