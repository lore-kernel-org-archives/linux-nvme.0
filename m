Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584BC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 14:06:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396D764EF6
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 14:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396D764EF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uc6VUz9GZlpTIAfjyWx4vuULgttNehpSaUcVyhDgPU0=; b=d1ONmUDDSGSB4XrklI3sEWXLw
	6GqnpXnMSxKvPa/zAqomploABwIdmI+2etMR9kVOm/IVuDCBdhDtQR4VgMM7XQV7LTbcPfdThAc/J
	+2+sQ3dhweapRCbqFlNkZE8tqnTKWfZWD/oM9CkwEHD8i4Kif++8vYPQbfMtfzRSXBE3JWkBdr8sk
	SzKrYA+LGXckti+HreGSgKFgHUWC6qmO+hESmcJBI6iTw11CfS1g8YlASygwF1z1afBHIWuNM4csp
	DNQ8CewM0+plf/6pt9bX+aBEDQvs3EEdA2oQZOFYmxnRqRBS0zBk5C0tZZtVOD69PxdS23lLDMLs4
	a+8sms57Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNFkw-007W3m-Up; Fri, 19 Mar 2021 14:05:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNFkt-007W3K-0u
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 14:05:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5518568BFE; Fri, 19 Mar 2021 15:05:32 +0100 (CET)
Date: Fri, 19 Mar 2021 15:05:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210319140532.GA7019@lst.de>
References: <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_140535_200718_8FCD0F91 
X-CRM114-Status: GOOD (  18.06  )
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

On Fri, Mar 19, 2021 at 06:52:56AM +0900, Keith Busch wrote:
> Having submit_bio() return the enter status was where I was going with
> this, but the recursive handling makes this more complicated than I
> initially thought.

Note that the recursion handling is not really required for
nvme-multipath.  I have some plans to actually kill it off entirely
for blk-mq submissions, which needs work on the bounce buffering
and bio splitting code, but should not be too hard.

> If you use the NOWAIT flag today with a freezing queue, the IO will end
> with BLK_STS_AGAIN and punt retry handling to the application. I'm
> guessing you don't want that to happen, so a little more is required for
> this idea.

We really should not use NOWAIT but a flag that only escapes the
freeze protection.  I think REQ_FAILFAST_DRIVER should probably be changed
to trigger that, but even if not we could add a new flag.

> Since it's an error path, perhaps a block operations callback is okay?
> Something like this compile tested patch?

We really should not need an indirection.  And more importantly I don't
think the consuming driver cares, it really is the submitting one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
