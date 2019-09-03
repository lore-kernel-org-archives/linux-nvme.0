Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C9C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 16:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1434B208E4
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qeqhsONX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1434B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DeRRIUCwZpjmVfrCXs3xldJCEKPctGP/95pDDDxu2C4=; b=qeqhsONXwkamhU
	Y/RRJ9I0dTN8ZK7xt/v8pouveS3pdP845VsaJtUK2RRbfH6Ne2zFA3PaRwZNKy2G7CP3D4laLmvg3
	a7Zoks9PwaKbPmpfc3A4N0Yf6dcRV8QwzU1kF7cX5Ihf2Y6dZLIiNCI/doms1RsNvBkCh16PRgFLk
	TXQXHVit2Kd0p7flSXuDWRy14RZuefltz05j6LJoyd56ttK7xHOEeGbpNFZNkOrRQokD2EITc/PKD
	sF7DWVZ5tY+fpBaUvSjJF/umtVjUP+h6qNo3elQUNc2/Ax94KwHODuQdjGy5tlBTz1nekzWQVTS2v
	hubsB7/uDcqGujJPnACw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5BML-0002V4-1s; Tue, 03 Sep 2019 16:08:45 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5BMH-0002UJ-II
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 16:08:43 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1i5BLi-0007Ci-LT; Tue, 03 Sep 2019 10:08:08 -0600
To: Keith Busch <keith.busch@intel.com>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
Date: Tue, 3 Sep 2019 10:08:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831152910.GA29439@localhost.localdomain>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: martin.petersen@oracle.com, hare@suse.com, kbusch@kernel.org,
 axboe@fb.com, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, keith.busch@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_090842_011567_3700B5C3 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-08-31 9:29 a.m., Keith Busch wrote:
> On Fri, Aug 30, 2019 at 06:01:39PM -0600, Logan Gunthorpe wrote:
>> To fix this, assign the subsystem's instance based on the instance
>> number of the controller's instance that first created it. There should
>> always be fewer subsystems than controllers so the should not be a need
>> to create extra subsystems that overlap existing controllers.
> 
> The subsystem's lifetime is not tied to the controller's. When the
> controller is removed and releases its instance, the next controller
> to take that available instance will create naming collisions with the
> subsystem still using it.
> 

Hmm, yes, ok.

So perhaps we can just make the subsystem prefer the ctrl's instance
when allocating the ID? Then at least, in the common case, the
controller numbers will match the subsystem numbers. Only when there's
random hot-plugs would the numbers get out of sync.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
