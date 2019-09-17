Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCDC4CECD
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 20:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730872054F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 20:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hYmtp731";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZqLRZE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730872054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zx05qkxpcu7ODMlJuvAqVxpwEkaGyZjKwdaC5QdFt+g=; b=hYmtp731tXkn09
	FyGu2C+f21yKgZp/4G4BN9Of6MCASz0zKQ/cGyvSAWPuXbhhfXl7Ja2LrMjE1WXzvyvywE4IrNyed
	N+xDbR2q43g+pPR0Hba8NXk7bUBxka/nnRDf9gcQJevdcEvZVziZJ8RimUeAIiu8T5mgEVU5GgcaP
	K/+uILBiVfzojLgx5h55qEWlEjvF9S+jaj5AdxQX4vOUCSgFIXG/72uH5qbAiAk4ftGVQMmZUDf6b
	QNpGYSoBLKB/xGJQf9AtRBi4JYHoEvTE8/7raPFCNCw/epQg99CBBzppHG1JOwJ9SytaqROB+6KTK
	1f1yyam3KG9xJ5l2psww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAK7p-0003Ns-To; Tue, 17 Sep 2019 20:31:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAK7m-0003NU-Tb
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 20:31:00 +0000
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 935942054F;
 Tue, 17 Sep 2019 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568752258;
 bh=qxXBgLaKWrGIdgVCqloNoJU+FP74sq8JftVLt8bg+TM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IZqLRZE/uabTF/7HFPqCsM38G4NmwLVCrLr/ENQqci/gcH41C334MEAM1TSu9f+Hl
 TvDet8pvA34fnowZ4VQ3FR4MuBpJZtyRsXc/Azeldx/9ktMrelxKLqKKFDqHkyrNcS
 HxilqX+LMzRh4Royncdthc1B/k1Go+9pf4A9MAvc=
Date: Tue, 17 Sep 2019 14:30:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 1/2] nvme/host/pci: Fix a race in controller removal
Message-ID: <20190917203055.GA39848@C02WT3WMHTD6.wdl.wdc.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <7017c4c1-75a9-1e37-eb54-6126dfbb251b@acm.org>
 <25d9badc90a1eb951cb5103774e8360edaa8ec15.camel@amazon.com>
 <14becaec-2284-d680-b3b2-c38537c91521@acm.org>
 <7a90bbc89594dd884b055cec3dc5f3060f1b1e5c.camel@amazon.com>
 <eeefce01-3d9d-ade1-50e1-79e3dca76fcc@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eeefce01-3d9d-ade1-50e1-79e3dca76fcc@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_133058_976812_468AC9E3 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: "sblbir@amzn.com" <sblbir@amzn.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "Singh, Balbir" <sblbir@amazon.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 17, 2019 at 10:55:45AM -0700, Bart Van Assche wrote:
> On 9/16/19 1:40 PM, Singh, Balbir wrote:
> > Is your concern largely with the comment or the patch?
> > 
> > Keith just recommend added
> > 
> >   /* Revalidate after unblocking dispatchers that may be holding bd_butex */
> > 
> > That sounds quite reasonable to me
> 
> Hi Balbir,
> 
> Keith's comment suggestion sounds great to me.
> 
> Another concern I have is that your patch depends on implementation details
> of the block layer. Calling revalidate_disk() after the DYING flag has been
> set means that requests will be allocated, started and completed after the
> DYING flag has been set. I think that works with the current implementation
> of the block layer because blk_queue_enter() does not check the DYING flag
> if percpu_ref_tryget_live() succeeds. If your patch gets accepted and if
> blk_queue_enter() would be modified such that the DYING flag is checked for
> every blk_queue_enter() call then that would break the NVMe driver.

I don't think it should matter. Once the call blk_set_queue_dying()
returns, blk_queue_enter() will already never succeed again: in addition
to setting the DYING flag in the queue, it also sets the percpu_ref to
__PERCPU_REF_DEAD, which causes percpu_ref_tryget_live() to fail, at
which point it will observe the DYING flag and abort entering the queue.

In the short window in which a request may be allocated on a DYING queue
but before we've killed the percpu_ref, the nvme driver handles those
requests by unquiescing to get them flushed out through its .queue_rq().
I don't really like that hack, but blk_mq_queue_tag_busy_iter() isn't
exported for a driver to directly end requests on a quiesced queue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
