Return-Path: <SRS0=poiV=NT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF3C432BE
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423F6610A3
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Aug 2021 07:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423F6610A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEglhI69NjcvurKlfAFqADyXEp5LVYWaOd4M2IESgdM=; b=sAwoAYhnqih+jG
	jaOXioEZRfSBqkT9wjTlVebSj5sWQIBILirqNek5/ohN8GPmAvzjNkgO982bAH7isEQVUgmAPQ5Xy
	wuR0lSFt3LjZMW6R40/5J8jUPN+q7FicP/mkdIr9+0QXQ21CtKfszRUFwcPljgUU0caMxtBTbS+Cw
	beLxWuIcZTKAdCERLTdv9adVSwQdCYAG40oVVsTiGQDGjTCNjbz427rKlxAeoL7TxCmRG7qz5QLh7
	EMfFwBQdNZoZWnEMHZYkb4cumcHqb1OzbcSmm84V7TLVgR4nxVzDniB04+44QssWyR986lcpluXj0
	lpmAjwc0JkCmysgjgEjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJskg-00DqIu-1l; Sat, 28 Aug 2021 07:27:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJske-00DqIl-Ic
 for linux-nvme@bombadil.infradead.org; Sat, 28 Aug 2021 07:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AFQaUzUuTEkMjtfZe6vMif4NxOxYH1tc9yvqOWpaGoU=; b=Vs4fikiD3b55mVdKmwPinQOrql
 2AK33dcgloSKhkn3nQm8xle7mYrgJmLXAgTipd9aFP5lr84o1zbAU3TPW2gaOy/9PC9RjmDSU77eh
 W5g66CdX4UtfAWObohVlVtaWpEvcJB7SYXwghgc5PinRypDaQ9Ul9ftmpWp3nZmqmNrOXQRo6RYLj
 I1GNzV2d8ZOkQOMPt43abeCgMW7JLoZnq07JzKclv09cdG6BstHMpOqcTg4KAznS4BOBsifgIENfn
 IppcKUZOYarvjyhvlYas+2pl8emMMGCZHR1/eaXF0J4oz00GH8XZRstaxf66G63sob0aEQ20KB9eR
 5cPJv5CA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mJsjt-00FNDf-Vc; Sat, 28 Aug 2021 07:27:05 +0000
Date: Sat, 28 Aug 2021 08:26:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com,
 hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] scsi/sd: use blk_cleanup_queue() insted of
 put_disk()
Message-ID: <YSnlPZD/LrVRZWx6@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-2-mcgrof@kernel.org>
 <YSSJNTxyLHu/LsNJ@infradead.org>
 <YSkumJBTztoYdzC7@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSkumJBTztoYdzC7@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Fri, Aug 27, 2021 at 11:27:36AM -0700, Luis Chamberlain wrote:
> On Tue, Aug 24, 2021 at 06:52:53AM +0100, Christoph Hellwig wrote:
> > On Mon, Aug 23, 2021 at 01:29:21PM -0700, Luis Chamberlain wrote:
> > > The single put_disk() is useful if you know you're not doing
> > > a cleanup after add_disk(), but since we want to add support
> > > for that, just use the normal form of blk_cleanup_disk() to
> > > cleanup the queue and put the disk.
> > 
> > Hmm, I don't think this is correct.  The request_queue is owned by the
> > core SCSI code.
> 
> Alright, I'll drop this one. For the life of me I can't find the respective
> probe call on the scsi layer.

What probe call?  SCSI allocates the request_queue using the normal
blk_mq_init_queue function in scsi_alloc_sdev.  It it then used to
send SCSI passthrough commands for probing before eventually binding
an upper level driver using the driver model (or something not binding
one at all if there is none for the device type).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
