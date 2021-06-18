Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D6C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:27:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F7D610CD
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F7D610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dPrTK4gMhLInUJC7TJTwyk/tpqWStkDWa7VRall7Wo8=; b=uQ/4QFG8Xo4LSl
	Q9f0N/5wahmbluxJ0kRrNv1pty+jzxRjDpF3wN42HZ6KU8USe/5sXE/w10iI4I/oOQAZXBaS5GzZy
	hvxlLF05ZZqVlVk48trzbwATJCEPaTHZ/RqIcihvY9wn+AidmCv5CN/egZqdjeGrIqiHo+ZrhEdQG
	ehOuajZTWXLVdIaTJ4gqmkrNsGjPnbiPdIqi0nvFEavzomSIOPyAUWu+ok5lQkalwb06opooRkOkk
	Xy5UOW9Pai68gLBSleqg54dXqoVd/cfcgXube4K3TopqoLjl348zA2knnom07Gco/2W5Yvgvcnws4
	FhF3mIK68iQKP8bpkAWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luFTD-00EThA-TS; Fri, 18 Jun 2021 14:27:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luFTB-00ETgU-GP
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 14:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624026458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/sCBTOwdqNgII3IAySkNB1KoKYpTV/nD9ZDHSFtulM=;
 b=FtvDhXLzMyaigWBrIVONU/xv4xtvLuN0ulDj9D3UjcT6fityNBBC/4dJAvLI+B+yEPFZba
 OUcuMMjUZ+485noDAgfdC/NlM7N0DetB/H3xvlK0zhxfyksfMXG8Mm+J5VOvzMk5yV1gf7
 467PUY1F5KexPaJxxsBGeRMeOWAjdDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-cumL99HCPe6gWJ4U4OdTKw-1; Fri, 18 Jun 2021 10:27:35 -0400
X-MC-Unique: cumL99HCPe6gWJ4U4OdTKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7781ABBEE0;
 Fri, 18 Jun 2021 14:27:33 +0000 (UTC)
Received: from T590 (ovpn-12-158.pek2.redhat.com [10.72.12.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2C7B60C4A;
 Fri, 18 Jun 2021 14:27:24 +0000 (UTC)
Date: Fri, 18 Jun 2021 22:27:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <YMytSIBm7k2pqFlc@T590>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de> <YMliP6sFVuPhMbOB@T590>
 <20210618140147.GA16258@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618140147.GA16258@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_072741_665746_44FAF91A 
X-CRM114-Status: GOOD (  22.02  )
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

On Fri, Jun 18, 2021 at 04:01:47PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 16, 2021 at 10:30:23AM +0800, Ming Lei wrote:
> > Not sure disk is valid, we only hold the disk when opening a bdev, but
> > the bdev can be closed during polling.
> 
> How?  On a block device the caller needs to hold the block device open
> to read/write from it.  On a file systems the file systems needs to
> be mounted, which also holds a bdev reference.

+       rcu_read_lock();
+       bio = READ_ONCE(kiocb->private);
+       if (bio && bio->bi_bdev)

The bio may be ended now from another polling job, then the disk is
closed & deleted, and released. Then request queue & hctxs are released.

+               ret = bio_poll(bio, flags);

But disk & request queue & hctx can still be referred in above bio_poll().

+       rcu_read_unlock();

> 
> > Also disk always holds one
> > reference on request queue, so if disk is valid, no need to grab queue's
> > refcnt in bio_poll().
> 
> But we need to avoid going into the lowlevel blk-mq polling code to not
> reference the potentially freed hctxs or tags as correctly pointed by
> yourself on the previous iteration.

If request queue isn't released, hctx won't be freed too. Tagset can be
freed, but it is supposed to not be touched after request queue is cleanup.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
