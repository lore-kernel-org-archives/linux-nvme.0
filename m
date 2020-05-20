Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220F5C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2252072C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C24hSWjN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wU2lOGs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2252072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGSmEMhP23LG8w1HRH5XP1GtVbQ4dRg0eVMFFdYdPUE=; b=C24hSWjNEBKmvp
	mSCPf6rF76apuT93xRZeEhWdgSUNlim9XoUqqz2yd5mrdQZsp2lSFrSaGF0SOWDOKIisZxLozsXBd
	kAmzFOvGXj4yw2SxmOVKJjPfcoU5po6xSmEyoQscgmi1izLhJTS/yBoGNztp+1ixc1tZhIBvNgVJ9
	JpQ3UBFpxAvSnqIHmAUYEXE8eerqrj5OsfNtJmF9VWZLssiPPkvypYd1uIO7ZLVgtMIxi7dAqNoQu
	dP7QQa/FsI/cGwCos0WZTaqomQqNDboNtAfjBmwIf24LEDIoprnp63NaFpKKXNDImOfPWygV2VqE+
	vxYUgi1B1l59KmRWEexg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSt2-0006xR-Nl; Wed, 20 May 2020 17:52:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSsz-0006w6-MW
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:52:11 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE89B206B6;
 Wed, 20 May 2020 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589997129;
 bh=ti1WjseTOpUkll0Pp/RDFQPT5PbKehiG1FR9vcyaXhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wU2lOGs3YIURROgGLkLHDx3s8886LDycW8Nd9dp3y6UQfBBMUaJf9UGI89tUv3GxF
 9NeQQC9GeIsSDuSw3d5CeecjsMYuu/xJROjso5QglHAD3jieVa0V8KoyxQwFgBDU+M
 J1dAZ9KnSPAyuYE4zGeY2Pi0JCRuprehvCWKxmOI=
Date: Thu, 21 May 2020 02:52:02 +0900
From: Keith Busch <kbusch@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Message-ID: <20200520175202.GA2151@redsun51.ssa.fujisawa.hgst.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
 <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_105209_750359_EC8A26F5 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 10:10:47AM -0700, Dongli Zhang wrote:
> On 5/20/20 4:56 AM, Ming Lei wrote:
> > +static bool nvme_wait_freeze_and_check(struct nvme_dev *dev)
> > +{
> > +	bool frozen;
> > +
> > +	while (true) {
> > +		frozen = nvme_frozen(&dev->ctrl);
> > +		if (frozen)
> > +			break;
> > +		if (!dev->online_queues)
> > +			break;
> > +		msleep(5);
> > +	}
> > +
> > +	return frozen;
> > +}
> > +
> >  static void nvme_reset_work(struct work_struct *work)
> >  {
> >  	struct nvme_dev *dev =
> >  		container_of(work, struct nvme_dev, ctrl.reset_work);
> >  	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
> >  	int result;
> > +	bool reset_done = true;
> >  
> >  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
> >  		result = -ENODEV;
> > @@ -2606,8 +2622,9 @@ static void nvme_reset_work(struct work_struct *work)
> >  		nvme_free_tagset(dev);
> >  	} else {
> >  		nvme_start_queues(&dev->ctrl);
> > -		nvme_wait_freeze(&dev->ctrl);
> > -		nvme_dev_add(dev);
> > +		reset_done = nvme_wait_freeze_and_check(dev);
> 
> Once we arrive at here, it indicates "dev->online_queues >= 2".
> 
> 2601         if (dev->online_queues < 2) {
> 2602                 dev_warn(dev->ctrl.device, "IO queues not created\n");
> 2603                 nvme_kill_queues(&dev->ctrl);
> 2604                 nvme_remove_namespaces(&dev->ctrl);
> 2605                 nvme_free_tagset(dev);
> 2606         } else {
> 2607                 nvme_start_queues(&dev->ctrl);
> 2608                 nvme_wait_freeze(&dev->ctrl);
> 2609                 nvme_dev_add(dev);
> 2610                 nvme_unfreeze(&dev->ctrl);
> 2611         }
> 
> Is there any reason to check "if (!dev->online_queues)" in
> nvme_wait_freeze_and_check()?

Looks correct to me. If the queues fail to freeze, that means a timeout
occured, and the nvme timeout handler tears down all online queues, so
this patch uses that for the criteria to break out of the loop. 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
