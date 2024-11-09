Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E42D5E373
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9oKSnF6tAPuoW/EZ+cRLrrwW3l94YIKR32LCJwNz6bs=; b=eLXLv61CjvNPiEaRLEYDP9PQhq
	3eVTzLiadI5jdiyTe67Izj8vZpS01PrA6okRARjoprzGfRAoJGfqoWkrW+DPPIbGc0BwSGhTNjOE7
	w9rNHSKuc33PQGjKfsZGj7ylCoSZkHIIlf2U6axMQz50KEfHViyUJDZ87HfrVoyRLG8FrqjRFjaIm
	GP8/EIkUC0HyJTgUmq6PMWQs/7uxjCgYTtojrQLsQ8QLXV+in2VyBekZsdJb3NLCdmZ2PND7KdoRl
	W42ke3GqVJ5uuwB58mYW7lYjcNJx6sTtvV44zTBemCGi9yapJ13JOt8XKHw3tmEjiBVoQTW2ZO+1v
	FSynuLqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9mx8-0000000DVax-3ufK;
	Sat, 09 Nov 2024 15:00:42 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9mx5-0000000DVa2-2v78
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 15:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731164436; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=9oKSnF6tAPuoW/EZ+cRLrrwW3l94YIKR32LCJwNz6bs=;
	b=TPTy3zfrb3UJ21RNLP3t31ljbGO1TNcZW2Tjk3nmSJBkCe6awXoLR0+uQ9/U26NeXMMLi/1Q1Gyvk8BZIxD+C8hGpnDVUx7rcC3DeF8wm4a2LKWRRlWs9iafrPvT5HhUocK+2RCKC0cFSKKkRvGTPJV78y5/65Bq1IMY3gkmTcw=
Received: from 30.120.40.73(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJ0ecgf_1731164432 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 Nov 2024 23:00:34 +0800
Message-ID: <aa121956-a050-4c47-be44-2d3afe6c6610@linux.alibaba.com>
Date: Sat, 9 Nov 2024 23:00:32 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 m@bjorling.me, matias.bjorling@wdc.com, kch@nvidia.com
References: <20241107193849.995554-1-kbusch@meta.com>
 <20241107193849.995554-14-kbusch@meta.com> <20241108142743.GG6694@lst.de>
 <Zy45M1HRz8cKLPxf@kbusch-mbp>
 <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
In-Reply-To: <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_070039_933218_605B84C4 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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


在 2024/11/9 22:59, Guixin Liu 写道:
>
> 在 2024/11/9 00:15, Keith Busch 写道:
>> On Fri, Nov 08, 2024 at 03:27:43PM +0100, Christoph Hellwig wrote:
>>> On Thu, Nov 07, 2024 at 11:38:48AM -0800, Keith Busch wrote:
>>>> diff --git a/drivers/nvme/target/admin-cmd.c 
>>>> b/drivers/nvme/target/admin-cmd.c
>>>> index 516af7b419189..f688d7fdf7d67 100644
>>>> --- a/drivers/nvme/target/admin-cmd.c
>>>> +++ b/drivers/nvme/target/admin-cmd.c
>>>> @@ -915,6 +915,9 @@ static void nvmet_execute_id_cs_indep(struct 
>>>> nvmet_req *req)
>>>>           id->nsattr |= NVME_NS_ATTR_RO;
>>>>       if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
>>>>           id->nsfeat |= NVME_NS_ROTATIONAL;
>>>> +    if ((req->ns->file && !req->ns->buffered_io) ||
>>> I don't think this check is correct.  Direct I/O still requires cache
>>> flushes for durability.
>> Oh, right. Would it be sufficient to check the file's block device for
>> write caching?
>>
>>     if ((req->ns->file && !req->ns->buffered_io &&
>> bdev_write_cache(file_inode(req->ns->file)->i_sb->s_bdev))
>
> Or just remove !req->ns->buffered_io check? All file backend return
>
> support vwc.
Sorry, remove "req->ns->file && !req->ns->buffered_io".
>
> Best Regards,
>
> Guixin Liu
>

