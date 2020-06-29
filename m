Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE42C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 12:31:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4617223D22
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpQ2lcZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617223D22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bu2kGiPGUv8EO8vmc+qTQwfTgB+crTSg7S1tiImdpuI=; b=LpQ2lcZDc7gcyLyygEC7YYtnUS
	wDFFEq717fADltR5J0B01dUUQXTxLclhBTf7GOe+rpL9URGlvOQPHpm867Nkcvh/mChmOTYPGzrTT
	nxcHDTzyWZ6cp1og8DASedL5ysPizj7vB2/+RLXFgiNCH7Ty2mLLumrgLaS9RivuFpT9z5IMO1GNt
	k9ZJv8TTXss+kKcr/0j2sEUoZCysatwEKRf+L1GzL6nzwB80LnOwywMdC+oo5AW6b7KJwd+s4wPyR
	Euystk4AG1/Vrgng1sdS9yYud2kCP9Y+EDaDwHRyOPZJ5Ny6qr5gwa9zeP1A4ni3J3WSamxTFxS2K
	5CnMaqNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpsw4-000539-8i; Mon, 29 Jun 2020 12:30:56 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpsvB-0004e9-IW
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 12:30:05 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U12RZQh_1593433787; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U12RZQh_1593433787) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 29 Jun 2020 20:29:47 +0800
Date: Mon, 29 Jun 2020 20:29:47 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Message-ID: <20200629122947.GA31739@VM20190228-100.tbsite.net>
References: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
 <20200629013143.GA1778220@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629013143.GA1778220@dhcp-10-100-145-180.wdl.wdc.com>
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
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jun 28, 2020 at 06:31:43PM -0700, Keith Busch wrote:
> On Sun, Jun 28, 2020 at 06:34:46PM +0800, Baolin Wang wrote:
> > Move the sg table allocation and free into the init_request() and
> > exit_request(), instead of allocating sg table when queuing requests,
> > which can benefit the IO performance.
> 
> If you want to pre-allocate something per-request, you can add the size
> to the tagset's cmd_size.
> 
> But this is adding almost 4k per request. Considering how many requests
> we try to allocate, that's a bit too large to count on being available
> or sequestor for this driver.

I saw other block drivers (mmc, scsi) had allocated the sg table in
init_request() instead of allocating them when queuing requests to benefit
performance, but I am not sure why the nvme did not do like this. OK,
now I think I know the reason, thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
