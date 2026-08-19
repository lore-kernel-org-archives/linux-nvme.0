Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6236C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZPEzQ83fx/Rgj5Si2G7R46VTpaCHpnHQoutvcmO8HE=; b=21x3BlOVuuWY/d0BcObMneqpF8
	AskEckBqqW3eNemP3iO7mbpLtK9M6fNC14ElqkIY45QPhyno2Y8NvV+Su7KuEukfqr68R+M5kOyKz
	4j6IakzrC4NZ6SxvC5DhwyUdq3lJtHJ6jHihjYUcd8b43MkeX6sc0dWd7X2vokLRPI2is5+g3AwMg
	LNwuW9sazlofkxfczftRiI6iJQFIXz0o3wclKq2yzxmX6yR6opBb6jLgknqgEBrKFvIjMXwJxf6aW
	3FRUXrFfId32R8Q7vF961q+LxNC/y+Lv0l0w04eVZ+jzcL4VJ9wpeiafGmAOpG2EzLkHU7DcrPi7r
	VwBsttmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcMx-00000009OOb-3yrj;
	Wed, 19 Aug 2026 09:13:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcMt-00000009ONn-147r
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:13:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 195DF68C7B; Wed, 19 Aug 2026 11:13:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:13:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
Message-ID: <20260819091350.GA10298@lst.de>
References: <20260818120854.3151628-1-john.g.garry@oracle.com> <20260818120854.3151628-2-john.g.garry@oracle.com> <20260819090050.GA9267@lst.de> <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_021355_452947_F5953F82 
X-CRM114-Status: GOOD (  15.68  )
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

On Wed, Aug 19, 2026 at 10:12:50AM +0100, John Garry wrote:
>> It also is used for giving a handle to NVMe devices that we can't support
>> as block devices and for which we only want a handle to issue passthrough
>> commands.  For those attempting a partition scan is rather suboptimal.
>
> We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).

I guess we could do that.  It still feels wrong, though :

>> As is in general doing an extra scan per controller when we know it must
>> give the same results.  Wouldn't it make more sense to just propagate
>> the partition table from the ns_head to each individual path?
>
> So you mean that we would have something which can clone the head gendisk 
> partitions onto the per-path gendisk by itering  >part_tbl and calling 
> something like blk_add_partition(), right?

Yes.

