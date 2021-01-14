Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB62C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 07:23:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42FB239CF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 07:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42FB239CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CLd19CiyxaqVf4vjrfDjkqwQ8y0qEx2a5nNqiBYgEi4=; b=B15C/NdjeIOy6cuoKRYT4cKQc
	O4lMKkOtmdflAzSMSzRS4f88+WPlKAK6Ll1E/3tAxr64N7XUmSddgdiKmYgx0y/cq5MKiDxEMM2c2
	bzJ6WbOVSk8SyKR1kQ7dHiMXWlVxCNZTdAbhg+Tzx5Ao6aSwQiMoqFdGfBEe9jwwq6+iKPTcXL4VG
	SCmUa4QZyjMdqzJ0RqqMb0GQIRuTMI2KPUb8rNC+rucGG5B9AOWMoChnDMcQebl+V3Qbb9io9x4SF
	Vabpv3xqGnNH0MH9jqQpyILw8KtC/039UJGIpTw+Upf7HyQ27HLX9UJ1DcS9uwdk3WCE29dnj5flr
	zKFP2HmIA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwyC-0001zm-Lh; Thu, 14 Jan 2021 07:23:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwyA-0001zL-1A
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 07:22:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B1CFE68AFE; Thu, 14 Jan 2021 08:22:54 +0100 (CET)
Date: Thu, 14 Jan 2021 08:22:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Message-ID: <20210114072254.GA517@lst.de>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
 <20210112080653.GB24949@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112080653.GB24949@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_022258_202432_17E699A6 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 12, 2021 at 09:06:53AM +0100, Christoph Hellwig wrote:
> Except for the little wording issue this looks good to me.  I'll pick it
> up for nvme-5.11 and will fix up the commit log.

Given that we never retry admin command right now I've moved this off 
nvme-5.11 into the pending queue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
