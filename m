Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B5C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 19:09:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD7064EB2
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 19:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD7064EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mgkwZTf1TD4Kt7CFRPO6iPwCPaLLsjLH5GD5/5xSiSA=; b=Y46/ZlqRxmKSg7alwBE1uJY/q
	oJM2+4SUOrQrMxggW4+wp4sX6IPD8OOMY7lHqmLpJdeejt2X8Wa9+Dbal3z0KJJh2xZnVuHQsDEP2
	BfUI5DBChKE8boRP6531jTK5Lq8d+KklXv5ZIH22qIqbuWMw46/F8mAYZYCke81kmL/kf1mLEmxvn
	ajM1WooVPamQJWCUqXfUz1ssHnLf+hxpD0aaqMDFyMAyWZWfBpoW4+1GWrCypeKQdadwl8B83iK9A
	/Az37lTeh3Wlcdc+kRiCWWdl3Wvfxi5U40rklylJUDIle/+4RomDYG3WCEwUOTzhz3bmn3rUIEllR
	gT9jqCvmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDXdG-00035Q-JR; Sat, 20 Feb 2021 19:09:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDXdF-00035E-4k
 for linux-nvme@merlin.infradead.org; Sat, 20 Feb 2021 19:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z8+/WNpbsZkqwy3FrYALDel13DrFd2M7SHQC2LqXykk=; b=Coqv5TZ84pbYV63BlHltSBs+O6
 PKlkeMKd9GjQBqahXNppgY+/xX6UfosepmWfMMZGYxfbMYZLokGKnYGxzrHd//hRD3ea6ydPU5Ytr
 jk14BWdCLSI0Xjk4dUlY/0AuGf7+IS46QTKPcxQDHjVPt697wE7M9ASyd68sRt67wCFENbj1Sy0kt
 KqqHpoWVrNfHkIOOJDK9bcVxCM3THBS7gsYqggibHRGGsuhhWcqYjoHcE5wj4W2q5T06Uq2cui7oH
 FimgH0MLEq4pfqGbJ2iPd/+91tRxJFefAI/iiGCu+kY3koSvRTlYD9gNzRUZzIek5wvaRqZ0H05K1
 L7LLTzpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lDXcL-004MAE-36; Sat, 20 Feb 2021 19:08:48 +0000
Date: Sat, 20 Feb 2021 19:08:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210220190837.GE2858050@casper.infradead.org>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <146c47907c2446d4a896830de400dd81@AcuMS.aculab.com>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
 "kch@kernel.org" <kch@kernel.org>, 'SelvaKumar S' <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Feb 20, 2021 at 06:01:56PM +0000, David Laight wrote:
> From: SelvaKumar S
> > Sent: 19 February 2021 12:45
> > 
> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
> > v2020.05.04 ("Ratified")
> > 
> > The Specification can be found in following link.
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> > 
> > Simple copy command is a copy offloading operation and is  used to copy
> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
> > LBA within the device reducing traffic between host and device.
> 
> Sounds to me like the real reason is that the copy just ends up changing
> some indirect block pointers rather than having to actually copy the data.

That would be incorrect, at least for firmware that I have knowledge of.
There are checksums which involve the logical block address of the data,
and you can't just rewrite the checksum on NAND, you have to write the
entire block.

Now, firmware doesn't have to implement their checksum like this,
but there are good reasons to do it this way (eg if the command gets
corrupted in transfer and you read the wrong block, it will fail the
checksum, preventing the drive from returning Somebody Else's Data).

So let's take these people at their word.  It is to reduce traffic
between drive and host.  And that is a good enough reason to do it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
