Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63919C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:59:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C1F2088E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yPIRxu3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rNV6P76o4i/QRlmKpCL4WT0BFLNEXnMbb1XO8yzkAtM=; b=yPIRxu3Hzl1kS0p6Jvje+Zal0J
	Fvfkogm1O8g8w6QcuEM0zpaKDe1QvaWj7UaK8k7rJQ3ytuOeIpdDywEM54BFNSPCvI2pyeUTQkLML
	IuNWwSRSLv+XylmsBn0mxjAPUA84O+oUPbaWu2by3RiFO7sI46yIbdGdcCOHPPur2PwspaANwaKRS
	+am4qbh3k/Mf/KAVQ2VS8MD2Hsd8L02JARLp8HkoczTNA/O3TjRBMTIh3OtIsCUhAGanAKDy61wxA
	XpzdM9PpjpSSe6VNZigx5IQBe8XDBWRER20WFyFUgPvsZcIWpml4Fh2j6tDKTNHZTMEe10t7YirMk
	EhuWI0yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo0JE-00086j-VQ; Wed, 24 Jun 2020 07:59:05 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo0JB-000845-IU
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 07:59:02 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U0aLOJ8_1592985534; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0aLOJ8_1592985534) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 15:58:54 +0800
Date: Wed, 24 Jun 2020 15:58:54 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Message-ID: <20200624075854.GA37292@VM20190228-100.tbsite.net>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
 <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
 <20200624065258.GA18130@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624065258.GA18130@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 08:52:58AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 02:49:57PM +0800, Baolin Wang wrote:
> > >From the NVMe spec, "In order to make efficient use of the non-volatile
> > memory, it is often advantageous to execute multiple commands from a
> > Submission Queue in parallel. For Submission Queues that are using
> > weighted round robin with urgent priority class or round robin
> > arbitration, host software may configure an Arbitration Burst setting".
> > Thus add Arbitration Burst setting support.
> 
> What is the value add of doing this in the kernel?  Wouldn't a nvme-cli
> subcommand to just set the arbitration burst to the recommended value,
> either as a saved or current value be both more useful and also cause
> less kernel bloat?

Yes, that's another way to configure the RAB, but for some simple and
frequently-used usage cases, we just want to use the recommanded arbitration
burst as default without bothering the nvme-cli tool every reset time.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
