Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E95C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:19:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA826501D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA826501D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yh7JV8w6TjXcbhcttFdLW9GstZuG0JSVRo6ZYJ2k3Lc=; b=cHOueoIJ63lj7+tEAMeiqtdzS
	QtvshAmt3CwYfKiDi4Hk3e1gk8md2l/cXAScdoXhmLrMuQTEylIkLHJpTu2u84s0/grwOJFf2J2IZ
	Kk92IL/KKqFCUs6SKv04JYNAESSFK28+B7xH1ZzLWMNYKsl8f7FcuUEY0GBX9q+38XWAAuLB3kkpt
	OL7gzh65AvKWaG46KPu+wc3m5ipz66V7pAlJn3XH4HcvF0D4Y7m7J5rOxWnptIQKqDV4Z4ksmx2KW
	fJg8WXNqLnUSVgeOpcxcIeZ84Y/YeiESyVMeQK+DzuN7WaxdC+N5JpuJtm4kWswYgpShk/MqV+I6k
	B6kAGtYFA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM32Q-00HVxK-T4; Tue, 16 Mar 2021 06:18:42 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM32K-00HVwf-Ul
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 06:18:40 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F031Y5N9VzWLTn;
 Tue, 16 Mar 2021 14:15:29 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 16 Mar 2021 14:18:29 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 16
 Mar 2021 14:18:29 +0800
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, "Chaitanya
 Kulkarni" <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <7d552635-6f95-fca4-b0ca-709967465495@huawei.com>
 <3a172ebf-eeb8-b7a0-4eb2-099fa74bc1c6@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c4df11c9-8d93-add1-396d-b8380d050a08@huawei.com>
Date: Tue, 16 Mar 2021 14:18:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3a172ebf-eeb8-b7a0-4eb2-099fa74bc1c6@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_061838_019792_46E602A1 
X-CRM114-Status: GOOD (  17.18  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/3/16 13:04, Sagi Grimberg wrote:
> 
>> Does the problem exist on the latest version?
> 
> This was seen on 5.4 stable, not upstream but nothing prevents
> this from happening in upstream code.
> 
>>
>> We also found Similar deadlocks in the older version.
>> However, with the latest code, it do not block grabbing the nshead srcu
>> when ctrl is freezed.
>> related patches:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=fe2008640ae36e3920cf41507a84fb5d3227435a
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=ed00aabd5eb9fb44d6aff1173234a2e911b9fead
>> I am not sure they are the same problem.
> 
> Its not the same problem.
> 
> When we teardown the io queues, we freeze the namespaces request queues.
> This means that concurrent mpath submit_bio calls can now block with
> the srcu lock taken.What is the call trace of ->submit_bio()?
The requeue work or normal submit bio?
> 
> When another path calls nvme_mpath_set_live, it needs to wait for
> the srcu to sync before kicking the requeue work (to make sure
> the updated current_path is visible).
> 
> And this is where the hang is, the only thing that will free it
> is if the offending controller reconnects (and unfreeze the queue)
> or it will disconnect (automatically or manually). Both can take
> a very long time or even forever in some cases.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
