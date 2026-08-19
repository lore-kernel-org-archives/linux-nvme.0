Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04904C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KLsouxoTg6Oem1f0fB+m9eGMshEESJSZXq28Td8Sjzw=; b=hxgFDNz1ptsj99lrPTr5RJlE5I
	e6iQP9uSr9Mw2xWQceInTRT/dXN8/SYsKBjzkcd8K14OOk2CFLV7IGpsFcEADI+pcvUGkhq7HLx62
	PK3yvFafhhgxhxeqsZ18e3piHX/4Tq0uwHucgtpZtMAhV8bL7bYMElgGuu5HaMG8vzn2C/Yj0s5MZ
	icPwaNpHBxkXbx04hRotKrap0/+Ln0iVIbozIbNT21c6N7qQi12AmuzVBRvbE3b1ceoR2Wc0pgRVw
	VU9nQQ9M1sX/SShOy1nNKDrPkq5Yeq8wqIcMWdlSjInjqQHBT2hYjruWk6jhSjpLpzZ9kK2nrWy8N
	kJxTEe1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcLx-00000009OGS-2DJz;
	Wed, 19 Aug 2026 09:12:57 +0000
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcLu-00000009OG0-1cf2
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:12:56 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=gOjdiylxj3dI6IB0RjlmP4RldcoL9z4Tuq7n9c7WLzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787130770; v=1; x=1787735570;
 b=rECOOIVN4Z6feZp4ZBhhdJVwPqT4amqW2Vr33U3a6hPW4KocmxUy6aRZRiV/j3HNMfQgPLVi
 Qk0bJoo8yNH8fQeDBa+73KpiL+PvmQpuRwwIi0dgqvN/cRjjna+U2KrXjdjn74S6/vxzwRToNqu
 m5Zwe8HoKuqGfhbXM6UGNawo=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: from [192.168.68.106] (80.176.231.63)
	by mta12.migadu.com with ESMTPS id 6310ff676a0e951b;
	Wed, 19 Aug 2026 09:12:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
Date: Wed, 19 Aug 2026 10:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
To: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
 <20260818120854.3151628-2-john.g.garry@oracle.com>
 <20260819090050.GA9267@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260819090050.GA9267@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_021255_065310_4DE702DC 
X-CRM114-Status: GOOD (  13.83  )
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

On 8/19/26 10:00, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 12:08:53PM +0000, John Garry wrote:
>> From: John Garry<john.garry@linux.dev>
>>
>> If a disk is hidden (GENHD_FL_HIDDEN flags set), we currently do not scan
>> the disk partition table.
>>
>> GENHD_FL_HIDDEN is used in NVMe multipath support to hide the per-path
>> disk.
> It also is used for giving a handle to NVMe devices that we can't support
> as block devices and for which we only want a handle to issue passthrough
> commands.  For those attempting a partition scan is rather suboptimal.

We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).

> 
> As is in general doing an extra scan per controller when we know it must
> give the same results.  Wouldn't it make more sense to just propagate
> the partition table from the ns_head to each individual path?

So you mean that we would have something which can clone the head 
gendisk partitions onto the per-path gendisk by itering  >part_tbl and 
calling something like blk_add_partition(), right?

