Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAEEC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 15:00:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E022613B8
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 15:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E022613B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CObFsTT4Q/VMef2g4gHBXRP+SL5YbHV9P8BAVGDTcdM=; b=RcOaoJe0o+6iZBI4iCG9F/koa
	gxggoeXJVrCbpUFmTVIg8KHooH6yvfN7824J6LQCZBD4hibuDmCGubc+QAzeBMDPnjJ8JMIKoEncS
	KpLUdhG/YTDJQt5n3GI57ZpZk1tLgrXXZsb3D8KtnnrxJipu6F6/iaU0cJFRO/SF+u5aacx3KDw6F
	/baoGZIaBffhyKEQUFCCg/U49k0I6NfduMrSQvkghEnPiJtrnhjxAncmw6PPi3qI40R7C3aSON8nq
	+zy4YpWHBXptkT0b0X9N73nBvd2j+W5uK5HoQNQqavArKUeecSpTGQhY6vi8XWlvFxbbPECNjLCLf
	YJiCv780w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTnBW-002syB-Vs; Tue, 06 Apr 2021 15:00:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTnBG-002swR-LV
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 14:59:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A7D5A68B02; Tue,  6 Apr 2021 16:59:48 +0200 (CEST)
Date: Tue, 6 Apr 2021 16:59:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210406145948.GB7790@lst.de>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406133533.GC2594@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_155951_293786_81D06497 
X-CRM114-Status: GOOD (  18.52  )
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

On Tue, Apr 06, 2021 at 10:35:33PM +0900, Minwoo Im wrote:
> > with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.
> > 
> > I think that there is value in reducing the confusion for regular users.
> 
> Agreed on this point.  We might have thousands of namespaces and it
> might be making confusions to users.

How does this create a confusion that it doesn't for the existing NVMe
block devices and the SCSI disk and generic devices?

Morover: why would anyone want to expose these huge numbers of
namespaces to a single host?  While larger LUN counts in SCSI are
sometimes needed for scalability reasons they aren't in NVMe.  I haven't
actually seen 4 digit namespace counts in NVMe except in synthetic
test setups yet.

> > 2) Only create the new per-ns char dev for namespaces that were rejected.
> 
> I prefer this one which is the major reason of this patch series being
> posted.

Which doesn't allow us to write portable programs just using the
char node, as now a kernel upgrade that supports a new namespace type
or feature will remove the char dev.  It also is very different from
what people expect from their SCSI and ATA setups.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
