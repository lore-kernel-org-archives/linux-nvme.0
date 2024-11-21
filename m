Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79AD6ED09
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09vF4pX8kaQ+dR6O2t20RwvdrQl+POuIrCNnkaiSmgA=; b=guegO3Ty2n6tVfDBIZNBN7wgTO
	Bc6vfoCQfevkStOrEHWGeTCM6/FFj9XIOFIKPKrYPnogKOeIRbC21/k45Eg6yQ6lzpZ9F+DB4fzx+
	bTVVBCh5dC5cnYaOMIEqJZbTCeo3wUO6YxxQm3nBNysCvWsR/TtCAb/Ime0SFxBLXg3WyzGSj1YRh
	3mhM0zeRk/Kev8DlUDGRQn9ChNWADiYIzC/hCXdB6NZXbT6NDPOL/JYxT3ag6VPBGqYEpRxJZLmVJ
	lBv6FmYR+66LPm0t/17VuM9U95R8Ba6kmUcgjnhz/H6SZeXEtG7vm9TNyjYy7kIZ5gXv5Fc/6uU5j
	8OshHrYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5Oz-0000000HU8M-1Fvd;
	Thu, 21 Nov 2024 11:31:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE5Ov-0000000HU6D-1YwD
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 11:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732188666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09vF4pX8kaQ+dR6O2t20RwvdrQl+POuIrCNnkaiSmgA=;
	b=Ay76XVSCjUAfFZmUQr1F4Ch/gUzCrDBcgGHawtUbhFxiLw6xB4Fsi48fYmbDcF/63l5j3a
	l5sW5BJo4VHdSc1bip+DheqlhuIVzDIR6k0IePiWlBlBwJQ/cHoJdciBufBEuY/FpNbtN7
	ppwCXNcYVLzZQkyuUwe9FB/ouhvhZP0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-VkpqpWfkOBifU72Bt2MalA-1; Thu,
 21 Nov 2024 06:31:05 -0500
X-MC-Unique: VkpqpWfkOBifU72Bt2MalA-1
X-Mimecast-MFC-AGG-ID: VkpqpWfkOBifU72Bt2MalA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 646091955D62;
	Thu, 21 Nov 2024 11:31:03 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F81195607C;
	Thu, 21 Nov 2024 11:31:00 +0000 (UTC)
Date: Thu, 21 Nov 2024 06:30:58 -0500
From: Phil Auld <pauld@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Message-ID: <20241121113058.GA394828@pauld.westford.csb>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_033109_482718_60A4CB53 
X-CRM114-Status: GOOD (  30.89  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi,

On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
> On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> > On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
> >> Hi,
> >>
> >> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
> >>
> >> Bisect root cause commit
> >> ===================
> >> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
> >>
> >>
> >> Test details
> >> =========
> >> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
> >> - Test is on ext4 filesystem
> >> - System has 4 NVMe disks
> >>
> > 
> > Thanks a lot for the report, to narrow down this problem can you
> > please :-
> > 
> > 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
> >     have used for this benchmark ?
> > 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> > 
> > This way we will know if there is an issue only with the ext4 or
> > with other file systems are suffering from this problem too or
> > it is below the file system layer such as block layer and nvme pci driver ?
> > 
> > It will also help if you can repeat these numbers for io_uring fio io_engine
> > to narrow down this problem to know if the issue is ioengine specific.
> > 
> > Looking at the commit [1], it only sets the max value to write zeroes 
> > sectors
> > if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
> > write zeroes value.
> 
> There's no way that commit is involved, the test as quoted doesn't even
> touch write zeroes. Hence if there really is a regression here, then
> it's either not easily bisectable, some error was injected while
> bisecting, or the test itself is bimodal.

I was just going to ask how confident we are in that bisect result.

I suspect this is the same issue I've been fighting here:

https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/

Saeed, can you try your randwrite test after

  "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"

please?

We don't as yet have a general fix for it as it seems to be a bit of
a trade off.


Cheers,
Phil

> 
> -- 
> Jens Axboe
> 

-- 


