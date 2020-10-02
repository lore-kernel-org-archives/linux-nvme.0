Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D8C4363D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 06:45:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2402E206DD
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 06:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ljy/72kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2402E206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=juqrtdhHUBu6kV8y2ksEUez+9MTplTsSgRwZygj8PC4=; b=ljy/72kBlICGqdk8NLSlMzY9w
	QqaxVn8HErqZVK/9Tiz/fg22xVRm2NquWA98nJRhg3bVEp2Ri9/RMv6Wx/TW78Av7YFPySihuJWm6
	wgQVnL18a5a69VFCtjVsXzJPfn4nCUu6/q31IrwfhQJacDnJNqgkbIlknlwoGxvK1iFf45VHrtB/r
	1DeI9lvv+d7Z3giAAv9Z+ZNRCJIdTx+nj6BOwqEQOD8/j6h88dUeSSsOZf3Z9O0WibiucQamOn55H
	KBZRiINVu3i4mBKQ9LMZqIa2f31SFMu8/KGvvJRLc753saLekNb2Bk/dFSMz8b0eVGHqF1PhNr2lG
	zq/VndBvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOEoZ-00047S-W7; Fri, 02 Oct 2020 06:45:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOEoX-00046U-O2
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 06:45:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A2DCC68B02; Fri,  2 Oct 2020 08:45:06 +0200 (CEST)
Date: Fri, 2 Oct 2020 08:45:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20201002064505.GA9593@lst.de>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
 <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_024509_900118_84431DC3 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 11:24:49AM -0700, Sagi Grimberg wrote:
> Yes, basically usage of managed affinity caused people to report
> regressions not being able to change irq affinity from procfs.

Well, why would they change it?  The whole point of the infrastructure
is that there is a single sane affinity setting for a given setup. Now
that setting needed some refinement from the original series (e.g. the
current series about only using housekeeping cpus if cpu isolation is
in use).  But allowing random users to modify affinity is just a receipe
for a trainwreck.

So I think we need to bring this back ASAP, as doing affinity right
out of the box is an absolute requirement for sane performance without
all the benchmarketing deep magic.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
