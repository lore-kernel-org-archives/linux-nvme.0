Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44AC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:52:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C962166E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PzK4LmyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C962166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OIrouzE6f9ogHY2AMBiBRuhPFfDDlInXj/EnnuKUI0U=; b=PzK4LmyHwbjkhHJjiPDPqJeAa
	C6R+g7g8YUKIXZwo1Uocvraq8G3kCfb1kQEqP4cq8jumQ4VmyD1qgz+Wjslj9BmnT5vHzhQizHpJW
	pP3LdzCkiBB7+sk56XeGsknPQr0lU56P6m9CrlREWvjdjBcxNP4S4AYG+42bLfBUlNdR1BKXmyZPt
	998cg6Zf33XR+hUo7GP//qymhvhIB2v7kh56xN1xKDPm3Vo1gbq7g6Lwq3UMYEEXfI9/YTSf+wAOk
	QQCmXNUBKnkJ4lMiOcdvbjvRlQZsJocctj3dwQQ63l8XxRBCG8y7gkgBROE0ScgwLwU3zrgZruRuu
	rFGANXAYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZMF-0001vw-Ni; Tue, 08 Sep 2020 08:52:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZMD-0001ue-Mz
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:52:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4235668AFE; Tue,  8 Sep 2020 10:52:03 +0200 (CEST)
Date: Tue, 8 Sep 2020 10:52:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 2/3] nvme: move get/put ctrl into dev open/release
Message-ID: <20200908085202.GB17413@lst.de>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904023929.5320-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_045205_879285_A7553268 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 03, 2020 at 07:39:28PM -0700, Chaitanya Kulkarni wrote:
> Introduce nvme_dev_release ctrl file release callback and move ctrl get
> and put operations from target passthru into host core in ctrl open and
> release file operations respectively. This is needed to atomically
> get/put ctrl and get/put ctrl module refcount without using any locks.

Besides the comment from Logan:  this doesn't move as said in the
subject but adds a reference.  I think this should be patch 1 as it
is a fixed that will need backports further back.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
