Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B50CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMMJup3DvdwBI7J9pYN303LXnPgoYG2uRfjQV28q38A=; b=DdAWM/2bpqOzoSMIOx6IBd13e2
	0yUrLAVdFaE/EBttwtJ61Ovk3tPM3qeiRtlvJz1VLairjfb7+ZD0rBnbpICQdBzORMP2QzbBMs7Ay
	Jyw4YaBXhZd3eNwqHcPnpK5j928PWm0+yVzyeHTPsHzYAiRy41UAN3cy02FfT6g5Pe8W03mLenUe8
	cZQ2J56bpT5sY9hCc1iAWUg0V3ZLuwk4nZChpBtKnpqUUP+eLaIf9Mjr08c9Ahcjih7BStnWDH9x6
	PzjoKJlIIq2jDrtkeqwbB2Gj7PpaZY6OF+O7uzZbTx+Kv4TyXawiZbzup/NI2a7BXjdBB8iy2fSxk
	wdvKJpPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2wb-008N2d-3I; Tue, 15 Mar 2022 08:54:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2wY-008N27-Ny
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:54:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5591968AA6; Tue, 15 Mar 2022 09:54:10 +0100 (CET)
Date: Tue, 15 Mar 2022 09:54:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
 javier@javigon.com, mcgrof@kernel.org, a.manzanares@samsung.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <20220315085410.GA4132@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com> <20220311070148.GA17881@lst.de>
 <20220314162356.GA13902@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314162356.GA13902@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015414_959187_8FEC08FE 
X-CRM114-Status: GOOD (  22.52  )
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

On Mon, Mar 14, 2022 at 09:53:56PM +0530, Kanchan Joshi wrote:
>>> +struct nvme_uring_cmd_pdu {
>>> +	u32 meta_len;
>>> +	union {
>>> +		struct bio *bio;
>>> +		struct request *req;
>>> +	};
>>> +	void *meta; /* kernel-resident buffer */
>>> +	void __user *meta_buffer;
>>> +} __packed;
>>
>> Why is this marked __packed?
> Did not like doing it, but had to.
> If not packed, this takes 32 bytes of space. While driver-pdu in struct
> io_uring_cmd can take max 30 bytes. Packing nvme-pdu brought it down to
> 28 bytes, which fits and gives 2 bytes back.

What if you move meta_len to the end?  Even if we need the __packed
that will avoid all the unaligned access to pointers, which on some
architectures will crash the kernel.

> And on moving meta elements outside the driver, my worry is that it
> reduces scope of uring-cmd infra and makes it nvme passthru specific.
> At this point uring-cmd is still generic async ioctl/fsctl facility
> which may find other users (than nvme-passthru) down the line. Organization 
> of fields within "struct io_uring_cmd" is around the rule
> that a field is kept out (of 28 bytes pdu) only if is accessed by both
> io_uring and driver. 

We have plenty of other interfaces of that kind.  Sockets are one case
already, and regular read/write with protection information will be
another one.  So having some core infrastrucure for "secondary data"
seems very useful.

> I see, so there is room for adding some efficiency.
> Hope it will be ok if I carry this out as a separate effort.
> Since this is about touching blk_mq_complete_request at its heart, and
> improving sync-direct-io, this does not seem best-fit and slow this
> series down.

I really rather to this properly.  Especially as the current effort
adds new exported interfaces.

> Deferring by ipi or softirq never occured. Neither for block nor for
> char. Softirq is obvious since I was not running against scsi (or nvme with
> single queue). I could not spot whether this is really a overhead, at
> least for nvme.

This tends to kick in if you have less queues than cpu cores.  Quite
command with either a high core cound or a not very high end nvme
controller.

