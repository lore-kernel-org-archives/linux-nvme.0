Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21679C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8292164ECB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8292164ECB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v2+B/30YDWbI5+EC/peY3Y8VAbRehqIS4jZvmveMuFA=; b=UuzLHJfqivle+PuTXs5TzYUS/
	ezDTydR6TqZwgMn9a0tVJgNXTxk1wtBP/RVcIzIbh1RWdwFOSd3laRfY0wSPtCjobs43TySC+mUO0
	vQMRoqekXbRb7UZNlAdNWsM5Eb7Tqpoc+2jfnjahRfVytbBKpp7u4YGTbXThVj3cuHOMHgLSmg9QC
	4QRgdgGYrGZY75TTo/PXdCYCtmgBn9uYCd1Jrv9YjvCLVYqwUdvO8x/xPJMYoAXznDQgD+R+Wos2z
	cSN/0VgVAQ4+PbpXu4E+oF7eg6p6Qnpwl/cN31iXMGRRR640plEpxJ2Qd6NAY6/N8OetUYeZ9lJyO
	hAICf+eeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEoTq-0007OH-QV; Wed, 24 Feb 2021 07:21:06 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEoTo-0007Nq-8B
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 07:21:05 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DlnNh69jbzYCTb;
 Wed, 24 Feb 2021 15:19:32 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Feb 2021 15:20:59 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 24
 Feb 2021 15:20:58 +0800
Subject: Re: [PATCH 0/2] nvme: sanitize KATO handling
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210223120728.104699-1-hare@suse.de>
 <36e3bfd8-0c69-7540-c9f2-fd37070dc107@huawei.com>
 <06e3b90a-719e-9561-5c63-67dac0a782e1@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <1834a11c-c472-e14f-ece3-a96ec2ced044@huawei.com>
Date: Wed, 24 Feb 2021 15:20:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <06e3b90a-719e-9561-5c63-67dac0a782e1@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_022104_903257_61715A32 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/24 15:06, Hannes Reinecke wrote:
> On 2/24/21 7:42 AM, Chao Leng wrote:
>>
>>
>> On 2021/2/23 20:07, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> one of our customer had been running into a deadlock trying to terminate
>>> outstanding KATO commands during reset.
>>> Looking closer at it, I found that we never actually _track_ if a KATO
>>> command is submitted, so we might happily be sending several KATO commands
>>> to the same controller simultaneously.
>> Can you explain how can send KATO commands simultaneously?
> 
> Sure.
> Call nvme_start_keep_alive() on a dead connection.
> Just _after_ the KATO request has been sent,
> call nvme_start_keep_alive() again.
Call nvme_start_keep_alive() again? why?
Now just nvme_start_ctrl call nvme_start_keep_alive().
The ka_work will be canceled sync before start reconnection.
Did I miss something?
> 
> You now have an expired KATO command, and the new KATO command, both are active and sent to the controller.
> 
> Cheers,
> 
> Hannes

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
