Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F61CFD315
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxdTAcDi8BFNwUdUY79Wn3lg/8EsLPR9j3YzOfVB9nE=; b=JYgNe5R02m9FuJQ3Jc482W7u8h
	U9SLPrhnU4v73Yyq3Hdl+y1RtYKl72uHcAeeqpZXaRKpQIwLPtlfjvIrRPyuY1tsmollY51Yh9x9x
	sh6twAvwT3bHsMRc2im4xucjKPsEyfEc+rUFL4ZvF/JtIZMl8XFVXbaKQD0NeXKkGAmgcfNA13IzR
	SnBqPWE0LWZGMRkPwMQBDccprg9l1qnlvPaLuD91EJISlhIr5AR6rt19W+XBiAUnpGbWdPMWq6Ox6
	jGpWuqV1cKn/ZIZw5QE6U5rCQUy6DFrRVHSn0j1Vz7i2ZDxOzAQqI2e1Xmu/njinSQ07Uf9PCzk+b
	BdF6DzhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnDU-0000000CrbF-4ByE;
	Tue, 25 Nov 2025 07:12:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnDQ-0000000Crae-2r44
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 07:11:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C77360195;
	Tue, 25 Nov 2025 07:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDCC4CEF1;
	Tue, 25 Nov 2025 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764054715;
	bh=xflNeMqf7k1tQ8p2f9Vf/KT0VAo9WTDVCCFoPk6I900=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vRW5r56jcgqXMxVPd0wuo6Asj/WFwwlD1sbbJn+TM5uvyv+LFWmulSpnq8gsEcoDB
	 9xM6Mo7+lurS8TbEynkUIWlNAssF1pYUcO0AklxAJ+AAiZl5seSlhrDuq68Kq/O2cn
	 cHh+bXZftIVMPHCe7c9IY57WuTMskj05VfhK5sKqpFNxgsSia9lA6h97quJQs3MzpF
	 T7eu7PHpjPa3mU7joudmxeoqPhsF+fvS6NPNj3DVzheWD1k8VSZpn7yTtlVBZCuOvs
	 aF8wrighi/0KfXj8IFm/XZmSEbiYeHktZXuy5rGJEVPsAvPHwmWoCB41m7uEAJI68x
	 uy5QFKvIGSBwQ==
Message-ID: <8e98a473-7991-43ae-a758-8ad324bb9393@kernel.org>
Date: Tue, 25 Nov 2025 15:11:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, yukuai@fnnas.com, sagi@grimberg.me, kch@nvidia.com,
 cem@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Christoph Hellwig <hch@lst.de>, jaegeuk@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
 <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
 <20251125063358.GA14801@lst.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251125063358.GA14801@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/25/2025 2:33 PM, Christoph Hellwig wrote:
> On Tue, Nov 25, 2025 at 09:10:00AM +0800, Chao Yu wrote:
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Sending these all as a series might be confusing - it would be good
> if the individual patches get picked through the subsystem trees
> so that the function signature can be cleaned up after -rc1.
> 
> Can we get this queued up in the f2fs tree?

Yes, I think it's clean to queue this patch into f2fs tree.

Thanks,

