Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433A3EED613
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xh6U4y1h4h6+qEv/R6ItuAAhyvM3S2kNj93wuu/hnCA=; b=0wJCTPu13M5i58EfpF2zpwveyb
	BJxkNsEhcDLBVW31CWUt87ltht7K0a+ThQfm4gEN3/hHjgrYDIIY3RIGE49t0XFOtBIaUfButoczv
	3oFCejKFWM+nIfzzPiFAvB9zDEpG5q5PckU/3mxHftfUoxxYWR+QpKAxQfssPoCf6ILalj6MZQORX
	hh4Auin7vWAJ5QwnqOI4x2n55p+1/TehvJsIE0bgOzqSbmaD08z94wnkkRCztP6QUnWmFHkg57cQz
	QiAkF6yVsD2McF3PAEeHuAsv6cKKqve/CIyhqoliw5P5jITT1ZmwDjbBPjDHkvVzLR/S3z6aVAflb
	tuwuhsTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solQ9-0000000DTkB-2Rgq;
	Thu, 12 Sep 2024 15:07:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1solQ6-0000000DTjr-1Zb7
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 15:07:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 338EB68AA6; Thu, 12 Sep 2024 17:07:37 +0200 (CEST)
Date: Thu, 12 Sep 2024 17:07:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, song@kernel.org,
	yukuai3@huawei.com, kbusch@kernel.org, sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] block: Make bdev_can_atomic_write() robust
 against mis-aligned bdev size
Message-ID: <20240912150736.GA5534@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-2-john.g.garry@oracle.com> <20240912131506.GA29641@lst.de> <0f2652ce-63e1-4399-8414-0bd150521e1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2652ce-63e1-4399-8414-0bd150521e1b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_080742_578237_D11259E2 
X-CRM114-Status: GOOD (  20.05  )
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

On Thu, Sep 12, 2024 at 03:58:00PM +0100, John Garry wrote:
> On 12/09/2024 14:15, Christoph Hellwig wrote:
>> On Tue, Sep 03, 2024 at 03:07:45PM +0000, John Garry wrote:
>>> For bdev file operations, a write will be truncated when trying to write
>>> past the end of the device. This could not be tolerated for an atomic
>>> write.
>>>
>>> Ensure that the size of the bdev matches max atomic write unit so that this
>>> truncation would never occur.
>>
>> But we'd still support atomic writes for all but the last sectors of
>> the device? 
>
> We should do be able to, but with this patch we cannot. However, a 
> misaligned partition would be very much unexpected.

Yes, misaligned partitions is very unexpected, but with large and
potentially unlimited atomic boundaries I would not expect the size
to always be aligned.  But then again at least in NVMe atomic writes
don't need to match the max size anyway, so I'm not entirely sure
what the problem actually is.

> I could also just reject any truncation on the atomic write in fops. Maybe 
> that is better.

It probably is.


