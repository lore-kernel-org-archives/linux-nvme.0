Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F24C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 04:05:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCA264E08
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 04:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCA264E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=95Kv6nTwsoHzYOgsOZPh+ooyI2ZcjZgp5BEPdycl/Cg=; b=E8R0Zbe0eL/8hglHeNFqGp/Ri
	TLqS8N+ZhasjSPNjlbDzY3FZWww6s4r6FNoKLI6mEQwT08XB9iKqJ2/JE6BTf63USmNCrjahQov19
	odTJK+iBuiv9DLzcIm+jsD4rJza9qWEH/flcVCbmwT4bk8F4q/WFSovoLnS11DBHOmJhlTVc22Ff6
	DE2gY5woRwhSy5f5nAv5qxRF4AwJGWn3aYuJKcdUe5j4rfSWvBOyjYj9ksBybCYgcWjGgmA7VJs0E
	y2MyzF+ttdVA93dxN6+Fwmz9VbfnVpqxY1ldQvhSAqcg0DYjz05MiuBX8DD070Y2yMBWfFvmq+gV+
	O6n08sVFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA3EB-00057W-Dk; Thu, 11 Feb 2021 04:05:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA3E8-00056q-GO
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 04:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613016310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFHRaF6EB1fXK56FXKAz9Lcv4QWphFSy/tEz5CP3dPI=;
 b=Vi4TDUfTeyTuAcldkx71bXaZr4dBf0TZf+Woy8UEkw4pySfeCUrQ2h/ajcr6nBiPSdPGOZ
 4LSUut6VCVokuhWzBU8I0akaC+/hqKGwBt4clBphHQ8/JV/YYOo8LBino2odbCFWaQdQD6
 bPbNW1ss3NotOYBt/RIqwsUi46TSUY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-Q15tucIVNyu0QvNUIi7FbA-1; Wed, 10 Feb 2021 23:05:06 -0500
X-MC-Unique: Q15tucIVNyu0QvNUIi7FbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E62A6803648;
 Thu, 11 Feb 2021 04:05:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 278A11F041;
 Thu, 11 Feb 2021 04:05:00 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: fix crash triggered with a dataless request
 submission
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210210220400.1730263-1-sagi@grimberg.me>
 <BYAPR04MB49650F2CB6A009986E0DC517868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <3d3efa8d-5e77-6cdf-88b4-a225fab36ffc@redhat.com>
Date: Thu, 11 Feb 2021 12:04:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650F2CB6A009986E0DC517868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_230512_735558_DF615BDB 
X-CRM114-Status: GOOD (  15.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/11/21 6:16 AM, Chaitanya Kulkarni wrote:
> On 2/10/21 2:10 PM, Sagi Grimberg wrote:
>> write-zeros has a bio, but does not have any data buffers associated
>> with it. Hence should not initialize the request iter for it (which
>> attempts to reference the bi_io_vec (and crash).
>> --
>>   run blktests nvme/012 at 2021-02-05 21:53:34
>>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] SMP NOPTI
>>   CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S        I       5.11.0-rc6+ #1
>>   Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
>>   Workqueue: kblockd blk_mq_run_work_fn
>>   RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
>>   RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246
>>   RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 0000000000000000
>>   RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000002000000
>>   RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 0000000000000000
>>   R10: 0000000002800809 R11: 0000000000000000 R12: 0000000000000000
>>   R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 0000000000000000
>>   FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007706e0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp]
>>    blk_mq_dispatch_rq_list+0x11c/0x7c0
>>    ? blk_mq_flush_busy_ctxs+0xf6/0x110
>>    __blk_mq_sched_dispatch_requests+0x12b/0x170
>>    blk_mq_sched_dispatch_requests+0x30/0x60
>>    __blk_mq_run_hw_queue+0x2b/0x60
>>    process_one_work+0x1cb/0x360
>>    ? process_one_work+0x360/0x360
>>    worker_thread+0x30/0x370
>>    ? process_one_work+0x360/0x360
>>    kthread+0x116/0x130
>>    ? kthread_park+0x80/0x80
>>    ret_from_fork+0x1f/0x30
>> --
>>
>> Fixes: cb9b870fba3e ("nvme-tcp: fix wrong setting of request iov_iter")
>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Verified with latest linux-block/for-next.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
