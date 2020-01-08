Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577EAC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4602067D
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZyokgBtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4602067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J3pi7CxuPDWjEftwAktBvL00d6ap+dednFkJ7npIWIE=; b=ZyokgBtHW+oscT
	/61Xx4o3diodH5xg5KwhVpTxYs7fNCxOWY/PJ8Lfj4s7jO+ONx0nruZx5OzhzNMbd4vABCG66Op0v
	ZIDQ5Zl7LrABWQWwRW2NY+K6WU1zQJGu7Z8jBvbhsyyUE1rmbXHBhKsLyiF/3TRl/xRDh5HpEzNRQ
	wasgyWMe7UQcoQ1NrqDy1ogHWxRX85ekpOyTqF6G+rIM3xFQHLjTqbxY4tleWcktjdZAGDtpzSWNt
	0BaGq2JAo+98xJtcT3u/9iw0KX4k0kZcaJMV5QbU76XbrUQcQ8qOiAa840ciN9Yh3VC6usKGq4h7L
	IULicxkU+RfKVcbY0M0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipCuX-00009k-DR; Wed, 08 Jan 2020 15:06:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipCuU-00008v-Ek
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 15:06:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96E1868BFE; Wed,  8 Jan 2020 16:06:12 +0100 (CET)
Date: Wed, 8 Jan 2020 16:06:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Message-ID: <20200108150612.GD10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1blrg2agh.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_070614_639133_38A21C64 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 ssomesh@amazon.com, Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 06, 2020 at 10:48:30PM -0500, Martin K. Petersen wrote:
> 
> Balbir,
> 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 5afb0046b12a..1a3be30b6b78 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
> >  
> >  	sdkp->first_scan = 0;
> >  
> > -	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
> > +	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
> >  	sd_config_write_same(sdkp);
> >  	kfree(buffer);
> 
> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> capacity changes. However, this event does not automatically cause
> revalidation.

Who is looking at these sdev specific events?  (And who is looking
at the virtio/xenblk ones?)  It  makes a lot of sense to have one event
supported by all devices.  But don't ask me which one would be the best..

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
