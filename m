Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270B4C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:52:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A253D61040
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A253D61040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=up2+Lvd8IFJZ3M6cyGtjtlvoiu+vOged0+vxj38VT6s=; b=Vfx2r87hxVhcyS/2MLUVslLXM
	qQzb/qFxKV1KVQmGe8AnrhMge5NexYe0XgvQ0e7DpEv3SMBaIb7TsDsJ1RFVewr+DspijPiqGejUi
	MmhZO5TnlY1LrTF9yT/Em1bYDhimeH64L8i7H6HbqaMTYCtnMHBQjU3wi6f3dEbmHo7ZuFW/uSNyj
	aYLqf0GTY8hXn6HaAPcDzDIzA0fphSzSDX3AAQPJRojUtUwy4TDGHZrtRraQyCBDTSvvw1aGZhAvw
	d/taWPdAxvxmgQXH/XEVRQ/Hxfo+EGqfo3IFktCmgGXhXkNAt3VjPxMjc2phYXSzHMjg1ps2bKv1T
	rv1HdopSA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2ag-007tZX-Bg; Mon, 26 Apr 2021 14:52:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2Zq-007tQa-VZ
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dnA7PrCrYkO4wvYtBiMLQe0pfJizvjH3wgQ8Yz+i3bo=; b=oSO/rxQl6WwtKGy60Ba148dUiT
 T09BNN0NH4eTK8IyUqoE33H7FY/fYOXojK6awU57QPPx16Bv0jLDQG7HvYccJpO5q0xwP85gB59Uz
 PN6eKUNGuV9ysZQFBQPuoojr0+pdKeQCeqWN3FL41fbO7gCBlUOWBmwBhToLxgyJ6kEaayxZXkgVx
 jw6nN2ygaEFDALRjWXQaVcbCWTdx9IlJY8uN4b1fF/6oEBfeK2u9B8df5zGCsmJiFTqNQJfNCU2YM
 NyMMSRF9zVv4PA/s6pX3b1pYcMlR7QN2lPT7XuNkYXMJA4bqLUdHJ75woHwxn80Codpimu+EfzyRt
 SDPNZegg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2Zo-00G1iw-6X
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:51:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8F62868C4E; Mon, 26 Apr 2021 16:51:05 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:51:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
Message-ID: <20210426145105.GA22120@lst.de>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_075108_409787_46CC2877 
X-CRM114-Status: GOOD (  16.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 23, 2021 at 05:21:03PM -0700, Sagi Grimberg wrote:
>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index be905d4fdb47..fc07a7b0dc1d 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1202,6 +1202,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>>   		return;
>>   	}
>>   +	nvme_mpath_stop(&ctrl->ctrl);
>>   	nvme_rdma_reconnect_or_remove(ctrl);
>
> Its pretty annoying to have to needlessly wait for the ana log page
> request to timeout... But this is also needed because we init ana_lock
> in nvme_mpath_init while it can be potentially taken in ana_work, which
> is a precipice for bad things...

I also really hate open coding this mpath detail in the transport
drivers.  Didn't you at some point have a series to factor out more
common code from the whole reset and reconnect path?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
