Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823EDC4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:11:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26B322242
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 02:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jvht8w2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26B322242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6yRlFe0EfBIAcsN+vNNADOJNHKcuBM4jopYm6b/uCzY=; b=Jvht8w2PcCOtJ1MYffnMIpWXx
	oZuwIq3hB02xG8B0KfWxj/dVfaHgWnyAJkh4+pPZjMA9iI9t66zjroaUEPY0ye5kQ4+vq/k2i/Yj0
	+vth0Fcv78N7Wr34fYLDm/nydDOr/UPMzpFoRmMYsbAAKAVz/jy9D2xESzqbCrAwgX0GSjzmAikqs
	EvcoDf5aQUAGZAeU5+NJsF1R0fU/bsD/Q+rWtb8V9FBx9RnENdOqEPwoDXH3G3XZIg6UhkXnmIOh/
	gjWbj1s2Rl2NU/HatdrxMhuJgQvpCyDhlGb4+U33B+bSjTUqaWmtCquxKjbwINgrgkXjFgNpFEPqq
	lumVwxyxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV3ai-0002XA-Fd; Wed, 21 Oct 2020 02:11:04 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV3ac-0002Wk-4F
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 02:10:59 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 4B80696F72FD0B086C93;
 Wed, 21 Oct 2020 10:10:50 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 21 Oct 2020 10:10:36 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 21
 Oct 2020 10:10:29 +0800
Subject: Re: [PATCH 1/3] nvme-core: introduce sync io queues
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20201020090817.27755-1-lengchao@huawei.com>
 <BYAPR04MB49659A83BC2C4763B1CF2E6C861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <cf50bebf-270d-09e9-7700-cbb13ee8926e@huawei.com>
Date: Wed, 21 Oct 2020 10:10:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49659A83BC2C4763B1CF2E6C861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_221058_602614_F9E8DF8F 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/10/21 1:06, Chaitanya Kulkarni wrote:
> On 10/20/20 02:12, Chao Leng wrote:
>> Introduce sync io queues for some scenarios which just only need sync
>> io queues not sync all queues.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
> 
> Can you please explain the scenario in detail ?
It is used for avoid race between time out and tear down. see patch 2/3.
The race may cause abnormal:
1. Reported by Yi Zhang <yi.zhang@redhat.com>
detail: https://lore.kernel.org/linux-nvme/1934331639.3314730.1602152202454.JavaMail.zimbra@redhat.com/
2. BUG_ON in blk_mq_requeue_request
Because error recovery and time out may repeated completion request.
First error recovery cancel request in tear down process, the request
will be retried in completion, rq->state will be changed to IDEL.
And then time out will complete the request again, and samely retry
the request, BUG_ON will happen in blk_mq_requeue_request.
3. abnormal link disconnection
Firt error recovery cancel all request, reconnect success, the request
will be restarted. And then time out will complete the request again,
the queue will be stoped in nvme_rdma(tcp)_complete_timed_out,
Abnormal link diconnection will happen. The condition(time out process
is delayed long time by some reason such as hardware interrupt) is need.
So the probability is low.
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
