Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF1C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:48:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB7920781
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aq2FrRuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB7920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DVfQD+Q6xlTI487It3KEFf2irhmjTNoTKiBIvnRf1E4=; b=aq2FrRuAw/7XzQqhQJjnF7WVU
	CQiaMm6lC6HU/bhQAkGFavKDyY6YatkGV66b2sN8GGZ3aqxMn/roNZZxdA/AdX4+ekKd6aTa0K8N6
	UJ7SdAQy2publtB+3RCcVRPesJkZbH/ZD584+TXwrS0bSqS3idEJrl9DcjvSvHYJVI6jdC0TBIsrW
	i9DTNgFVKK0FTgy8xXzlEUe2ddN/1Mp1r0JH9lQ2cSp7bXrq+oCzt9p9JFBI8kyVYW6sHrFTZ1bza
	5cKp511ZVbNAsKXxprY9COpogkGRiPJfp+K6uHARiaCYyDox9lZZMaSbcYsgbkNhWou4TYALAJB3z
	mUFiefmag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6FSV-0001z4-1d; Thu, 13 Aug 2020 15:48:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6FSS-0001xr-P8
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 15:48:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 21F4E68AFE; Thu, 13 Aug 2020 17:47:58 +0200 (CEST)
Date: Thu, 13 Aug 2020 17:47:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
Message-ID: <20200813154757.GA14486@lst.de>
References: <20200812081844.22224-1-lengchao@huawei.com>
 <20200812151035.GB29544@lst.de> <20200812202829.GA586@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812202829.GA586@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_114800_965318_62F65325 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, Chao Leng <lengchao@huawei.com>,
 kbusch@kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2020 at 04:28:30PM -0400, Mike Snitzer wrote:
> On Wed, Aug 12 2020 at 11:10am -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
> > > nvme should not depend on blk status, just need check nvme status.
> > > Just need do translating nvme status to blk status for returning error.
> > 
> > While this doesn't look wrong it also doesn't save us a single
> > instruction and actually adds more lines of code.  Do you have a good
> > reason for this change?
> 
> It certainly saves nvme_error_status(nvme_req(req)->status if
> nvme_req_needs_retry().

Yeah, but the retry path isn't exactly the fast path, is it?

Not that I really care too much about this one..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
