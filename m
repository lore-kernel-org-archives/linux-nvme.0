Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35A9C433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:39:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F4661003
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F4661003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pCd2AZHi/KWzVzHtOkpQx5Vcq8jS7zWWqelZxfQuFSE=; b=mE/8Pq++0FK/qFOu5o95IG9uv
	HPGXGp6ydzIOEGG2+OzZTG+BfkY9zsrMBfn5mpOGNQ9l+p4XA/pZ5qS0FU0wK6IOJJnfCIgpTiPUM
	eRMO4TeeuG10v821pA6uiN4EoEi9Y/uCuhqArfqF6nIZhlieleRNMLsmibdwvnGtTEKNvYXNHnhr4
	4VAGXVOVqmIIFcM8Gx/GAsbEUEWrLeqTQ1FT0Abc6DX2ESIbwcjOk4yg1bFwUnsp/8dyj79LItMij
	oPACV0qtQTc+sOWDCbakeYXgsAJBE7XwjIaeTFluDZlCqpNHD8fz/7YIiTxsiXbdqZz+EmY+hqIcH
	yXB//N5Tg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXarz-0046gE-2o; Sat, 17 Apr 2021 02:39:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXarv-0046fz-IM
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 02:39:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=aDLyy2Ja5NLwS11lwzxlImuGkyN7gifgByJNPlpXsd4=; b=5FRLjCNO/LSXcyJfZMo3MMuHiK
 zPisvffslC7kUH/4ADiUsjBfoNL8gmIxMlpsioH5/N/+xLfhujMH5axv8f1WIV8pRwbWdMVA/HBHf
 os2M5IVkH/qiZifcSMGGbRalacG1J/xDC3e92TCA/+e8UtWGbeqmhAZVq7QAeMuVzt4bpMuP0U8Eh
 If4EYEAuXzs92k7wwVCPifsSZukvTC0myncT9MoELGYski6YhT5TdD+6O9Zx2FsqY8jRNkFy4K/pY
 bQ4VsodJktFvBhWi3QADKYKDy2fM/wA/OTYxdkFKNxO0y9AKsadlGEQp9IMt+RFiNLZjPBlaaCAW8
 2KQY+T2w==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXart-009ptE-3v
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 02:39:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8A161003;
 Sat, 17 Apr 2021 02:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618627172;
 bh=pSDKr/liJyVbO63YqO2P1N7S8zwfLxAGDsxPHIyOWNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jNEBNTAwlPifNx9srHY82kEe1rEG5u2s3TDCy2+kZ0ghCMaJzK4lLDBc7ZuOVuxk1
 tWH7XBIDUk80UmK5Ae3t7JFHwSCGFoAWWIPEDJWBXdtRXY3LgLacyA7Q2QKWD/UIIJ
 B04WXlt44f8TTrbZ57y1rdYxhhfusbSDIYHTqvGwusqC58ScbhbRW/0DOJOzuhFwHe
 rHVYHbSnOBIom0Qrw4YFSLDIdxjVSBXKFqHpvyTKwLmYkKMxfKjRMQCR5PSQk/JOvR
 /cSbfg10aJ1z5S0Tfb83OYPxGanri3VTxGHgtVg5ivWd8vCSMg17pgHIt4WeehIrlI
 heeGrWqrmaJIg==
Date: Sat, 17 Apr 2021 11:39:29 +0900
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, yzhong@purestorage.com
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210417023929.GD32082@redsun51.ssa.fujisawa.hgst.com>
References: <CALCePG0y1REA8xXX1ymTwAZhrbSyUh41zfpOmFQViuyPGf5ePg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCePG0y1REA8xXX1ymTwAZhrbSyUh41zfpOmFQViuyPGf5ePg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_193933_196748_C83ED77D 
X-CRM114-Status: GOOD (  14.19  )
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

On Fri, Apr 16, 2021 at 07:04:34PM -0700, Casey Chen wrote:
> > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > >         if (poll)
> > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> >
> > Why? Those callers already provide their own callback that directly get
> > the error.
> 
> We should make sure all callbacks provided to blk_execute_rq_nowait()
> carry error back. i.e. by reusing rq->end_io_data.
>
> > > How to get error ret from polled rq?
> >
> > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > It already has the error.
> 
> nvme_end_sync_rq() currently doesn't store error in rq->end_io_data as
> you proposed in patch 1.

The question was how the error gets back to the caller, and they already
have it.

Patch 1 is specific to the sync execution. All the async users' handling
of the provided error are implementation specific. If they're not using
it correctly, then they can be fixed too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
