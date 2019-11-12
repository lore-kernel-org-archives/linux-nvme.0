Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F49FC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 16:49:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2FF21D7F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 16:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jObpw+s7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="glUAxkHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2FF21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OP30YhMh/3+kpE5K8ZGOEvLQbKYYYJljouEn+pRH0aE=; b=jObpw+s7p9qQnO
	pegykCQaDp472Ty42hHHuq6NLRwfW5YpoOSTIhanDMDm2R5YJD8h2765WH5lPQAgmbdKRw2PZ1+Ud
	h/G6di9ohiRwILTDkQXRoesh5hznSQdAOnYVRivBnmCTKnnPvvBt0q04vIyUU2NnjCp3elsQf00ru
	DjjhPm+JZrQRYZ45Weef8xD3KbK/o1m/Hgxsz07urHgn0tEwKSMXDXIMiOR8DV7BWBcBNTVazPvM9
	alRrwd8pIxpS6FqTQnd0cLikxRIsXl4B+Zpm002S9uV7kMZuWMKmQyCEAZd+6QSsCpf1kbvyRVGGm
	MGRZWXkHJZuLMc5Ls/Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUZMY-0003o5-N2; Tue, 12 Nov 2019 16:49:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUZMV-0003nV-5k
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 16:49:52 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD3DC2196E;
 Tue, 12 Nov 2019 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573577390;
 bh=Q2xRU7Z4v3yzGyfzxMUbjy7nzrxqCBLw3lpu3s35AsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=glUAxkHM0wzHyQ0mEHJ85TsKR/2yyVvFdh5Hjle2DFFl8RWS+EC+wwjzbA4oJRL/L
 lFD7RaH792NVskFVUbpDU3fARU1RZlMqih0HrZalFeXAP5QdLgWVU5EXS0Cnv4ZrHH
 x9bvGq56HwDsjyHfuMQMluidVgOi7RHLmSpuHSi0=
Date: Wed, 13 Nov 2019 01:49:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191112164947.GB29135@redsun51.ssa.fujisawa.hgst.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
 <8198fd99-6b47-7594-ba1c-4a15ffe25269@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8198fd99-6b47-7594-ba1c-4a15ffe25269@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_084951_237932_5D85C283 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2019 at 05:25:59PM +0100, Hannes Reinecke wrote:
> (Nitpick: what does happen with the interrupt if we have a mask of
> several CPUs? Will the interrupt delivered to one CPU?
> To all in the mask?

The hard-interrupt will be delivered to effectively one of the CPUs in the
mask. The one that is selected is determined when the IRQ is allocated,
and it should try to select one form the mask that is least used (see
matrix_find_best_cpu_managed()).

> Can't we implement blk_poll? Or maybe even threaded interrupts?

Threaded interrupts sound good. Currently, though, threaded interrupts
execute only on the same cpu as the hard irq. There was a proposal here to
change that to use any CPU in the mask, and I still think it makes sense

  http://lists.infradead.org/pipermail/linux-nvme/2019-August/026628.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
