Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4805FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3qqmr1dM4NQ8c6ofhsJKQArhXM8UY1yS2LzE4iTWoKE=; b=zXaxXNaOSoBJfqxJRwjkCsk7xn
	jihlQlUYzdymY2c70kRyPSCigp0JdEKmaGURv5Cjh2ZaaZk8jJdTFMQ1PrkqElXNJGq609Evvvnuh
	7mFEQ0EZWeJ0n1CXEod5y5q4Shcs6AaQdHBsEbeDb3GDBXipGNT6HHwIRz+uMERAlyJT7lxTguL3S
	S+IEH1X4usd3vfAFd7sidl7qdn77WPFiGg2Z3mABx9q2zXK9hgdMnMF8xKSfsZLfqULQGz82nMhba
	Y8tw0Ir3SfTLXK4awJQ3Ndd84f+TejivI2rUe+lxhU5+m1+dpoDJZAjTyATC0THgdvjLDlAS4sakm
	8xO7PX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7tu3-00BmK3-D7; Wed, 21 Dec 2022 07:52:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7tsg-00Bl13-9M
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 07:51:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9567F67373; Wed, 21 Dec 2022 08:50:57 +0100 (CET)
Date: Wed, 21 Dec 2022 08:50:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "J. Hart" <jfhart085@gmail.com>, linux-nvme@lists.infradead.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <20221221075057.GA23095@lst.de>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com> <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com> <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com> <Y6B4JFj5jIDs0cBI@kbusch-mbp.dhcp.thefacebook.com> <b82b44db-1169-6b77-4f1b-ffdf4fb7feae@gmail.com> <Y6HpN83+Pm9WwjU0@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HpN83+Pm9WwjU0@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_235114_585025_8C3B90C5 
X-CRM114-Status: GOOD (  16.87  )
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

On Tue, Dec 20, 2022 at 09:56:23AM -0700, Keith Busch wrote:
> Though I am skeptical, Christoph seemed to also think there was a
> possibility you hit a real kernel issue with your setup, but I don't
> know if he has any ideas other than enabling KASAN to see if that
> catches anything.

Sorry for the delay, caught the nasy cold bugs circulating everywhere
and was mostly knocked out for a couple of days.

I can't really think of anything specific, but when we see random
memory corruption, there's basically two major options:

 - something DMAing where it should not.  In general an IOMMU should
   catch that if it is actually enable.  I think Keith rightly questioned
   if VT-d is actually running here and not disabled by the BIOS, and
   I don't remember a dmesg disproving that.  Even with that there
   could be some devices opting out of the IOMMU in the BIOS
 - the kernel overwriting random data.  This should be really rare, but
   could happen and KASAN should catch it.  But I really have no idea
   what it would be.

