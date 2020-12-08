Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC90C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0440C23AA7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0440C23AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wcdvSPFROV//bynGG1ISLwzZnFYUGLSR6j2oOTGjdqM=; b=uzKrlhQfqxKpNfd9EsNlCYef+
	kNlDFD2rf6OTRy6GUZHC2PEBaCvAv+mdITbHzy4jJcngRe45en5yq4TL/2I6jnY6biaxIvghQCrhg
	CjeKHx0Z6/BasHq/Zgp2aUixG3e22HwLNlaDGHLMKP9bovP5luQvTVDxLyNca5Z60EDOCbT95X9sz
	josEGubc+2U36/Qtzy3oBB3nmuIexlsybYGjm2zdaq97kAwETmfmtydxIcR924aQ156u6p0bX64sX
	P61/NlCk7htZZGVR5sXARqBxizaux0a9StouTSH1AhpXHX4zLfq+7uLs2TLUuyGiyZb0bxsNdkvz9
	3iPSqK6dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmagt-0004au-CX; Tue, 08 Dec 2020 10:57:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmagr-0004a8-7V
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 10:57:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 637ED6736F; Tue,  8 Dec 2020 11:57:47 +0100 (CET)
Date: Tue, 8 Dec 2020 11:57:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/6] block: add a hard-readonly flag to struct gendisk
Message-ID: <20201208105747.GA21762@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-4-hch@lst.de> <20201208102211.GC1202995@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208102211.GC1202995@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_055753_390140_3D348D31 
X-CRM114-Status: GOOD (  10.88  )
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
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 06:22:11PM +0800, Ming Lei wrote:
> >  int bdev_read_only(struct block_device *bdev)
> >  {
> > -	return bdev->bd_read_only;
> > +	return bdev->bd_read_only ||
> > +		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
> >  }
> >  EXPORT_SYMBOL(bdev_read_only);
> 
> Maybe one inline version can be added for fast path(bio_check_ro()), and the approach
> is good:

I thought of that, but our header mess means it would have to be a macro.
I have a plan to reorganize the headers in the not too far future, at which
point this should become an inline.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
