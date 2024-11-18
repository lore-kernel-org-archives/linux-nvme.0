Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F72D49219
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GhJXkLYb46iqwj09Gb1oEQ/3nY9j0vCZb2VZl22R7YU=; b=pTkq3eD79W1hHY6kekRekzmdKV
	NLbLuv9DmaBZ5kzrdPpwbF2gxzy3CcO0p5zF4Rs7H4hy/6+TXpComi4pWI/BeGd2itPfVE3sjQFtG
	yYoaJ1IcVyrhzwZ9Kg2S5upON4eHojlnaLArKkpKMvZeIUjLBBxMdpsEJNOh/efLFRuo64wkCysMZ
	ZuteNizu90bgAju4IKkjYs8ES1BifIqymxxRys47I5Ez8yuaMw0we4SPQX5iyijwqLx6sdkhfNiOL
	KeT8Y2YhCeHBOCu6zGCAoIxVfI06qPgHi7VF3EBIzu0eECCQeA0zIJbhdnY5D2RqTIFNfN0uPR8S2
	fHXje6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD1Bq-00000009RRm-2KNZ;
	Mon, 18 Nov 2024 12:49:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD1Bk-00000009RQW-1NUG
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 12:49:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F06568BFE; Mon, 18 Nov 2024 13:49:01 +0100 (CET)
Date: Mon, 18 Nov 2024 13:49:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241118124901.GA27505@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de> <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com> <20241114151921.GA28206@lst.de> <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com> <20241115171205.GA23990@lst.de> <397bc8b7-b569-4726-984a-46054d6b5950@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397bc8b7-b569-4726-984a-46054d6b5950@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_044908_502475_E2A39B96 
X-CRM114-Status: GOOD (  13.84  )
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

On Fri, Nov 15, 2024 at 07:03:28PM +0000, Pavel Begunkov wrote:
>>> but that shouldn't be PI specific.
>>
>> Why would anyone not use the SQE128 version?
>
> !SQE128 with user pointer can easily be faster depending on the
> ratio of requests that use SQE128 and don't. E.g. one PI read
> following with a 100 of send/recv on average. copy_from_user
> is not _that_ expensive and we're talking about zeroing an
> extra never used afterwards cache line.

Why would you use the same ring for it?  Remember PI is typically
used by thing like databases.  Everything that does disk I/O
will use it, so optimizing for it actually being used absolutely
makes sense.


