Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D6C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQ60lN4XHdfNtivmwoGJBfMIbR60YzEa9u0zT+J699w=; b=xi4m8/35pk9FoPtUibL2KIa1qb
	+6PuPnLcsnoOpkQZLmyhl74n0RoS1xYXTIcQMTLnYCIICzfbMIo+1SG00OoKMKmYbYJa8o1+5Pur/
	ONa1mjLBdN1XNH78wmt94vCNLk346hCVdwpLKri3lTq8hrbabT8j9wUVG7IjA6DEmo1DYDEpg0j51
	MFobyUF5kOHO2l/4srlPeBZ3M/syuICmp9hcj3Yf8yAvCLitGFq+drRn8KWe5d36N3Gq+Llm/mRdJ
	rkH6wgT3PTx4A2He8KaNJUPvV5VGG0YMLVGpZlRVoMvQvXY3qqawp8f3xJ39tGsyg3fQ3ISEkU+pJ
	fTB4eTZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okkQU-005znz-DG; Tue, 18 Oct 2022 11:06:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okkPv-005zHU-Hj
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 11:05:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3957768C4E; Tue, 18 Oct 2022 13:05:44 +0200 (CEST)
Date: Tue, 18 Oct 2022 13:05:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018110544.GA4785@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017134244.GA24775@lst.de> <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me> <20221018085557.GA28266@lst.de> <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_040551_782593_AE343F5E 
X-CRM114-Status: GOOD (  15.83  )
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

On Tue, Oct 18, 2022 at 12:06:41PM +0300, Sagi Grimberg wrote:
>>   +	/*
>> +	 * Mark the disk dead to prevent new opens, and set the capacity to 0
>> +	 * to end buffered writers dirtying pages that can't be synced.
>> +	 */
>>   	blk_mark_disk_dead(ns->disk);
>> -	nvme_start_ns_queue(ns);
>> -
>>   	set_capacity_and_notify(ns->disk, 0);
>> +
>> +	/* forcibly unquiesce queues to avoid blocking dispatch */
>> +	nvme_start_ns_queue(ns);
>>   }
>
> If we no longer have this ordering requirement, then I don't see why
> the unquiesce cannot move before or after nvme_set_queue_dying and apply
> a tagset-wide quiesce/unquiesce...

Yes.  After this patch we can simply do the tagset-wide unquiesce
after the loop calling blk_mark_disk_dead and set_capacity_and_notify.

We can then also move the NЅ_DEAD flag to the controller..

