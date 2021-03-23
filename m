Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D7C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:16:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66714619B7
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 16:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66714619B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HzyRhdMKcexMosh4Ik6nIIFbh8L+Q7o8NWVPtstl3ns=; b=I+FvbpW+8p8u00CxLUZjIt1AU
	mTi3l5Zh83Gyx+Bjf4SnR/JHI8DAotJrqvGsluDz7XX6DuOEur8ISsESu5GYj+QuEg0tCMsbrpZ51
	wV5Iekzi6Ar1hiPWb2qMZ1G92PQNCDvWmZsah1Q7vVE/DsAvrN2dSlCkLwpKfaU20aei1BwoxwESY
	AbNfVr+Tck6JDeYP38sPsJIK1Su+gp1V9alMr0k1JJ5cIqcOMa7GyslsvAEEOHDwVW0b3xrV02van
	EH2q15leBvsV5BJz+L1qLfYbgFF5yD+EkRg8kbyEQh8MFI6evSN9+WWxewiiHb5GIGwXOvxyYh+aS
	nzdRS5hFA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOjhD-00FIGT-Pm; Tue, 23 Mar 2021 16:15:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOjh9-00FIG6-2A
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 16:15:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0D2ED68BFE; Tue, 23 Mar 2021 17:15:47 +0100 (CET)
Date: Tue, 23 Mar 2021 17:15:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161544.GA13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_161551_235167_06516312 
X-CRM114-Status: GOOD (  20.86  )
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

On Tue, Mar 23, 2021 at 12:36:40AM -0700, Sagi Grimberg wrote:
>> The process:
>> 1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
>> 2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead of 
>> waiting for the frozen queue.
>
> Nothing guarantees that you have a bio_list active at any point in time,
> in fact for a workload that submits one by one you will always drain
> that list directly in the submission...

It should always be active when ->submit_bio is called.

>
>> 3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
>> So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is 
>> frozen, can avoid deadlock.
>>
>> Sagi, suggest trying this patch.
>
> The above reproduces with the patch applied on upstream nvme code.

Weird.  I don't think the deadlock in your original report should
happen due to this.  Can you take a look at the callstacks in the
reproduced deadlock?  Either we're missing something obvious or it is a
a somewhat different deadlock.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
