Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E2EC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 05:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nit1nfBa/sc8gaMVsp966Vo29K55WwrvXnwUNz78qHo=; b=rW1pihWTbsfYA3LUYVe+yIJchB
	+DT5hZXoEP/XO9SGlz8In744aKQ7ejzAehqKjDcobdvwYPKZlqbd+FJStRTHMxxePLhb3AglTdBvO
	1Lwyjmcuwp0lAGq1SjvM6zmP6vsQ/M33AcVLRLxI5FmW8UeWbhMWQNuRUybjmkXr+yGxjXob96U7K
	W13w2B7eAt/Xe/kdBPZnEic5zQjI+cxyGJ6SgJY1pU+Ew+DCHvfMKOsJ/PtZH85bH4g7EDhnt6EYU
	zx1qs9i8iFTP/gx/Gvr+3cdZr4Wz6DaLpKZLgdodZE9whzDrEDiusLQRqyYksRQSaqJOpFAskqk3k
	bkv4Fpxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpij0-0000000CcoI-3wY0;
	Thu, 28 Mar 2024 05:54:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiiy-0000000Ccnq-3EJD
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 05:54:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17A1960AFF;
	Thu, 28 Mar 2024 05:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1531FC433F1;
	Thu, 28 Mar 2024 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711605291;
	bh=R1I8/lwm7TQTj/Rx7NOR7Kh++SMDavsSyypMJXowvqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Not8lgvvo57JW8mQsdE04ybsKR4cSQfq7yNynShXu/xh1N5+a8Q0V9D3OU09GPw+n
	 k0F+KvwG9M9Jbs+IAKstSG7bJlHNkESsVgOvOoAwRNN/tjIUzl+0E18WzmNG650Sau
	 frkp9ogTJYuQ14LngS1CmZ60zxhy+Cq0osDvDVPXSoozH5Pq8ehWKrcoDUskccCQ/o
	 qhiKxhFuVRFUlTYlBFkg1iA/rexA5ajHCfxn0UY3uax4N1sT+76/eZBSD+M1S2iHJU
	 U/OtpbdtnYSKQyqPgyCgMjc4tMJbFAkhtSU0PpW/VYr1C2wkKbnAveEXSBG+CZ8wxU
	 NvQjDVeV0nTWA==
Message-ID: <573649d8-c022-4c05-83bf-99b8074fd930@kernel.org>
Date: Thu, 28 Mar 2024 14:54:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-5-dlemoal@kernel.org> <20240328041457.GC13510@lst.de>
 <86114cba-535b-41e9-9b85-bac2fbdc1ed3@kernel.org>
 <20240328054208.GA16087@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328054208.GA16087@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_225452_881717_C03CA8C5 
X-CRM114-Status: GOOD (  17.94  )
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

On 3/28/24 14:42, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 02:20:17PM +0900, Damien Le Moal wrote:
>> I do not think that is corect. Because is_flush indicates that RQF_FLUSH_SEQ is
>> set, that is, we are in the middle of a flush sequence. And flush sequence
>> progression is handled at the request level, not BIOs. Once the sequence
>> finishes, then and only then the BIO original endio should be done, meaning that
>> we will then take this path and actually do blk_zone_update_request_bio() and
>> bio_endio(). So I still think this is correct.
> 
> Well.
> 
> lk_flush_restore_request with the previous patch now restores rq->__sector,
> and the blk_mq_end_request call following it will propagate it to the
> original bio.  But blk_flush_restore_request grabs the sector from
> rq->bio->bi_iter.bi_sector, and we need to actually get it there first,
> which is done by the data I/O completion that has RQF_FLUSH_SEQ set.

Ah. Yes. There is no issue with the current code for regular writes, but we
would get the original sector and not the written sector in the case of zone
append. Will make the change.

> I think we really need a good test case for zone append and FUA,
> i.e. we need the append op for zonefs, which should exercise the
> fua code if O_SYNC/O_DSYNC is set.

Yep. There is currently no issuer of zone append + FUA. But once I get to add
that for zonefs and block dev files, we indeed will have good tstbed.

> 

-- 
Damien Le Moal
Western Digital Research


