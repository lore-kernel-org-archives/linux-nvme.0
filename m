Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F06C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 02:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC8C2067B
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9sZR3Fu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYrz3+cl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiaReo/C";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kwh/MsY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC8C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EEDZqP5qw7oqZLf3Y6isFuQCFFkxvtGuh4+ZhM+HLnc=; b=Y9sZR3Fu6jAJ2v
	YQTzxBHuq3sid1aPe97A+29tsawU3nmVR7MDUPue++bGxf/ULfsdshezjm2NWHc4qslRiv2s2P2TB
	bizpsKn048s2FJSFzkCbTiscj9p+G5OG8xEVH7yR2ltYob4RDxD/Lc7iBLIO7axHHhhSnd92VJEkp
	E6R5A0uJFNAYTwMCYKJUYUr1mRO6N7Boxc5xqN7o+/3iS4vWwzKzDZG0mRb+bSKfiFckDM5LyJhl2
	4aFtVuzrTGfcfDcmB6k389PuVMuRMQdKLH0nPMh1244lWbDH2hNPS8o4oHlKxMwQklN4AxMW4jUjI
	glXcTtvpozHtBbkn2DZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbb2F-0007dw-Qq; Thu, 21 May 2020 02:34:15 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbb2F-0007dq-1K
 for linux-nvme@bombadil.infradead.org; Thu, 21 May 2020 02:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1f8/IfrcNATH3gWolOTKS3pgAESBVnyPUIRUgUI3NFE=; b=uYrz3+clXzTMUisCqdsT9zsDu2
 J8eZJcCcRcacHV03vn/b8CwtIfRePBhynH/WGMg8MOoRGuDkRYi1PqVp5ufYGkLzCAOlWMPENvR9a
 dfNjTvwgoBMdvudOD6CMMAs7wnf9GeDUczWDYbKIc5Msfs82o6UNPo3qfb7tI4y9QF5vVArkRhFut
 l7CX1amdkLWhF+R2mT0XlN6lFPuFSyo35r6fULgqOyIno3eRl5DGXnhdHoANWejvYctZmeTDYaqDd
 83ZHh/QLFE8kGmH18vIikTX8mls1e/NWAsDZ03mH8qkpap9hSWLuAbAYxU5lohwwxuLwrUGRonw8h
 d6UcTftg==;
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbb2D-00036B-SJ
 for linux-nvme@lists.infradead.org; Thu, 21 May 2020 02:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590028434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f8/IfrcNATH3gWolOTKS3pgAESBVnyPUIRUgUI3NFE=;
 b=CiaReo/CJvlrC5LeRbcCbf3B2bnQAjXIcGroDnoSD0DuyPBLDd+rvtx6T5R8B2PivQaJhI
 kq99/NOY6tK9+LYpLDHkYfp98FSDbTQW4iKsHCVERzJgDMnMzx6tpqY9xH1MhECgj4Nazp
 DdyVfe7PDHdpk5fga2GYNGGjzZ/d89g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590028453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f8/IfrcNATH3gWolOTKS3pgAESBVnyPUIRUgUI3NFE=;
 b=Kwh/MsY8KRJPDhLtCiliVd2mU3YO4W2DzUCBZCPktwHJSIZY0kXRbqgXXmg964+J3Tw9zr
 HzqiecoZO9MMWGtUyQkNd9VwZbQl7U8iW/gPdUDoU9KZr2WgmAJU8Mil59FvJN+PGK3SFs
 lMcUlZjKMrghvrAHB2OZ8ZScCZLld2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-U5SsDQg8MYWglF8P8MJiDQ-1; Wed, 20 May 2020 22:33:51 -0400
X-MC-Unique: U5SsDQg8MYWglF8P8MJiDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD5F80183C;
 Thu, 21 May 2020 02:33:50 +0000 (UTC)
Received: from T590 (ovpn-13-123.pek2.redhat.com [10.72.13.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A83DB60C05;
 Thu, 21 May 2020 02:33:42 +0000 (UTC)
Date: Thu, 21 May 2020 10:33:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
Message-ID: <20200521023337.GB730422@T590>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
 <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Alan Adamson <alan.adamson@oracle.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 20, 2020 at 10:10:47AM -0700, Dongli Zhang wrote:
> 
> 
> On 5/20/20 4:56 AM, Ming Lei wrote:
> > During waiting for in-flight IO completion in reset handler, timeout
> > or controller failure still may happen, then the controller is deleted
> > and all inflight IOs are failed. This way is too violent.
> > 
> > Improve the reset handling by replacing nvme_wait_freeze with query
> > & check controller. If all ns queues are frozen, the controller is reset
> > successfully, otherwise check and see if the controller has been disabled.
> > If yes, break from the current recovery and schedule a fresh new reset.
> > 
> > This way avoids to failing IO & removing controller unnecessarily.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Max Gurtovoy <maxg@mellanox.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index ce0d1e79467a..b5aeed33a634 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/sed-opal.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/delay.h>
> >  
> >  #include "trace.h"
> >  #include "nvme.h"
> > @@ -1235,9 +1236,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	 * shutdown, so we return BLK_EH_DONE.
> >  	 */
> >  	switch (dev->ctrl.state) {
> > -	case NVME_CTRL_CONNECTING:
> > -		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> > -		/* fall through */
> >  	case NVME_CTRL_DELETING:
> >  		dev_warn_ratelimited(dev->ctrl.device,
> >  			 "I/O %d QID %d timeout, disable controller\n",
> > @@ -2393,7 +2391,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >  
> >  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> > -		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> > +		    dev->ctrl.state == NVME_CTRL_RESETTING ||
> > +		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
> >  			freeze = true;
> >  			nvme_start_freeze(&dev->ctrl);
> >  		}
> > @@ -2504,12 +2503,29 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
> >  		nvme_put_ctrl(&dev->ctrl);
> >  }
> >  
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
> 

nvme_dev_disable() suspends all io queues and admin queue, so dev->online_queues
will become 0 after nvme_dev_disable() is run from timeout handler.


thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
