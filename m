Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D0C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Gmvo6XJvdcJa+PrDF5vC1yTeHMa1Seh4HyxMnAQDQw=; b=n/L1Ydmg/IxeyPb4xgOt6awJZI
	12WGQTRSGJYZJj6PHCVTAzw1anJkpcBsCR4AfBPsop+REpn6MUoMnvDPUXSoKpAuI1kTzPXA/dqlS
	zSmmeeeNb018CKILuK3xeizcv60NLNZ2m/1yksUhjTbrWK9ocxKOPUfG2IGzU2v5/7kdHaXXCGYjn
	EfY4seh1c77Dbl+YCW/oVpthOQ3wjW1F6RCJ92AC8a8FVSQaas5KUyGREQTe/hruhvQcsBkfIH5+5
	rEGHJ/eQyAl+H79T7F+FkIqFIzfbQDYWXsdLGLr5ugHxY5OOmHIoJT+0KHkT7qRdvPJtybr8qSKWt
	Hq5runkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcq5-00000009RJL-0ls4;
	Wed, 19 Aug 2026 09:44:05 +0000
Received: from out-7.mta0.migadu.com ([2001:41d0:1004:224b::7] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcq1-00000009RIf-44JD
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:44:03 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=vi6K1Mgx+fZIvgXzENIjHfOngQ5Nx2T8UVV7jOpIREw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787132639; v=1; x=1787737439;
 b=GFcLilbZP+rONlknbNdr+XfvB3BeNDasBR20rjlzUOV2VsBvwPeAfgmGnNU9/JuEIZnj9kgd
 pxlPNBfNC7pqGMO9kxa3bx66SvV9J0L9I0OANhfzS29ulQ/TJxmgALJtMtJHxuTeIsZV12ORcDX
 zLvBtLv+7vVllqsl46x2fqTs=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: from [192.168.68.106] (80.176.231.63)
	by mta12.migadu.com with ESMTPS id bf42fb00cf31c670;
	Wed, 19 Aug 2026 09:43:49 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <188916f8-45e2-434c-a466-376854c7fa4c@linux.dev>
Date: Wed, 19 Aug 2026 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 sagi@grimberg.me, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260818120854.3151628-1-john.g.garry@oracle.com>
 <20260818120854.3151628-2-john.g.garry@oracle.com>
 <20260819090050.GA9267@lst.de>
 <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
 <20260819091350.GA10298@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260819091350.GA10298@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_024402_520523_8D64AC50 
X-CRM114-Status: GOOD (  15.41  )
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

On 8/19/26 10:13, Christoph Hellwig wrote:
> On Wed, Aug 19, 2026 at 10:12:50AM +0100, John Garry wrote:
>>> It also is used for giving a handle to NVMe devices that we can't support
>>> as block devices and for which we only want a handle to issue passthrough
>>> commands.  For those attempting a partition scan is rather suboptimal.
>>
>> We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).
> 
> I guess we could do that.  It still feels wrong, though :

Maybe we just don't change the GENHD_FL_HIDDEN behavior. As long as 
/proc/diskstats and /proc/partitions don't show those per-path partitions.

It seems to me that we need to have a dedicated function to clone the 
partitions, and it would be called per NS after nvme_mpath_set_live() -> 
device_add_disk(). I am not sure if that works, though. We may get 
nvme_ns_head_submit_bio() looking up the per-path partition before they 
are available. In that case I would need to keep the path disabled until 
after the partition table is available.

> 
>>> As is in general doing an extra scan per controller when we know it must
>>> give the same results.  Wouldn't it make more sense to just propagate
>>> the partition table from the ns_head to each individual path?
>>
>> So you mean that we would have something which can clone the head gendisk
>> partitions onto the per-path gendisk by itering  >part_tbl and calling
>> something like blk_add_partition(), right?
> 
> Yes.

ok

