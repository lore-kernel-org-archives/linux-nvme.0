Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8326CC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:49:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494B960FF1
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B960FF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ATpBIGkRZrIR5O/u+n13JsUP6eHQxSFEPhoI4NBtSXc=; b=AhOkzVoVlKZcByAr9n84a1DaT
	/cvb3JG2QbPPiAAkonjLk1S8hB/maSbd6gCZ1zMVS5Xyg1tbbQEhZG4xTdc7tKZGgZpPWgd0JZWEC
	3MgMA8hP+TZjZYGj0AXMhyfn+1OKW+FiFgodbZKy+xju9yXsUTmR6HjB28S8AeROvkk4+hy1MheU5
	d/BN5t0+sbxFmBlZryyzEitPwjZkdzsz0j7KsC9oDPUgK7Ehy/vxHkyrrt6qdrAqlt6jgwtSucqLZ
	t/0KPk1UFTFOf2om21i33qHNA5spt1n4K3YqKxCey+yD7YsbPdzLNSzz0Xw/RyQiKeI98F7M3MWwd
	ZmBfF3PUw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYQWU-009cb3-1i; Mon, 19 Apr 2021 09:48:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQPc-009amI-Fl
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 09:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5TJVXtI9X2kcptz9UBE/JvUwJanKZ4gbvYwSLMqz6T0=; b=V0/cr8zLKuJGdpCGbZew7airJL
 46ipns0v+MwJUhsQBXTH+DZlRTHjocgl9d7jgveKVxfDJEyNaZoJjd1lXaNF00eZ/2CivzveEEHqw
 edPsPTmSI/imOc293tM3R3jGSDjJ2ntpCaOedZeyVjtEeWP6U6o+ofHOSkZB8PuqFvXlhkxLJInsQ
 kl9ZGgCHZGvV9HR9PMLxNlFP4fB0656W/wYNz8NGOGq05Ks/zT4Fn0rES1V+Tjly7p+RfeFNnruMs
 r9b+TZanWhZViH/3TCVgYaLIwZMOfugEyoq++Y2hFqZDGLZq1lDMMy6V8i9qCLBW27GcHz+v1IJI/
 XAj1YZlw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lYQNF-00DXWh-2b; Mon, 19 Apr 2021 09:39:47 +0000
Date: Mon, 19 Apr 2021 10:39:21 +0100
From: "hch@infradead.org" <hch@infradead.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "dsterba@suse.cz" <dsterba@suse.cz>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419093921.GA3226573@infradead.org>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
 <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
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

On Mon, Apr 19, 2021 at 09:35:37AM +0000, Damien Le Moal wrote:
> This is only to avoid someone from running zoned-btrfs on top of dm-crypt.
> Without this patch, mount will be OK and file data writes will also actually be
> OK. But all reads will miserably fail... I would rather have this patch in than
> deal with the "bug reports" about btrfs failing to read files. No ?
> 
> Note that like you, I dislike having to add such code. But it was my oversight
> when I worked on getting dm-crypt to work on zoned drives. Zone append was
> overlooked at that time... My bad, really.

dm-crypt needs to stop pretending it supports zoned devices if it
doesn't.  Note that dm-crypt could fairly trivially support zone append
by doing the same kind of emulation that the sd driver does.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
